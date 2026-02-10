public class HotelController { 
    public Hotel_Customer__c hObj {get;set;} 
    public List<Hotel_Customer__c> CustomerList {get;set;}
    public List<HotelModal> hotelList {get;set;}
    public List<Hotel_Customer__c> edithotelList {get;set;}
    
    public String IdIndex {get;set;}
    public Integer Index {get;set;}
    public boolean allSelect {get;set;}
    public boolean isEdit1 {get;set;}
    public boolean isEdit {get;set;}
    public boolean isEdit2 {get;set;}
    public boolean isEdit3 {get;set;}
    
    public Integer pageNum {get;set;}
    public Integer totalPage {get;set;}
    public Integer pageSize {get;set;}
    Integer skipRecord {get;set;}
    public List<Hotel_Customer__c> tempList;
    
    public String searchdata1 {get;set;}
    public String searchdata2 {get;set;}
    public String searchdata3 {get;set;}
    public String searchCriteria1 {get;set;} 
	public String searchCriteria2 {get;set;} 
	public String searchCriteria3 {get;set;}   
    public boolean Searching {get;set;}
    
    public HotelController(){ 
        edithotelList = new List<Hotel_Customer__c>();
        isEdit1 = false;
        isEdit2 = false;
        isEdit3 = false;
        Searching = false;
        IdIndex = 'a0H2w00000KThYQ';
        fillModal();							  
    }
    public void fillModal(){
        CustomerList = new List<Hotel_Customer__c>();
 //       CustomerList = [select id, name, First_Name__c, Last_Name__c, Gender__c, State__c, City__c , Phone_No__c from Hotel_Customer__c order by name];
        hotelList = new List<HotelModal>();
        hObj = new Hotel_Customer__c();
        
		pageNum = 1;
        pageSize = 6;
        tempList = [select id, name, First_Name__c, Last_Name__c, Gender__c, State__c, City__c , Phone_No__c from Hotel_Customer__c];
        totalPage = tempList.Size()/pageSize;
        if(Math.mod(tempList.Size(),pageSize)!=0)	   totalPage++;
        String msg = 'select id, name, First_Name__c, Last_Name__c, Gender__c, State__c, City__c , Phone_No__c from Hotel_Customer__c order by name LIMIT '+ pageSize;
        CustomerList = Database.query(msg);
        fillModal2();
        isEdit = false; 
        skipRecord = 0;        
    }
    public void fillModal2(){
        allSelect = false;
        hotelList = new List<HotelModal>();
        for(Integer i=0; i<CustomerList.Size(); i++){ 
        	HotelModal hm = new HotelModal();
            hm.hotelObj = CustomerList[i];
            hm.rowNum = i+1;
            hotelList.add(hm);
        }
    }
    public void clickNewRec(){ 
        isEdit = true;
        isEdit2 = false;
    }
    public void newRecord(){         			// insert new record
        upsert hObj; 
        isEdit2 = true;
        fillModal2();
        Index=0;
    }
    public void editRecord(){					// single edit save
        if(Index >= 0 && Index < CustomerList.size()) 
        	hObj = CustomerList[Index-1];
        System.debug('---'+ hObj);
    }
    public void clickRec(){
        hObj = new Hotel_Customer__c();
        isEdit3 = true;
        if(IdIndex != null){
            String msg = 'select name, First_Name__c, Last_Name__c, Gender__c, State__c, City__c , Phone_No__c from Hotel_Customer__c where id =  \'' + IdIndex +'\'';     
            System.debug('---'+ msg + '---' + hObj);
            hObj = Database.query(msg);
        }
    //    fillModal2();
    }
    public void deleteRec(){  
        if(Index >= 0 && Index < CustomerList.size()){
            hObj = CustomerList[Index-1];
            System.debug('---' + hObj);
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
        edithotelList = new List<Hotel_Customer__c>();
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
        edithotelList = new List<Hotel_Customer__c>();
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
        tempList = [select id, name, First_Name__c, Last_Name__c, Gender__c, State__c, City__c , Phone_No__c from Hotel_Customer__c order by name];
        totalPage = tempList.Size()/pageSize;
        if(Math.mod(tempList.Size(),pageSize)!=0)	   totalPage++;
        String msg = 'select id, name, First_Name__c, Last_Name__c, Gender__c, State__c, City__c , Phone_No__c from Hotel_Customer__c order by name LIMIT '+ pageSize;     
        CustomerList = Database.query(msg);
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
        String msg = 'select id, name, First_Name__c, Last_Name__c, Gender__c, State__c, City__c , Phone_No__c from Hotel_Customer__c order by name LIMIT '+ pageSize + ' OFFSET ' + skipRecord;     
        CustomerList = Database.query(msg);
        fillModal2();
    }
    public void firstPage(){
        skipRecord = 0;
        pageNum = 1;
        String msg = 'select id, name, First_Name__c, Last_Name__c, Gender__c, State__c, City__c , Phone_No__c from Hotel_Customer__c order by name LIMIT '+ pageSize + ' OFFSET ' + skipRecord;     
        CustomerList = Database.query(msg);
        fillModal2();
    }
    public void prevpage(){
        pageNum--;
        if(pageNum <= 1) 	pageNum = 1;
        else{
            skipRecord -= pageSize;
            String msg = 'select id, name, First_Name__c, Last_Name__c, Gender__c, State__c, City__c , Phone_No__c from Hotel_Customer__c order by name LIMIT '+ pageSize + ' OFFSET ' + skipRecord;     
            CustomerList = Database.query(msg);
       		fillModal2();
        }
    } 
    public void nextpage(){
        pageNum++;
        if(pageNum > totalPage)		pageNum = totalPage;
        else{
            skipRecord += pageSize; 
            String msg = 'select id, name, First_Name__c, Last_Name__c, Gender__c, State__c, City__c , Phone_No__c from Hotel_Customer__c order by name LIMIT '+ pageSize + ' OFFSET ' + skipRecord;     
            CustomerList = Database.query(msg);
            fillModal2();
        }
    }
    public void lastpage(){
        skipRecord = (totalPage-1) * pageSize;
        String msg = 'select id, name, First_Name__c, Last_Name__c, Gender__c, State__c, City__c , Phone_No__c from Hotel_Customer__c order by name LIMIT '+ pageSize + ' OFFSET ' + skipRecord;     
        CustomerList = Database.query(msg);
        pageNum = totalPage;
        fillModal2();
    }
    
//											<------	Search Record ------->    
    
    public void searchClick(){ 
        Searching = true;
    }
    public void searchData(){		// all three fill are must
        Searching = false;
        String x = 'select id, name, First_Name__c, Last_Name__c, Gender__c, State__c, City__c , Phone_No__c from Hotel_Customer__c';
        if(searchdata1 != null && searchdata1 != '' && searchCriteria1 != null && searchCriteria1 != ''){

            x += ' where ' + searchdata1;
            if(searchdata1 == 'First_Name__c'){
                x += ' like \'' + searchCriteria1 +'\'';  
            }else if(searchdata1 == 'Last_Name__c'){
                x += ' like \'' + searchCriteria1 + '\'';
            }else if(searchdata1 == 'City__c'){
                x += ' like \'' + searchCriteria1 + '\'';
            }
        }
        if(searchdata2 != null && searchdata2 != '' && searchCriteria2 != null && searchCriteria2 != ''){

            x += ' and ' + searchdata2;
            if(searchdata2 == 'First_Name__c'){
                x += ' like \'' + searchCriteria2 +'\''; 
            }else if(searchdata2 == 'Last_Name__c'){
                x += ' like \'' + searchCriteria2 + '\'';
            }else if(searchdata2 == 'City__c'){
                x += ' like \'' + searchCriteria2 + '\'';
            }
        }
        if(searchdata3 != null && searchdata3 != '' && searchCriteria3 != null && searchCriteria3 != ''){ 

            x += ' and ' + searchdata3;
            if(searchdata3 == 'First_Name__c'){
                x += ' like \'' + searchCriteria3 +'\''; 
            }else if(searchdata3 == 'Last_Name__c'){
                x += ' like \'' + searchCriteria3 + '\'';
            }else if(searchdata3 == 'City__c'){
                x += ' like \'' + searchCriteria3 + '\'';
            }
        }
        x += ' Order By CreatedDate '; 
        
//        System.debug('---> My Query is : ' + x); 
        CustomerList = Database.query(x);
        fillModal2();
    }
    
//	    						 ModalClass 
	public class HotelModal{
        public Hotel_Customer__c hotelObj {get;set;} 
        public boolean selectStatus {get;set;}
        public Integer rowNum {get;set;}
    	
        
        public HotelModal(){
            hotelObj = new Hotel_Customer__c();
            selectStatus = false;
            rowNum = 1;
           
        }
	}
}