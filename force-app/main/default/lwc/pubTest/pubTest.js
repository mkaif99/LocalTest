import { LightningElement,wire } from 'lwc';
import { publish,MessageContext} from 'lightning/messageService';
import COUNTING_UPDATED_CHANNEL from '@salesforce/messageChannel/StudentDetail__c';

export default class PubLwc extends LightningElement {

    @wire(MessageContext)
    messageContext;
    
    handleIncrement(){
        const payload = {
            operator:'add',
            constant:1
        };
        console.log('payload1 -> ', payload);
        console.log('run1 ->',  publish(this.messageContext ,COUNTING_UPDATED_CHANNEL,payload ));
       
    }

    handleDecrement(){
        const payload = {
            operator:'subtract',
            constant:1
        };
        console.log('payload2 -> ', payload);
        publish(this.messageContext ,COUNTING_UPDATED_CHANNEL,payload );
        console.log('payload3 -> ', payload);

    }

    handleMultiply(){
        const payload = {
            operator:'multiply',
            constant:2
        };

        publish(this.messageContext ,COUNTING_UPDATED_CHANNEL,payload );

    }
}