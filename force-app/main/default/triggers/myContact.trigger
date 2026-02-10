trigger myContact on Contact (before insert, before update) {
/*	List<Salgrades__c> SalgradeList = [select id, name, Job_Title__c, MaxSalary__c, MinSalary__c from Salgrades__c];
    
    for(contact conObj : Trigger.NEW){
        Salgrades__c res = null; 
        for(Salgrades__c s : SalgradeList){
            if(conObj.Post__c == s.Job_Title__c){
                res = s;
                break;
            }
        }
        if(res != null){
            String msg = 'Salary of ' + res.Job_Title__c +' must be in range of '+ res.MinSalary__c + ' to '+ res.MaxSalary__c;
			conObj.addError(msg);	
        }
    }  */
    Set<String> postSet = new Set<String>(); 
    for(Contact cObj : Trigger.NEW){
        if(cObj.Post__c != null && cObj.Salary__c != null && cObj.Salary__c > 0)	postSet.add(cObj.Post__c);
    }
    
    if(!postSet.isEmpty()){
        List<Salgrades__c> SalgradeList = [select id, name, Job_Title__c, MaxSalary__c, MinSalary__c from Salgrades__c where Job_Title__c in : postSet];
        
        Map<String,Salgrades__c> salGradMap = new Map<String,Salgrades__c>();
        if(SalgradeList != null && SalgradeList.size() > 0){ 
            for(Salgrades__c sm : SalgradeList){
                salGradMap.put(sm.Job_Title__c, sm);
            }        
        }
        
        for(Contact cObj : Trigger.NEW){
            Salgrades__c salgradeRecord = null;
            
            if(!salGradMap.isEmpty() && salGradMap.containsKey(cObj.Post__c))
                salgradeRecord = salGradMap.get(cObj.Post__c);
            
            if(salgradeRecord != null){
                if(cObj.Salary__c > salgradeRecord.MaxSalary__c && cObj.Salary__c < salgradeRecord.MinSalary__c){
                    String msg = 'Salary for ' + salgradeRecord.Job_Title__c + ' must be in range of ' + salgradeRecord.MaxSalary__c + ' to ' + salgradeRecord.MinSalary__c ;
                    cObj.Salary__c.addError(msg);
                }
            }
        }
    }
}