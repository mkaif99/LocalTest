public class BulkProductController {
 // public MyProduct__c productObj {get;set;}  				// It is a single obj 
    
    public List<MyProduct__c> productList {get;set;}		// 	Vector<Integer> vs = new Vector<Integer>(); It is an array
    public boolean isEdit {get;set;}
    public Integer Deldata {get;set;}
    
    public BulkProductController(){
	//	productObj = new MyProduct__c();					// memory allocation of single obj
        
        productList = new List<MyProduct__c>();				// memory allocation of array obj
     	productList.add(new MyProduct__c());				// make new obj by add
        productList.add(new MyProduct__c());
        productList.add(new MyProduct__c());
        isEdit = false;
    }
    public void saveRecord(){
        try{
            upsert productList;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Record Saved Successfully...!'));
        }catch(Exception eobj){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,eobj.getMessage()));
        }
       
        isEdit = true;
    }
    public void editRecord(){
        isEdit = false;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Record Edited Successfully...!'));
    }
    public PageReference deleteRecord(){
        delete productList;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Record Deleted Successfully...!'));
        return new PageReference('/a04/o');
    }
    public void saveAll(){
      for(Integer i=0; i<productList.size(); i++){
              MyProduct__c P = productList[i];
              if(i==0){
                  if(P.Product_Name__c == null && P.Brand__c == null && P.Rate__c == null && P.Stock__c == null){
                       	ApexPages.addMessage(new apexPages.Message(ApexPages.Severity.ERROR,'Please fill The Input box'));
                  }    // not complete
             }                                
             else if(P.Product_Name__c == null && P.Brand__c == null && P.Rate__c == null && P.Stock__c == null){	
                    productList.remove(i);
                i--;
       		}
      }
			upsert productList;
            isEdit = false;
    }
    public void AddRow(){
        productList.add(new MyProduct__c());
        ApexPages.addMessage(new apexPages.Message(ApexPages.Severity.INFO,'Row added Sucessfully..'));
    }
    public void RemoveRow(){
        productList.remove(productList.size()-1);
        ApexPages.addMessage(new apexPages.Message(ApexPages.Severity.INFO,'Row Removed Sucessfully..'));

    }
    
    
}