trigger AccountRollUp on Account (before insert) {
	List <Account> actList = [Select Id, name, Rating from Account where Rating != null];
    Map<String,Integer> ratingMap = new Map<String,Integer>();
    
    Integer totalHot, totalWarm, totalCold;
    
    for(Account a : actList){
        if(ratingMap.containsKey(a.Rating)){
            if(a.Rating == 'Hot')	totalHot++;
            else if(a.Rating == 'Cold')		totalCold++;
            else if(a.Rating == 'Warm')		totalWarm++;
            else{
                totalHot = 0;
                totalCold = 0;
                totalWarm = 0;
            }
        }
        ratingMap.put('Hot',totalHot);
    }
    for(Account a : Trigger.NEW){
        if(a.rating != null){
            
        }
    }
}