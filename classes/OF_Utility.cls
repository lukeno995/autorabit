global class OF_Utility{
    
    public static boolean checkRT_DevNameId_Map = false;   
    public static map<String,String> RT_DevNameId_Map;
    public static boolean checkRT_IdDevName_Map = false;   
    public static map<String,String> RT_IdDevName_Map;
    
    //metodo per ricevere una mappa con chiave developername e valore id dei recordtype
    public static map<String,String> getRT_DevNameId_Map(){
    	if(OF_Utility.checkRT_DevNameId_Map){
    		return OF_Utility.RT_DevNameId_Map;
    	}
    	else{
    		OF_Utility.RT_DevNameId_Map=new map<String,String>();
    		for(recordType rt : [select id,developername from recordType]){
    			OF_Utility.RT_DevNameId_Map.put(rt.developername,rt.id);
    		}
    		OF_Utility.checkRT_DevNameId_Map=true;
    		return OF_Utility.RT_DevNameId_Map;
    	}
    }
    
    //metodo per ricevere una mappa con chiave developername e valore id dei recordtype
    public static map<String,String> getRT_IdDevName_Map(){
    	if(OF_Utility.checkRT_IdDevName_Map){
    		return OF_Utility.RT_IdDevName_Map;
    	}
    	else{
    		OF_Utility.RT_IdDevName_Map=new map<String,String>();
    		for(recordType rt : [select id,developername from recordType]){
    		OF_Utility.RT_IdDevName_Map.put(rt.id,rt.developername);
    		}
    		OF_Utility.checkRT_IdDevName_Map=true;
    		return OF_Utility.RT_IdDevName_Map;
    	}
    }
    
    /* AQ - Metodo per log - 
    Active = indica se il log è attivo 
    ClassName = nome della classe o del trigger
    MethodName = per le classi (nome metodo) - per i trigger (tipologia after-before)
    Message = messaggio da stampare
    */
    
    public static void logMessage(Boolean active,String logType,String className, String methodName, String message){
    Boolean GeneralWriteLog = true;
     if (GeneralWriteLog) {
        if (active) {
             system.debug('active');
            try{
                 if (logType == 'L') {      
                TEMPLOG__c newDebugMsg = new TEMPLOG__c(
                        Type__c = 'L',
                        Class__c = className,
                        Method__c = methodName,
                        Desc__c = message,
                        Timestamp__c = system.now().format('YYYY-MM-dd HH:mm:ss')
                        
                    );
                    insert newDebugMsg;
               } else  if (logType == 'E') {
                    
                    TEMPLOG__c newDebugMsg = new TEMPLOG__c(
                        Type__c = 'E',
                        Class__c = className,
                        Method__c = methodName,
                        Desc__c = message,
                        Timestamp__c = system.now().format('YYYY-MM-dd HH:mm:ss')
                    );
                insert newDebugMsg;
                } else  if (logType == 'P') {
                    TEMPLOG__c newDebugMsg = new TEMPLOG__c(
                        Type__c = 'P',
                        Class__c = className,
                        Method__c = methodName,
                        Desc__c = message,
                        Timestamp__c = system.now().format('YYYY-MM-dd HH:mm:ss')
                    );
                    insert newDebugMsg;
                } else   {
                    TEMPLOG__c newDebugMsg = new TEMPLOG__c(
                        Type__c = 'N',
                        Class__c = className,
                        Method__c = methodName,
                        Desc__c = message,
                        Timestamp__c = system.now().format('YYYY-MM-dd HH:mm:ss')
                    );
                    insert newDebugMsg;
                }
                   
                     }
                catch (Exception ex){
                        System.debug('Failed to INSERT logMessage in TEMPLOG__c ' + 'Error: ' + ex.getMessage());
                    }
        }
       }
    }
    
    //metodo Modificato AM
    public static TEMPLOG__c logMessageNew2(String logName,String logType,String className, String methodName, Integer tentativi,exception e){
    	TEMPLOG__c t = new TEMPLOG__c();
    	t.Name=logName;
    	t.Type__c=logType;   
    	t.Timestamp__c=system.now().format('YYYY-MM-dd HH:mm:ss');
    	t.Desc__c=e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage();
    	t.Class__c=className;
    	t.method__C=methodName;
    	t.Of_tentativi__c=tentativi;
    	return t;
    }
        /* AQ - Metodo per log dedicato al process builder- 

    Message = messaggio da stampare
    */
    @InvocableMethod
     public static void logMessageProcessBuilder(List<String>  message){
      Boolean GeneralWriteLog = true;
      if (GeneralWriteLog) {
            try{
                
                TEMPLOG__c newDebugMsg = new TEMPLOG__c(
                        Type__c = 'P',
                      //  Class__c = className,
                      //  Method__c = methodName,
                        Desc__c = message[0],
                        Timestamp__c = system.now().format('YYYY-MM-dd HH:mm:ss')
                        
                    );
                    insert newDebugMsg;
               } 
                              
                catch (Exception ex){
                        System.debug('Failed to INSERT logMessage in TEMPLOG__c ' + 'Error: ' + ex.getMessage());
                    }
                    }
        }
    
    
    
    /* AQ - Metodo per log - 
       stampa il numero delle Query che sono state eseguite fino al momento in cui viene chiamato  questo metodo
    INPUT :   
    Active = indica se il log è attivo 
    Entity = nome della classe o del trigger
    Method = per le classi (nome metodo) - per i trigger (tipologia)
    */
   
    public static void DebugLimitQuery(Boolean active,String type,String Entity,String method)
    {
        if( active == true )
        {
                String s = '';
               /**Debug su un Trigger**/
               if( type == 'T')
               {
                  s =  ' Trigger: '+Entity+' EventoTrigger: '+method;
               }
               if( type == 'C')
               {
                  s = ' Classe : '+Entity+' Metodo: '+method;
               }
               system.debug(s+ ' QueryEffettuate :' + 
                             Limits.getQueries() + '/' + Limits.getLimitQueries());
        }
      return;
    }
    
    WebService static void DeleteLog(String type)
    {
        if( type == 'All' )
        { 
            list<TempLog__c> DeleteList = [select Name from TempLog__c]; 
            delete DeleteList;
        }
      return;
    }
    
 }