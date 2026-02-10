public class BulkCourseEditController {
    public List<CourseModal> modalList {get;set;}
    public List<Course__c> editCousreList {get;set;}
    List<Course__c> CourseList {get;set;}
    public boolean allSelect {get;set;} 
    public boolean isEdit {get;set;}
    public Integer Index {get;set;} 
    
    public BulkCourseEditController(){
        editCousreList = new List<Course__c>();
        fillModal();
    }
    
    public void fillModal(){
        CourseList = [select Id, Name, Type_Of_Course__c, Course_Title__c, Duration__c, Fees__c from Course__c];
        modalList = new List<CourseModal>();
        allSelect = false;
        isEdit = false;
        Index = -1;
        for(integer i=0 ;i<CourseList.size(); i++){
            CourseModal oneCourse = new CourseModal();
            oneCourse.courseObj = CourseList[i];
            oneCourse.rowNum = i+1;
            modalList.add(oneCourse);
        }
    }
    public void saveAll(){
        update editCousreList;
        cancelAll();
    }
    public void deleteAll(){
        editAll();
        if(!editCousreList.isEmpty()){
    		delete editCousreList;
        	isEdit = false;
            fillModal();
        }
    }
    public void cancelAll(){
        for(CourseModal c : modalList){
            if(c.selectstatus == true)	
            c.selectstatus = false;	 
        }
		isEdit = false;
    }    
    public void allSelected(){      
        for(CourseModal c : modalList)	c.selectstatus = allSelect; 
    }
    
    public void editAll(){
        isEdit = true;
        editCousreList = new List<Course__c>();
        for(CourseModal c : modalList){
            if(c.selectstatus == true)	
        //    c.rowNum = Index;
            editCousreList.add(c.courseObj);		// kyse open ho rha h edit 
        }
    }
    
    public class CourseModal{
        public boolean selectstatus {get;set;}
        public Course__c courseObj {get;set;}
        public Integer rowNum {get;set;}
     
        public CourseModal(){ 
            selectstatus = false;
            courseObj = new Course__c();
            rowNum = 1;
            
        }
    }
}