@isTest
private class TestPaginationPage {
	
	@testSetup
    private static void addTestMethod(){
        Course__c oneCourse = new Course__c();
        
        List<Course__c> course1 = new List<Course__c>();	 //		[select id, name, Fees__c from Course__c]; 
        for(integer i = 1; i<14; i++)
           course1.add(new Course__c(Type_Of_Course__c='Graduate', Course_Title__c='BCA', Duration__c=24 + i, Fees__c=30000 * i)); 
        
        if(!course1.isEmpty())
            insert course1;
    }
    private static testMethod void testConstructor(){
        PaginationController Obj = new PaginationController();
        System.assertEquals(obj.pageSize, Obj.courseList.size());
   //     System.assertEquals(obj.totalPages,4);
    }
    
    private static testMethod void testSize(){
        PaginationController obj = new PaginationController();
        Obj.pageSize = 6;
        Obj.selectSize();
        System.assertEquals(obj.totalPages,3);
    }
    
    private static testMethod void testNavigation(){
        PaginationController Obj = new PaginationController();
        
        Obj.nextPage();
        System.assertEquals(obj.pageNum, 2);
        
        Obj.lastPage();
 		System.assertEquals(obj.pageNum, obj.totalPages);
        
        Obj.prevPage();
        System.assertEquals(obj.pageNum, obj.totalPages-1);
        
        Obj.firstpage();
        System.assertEquals(obj.pageNum, 1);
        
        obj.pageNum = 3; 
        obj.goPage();
        System.assertEquals(obj.pageNum,3);
        
        
    }
}