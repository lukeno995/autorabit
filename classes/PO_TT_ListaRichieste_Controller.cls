//@Author ATOS CRM O.S 20_09_2017
public with sharing class PO_TT_ListaRichieste_Controller {
    
    public List<EOF_EAI_Service_Log__c> listRichiesteTT {get;set;}
    public List<EOF_EAI_Service_Log__c> listRichiesteTTBozza{get;set;}
    public boolean richiesteTT{get;set;}
    public boolean richiesteTTBozza{get;set;}
    public String IdScelta{get;set;}
    /*
    public String listRichiesteTTstring {
    	get { return JSON.serialize(listRichiesteTT);}
    	set;
    	}
    */
    public String soql {get;set;}
    public String listRichiesteTTstring {get;set;}
    public String debugSoql {
	    get { return soql;}
	    set;
  	}
  	
  	/*
    public List<String> ListCasualeApertura {get;set;}
    
    public List<String> ListStatus {get;set;}
    
    public String DataFine {get;set;}
    
    public String DataInizio {get;set;}
    */
    
    public String optCausaleAperturaString {get;set;}
	public String optStatusString  {get;set;}
  
    public Map<String,String> mapCausale = new Map<String,String>();


                                               
  

    // wrapper per la generazione delle option delle selectlist
   public class optionApex {
		public string value {get; set;}
		public string text {get; set;}

		//This is the contructor method. 
		public optionApex(string s, string t) {
			value = s;
			text = t;
		}
	} 
   
         
    //Costruttore
    public PO_TT_ListaRichieste_Controller()
    {
		 mapCausale.put('1','Connettività non disponibile');
		 mapCausale.put('2','Connessione instabile');
		 mapCausale.put('3','Lentezza di navigazione');
		 mapCausale.put('4','Mai Navigato'); 
         //User utenteLoggato = [select id,Account.EOF_Codice_Operatore__c from User where id =: UserInfo.getUserId()];
         richiesteTT = false;
         richiesteTTBozza = false;
         User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
         listRichiesteTT = [Select id,RecordType.name,EOF_Data_Ora_Desospensione__c,EOF_Codice_Comunicazione_OLO__c,EOF_Causale_Apertura__c,EOF_Stato_Richiesta__c, EOF_Data_Notifica__c, EOF_Codice_Ordine_OLO__c,EOF_STATO_ORDINE__c,CreatedDate from EOF_EAI_Service_Log__c 
                            where 
                            recordtype.DeveloperName = 'PO_TT_TroubleTicketRequest' 
                            and EOF_Stato_Richiesta__c != 'Bozza'
                            and EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c 
                            order by CreatedDate DESC ];
         listRichiesteTTBozza = [select id,RecordType.name,EOF_Data_Ora_Desospensione__c,EOF_Codice_Comunicazione_OLO__c,EOF_Causale_Apertura__c,EOF_Stato_Richiesta__c, EOF_Data_Notifica__c, EOF_Codice_Ordine_OLO__c,EOF_STATO_ORDINE__c, CreatedDate from EOF_EAI_Service_Log__c 
                            where 
                            recordtype.DeveloperName = 'PO_TT_TroubleTicketRequest' 
                            and EOF_Stato_Richiesta__c = 'Bozza'
                            and EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c 
                            order by CreatedDate DESC ];
                            
         listRichiesteTTstring=JSON.serialize(listRichiesteTT);
         if( listRichiesteTT.size()>0)
         {
             richiesteTT = true;
            
            Set<String> setCausaleApertura =new Set<String>();
        	Set<String> setStatus =new Set<String>();
        	List<optionApex>optCausaleApertura = new List<optionApex>();
        	List<optionApex>optStatus = new List<optionApex>();
        	
        	for(EOF_EAI_Service_Log__c mySL:listRichiesteTT  ){
        			setCausaleApertura.add(mySL.EOF_Causale_Apertura__c);
        			setStatus.add(mySL.EOF_STATO_ORDINE__c);	
        	}
        	 
        	for(String myString:setCausaleApertura ){
        		 optCausaleApertura.add(new optionApex(myString,mapCausale.get(myString)));
        	}	 
            for(String myString:setStatus ){
                 optStatus.add(new optionApex(myString,myString));
        	}
        	
        	optCausaleAperturaString=JSON.serialize(optCausaleApertura);
        	optStatusString=JSON.serialize(optStatus);
            
         }
         if( listRichiesteTTBozza.size()>0)
         {
             richiesteTTBozza = true;
         }
                              
    }
    

    
    
    
    public PageReference runSearch() { 
	        
		    String DataInizio = Apexpages.currentPage().getParameters().get('DataInizio');
		    String DataFine = Apexpages.currentPage().getParameters().get('DataFine');
		    List<String> ListCasualeApertura = (List<String>)System.JSON.deserialize(Apexpages.currentPage().getParameters().get('selectValueL1'), List<String>.class);
		    List<String> ListStatus = (List<String>)System.JSON.deserialize(Apexpages.currentPage().getParameters().get('selectValueL2'), List<String>.class);
		    
		    soql = 'Select id,RecordType.name,EOF_Codice_Comunicazione_OLO__c,EOF_Causale_Apertura__c,EOF_Stato_Richiesta__c, EOF_Data_Notifica__c, EOF_Codice_Ordine_OLO__c,EOF_STATO_ORDINE__c, CreatedDate from EOF_EAI_Service_Log__c where recordtype.DeveloperName = \'PO_TT_TroubleTicketRequest\' and EOF_Stato_Richiesta__c != \'Bozza\'';
		    if (!DataInizio.equals(''))
			{
			  soql += ' and CreatedDate >='+String.escapeSingleQuotes(DataInizio);
			}
		    if (!DataFine.equals(''))
		    {
		      soql += ' and CreatedDate <='+String.escapeSingleQuotes(DataFine);
		    }
			
			if(ListCasualeApertura!=null && !ListCasualeApertura.isEmpty())	
			{
			  soql += ' and EOF_Causale_Apertura__c in (';
			  for (string mystring:ListCasualeApertura){
			  	soql +='\'' + mystring + '\',';
			  }
			  soql = soql.removeEnd(',');
			  soql += ')';			
			}
			if(ListStatus!=null && !ListStatus.isEmpty())	
			{
			  
			  soql += ' and EOF_STATO_ORDINE__c in (';
			  //soql +=' and in Case_Portale__r.Status  (';
			  for (string mystring:ListStatus){
			  	soql +='\'' + mystring + '\',';
			  }
			  soql = soql.removeEnd(',');
			  soql += ')';	
			}
			
			User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
			
			soql += 'and EOF_Codice_Operatore__c=\'' + attuale.Account.EOF_Codice_Operatore__c  + '\' ';
			
			system.debug(soql);

	    // run the query again
	       runQuery();
	
	    return null;
	  }
	public void runQuery()
	{
	
		    try {
		      listRichiesteTT = Database.query(soql + ' order by CreatedDate DESC ');
		      listRichiesteTTstring=JSON.serialize(listRichiesteTT);
	        
	        Set<String> setCausaleApertura =new Set<String>();
        	Set<String> setStatus =new Set<String>();
        	List<optionApex>optCausaleApertura = new List<optionApex>();
        	List<optionApex>optStatus = new List<optionApex>();
        	
        	for(EOF_EAI_Service_Log__c mySL:listRichiesteTT  ){
        			setCausaleApertura.add(mySL.EOF_Causale_Apertura__c);
        			setStatus.add(mySL.EOF_STATO_ORDINE__c);	
        	}
        	 
        	for(String myString:setCausaleApertura ){
        		 optCausaleApertura.add(new optionApex(myString,mapCausale.get(myString)));
        	}	 
            for(String myString:setStatus ){
                 optStatus.add(new optionApex(myString,myString));
        	}
        	
        	optCausaleAperturaString=JSON.serialize(optCausaleApertura);
        	optStatusString=JSON.serialize(optStatus);
            
		    } catch (Exception e) {
		      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ooops!'));
		    }
	
	}
    
    
    //Funzione di View Dettagli del Case onclick
    public PageReference ViewCaseDettail()
    {
        PageReference pg = new PageReference('/PO_TT_InsertNewRequest');
        pg.getParameters().put('proc','TTVisualizza');
        pg.getParameters().put('origId',IdScelta);
        return pg;
    }

	public Double offset{get{
        TimeZone tz = UserInfo.getTimeZone();
        //Milliseconds to Day
        return tz.getOffset(DateTime.now()) / (1000 * 3600 * 24.0);
    }}
}