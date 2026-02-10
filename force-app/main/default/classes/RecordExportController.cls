public class RecordExportController {
    public List<CustomerModal> custModalList {get;set;}
    public boolean allSelect {get;set;}
    public String emailbody {get;set;}
    public String toAddresses {get;set;}
    public String emailSubject {get;set;}
    
    public RecordExportController(){
        allSelect = false;
        custModalList = new List<CustomerModal>();
        Integer r = 1;
        for(Hotel_Customer__c h1Obj : [select id, name,First_Name__c, Last_Name__c,Gender__c, State__c, City__c, Phone_No__c, Email_ID__c from Hotel_Customer__c order by createdDate]){
            CustomerModal Cobj = new CustomerModal();
            Cobj.selectStatus = false;
            Cobj.rowNum = r++;
            Cobj.hObj = h1Obj;
            custModalList.add(Cobj);
        }
    }
    
    public void EmailIdSelection(){				// not work
        toAddresses = '';
        for(CustomerModal cm : custModalList){
            if(cm.selectStatus == true){
                toAddresses += cm.hObj.Email_ID__c + ';';
            }
        }
        toAddresses = toAddresses.substring(0,toAddresses.length()-1);
    }
    
    public void sendRecords(){
        String xmlBody = '<Customers>\n';
        String csvBody = 'FirstName, LastName, Gender, State, City, Phone_No__c \n';
        List<Hotel_Customer__c> myList = new List<Hotel_Customer__c>();
        for(CustomerModal cm : custModalList){
            if(cm.selectStatus){
                myList.add(cm.hObj);
                csvBody += cm.rowNum;
                csvBody += cm.hObj.First_Name__c + ',';
                csvBody += cm.hObj.Last_Name__c + ',';
                csvBody += cm.hObj.Gender__c + ',';
                csvBody += cm.hObj.State__c + ',';
                csvBody += cm.hObj.City__c + ',';
                csvBody += cm.hObj.Phone_No__c + '\n';
                
                xmlBody += '\t</Customer>\n';
                xmlBody += '\t\t<RowNo>' + cm.rowNum + '</rowNo>\n';
                xmlBody += '\t\t<FirstName>' + cm.hObj.First_Name__c + '</FirstName>\n';
                xmlBody += '\t\t<LastName>' + cm.hObj.Last_Name__c + '</LastName>\n';
                xmlBody += '\t\t<Gender>' + cm.hObj.Gender__c + '</Gender>\n';
                xmlBody += '\t\t<State>' + cm.hObj.State__c + '</State>\n';
                xmlBody += '\t\t<City>' + cm.hObj.City__c + '</City>\n';
                xmlBody += '\t\t<PhoneNo>' + cm.hObj.Phone_No__c + '</PhoneNo>\n';
                xmlBody += '\t</Customer>\n';
            }
        }
        xmlBody += '</Customers>\n';
        String jsonBody = JSON.serialize(myList);				// by json don't need to 28 line to 44
        Messaging.SingleEmailMessage emailObj  = new Messaging.SingleEmailMessage(); 
        
        emailObj.setSubject(emailSubject);  
        List<String> addressList = new List<String>();	 
        if(toAddresses.indexOf(';') != -1)
       		addressList = toAddresses.split(';'); 
        else 
            addressList.add(toAddresses);        
        emailObj.setToAddresses(addressList); 
        
        emailObj.setPlainTextBody(emailBody);
      
       	Messaging.EmailFileAttachment atchObj1 = new Messaging.EmailFileAttachment(); 
        atchObj1.setFileName('Customer.csv');  
        atchObj1.setBody(Blob.valueOf(csvBody));
        
        Messaging.EmailFileAttachment atchObj2 = new Messaging.EmailFileAttachment(); 
        atchObj2.setFileName('Customer.xml');  
        atchObj2.setBody(Blob.valueOf(xmlBody));
        
        Messaging.EmailFileAttachment atchObj3 = new Messaging.EmailFileAttachment(); 
        atchObj3.setFileName('Customer.json');  
        atchObj3.setBody(Blob.valueOf(jsonBody));	
        
        emailObj.setFileAttachments(new List<Messaging.EmailFileAttachment>{atchObj1, atchObj2, atchObj3});	  
        
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{emailObj});
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Record(s) Exported....!!!!'));
  
    } 
    public class CustomerModal{
        public boolean selectStatus {get;set;}
        public Integer rowNum {get;set;}
        public Hotel_Customer__c hObj {get;set;}
    }
}