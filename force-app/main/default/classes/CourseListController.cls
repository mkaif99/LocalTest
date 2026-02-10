public class CourseListController {
    public List<Course__c> courseList {get;set;}
    public String SearchValue {get;set;}
    
    CourseListController(){
        courseList = new List<Course__c>();
        courseList = [Select Id,Type_Of_Course__c,Course_Title__c,Duration__c,Fees__c from Course__c];
    }
    
    public void searchData(){
		courseList = [Select Id,Type_Of_Course__c,Course_Title__c,Duration__c,Fees__c from Course__c where Name like: searchValue];
	}
}