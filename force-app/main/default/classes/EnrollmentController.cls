public class EnrollmentController {
    public Course__c courseObj {get;set;}
    public Student__c studentObj {get;set;}
    public Enrollment__c enrolObj {get;set;}
    public boolean isEdit {get;set;}
    
    public EnrollmentController(){
        courseObj = new Course__c();
        studentObj = new Student__c();
        enrolObj = new Enrollment__c();
        isEdit = false;
    }
    public void saveRecord(){
        insert courseObj;
        insert studentObj;
        
        enrolObj.Enrolling_Course__c = courseObj.Id;
        enrolObj.Enrolling_Student__c = studentObj.Id; 
        insert enrolObj;
    }
    public void isEdit(){
        isEdit = true;
    }
	public PageReference deleteRecord(){
        delete enrolObj;
        return new PageReference('/a02/o');
    }
}