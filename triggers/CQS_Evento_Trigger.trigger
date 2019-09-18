trigger CQS_Evento_Trigger on OF_CQS_Evento__c (before insert, after insert) {
    
    
    if((Trigger.isBefore)&&(Trigger.isInsert)){
        system.debug('Parte before Insert');
        
        	Set<Id> SetProgetti = new Set<Id>();
	    	Map<Id,Id> mapEvProg = new Map<Id,Id>();
	    	List<Id> evIdList = new List<Id>();
					   
        for(OF_CQS_Evento__c ev2 : Trigger.New){
	       TEMPLOG__c tL = new TEMPLOG__c(); 
           evIdList.add(ev2.id);
           SetProgetti.add(ev2.CQS_Ev_Progetto__c);
           mapEvProg.put(ev2.id,ev2.CQS_Ev_Progetto__c);
		   tl.Desc__c='In Before Insert parte CQS_Utils.setApexSharingEventi(mapEvProg,setProgetti);';
	     //  System.debug('@@@@@@@tuttiICityManagers Owner: ' +tL.Owner + ' Classe: ' + tL.class__c + ' CPU_TIME: ' + tl.OF_CPU_Time__c );
  	       insert tL;
  	      //  CQS_Utils.setApexSharingEventi(mapEvProg,setProgetti); 
        }
       
       // CQS_Utils.inviaMail(evIdList, mapEvProg, setProgetti); 
	}
   	
   	if((Trigger.isAfter)&&(Trigger.isInsert)){
   		system.debug('Parte after Insert');
    	Set<Id> SetProgetti = new Set<Id>();
    	Map<Id,Id> mapEvProg = new Map<Id,Id>();
    	List<Id> evIdList = new List<Id>(); 
        for(OF_CQS_Evento__c ev2 : Trigger.New){
        	TEMPLOG__c tL = new TEMPLOG__c();
        	SetProgetti.add(ev2.CQS_Ev_Progetto__c);
        	mapEvProg.put(ev2.id,ev2.CQS_Ev_Progetto__c);
        	evIdList.add(ev2.id);
	    tl.Desc__c='In After Insert parte CQS_Utils.inviaMail';				
		insert tL;
		//System.debug('@@@@@@@AFTERINSERT Owner: ' +tL.Owner + ' Classe: ' + tL.class__c + ' CPU_TIME: ' + tl.OF_CPU_Time__c );
    //	CQS_Utils.inviaMail(evIdList, mapEvProg, setProgetti); 
    	CQS_Utils.setApexSharingEventi(mapEvProg,setProgetti);   
        }
		     
   	}	
   		
    
    
    
}