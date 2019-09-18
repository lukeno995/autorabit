//@Author: O.s ATOS CRM
public class PO_COMP_TT_Inserimento_Controller {
    public EOF_EAI_Service_Log__c slToInsert{set;get;}
    public Map<String,Id> rtMap;
    public string inputTimeStr {get; set;}
    
    public string inputTimeStr2 {get; set;}

     
 
    //Costruttore
    
    public PO_COMP_TT_Inserimento_Controller()
    {
        try{
            
        List<recordtype> rtList=[select Id,developerName from recordtype where sobjecttype='EOF_EAI_Service_Log__c'];                                                                               
	    rtMap = new Map<String,Id>(); 
	    for(recordtype rt :rtList)
        {
	       rtMap.put(rt.developerName, rt.Id); 
	    } 
       String origId = ApexPages.currentPage().getParameters().get('origId');
       String proc = ApexPages.currentPage().getParameters().get('proc');
       
            
        system.debug('OSCRM origId:'+origId);
        system.debug('OSCRM proc:'+proc);
        
       if( origId != null && proc == 'TTModifica')
       {
          
           slToInsert = [select id, EOF_Codice_Comunicazione_OLO__c, EOF_Categoria_Guasto__c, 
           					EOF_ID_Risorsa__c, EOF_Causale_Apertura__c, EOF_Data_Ora_Inizio_Guasto__c, 
           					EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c, EOF_RECAPITO_TELEFONICO_CLIENTE_1__c, 
           					EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,EOF_NOME_REFERENTE_TECNICO_OLO__c, 
           					EOF_EMAIL_REFERENTE_TECNICO_OLO__c, EOF_Verifica_apparato_cliente__c, 
           					EOF_Descrizione_Problema__c,EOF_NOTE__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
           					EOF_Intervento_Congiunto__c     
           					from EOF_EAI_Service_Log__c
                           	WHERE Id =: origId];
                           	
           //inputTimeStr=String.valueOf(slToInsert.EOF_Data_Ora_Inizio_Guasto__c);
       }else{
        
          slToInsert = new EOF_EAI_Service_Log__c();
          slToInsert.recordtypeId = rtMap.get('PO_TT_TroubleTicketRequest');
          slToInsert.EOF_Data_Ora_Inizio_Guasto__c=datetime.now();
          slToInsert.EOF_Stato_Richiesta__c = 'Bozza';
          User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
          if(attuale!=null){
          	slToInsert.EOF_Codice_Operatore__c=attuale.Account.EOF_Codice_Operatore__c; 
          }
          //slToInsert.PO_SA_Portale__c =true;
       
       }
     
        
        }catch( Exception e )
        {
            OF_Utility.logMessage(true,'E',
                     'Classe: PO_COMP_TT_Inserimento_Controller',
                     'Method: Costruttore',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );            
                //return null;
        }
        
    }
    
    //Funzionalità bottone ANNULLA
    public PageReference AnnullaS()
    {
        PageReference pg = new PageReference('/PO_Index');
        return pg;
    }
    //Funzionalità bottone SAVE
    public PageReference SalvaC()
    {
        try{ 
        	
        	List<EOF_EAI_Service_Log__c> DbSL= [select EOF_Codice_Comunicazione_OLO__c from EOF_EAI_Service_Log__c WHERE EOF_Codice_Comunicazione_OLO__c =: slToInsert.EOF_Codice_Comunicazione_OLO__c];

        	if (!DbSL.isEmpty()){
        		ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Codice Comunicazione Operatore non univoco');
        		ApexPages.addMessage(myMsg);
    			return null;
        	}else{
	        	slToInsert.EOF_Data_Ora_Inizio_Guasto__c=datetime.valueOfGmt(inputTimeStr2);
	    		upsert slToInsert;
        	}
    	}
    	catch(DMLexception e){
    		ApexPages.addMessages(e);
    		return null;
    	}
        PageReference pg = new PageReference('/PO_TT_InsertNewRequest');
        pg.getParameters().put('proc','TTVisualizza');
        pg.getParameters().put('origId',slToInsert.Id);
        return pg;
    }

}