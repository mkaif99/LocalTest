import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import ContactCityList from '@salesforce/apex/StudentCity.getCities';
import StudentDetailed from '@salesforce/messageChannel/StudentDetail__c';
// we need to use . for import custom file
export default class TrainingContacts extends LightningElement {
    
    optionsCityName=[];
    selectCity;
    conRec;
    errorMsg;
    constructor(){
        super(); 
    }
    @wire(MessageContext) messagecontext;

    handleChange(event){
        this.selectCity = event.target.value;
        const payload = {
            city: event.target.value
        };
        console.log('city -> ',this.selectCity);
        console.log('runs1-> ',payload.city);
        publish(this.messagecontext, StudentDetailed, payload );
        console.log('runs2-> ',payload.city);
    }
    
    // It shows only to get city List
    @wire (
        ContactCityList
    ) getCities({data,error}){
        if(data)        this.optionsCityName = data.map(city => ({label : city, value: city}));
        else if(error)  alert(error);
    }
    // // It is used to show records
    // import ContactRec from '@salesforce/apex/StudentCity.getContacts';
    // @wire (ContactRec,
    //     {
    //         cityName : '$selectCity' //$ is used to if any changes happen in selectCity then wire property 
    //                                   //  has run or overwrite everyTime
    //     }
    // ) listContact({data,error}){   // with method listContact as method we can use it's name from html
    //     if(data){
    //         this.conRec = data;
    //         this.errorMsg = null;
    //     }
    //     else {
    //         this.conRec = null;
    //         this.errorMsg = error;
    //     }
    // }    
}