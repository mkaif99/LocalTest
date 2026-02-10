public class CourseController {
    public Course__c courseObj {get;set;}
    public boolean isEditClick {get;set;}
    public CourseController(){
        courseObj = new Course__c();
        isEditClick = false;
    }
    public void saveRecord(){		// Quick Save
     /*   if(courseObj.Id==null)	insert courseObj;
        else{
            update courseObj;
            isEditClick = false;
        }	*/
        upsert courseObj;
        isEditClick = false;
      //  if(isEditClick==true)	update courseObj;	apna logic
     //   else 	insert courseObj;
       
    }
    public PageReference saveGo(){	//Save
        saveRecord();
        PageReference Pobj = new PageReference('/'+courseObj.Id);
        // Pobj.setRedirect(true);
        return Pobj;
    }
  
     public void saveNew(){
        saveRecord();
        courseObj = new Course__c();
    }
    
    public void editRecord(){
        isEditClick = true;
    }
    public PageReference deleteRecord(){
       delete courseObj;
        return new PageReference('/a00/o');
    }
    public void cloneRecord(){
      
    }
}