trigger AccountT on Account (before insert, before update) {
    for(Account a : Trigger.NEW){
        if(Trigger.isInsert && a.Rating != null && a.Salary__c != null){
            a.Salary__c += a.Salary__c * 0.10;
        }
        if(Trigger.isUpdate && a.Rating != Trigger.oldMap.get(a.Id).Rating && a.Salary__c != null){ // if we dont write this
            a.Salary__c += a.Salary__c * 0.10;
        }
    }
}