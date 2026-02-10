public class ProductSearchController {
    public List<MyProduct__c> productList {get;set;}
    public String searchsingleData {get;set;}
    public String searchdata {get;set;}
    public String searchCriteria {get;set;}
    
    public ProductSearchController(){
  		productList = new List<MyProduct__c>();     
    }
    
    public void search1(){
        productList = [Select Id, Name,Product_Name__c,Brand__c,Rate__c,Stock__c from MyProduct__c where Product_Name__c like: searchsingleData];
    }
    public void search2(){
        String x = 'Select Id, Name,Product_Name__c,Brand__c,Rate__c,Stock__c from MyProduct__c';
        x += ' where ' + searchdata;
        
        if(searchdata == 'Product_Name__c'){
            x += ' like \'' + searchCriteria +'\''; 
        }else if(searchdata == 'Brand__c'){
            x += ' = \'' + searchCriteria + '\'';
        }else{
            x += searchCriteria;
        }
        System.debug('<-->' + x);
        productList = Database.query(x); 
    }
}