public class EmailController {
    public String fileName {get;set;}
    public Blob bodyName {get;set;}
    public String EmailBody {get;set;}
    public String addressSent {get;set;}
    public String CCAddress {get;set;}
    Public String emailSubject {get;set;}
    
    public void emailSendProcess(){
        Messaging.SingleEmailMessage emailObj;
        emailObj = new Messaging.SingleEmailMessage();
        emailObj.setSubject(emailSubject);
        
        List<String> addressList = new List<String>(); 
        if(addressList.indexOf(';') != -1)
            addressList = addressSent.split(';');
        else
        	addressList.add(addressSent);
        emailObj.setToAddresses(addressList);
        
        List<String> CCAddressList = new List<String>();
        CCAddressList = CCAddress.indexOf(';') != -1 ?CCAddress.split(';') : new List<String>{CCAddress};
        emailObj.setCCAddresses(CCAddressList);
        
        Messaging.EmailFileAttachment attachFile = new Messaging.EmailFileAttachment();
        attachFile.setFileName(fileName);
        attachFile.setBody(bodyName);
        emailObj.setFileAttachments(new List<Messaging.EmailFileAttachment>{attachFile});
        
        emailObj.setPlainTextBody(EmailBody);
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{emailObj});
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Email Sent....!!!!'));
    }
    public static void emailSend(){
        Messaging.SingleEmailMessage emailObj;
        emailObj = new Messaging.SingleEmailMessage();
        emailObj.setSubject('Selection in IT Company');
        
        List<String> addressList = new List<String>();
        addressList.add('mohammadkaifghosi998@gmail.com');
        addressList.add('deepakdetwal811@gmail.com');
        emailObj.setToAddresses(addressList);
        
        emailObj.setCCAddresses(new List<String>{'insafraza@gmail.com','karankhandal000@gmail.com'});
        emailObj.setBCCAddresses(new List <String>{'ishanali438@gmail.com'});
        
        emailObj.setPlainTextBody('Hello Sir,\n\t You are Selected for Infosys Company in Delhi...');
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{emailObj});
    }
}