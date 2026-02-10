public class PaginationCustomController {
    public List<Course__c> courseList {get;set;}
    public Integer pageNum {get;set;}
    public Integer pageSize {get;set;}
    public Integer totalPage {get;set;}
    Integer skipRecord {get;set;}
    public List<Course__c> tempList;
    
    public PaginationCustomController(){
        courseList = new List<Course__c>(); 
        pageSize = 6;
        tempList = [select Name, Type_Of_Course__c, Course_Title__c, Duration__c, Fees__c from Course__c];
        totalPage = tempList.Size()/pageSize;
        if(Math.mod(tempList.Size(),pageSize)!=0)	   totalPage++;
        String msg = 'select Name, Type_Of_Course__c, Course_Title__c, Duration__c, Fees__c from Course__c LIMIT '+ pageSize;
        courseList = Database.query(msg);
        pageNum = 1;    
        skipRecord = 0;
	}
    public List<SelectOption> getpageSizeList(){
        List<SelectOption> optionList = new List<SelectOption>();
        for(Integer i=3 ;i<=30; i+=3){
            optionList.add(new SelectOption (String.valueOf(i), String.valueOf(i)));
        } 
        return optionList;
    }
    public void selectPageSize(){
        pageNum = 1;
        tempList = [select Name, Type_Of_Course__c, Course_Title__c, Duration__c, Fees__c from Course__c];
        totalPage = tempList.Size()/pageSize;
        if(Math.mod(tempList.Size(),pageSize)!=0)	   totalPage++;
        String msg = 'select Name, Type_Of_Course__c, Course_Title__c, Duration__c, Fees__c from Course__c LIMIT '+ pageSize;     
        courseList = Database.query(msg);
        
    }
    public void getPageNumber(){
        String msg = 'select Name, Type_Of_Course__c, Course_Title__c, Duration__c, Fees__c from Course__c LIMIT '+ pageSize +' OFFSET '+ pageSize*(pageNum-1);     
        courseList = Database.query(msg);
    }
    public void firstPage(){
        skipRecord = 0;
        pageNum = 1;
        String msg = 'select Name, Type_Of_Course__c, Course_Title__c, Duration__c, Fees__c from Course__c LIMIT '+ pageSize;     
        courseList = Database.query(msg);
    }
    public void lastPage(){
        skipRecord = (totalPage-1) *  pageSize;
        String msg = 'select Name, Type_Of_Course__c, Course_Title__c, Duration__c, Fees__c from Course__c LIMIT '+ pageSize + ' OFFSET ' + skipRecord;     
        courseList = Database.query(msg);
        pageNum = totalPage;
    }
    public void nextPage(){
        pageNum++;
        if(pageNum > totalPage)		pageNum = totalPage;
        else{
            skipRecord += pageSize;
        	String msg = 'select Name, Type_Of_Course__c, Course_Title__c, Duration__c, Fees__c from Course__c LIMIT '+ pageSize + ' OFFSET ' + skipRecord;     
        	courseList = Database.query(msg);
        }
    }
    public void prevPage(){
        pageNum--;
        if(pageNum <= 1)			pageNum = 1;
        else{
            skipRecord -= pageSize;
            String msg = 'select Name, Type_Of_Course__c, Course_Title__c, Duration__c, Fees__c from Course__c LIMIT '+ pageSize + ' OFFSET ' + skipRecord;     
            courseList = Database.query(msg);
        }
    }
}