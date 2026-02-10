public class PaginationController {
    public List<Course__c> CourseList {get;set;}
    public Integer pageSize {get;set;}
    public Integer pageNum {get;set;}
    public Integer totalPages {get;set;}
    ApexPages.StandardSetController sObj;
      
    public PaginationController(){
        CourseList = new List<Course__c>();
        String msg = 'select Name, Type_Of_Course__c, Course_Title__c, Duration__c, Fees__c from Course__c';
        Database.QueryLocator dObj = Database.getQueryLocator(msg);
        sObj = new ApexPages.StandardSetController(dObj);
        pageSize = 5;
        sObj.setPageSize(pageSize);
        CourseList = sObj.getRecords();
		pageNum = sObj.getPageNumber(); 
        
        totalPages = sObj.getResultSize() / pageSize;
        if(Math.mod(sObj.getResultSize(),pageSize)!=0)	totalPages++;
    }
    public void selectSize(){
        sObj.setPageSize(pageSize);
        CourseList = sObj.getRecords(); 
        totalPages = sObj.getResultSize() / pageSize;
        if(Math.mod(sObj.getResultSize(),pageSize)!=0)	totalPages++;
    }
    public void goPage(){
        sObj.setPageNumber(pageNum);
        CourseList = sObj.getRecords();
    }
    public void firstpage(){
        sObj.first();
        CourseList = sObj.getRecords();
        pageNum = sObj.getPageNumber();
    }
    public void prevpage(){
        sObj.previous();
        CourseList = sObj.getRecords();
        pageNum = sObj.getPageNumber();
    }
    public void nextpage(){
        sObj.next();
        CourseList = sObj.getRecords();
        pageNum = sObj.getPageNumber();
    }
    public void lastpage(){
        sObj.last();
        CourseList = sObj.getRecords();
        pageNum = sObj.getPageNumber();
    }
}