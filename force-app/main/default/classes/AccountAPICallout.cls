@RestResource(urlMapping='/getAccountDetails/*')
global with sharing class AccountAPICallout {

    global class AccountResponse {
        public String Name;
        public String Type;
    }

    @HttpGet
    global static List<AccountResponse> getAccountInfo() {
        // Get the Account Id from the URL parameter
        RestRequest req = RestContext.request;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);

        // Query the account
       List<Account> acc = [SELECT Name, Type FROM Account WHERE Name LIKE : (accountId + '%') LIMIT 20];

        List<AccountResponse> response = new List<AccountResponse>();
        
        for(Account a : acc){
            AccountResponse ax = new AccountResponse();
        	ax.Name = a.Name;
            ax.Type = a.Type;
            response.add(ax);
        }
        
      
        return response;
    }
}