import { LightningElement,wire,track } from 'lwc';
import getAccountsCvent from '@salesforce/apex/AccountConsumeService.getAccountsCvent';

export default class DisplayAccountREST extends LightningElement {

 
  @track result = [];
  @track error;


  handleLoad(){
    getAccountsCvent()
     .then( result => {
         this.result = JSON.parse(JSON.stringify(result));
         console.log(result);
     })
     .catch( error => {
        console.log(error);
        this.error = JSON.parse(JSON.stringify(error));
     });
  }


}