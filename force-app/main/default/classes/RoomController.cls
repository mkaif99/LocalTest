public class RoomController {
    public Room__c roomObj {get;set;}
    public boolean isEdit {get;set;}
    
    public RoomController(){
        roomObj = new Room__c();
        isEdit = false;
    }
    public void saveRecord(){			// output mode
        upsert roomObj;
        isEdit = false;
    }
    public PageReference SaveAndGo(){		// detail page
        saveRecord();
        PageReference pObj = new PageReference('/'+roomObj.Id);
        return pObj;
    }
    public void saveNew(){			// new page
        saveRecord();
        roomObj = new Room__c();
    }
    public void editRecord(){		// edit mode
        isEdit = true;
    }
    public PageReference deleteRecord(){
        delete roomObj;
        return new PageReference('/a0F/o');
    }
    public void cloneRecord(){
        roomObj.Id = null;
        isEdit = true;
    }   
}