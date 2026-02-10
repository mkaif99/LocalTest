public class ChairController {
    public ChairModal aObj {get;set;}
    public List<ChairModal> ChairList {get;set;}
    public boolean isEdit {get;set;}
    
    public ChairController(){
        aObj = new ChairModal();
    //    aObj.show();    
    //    ChairModal bObj = new ChairModal('DinnerChair', 300, 'Silver');
    //    bObj.show();

    	ChairList = new List<ChairModal>();		// memory allocation
        
        ChairModal temp = new ChairModal();		// 1st way of initialization
        ChairList.add(temp);
        ChairList.add(new ChairModal());  		// It use for bulk purchase by add new List
        ChairList.add(new ChairModal());		// aObj (2nd way) ->  It keep single input value in bulk show /
        ChairList.add(new ChairModal());		// 3rd way
        isEdit = false;
    }
    public void saveRecord(){
    	isEdit = true;    
    } 
    
    public void EditRecord(){
    	isEdit = false;    
    } 
    public class ChairModal{				// ANOMNOUS CLASS -> It is used for temporary data storage
        private String type; 		
        public Integer rate {get;set;}		// It makes automatically get,set
        public String color {get;set;}
        
        public ChairModal(){
        /*	type = 'StudyChair';
            rate = 400;
            color = 'Brown'; 	*/
        }
        public ChairModal(String type, Integer rate, String color){
            this.type = type;
            this.rate = rate;
            this.color = color;
        } 
        
        public void setType(String t){		type = t;	   }
        public String getType(){		return type;	   }
        
        public void show(){
            System.debug('Chair Type :' + type);	// It takes automatically gettype()
            System.debug('Chair Rate :' + rate);
            System.debug('Chair Color :' + color);
        }
    }
}