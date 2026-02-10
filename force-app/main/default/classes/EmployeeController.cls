public class EmployeeController {
    public EmployeeModal eObj {get;set;}
    public List<EmployeeModal> EmployeeList {get;set;}
    public boolean isEdit {get;set;}
    public Integer Index {get;set;}
    
    public EmployeeController(){
        eObj = new EmployeeModal();
        EmployeeList = new List<EmployeeModal>();
        isEdit = true;
        Index = -1;
    }
    
   	public void saveEmp(){
        if(Index == null || Index == -1){
        	eObj.RecordNo = EmployeeList.size()+1;
        	EmployeeList.add(eObj);
        	eObj = new EmployeeModal();
        }
    }  
    
    public void Edit(){
        if(Index != null){
       		eObj = EmployeeList[Index-1];
        //    Index = -1;		wrong
        }
    }
    public void deleteRec(){
        if(Index != null){
       		EmployeeList.remove(Index-1);
            Index = -1; 
        }    
    }
    
    public class EmployeeModal{
        public Integer EmpNo {get;set;}
        public String EmpName {get;set;}
        public String Gender {get;set;}
        public String salary {get;set;}
        public Integer RecordNo {get;set;}
        
        public EmployeeModal(){
        /*    EmpNo = 101;
            EmpName = 'Kaif';
            Gender = 'Male';
            salary = '67583865554';	*/
        }
        public EmployeeModal(Integer EmpNo, String EmpName, String Gender, String salary){
            this.EmpNo = EmpNo;
            this.EmpName = EmpName;
            this.Gender = Gender;
            this.salary = salary;
        } 
    }
}