public class ArrayController {
    public List<Integer> numlist {get;set;}		// 	Vector<Integer> vs = new Vector<Integer>(); It is an array
    public Integer numdata {get;set;}
    
    public ArrayController(){
        numlist = new List<Integer>{1,2,3,4,5,6,9,11,12,14,16};		// memory allocation of array obj
    }
    
    public void addData(){
        if(numdata!=null){
            numlist.add(numdata);
            numdata=null;				// Below is used for showing msg on pages on top
        }else	ApexPages.addMessage(new apexPages.Message(ApexPages.Severity.ERROR,'Please fill The Input box'));
    }
    public void removeData(){
        if(numdata>=0 && numdata<numlist.size()){
            numlist.remove(numdata);
            numdata=null;
        }
        else	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Invalid Index'));       
    }
    public void searchData(){
        Integer findIdx = numlist.indexOf(numdata);
        String msg = numdata + ' is found at '+findIdx +' Index';
        ApexPages.Message msgObj = new ApexPages.Message(ApexPages.Severity.INFO,msg);	// Initilitation
        ApexPages.addMessage(msgObj);		// For show on page by add
        numdata=null;
    }
}