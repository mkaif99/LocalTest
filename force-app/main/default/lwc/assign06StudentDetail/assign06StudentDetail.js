import { LightningElement,wire } from 'lwc';
import studentdetails from '@salesforce/apex/StudentCity.getStudentDetail';
import { subscribe,MessageContext } from 'lightning/messageService';
import Student_Details from '@salesforce/messageChannel/StudentDetail__c';

export default class Assign06StudentDetail extends LightningElement {
    stdata;
    errorMsg;
    recId;
    subscription = null;
    connectedCallback(){
        this.subscribeToMessageChannel(); 
    }
    @wire (MessageContext) messageContext;
    subscribeToMessageChannel(){
        this.subscription = subscribe (this.messageContext,
        Student_Details, 
        (message) => 
            this.handleMessage(message)
        );
    }
    handleMessage(message){
        //alert("message:"+JSON.stringify(message));
        //console.log(message);
        this.recId = message.stdId;
        console.log('counter -> ',this.recId);
    }
    @wire (studentdetails,
            {
                studentName: '$recId' //$ is used to if any changes happen in selectCity then wire property 
                                          //  has run or overwrite everyTime
            }
        ) listContact({data,error}){   // with method listContact as method we can use it's name from html
            if(data){
                this.stdata = data;
                this.errorMsg = null;
            }
            else {
                this.stdata = null;
                this.errorMsg = error;
            }
        } 
}