import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi'; //this code is written for record creation of every object.
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreateAccount extends LightningElement {
    isAccountCreated;
    accountObjId;
    constructor(){
        super();
        this.isAccountCreated = false;

    }
    handleCreate(){
        const accName = this.template.querySelector('lightning-input[data-name=txtAccName]').value;
        const accPhone = this.template.querySelector('lightning-input[data-name=txtAccPhone]').value;
        const accCity = this.template.querySelector('lightning-input[data-name=txtAccCity]').value;
       console.log(accCity,accName,accPhone);
        createRecord(
            {
                
                apiName: "Account",
                "fields": {
                  "Name": accName,
                  "Phone": accPhone,
                  "BillingCity": accCity
                }
            }
        ).then(
            (objAcc) => {
                this.isAccountCreated = true;
                this.accountObjId = objAcc.id;
                const eve = new ShowToastEvent(
                {
                    title:'Account',
                    message:'created Successfully' + objAcc.id,
                    variant:'success',
                //    mode:'sticky'
                }
            );
            this.dispatchEvent(eve);})
        .catch((error) => {
            console.log('Error' , error );
            const eve = new ShowToastEvent(
            {
                title:'Account',
                message:'not Created' + error,
                variant:'error'
            }
        );
        this.dispatchEvent(eve);})
    }
    
    handleReset(){
        const accName = this.template.querySelector('lightning-input[data-name=txtAccName]').value="";
        const accPhone = this.template.querySelector('lightning-input[data-name=txtAccPhone]').value="";
        const accCity = this.template.querySelector('lightning-input[data-name=txtAccCity]').value="";
    }
}