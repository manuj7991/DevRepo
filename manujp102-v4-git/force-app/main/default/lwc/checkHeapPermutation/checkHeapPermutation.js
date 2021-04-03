import { LightningElement,track,api } from 'lwc';

export default class CheckHeapPermutation extends LightningElement {

    @api arr = ["a","a","b"];
    @api perm = [];

    generatePerm(k, arr){
        
        if(k === 1){

            this.perm.push(arr);
            console.log(arr);  
        }
        else{

            this.generate(k - 1, arr);

            // Generate permutations for kth swapped with each k-1 initial
            for(var i = 0; i < k-1; i++){
                // Swap choice dependent on parity of k (even or odd)
                if(k % 2 === 0)
                    this.swap(i,k-1);// zero-indexed, the kth is at k-1
                else
                    this.swap(0,k-1);
                this.generate(k - 1, arr);

            }
        }

    }

    swap(index1,index2){
  
       tmp = this.arr[index1];
       this.arr[index1] = this.arr[index2];
       this.arr[index2] =tmp; 

    }

    handleClick(){
        this.generatePerm(arr.length,arr);

    }

}