import { LightningElement, wire } from 'lwc';
import { subscribe,MessageContext} from 'lightning/messageService';
import COUNTING_UPDATED_CHANNEL from '@salesforce/messageChannel/StudentDetail__c';
 

export default class SubLwc extends LightningElement {

    counter = 0;
    subscription = null;

    @wire(MessageContext)
    messageContext;

    connectedCallback(){
        this.subscribeToMessageChannel();
    }

    subscribeToMessageChannel(){
        this.subscription = subscribe(
            this.messageContext,
            COUNTING_UPDATED_CHANNEL,
            (message) => this.handleMessage(message)
        );
        console.log('mesage -> ', this.subscription);
    }

    handleMessage(message){
        //alert("message:"+JSON.stringify(message));
    //    console.log('handleMessage11 ->', message);
        if(message.operator == 'add'){

            this.counter += message.constant;
        }
        else if(message.operator == 'subtract'){

            this.counter -= message.constant;
        }
        else if(message.operator == 'multiply'){

            this.counter *= message.constant;
        }
    }
}