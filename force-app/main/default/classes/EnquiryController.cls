public class EnquiryController {
    public String Fname {get;set;}
    public String Lname {get;set;}
	public String EmailId {get;set;}
    public String Phone {get;set;}  
    public String EnquiryFor {get;set;}
    public List<EnquiryModal> modalList {get;set;}
    
    public EnquiryController(){
        modalList = new List<EnquiryModal>();
        modalList.add(new EnquiryModal());
    }
    public void addRow(){
        modalList.add(new EnquiryModal());
    }
    
    public void sendEnquiry(){
      Messaging.SingleEmailMessage emailObj;
        emailObj = new Messaging.SingleEmailMessage();
        emailObj.setSubject(EnquiryFor);
        
        List<String> addressList = new List<String>();
        addressList.add('mohammadkaifghosi998@gmail.com');
        emailObj.setToAddresses(addressList);
        
        emailObj.setCCAddresses(new List<String>{'insafraza@gmail.com','karankhandal000@gmail.com'});
        emailObj.setBCCAddresses(new List <String>{'firstemail@7ixbcz03253xw2yi6oh0px5e0fpkqv5dixqz0wron26jn7xc6.2w-rlfnaeah.ap16.apex.salesforce.com'});
        
        String emailBody = '';
        emailBody += 'First Name :' + Fname + '\n';
        emailBody += 'Last Name :' + Lname + '\n';
        emailBody += 'Email Id :' + EmailId + '\n';
        emailBody += 'Phone No :' + Phone;
        
        emailObj.setPlainTextBody(emailBody);
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{emailObj});
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Enquery Sent....!!!!'));
    }
    
    public void sendBulkEnquiry(){
      Messaging.SingleEmailMessage emailObj;
        emailObj = new Messaging.SingleEmailMessage();
        emailObj.setSubject('BulkEnquiry');
        
        List<String> addressList = new List<String>();
        addressList.add('mohammadkaifghosi998@gmail.com');
        emailObj.setToAddresses(addressList);
        
        emailObj.setCCAddresses(new List<String>{'insafraza@gmail.com','karankhandal000@gmail.com'});
        emailObj.setBCCAddresses(new List <String>{'firstemail@7ixbcz03253xw2yi6oh0px5e0fpkqv5dixqz0wron26jn7xc6.2w-rlfnaeah.ap16.apex.salesforce.com'});
        
        String emailBody = 'Hello Sir, \nFind Enquiry the Attachment';  
        String atch = 'fname,lname,EmailId,Phone,EnquioryFor\n';
        for(EnquiryModal em : modalList){
            atch += em.Fname + ',';
            atch += em.Lname + ',';
            atch += em.EmailId + ',';
            atch += em.Phone + ',';
            atch += em.EnquiryFor + '\n';
        /*    emailBody += 'First Name :' + em.Fname + '\n';
            emailBody += 'Last Name :' + em.Lname + '\n';
            emailBody += 'Email Id :' + em.EmailId + '\n';
            emailBody += 'Phone No :' + em.Phone + '\n';
            emailBody += 'Enquiry :' + em.EnquiryFor + '\n';  */
        }
        
        Messaging.EmailFileAttachment atch1 = new Messaging.EmailFileAttachment();
        atch1.setFileName('Enquiry.csv');
        atch1.setBody(blob.valueOf(atch));
        emailObj.setFileAttachments(new List<Messaging.EmailFileAttachment>{atch1});
        
        emailObj.setPlainTextBody(emailBody);
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{emailObj});
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Enquery Sent....!!!!'));
    }
    
    public class EnquiryModal { 
        public String Fname {get;set;}
        public String Lname {get;set;}
        public String EmailId {get;set;}
        public String Phone {get;set;}  
        public String EnquiryFor {get;set;}
    }
}