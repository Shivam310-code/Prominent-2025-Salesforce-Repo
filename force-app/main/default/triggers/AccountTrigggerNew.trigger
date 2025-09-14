trigger AccountTrigggerNew on Account (After insert) {
    
    if(Trigger.isAfter && Trigger.isInsert){
        
       // futureExample.creteOpp(Trigger.New); We can not directly call Trigger.New in Method of Class
          futureExample.creteOpp(trigger.NewMap.keySet());
        
    }

}