import { LightningElement , wire} from 'lwc';
import ContactRec from '@salesforce/apex/StudentCity.getContacts';
import { publish,subscribe,MessageContext} from 'lightning/messageService';
import StudentDetail from '@salesforce/messageChannel/StudentDetail__c';

export default class Assign06STUDENTRECORD extends LightningElement {

    conRec=[];
    errorMsg=[];
    selectedCity;
    subscription=null;

    connectedCallback() {
        this.subscribeToMessageChannel();
    }
    @wire(MessageContext) messageContext;

    subscribeToMessageChannel(){
        console.log('subscribeToMessageChannel');
        this.subscription = subscribe (
            this.messageContext, 
            StudentDetail, 
            (message) => 
                this.handleMessage(message)
        );
       console.log('subscribeToMessageChannel');
    }
    handleMessage(message){
        //alert("message:"+JSON.stringify(message));
        console.log(message);
        this.selectedCity = message.city;
        console.log('counter -> ',this.selectedCity);
    }
    @wire (ContactRec,
            {
                city: '$selectedCity' //  $ is used to if any changes happen in selectCity then wire property 
                                   //  has run or overwrite everyTime
            }
        ) listContact({data,error}){   // with method listContact as method we can use it's name from html
            if(data){
                this.conRec = data;
                this.errorMsg = null;
                console.log('wire ->',this.conRec);
            }
            else {
                this.conRec = null;
                this.errorMsg = error;
            }
        }
    
    handleclick(event){
        
        const payload = {
            stdId: event.target.value
        };
        console.log('sts1-> ',payload.stdId);
        publish( this.messageContext, StudentDetail, payload);
        //console.log('sts2-> ',payload.studentName);
    }
       
}