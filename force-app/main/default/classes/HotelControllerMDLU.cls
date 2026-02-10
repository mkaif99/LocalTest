public class HotelControllerMDLU {				// masterdetail
    public Contact cObj {get;set;}
    public List<SelectOption> customerList {get;set;}
    public List<SelectOption> roomList {get;set;}
    public List<Hotel_Booking__c> BookList {get;set;}
    public String selectCustomer {get;set;}
    public String selectRoom {get;set;}
    public String addEmail {get;set;}
    
    public HotelControllerMDLU(){
        BookList = new List<Hotel_Booking__c>();
        cObj = new Contact();
        selectCustomer = null;
        selectRoom = null;
        addEmail = null;
        customerList = new List<SelectOption>();
        roomList = new List<SelectOption>();
         
 /*       for(Hotel_Customer__c hObj : [select id, name,First_Name__c, Last_Name__c from Hotel_Customer__c order by createdDate]){
            customerList.add(new SelectOption(hObj.id,hObj.First_Name__c + ' ' + hObj.Last_Name__c));
        } 
        
        for(Room__c rObj : [select id, name, Room_No__c from Room__c order by createdDate]){
            roomList.add(new SelectOption(rObj.id, rObj.Room_No__c));
        }	*/
        String msg = 'select id, name, Hotel_Customer__c, Room_No__c, Customer_Email__c from Hotel_Booking__c';
        BookList = Database.query(msg);
    } 
    public pageReference newRecord(){
        Hotel_Booking__c hbObj = new Hotel_Booking__c();
        hbObj.Hotel_Customer__c = selectCustomer;
        hbObj.Room_No__c = selectRoom;
        addEmail = cObj.Email;
        hbObj.Customer_Email__c = addEmail;
        insert hbObj;
        return new pageReference('/' + hbObj.Id);
    }
}