public with sharing class ContactController {
    public String name {get;set;}
    public String Emailid {get;set;}
    public String Phone {get;set;}
    public ContactUs__c cObj {get;set;}
//    public List<ContactUs__c> contactList {get;set;}
    
    public ContactController(){
       cObj = new ContactUs__c();
    }
    
    public void newRecord(){
        insert cObj; 
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Record Send Successfully...!'));
    }
    
    @AuraEnabled(cacheable=true)
    public static Contact createContact(String firstnam , String lastnam){
        List<Contact> conList = new List<Contact>();
        Contact con = new Contact(FirstName = firstnam,LastName = lastnam);
       
            System.debug('conList->' + con); 
            insert con;
			       	  
       
      /*  if(!conList.isEmpty()){
            insert conList; 
            return conList;
        }	 */
        return con;
    }
}