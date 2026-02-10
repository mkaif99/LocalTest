// SOURCE ORG
public class LeadTriggerHandler { 
    public static final String consumer_Key = '3MVG9GCMQoQ6rpzSQEOCRn2hjHmcl2BTUfMUes2k2oO7deYMcFFlMehY2nI06i7N01PO04REdjXbkcqadwFAA';
    public static final String secret_Key = '87820B2D3D32A8023ECBAEF0176941876DB9F775AE4913BFAB1493ED229201E0';
    public static final String USERNAME = 'kaif@ali.com';
    public static final String PASSWORD = '8060@sanaAQ75VIh9Tt6vdknTIQnhIHe2';

    public static void afterInsert(Map<Id,Lead> leadNewMap){
    
    } 
    
    public static void generateToken(){
    	String requestBody = 'grant_type=password&client_id='+consumer_Key+'&client_secret='+secret_Key+
            '&username='+USERNAME+'&password='+PASSWORD;   
        HTTP http = new HTTP();
        HTTPRequest request = new HTTPRequest();
        request.setBody(requestBody);
        request.setMethod('POST');
    	request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        HTTPResponse responses = http.send(request);
        System.debug(responses.getStatusCode());
        System.debug(responses.getBody());
    }
    
}