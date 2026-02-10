// SOURCE ORG
trigger LeadTrigger on Lead (After insert) {
    IF(trigger.isInsert && trigger.isAfter){
    //    LeadTriggerHandler.afterInsert(trigger.newMap);
    }
}