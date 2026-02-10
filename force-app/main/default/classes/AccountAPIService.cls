public class AccountAPIService {
    
    public class AccountResponse {
        public String Name;
        public String Type;
    }

    public static AccountResponse getAccountDetails(String accountId, String accessToken) {
        String endpoint = 'https://ibirds-6a-dev-ed.develop.my.salesforce.com/services/data/v64.0/sobjects/Account/' + accountId + '?fields=Name,Type';

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer ' + accessToken);
        req.setHeader('Content-Type', 'application/json');

        Http http = new Http();
        HTTPResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            return (AccountResponse) JSON.deserialize(res.getBody(), AccountResponse.class);
        } else {
            System.debug('Error: ' + res.getBody());
            return null;
        }
    }
}