@isTest
private class TestContactTrigger {
    @testSetup
    private static void testData(){
        List<Salgrades__c> salgradList = new List<Salgrades__c>();
        Salgrades__c sal = new Salgrades__c();
        sal.Job_Title__c = 'CLERK';
        sal.MaxSalary__c = 5000;
        sal.MinSalary__c = 1000;
        salgradList.add(sal);
        salgradList.add(new Salgrades__c(Job_Title__c='MANAGER', MaxSalary__c=15000, MinSalary__c=10000));
        if(!salgradList.isEmpty())	insert salgradList;
    }
    
    private static testMethod void testControllerNegative(){
        Contact cObj = new Contact();
        cObj.FirstName = 'Amit'; 
        cObj.LastName  = 'Rane';
        cObj.Post__c = 'CLERK';
        cObj.Salary__c = 10;
        try{
        	insert cObj;
        }catch(Exception e){}
        List<Contact> c = [select id, name from Contact];
        System.assertEquals(c.size(), 0);
    }
    
    private static testMethod void testControllerPositive(){
        Contact cObj = new Contact();
        cObj.FirstName = 'Amit'; 
        cObj.LastName  = 'Rane'; 
        cObj.Post__c = 'CLERK';
        cObj.Salary__c = 2000;
        try{
        	insert cObj;
        }catch(Exception e){}
        List<Contact> c = [select id, name from Contact];
        System.assertEquals(c.size(), 1);
    }
    
    /*
	private testMethod static void testUpdateEventNegative(){
        Contact conObj = new Contact(); 
        conObj.FirstName = 'Amit'; 
        conObj.LastName  = 'Rane'; 
        conObj.Post__c   = 'Clerk';
        conObj.Salary__c = 2000; 
		insert conObj; 
		List<Contact> conList1 = [Select Id,Salary__c from Contact];
        
		conObj.Salary__c = 50;
		Test.startTest();		        
        	try{        update conObj; 		}
        	catch(Exception eObj){}
        Test.StopTest();
        
        List<Contact> conList2 = [Select Id,Salary__c from Contact]; 
        System.assertEquals(conList1[0].Salary__c, conList2[0].Salary__c); 
    }
		*/
}