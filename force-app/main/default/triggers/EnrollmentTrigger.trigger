trigger EnrollmentTrigger on Enrollment__c (after insert) {
	Set<String> courseSet = new Set<String>();
    Set<String> studentSet = new Set<String>();
    
    for(Enrollment__c enObj : Trigger.NEW){
        if(enObj.Enrolling_Course__c != null)		courseSet.add(enObj.Enrolling_Course__c);
        if(enObj.Enrolling_Student__c != null)		studentSet.add(enObj.Enrolling_Course__c);
    }
    
    if(!courseSet.isEmpty() && !studentSet.isEmpty()){
//        List<Course__c> courseList = [select id, name, Fees__c from Course__c where id in : courseSet];
//        List<Student__c> studentList = [select id, name, Total_Payable_Amt__c from Student__c where id in : studentSet];
        
        Map<ID,Course__c> courseMap = new Map<ID,Course__c>([select id, name, Fees__c from Course__c where id in : courseSet]);
        Map<ID,Student__c> studentMap = new Map<ID,Student__c>([select id, name, Total_Payable_Amt__c from Student__c where id in : studentSet]);
        for(Enrollment__c enObj : Trigger.NEW){
            Course__c coRec = null;
            
            if(!courseMap.isEmpty() && courseMap.containsKey(enObj.Enrolling_Course__c)){
               	coRec = courseMap.get(enObj.Enrolling_Course__c);  // enObj.Id - if i write this
            }
               
            Student__c stRec = (!studentMap.isEmpty() && studentMap.containsKey(enObj.Enrolling_Student__c))  ?studentMap.get(enObj.Enrolling_Student__c) :null;
/*            for(Student__c s : studentList){
                if(s.ID == enObj.Enrolling_Student__c){
                    stRec = s;
                    break;
                }
            }
            for(Course__c c : courseList){
                if(c.ID == enObj.Enrolling_Course__c){
                    coRec = c;
                    break;
                }
            }		*/
            if(stRec != null && coRec != null)		stRec.Total_Payable_Amt__c += coRec.Fees__c;
            System.debug(stRec.Total_Payable_Amt__c += coRec.Fees__c);
        }
        
        if(!studentMap.isEmpty())		update studentMap.values();
    }
}