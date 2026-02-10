trigger Opportunityt on Opportunity (after insert, before update) {
	
    //Map<Id,Account> AccMap = new Map<Id,Account>([select id, Name, Accout_Type__c from Account]);
//    Map<String,String> TypeMap = new Map<String, String>([select Accout_Type__c from Account]); 
   
    for(Opportunity Obj : Trigger.NEW){
        system.debug('----' + Obj);
//        system.debug('--->'+AccMap.containsKey(Obj.AccountId));
        if(Obj.Stage__c != null && Obj.Account != null){
            //    system.debug('----' + Obj.Accout_Type__c);
                if(Obj.Stage__c == '10'){
                    Obj.Account.Accout_Type__c = 'Reseller';
                   // AccMap.get(Obj.AccountId).Accout_Type__c = 'Account';
                }
                if(Obj.Stage__c == '25'){
                    Obj.Account.Accout_Type__c = 'Byuer';
                }
            	if(Obj.Stage__c == '100'){
                    Obj.Account.Accout_Type__c = 'Current Customer';
                }
        }
    }
}