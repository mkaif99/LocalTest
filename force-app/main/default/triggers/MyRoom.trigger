trigger MyRoom on Room__c (before insert, before update) {
	Set<String> roomSet = new Set<String>();
    for(Room__c rObj : Trigger.NEW){
        if(Trigger.isInsert && rObj.Type__c != null && rObj.Room_Charges__c != null && rObj.Room_Charges__c > 0)	
            roomSet.add(rObj.Type__c);
        if(Trigger.isUpdate && (rObj.Type__c != Trigger.oldMap.get(rObj.ID).Type__c || rObj.Room_Charges__c != Trigger.oldMap.get(rObj.ID).Room_Charges__c))
            roomSet.add(rObj.Type__c);
    }
    System.debug('---> RoomSet : ' + roomset);
    if(!roomSet.isEmpty()){ 
    	List<RoomFair__c> rfObj = [select id, name, Room_Type__c, MaxPrice__c, MinPrice__c from RoomFair__c where Room_Type__c in : roomSet];
    	Map<String,RoomFair__c> roomMap = new Map<String,RoomFair__c>();
    	
        System.debug('----> rfObj : ' + rfObj);
        if(rfObj != null && rfObj.size() > 0)
    		for(RoomFair__c r : rfObj)		roomMap.put(r.Room_Type__c, r);
        
        for(Room__c rObj : Trigger.NEW){
            RoomFair__c roomRec = null;
            System.debug('---> Entered Room Type : ' + rObj.Type__c);
            if(!roomMap.isEmpty() && roomMap.containsKey(rObj.Type__c))		roomRec = roomMap.get(rObj.Type__c);
            
            if(roomRec != null){
                String msg = 'Room Charge of ' + roomRec.Room_Type__c + ' must be in range of ' + roomRec.MaxPrice__c + ' to ' + roomRec.MinPrice__c;
            	rObj.addError(msg);
            }
        }
    }
}