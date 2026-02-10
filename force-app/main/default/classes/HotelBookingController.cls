public class HotelBookingController {
    public Hotel_Booking__c hObj {get;set;} 
    public List<SelectOption> customerList {get;set;}
    public List<SelectOption> roomList {get;set;}
    public List<Hotel_Booking__c> BookList {get;set;}
    public List<HotelModal> hotelList {get;set;}
    public List<Hotel_Booking__c> edithotelList {get;set;}
    
    public Integer Index {get;set;}
    public boolean allSelect {get;set;}
    public boolean isEdit1 {get;set;}
    public boolean isEdit {get;set;}
    public boolean isEdit2 {get;set;}
    
    public Integer pageNum {get;set;}
    public Integer totalPage {get;set;}
    public Integer pageSize {get;set;}
    Integer skipRecord {get;set;}
    public List<Hotel_Booking__c> tempList;
    
    public Contact cObj {get;set;}
    public String selectCustomer {get;set;}
    public String selectRoom {get;set;}
    public String addEmail {get;set;}
    
/*    public String searchdata1 {get;set;}
    public String searchdata2 {get;set;}
    public String searchdata3 {get;set;}
    public String searchCriteria1 {get;set;} 
	public String searchCriteria2 {get;set;}  */
	public String searchCriteria1 {get;set;}   
    public boolean Searching {get;set;}		
    
    public HotelBookingController(){ 
        edithotelList = new List<Hotel_Booking__c>();
        isEdit1 = false;
        isEdit2 = false;
        cObj = new Contact();
        Searching = false;
        customerList = new List<SelectOption>();
        roomList = new List<SelectOption>();
           for(Hotel_Customer__c hObj : [select id, name,First_Name__c, Last_Name__c from Hotel_Customer__c order by createdDate]){
            customerList.add(new SelectOption(hObj.id,hObj.First_Name__c + ' ' + hObj.Last_Name__c));
        }
        
        for(Room__c rObj : [select id, name, Room_No__c from Room__c order by createdDate]){
            roomList.add(new SelectOption(rObj.id, rObj.Room_No__c));
        }
        fillModal();							  
    }
    public void fillModal(){
        BookList = new List<Hotel_Booking__c>();
        hotelList = new List<HotelModal>();
        hObj = new Hotel_Booking__c();
        
		pageNum = 1;
        pageSize = 6;
        tempList = [select id, name,  Hotel_Customer__c, Room_No__c, Customer_Email__c from Hotel_Booking__c];
        totalPage = tempList.Size()/pageSize;
        if(Math.mod(tempList.Size(),pageSize)!=0)	   totalPage++;
        String msg = 'select id, name, Hotel_Customer__c, Room_No__c, Customer_Email__c from Hotel_Booking__c order by createdDate LIMIT '+ pageSize;
        BookList = Database.query(msg);
        fillModal2();
        isEdit = false; 
        skipRecord = 0;        
    }
    public void fillModal2(){
        allSelect = false;
        hotelList = new List<HotelModal>();
        for(Integer i=0; i<BookList.Size(); i++){ 
        	HotelModal hm = new HotelModal();
            hm.hotelObj = BookList[i];
            hm.rowNum = i+1;
            hotelList.add(hm);
        }
    }
    public void clickNewRec(){ 
        isEdit = true;
        isEdit2 = false;
    }
    public pageReference newRecord(){         			// insert new record     
        Hotel_Booking__c hbObj = new Hotel_Booking__c();
        hbObj.Hotel_Customer__c = selectCustomer;
        hbObj.Room_No__c = selectRoom;
        addEmail = cObj.Email;
        hbObj.Customer_Email__c = addEmail;
  //      if(hbObj.ID != null){
        	upsert hbObj;
  //                      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Record Saved Successfully...!'));
  //      }
  //      else		    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Please Fill...!')); 
        isEdit2 = true;
        fillModal2();
        Index=0;
        return new pageReference('/' + hbObj.Id);
    }
    public void editRecord(){					// single edit save
        if(Index >= 0 && Index < BookList.size()) 
        	hObj = BookList[Index-1];
    }
     public void deleteRec(){  
        if(Index >= 0 && Index < BookList.size()){
            hObj = BookList[Index-1];
            delete hObj; 
            Index = 0;
        }
        fillModal();
    } 
     public void cancelRec(){ 					// single select cancel
        Index = 0;
        getPageNumber();
    //    fillModal2();
  /*      for(HotelModal hm : hotelList){ 
            if(hm.selectStatus == true){
                hm.isEdit1 = false;                       	
            }
        } */  
    }   
    		
//    									<------	Bulk Edit ------->
    public void editAll(){	
        isEdit1 = true;							// bulk edit open
        edithotelList = new List<Hotel_Booking__c>();
    /*     HotelModal hm = new HotelModal();
        for(integer i=0; i<hotelList.size(); i++){
            if(hm.selectStatus == true){ 
                isEdit1 = true;
                edithotelList.add(hm.hotelObj);                        	
            } 
        }	*/ 
       for(HotelModal hm : hotelList){ 
            if(hm.selectStatus == true){
                edithotelList.add(hm.hotelObj);                        	
            }
        }  
    }
    public void saveEdit(){						// bulk edit save
        update edithotelList;
        isEdit1 = false;
        cancelEdit();
        fillModal2();
    } 
   
    public void cancelEdit(){					// bulk select cancel
        Index = 0;
        isEdit1 = false;
        allSelect = false;
        allRecordSelect();
        fillModal2();
    }
    public void allRecordSelect(){
        edithotelList = new List<Hotel_Booking__c>();
        HotelModal h1 = new HotelModal();
        for(integer i=0; i<hotelList.size(); i++){
            h1 = hotelList[i]; 
            h1.selectStatus = allSelect;
        }	
    //    for(HotelModal h1 : hotelList)		h1.selectStatus = allSelect;  // same as above
    }
    
//								<------	Pagination -------> 

    public void selectPageSize(){
        skipRecord = 0;
        pageNum = 1;
        tempList = [select id, name, Hotel_Customer__c, Room_No__c, Customer_Email__c from Hotel_Booking__c order by name];
        totalPage = tempList.Size()/pageSize;
        if(Math.mod(tempList.Size(),pageSize)!=0)	   totalPage++;
        String msg = 'select id, name, Hotel_Customer__c, Room_No__c, Customer_Email__c from Hotel_Booking__c order by name LIMIT '+ pageSize;     
        BookList = Database.query(msg);
        fillModal2();
    }
    public List<SelectOption> getpageSizeList(){
    	List<SelectOption> optionList = new List<SelectOption>();
    	for(Integer i=3 ;i<=30; i+=3){
        	optionList.add(new SelectOption (String.valueOf(i), String.valueOf(i)));
    	}	 
    	return optionList;
	}
    public void getPageNumber(){ 
        skipRecord = pageSize*(pageNum-1); //(totalPage-pageNum) * pageSize; 
        String msg = 'select id, name, Hotel_Customer__c, Room_No__c, Customer_Email__c from Hotel_Booking__c order by name LIMIT '+ pageSize + ' OFFSET ' + skipRecord;     
        BookList = Database.query(msg);
        fillModal2();
    }
    public void firstPage(){
        skipRecord = 0;
        pageNum = 1;
        String msg = 'select id, name,  Hotel_Customer__c, Room_No__c, Customer_Email__c from Hotel_Booking__c order by name LIMIT '+ pageSize + ' OFFSET ' + skipRecord;     
        BookList = Database.query(msg);
        fillModal2();
    }
    public void prevpage(){
        pageNum--;
        if(pageNum <= 1) 	pageNum = 1;
        else{
            skipRecord -= pageSize;
            String msg = 'select id, name, Hotel_Customer__c, Room_No__c, Customer_Email__c from Hotel_Booking__c order by name LIMIT '+ pageSize + ' OFFSET ' + skipRecord;     
            BookList = Database.query(msg);
       		fillModal2();
        }
    } 
    public void nextpage(){
        pageNum++;
        if(pageNum > totalPage)		pageNum = totalPage;
        else{
            skipRecord += pageSize; 
            String msg = 'select id, name, Hotel_Customer__c, Room_No__c, Customer_Email__c from Hotel_Booking__c order by name LIMIT '+ pageSize + ' OFFSET ' + skipRecord;     
            BookList = Database.query(msg);
            fillModal2();
        }
    }
    public void lastpage(){
        skipRecord = (totalPage-1) * pageSize;
        String msg = 'select id, name, Hotel_Customer__c, Room_No__c, Customer_Email__c from Hotel_Booking__c order by name LIMIT '+ pageSize + ' OFFSET ' + skipRecord;     
        BookList = Database.query(msg);
        pageNum = totalPage;
        fillModal2();
    }
    
//											<------	Search Record ------->    
    
    public void searchClick(){ 
        Searching = true;
    }
    public void searchData(){
        Searching = false;
        String x = 'select id, name, Hotel_Customer__c, Room_No__c, Customer_Email__c from Hotel_Booking__c';
        if(searchCriteria1 != null && searchCriteria1 != ''){
            x += ' where name like \'' + searchCriteria1 +'\'';
            //    if(searchdata1 == 'Room_No__c'){
            //        x += ' like \'' + searchCriteria1 +'\'';  
            //    }
        }
        x += ' Order By CreatedDate '; 
        
        System.debug('---> My Query is : ' + x); 
        BookList = Database.query(x);
        fillModal2();
     }	
    
//	    						 ModalClass 
	public class HotelModal{
        public Hotel_Booking__c hotelObj {get;set;} 
        public boolean selectStatus {get;set;}
        public Integer rowNum {get;set;}
    	
        
        public HotelModal(){
            hotelObj = new Hotel_Booking__c();
            selectStatus = false;
            rowNum = 1;
           
        }
	}
}