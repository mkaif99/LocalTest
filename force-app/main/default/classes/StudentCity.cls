public with sharing class StudentCity {
    
    @AuraEnabled(cacheable=true)  // used to store data on web browser ram (no need to add again and again)
    public static List<Student__c> getContacts(String city){
        return [
         		select Id,First_Name__c, Last_Name__c,Full_Name__c, City__c, Email__c, Phone__c, ImageUrl__c from Student__c 
             	where city__c =: city and ImageUrl__c !=: null
        ];
  /*      if(cityName.equalsIgnoreCase('All')){
            return [
         		select First_Name__c, Last_Name__c,Full_Name__c, Email__c, Phone__c, ImageUrl__c from Student__c 
        		];
        	} */
        
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Student__c> getStudentDetail(String studentName){
        if(studentName != null) return [
         		select Id,Full_Name__c, City__c,Email__c, ImageUrl__c from Student__c 
             	where Id =: studentName
        ];
        return [
         		select Id,Full_Name__c, City__c,Email__c,  ImageUrl__c from Student__c 
             	where Id =: 'a01Ig00000AEWO4IAP'
        ];
    }
    
    @AuraEnabled(cacheable = true)
    public static List<String> getCities(){
        Set<String> citySet = new Set<String>();
        List<Student__c> students = [Select City__c from Student__c where City__c != null];
        //System.debug('###'+ contacts);
  
        for (Student__c st : students) {
            if (st.City__c != null) {
                citySet.add(st.City__c);
            }
        }
        List<String> CityList = new List<String>(citySet);
        return CityList;  
    }
    
 //   @AuraEnabled(cacheable=true)
//    public static List<Contact> getAccContact(String accId){
 //       return [Select id, FirstName , LastName, Email, Phone from Contact where accountId = : accId];
  //  } 
}