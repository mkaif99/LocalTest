public class MyEmailService implements Messaging.InboundEmailHandler {
    
    public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope){
         System.debug('-----> ' + email.subject);
        System.debug('-----> ' + email.fromAddress);
        System.debug('-----> ' + email.plainTextBody);
        System.debug('-----> ' + email.binaryAttachments.size());
        
        for(Messaging.InboundEmail.binaryAttachment atch : email.binaryAttachments){
            System.debug('---> Name of Attachments ' + atch.filename);
            System.debug('---> Body of Attachments ' + atch.body.toString());
        }
        
        Contact conObj = new Contact();
        conObj.Department = email.subject;
        
        String emailBody = email.plainTextBody;
        Integer colonPos = emailBody.indexOf(':');
        Integer newLinePos = emailBody.indexOf('\n');
        conObj.FirstName = emailBody.substring(colonPos+1,newLinePos);
        
        colonPos = emailBody.indexOf(':',colonPos+1);
        newLinePos = emailBody.indexOf('\n',newLinePos+1);
        conObj.LastName = emailBody.substring(colonPos+1, newLinePos);
        
        colonPos = emailBody.indexOf(':',colonPos+1);
        newLinePos = emailBody.indexOf('\n',newLinePos+1);
        conObj.Email = emailBody.substring(colonPos+1, newLinePos);
            
        colonPos = emailBody.indexOf(':',colonPos+1);   
        conObj.Phone = emailBody.substring(colonPos+1, newLinePos);
        
        insert conObj;
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        return result;
	}
}