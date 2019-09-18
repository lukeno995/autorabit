/**
* Author:       Team Napoli
* Description:  Integrazione SFDC to TTM/Salesforce/OLO
* SI:           
*/ 

public class OF_TT_WS_Notifica_Request_TTM {

    public String requestTTM{get;set;}
    private String blank='';
    private EOF_Notify__c notify;
    private Case caseTTM;
    
    public String nameService{get;set;}
    private String userName;
	private String password;
	private String token;
	private String kind_communication;
	private String olo_gw_ttid;
	private String orderid;
	private String note;
	private String attachments;  // to do: con il nuovo wsdl sarà cancellato
	private String type_auto_reset_request;
	private String data_ora_autoreset;
	private String type_cancel;
	private String data_ora_cancel;		
	private String id_notification;
    private String request_type;
    private String id_resource;
    private String data_ora_beginning_fault;
    private String name_client;
    private String ticketreason;
    private String intervention_joint;
    private String tec_olo;
    private String tel_tec_olo;
    private String data_ora_intervento_congiunto;
    private String region;  // to do: con il nuovo wsdl sarà cancellato
    private String address; // to do: con il nuovo wsdl sarà cancellato
    private String diagnosis_result; // to do: con il nuovo wsdl sarà cancellato
    private String sla_type;
    private String service_type;
    private String customer_surname;
    private String customer_telephone_number_1;
    private String customer_telephone_number_2;
    private String nome_referente_tecnico_olo;
    private String telefono_referente_tecnico_olo;
    private String email_referente_tecnico_olo;
    private String data_ora_joint_intervention;
    private String note_cliente;
    private String type_resume_request;
    private String data_ora_resumerequest;
    private String type_testok;
    private String type_testko;
	
	//Nuovi campi
	private String NUMERO_TICKET_ID_RISORSA;
	private String counter_testko;
    private String CAUSALE_RICHIESTA_ANNULLAMENTO; 
    private String CAUSALE_DESOSPENSIONE;
    private String DATA_ORA_INIZIO_SLA;
    private String DATA_ORA_NOTIFICA_OLO;
    private String data_ora_testok;
    private String data_ora_testko;
    private String VERIFICA_APPARATO;
    private String DESCRIZIONE_PROBLEMA;
    
    //da qui Campi inseriti EC
    private String res;
    private String request_detail;  // to do: con il nuovo wsdl sarà cancellato
    private String request_time;   // to do: con il nuovo wsdl sarà cancellato
    
    private String data_ora_notifica_sospensione; // to do: con il nuovo wsdl sarà cancellato
	private String causale_sospensione; // to do: con il nuovo wsdl sarà cancellato
	private String referente_sospensione; // to do: con il nuovo wsdl sarà cancellato
	private String rischedulazione_appuntamento; // to do: con il nuovo wsdl sarà cancellato
	private String data_ora_pauserequest; // to do: con il nuovo wsdl sarà cancellato
	private String type_pause_request; // to do: con il nuovo wsdl sarà cancellato
    
    public OF_TT_WS_Notifica_Request_TTM(EOF_Notify__c n,String nS){
      caseTTM=[Select id,Account.Name,Account.FirstName,Account.LastName,AssetId,Note_Cliente__c,EOF_Telefono_Referente_Tecnico_OLO__c,EOF_Contact__c,EOF_Verifica_apparato_cliente__c,EOF_Descrizione_Problema__c,EOF_Recapito_Telefonico_Cliente_2__c,EOF_Recapito_Telefonico_Cliente_1__c,EOF_Indirizzo_WS__c,EOF_Categoria_Guasto__c,EOF_Data_Ora_Inizio_Guasto__c,EOF_Causale_Apertura__c,EOF_Tipologia_Servizio__c,Data_Ora_Autoripristinato__c,EOF_Causale_Desospensione__c, EOF_Email_Referente_Tecnico_OLO__c from Case where id=:n.Caso__c limit 1];
      requestTTM=this.blank;
      notify=n;
      mappingField(nS);
    }
    
    //TO DO
    public void mappingField(String nS){
        nameService=nS;
        userName= blank;	
        password=blank;
        token=blank;       
         
        kind_communication= notify.OF_TT_Tipo_Comunicazione__c;
        olo_gw_ttid=notify.EOF_Codice_Operatore__c;
        orderid=notify.EOF_Codice_Comunicazione_OLO__c;
        note=notify.EOF_Note__c;
        
        attachments=blank;
        type_auto_reset_request=blank;
		data_ora_autoreset=OF_TTM_WS_Notify_Utils.DateTimeToString(caseTTM.Data_Ora_Autoripristinato__c);
        type_cancel=blank;
		//PG Mapping 28-03
        data_ora_cancel=OF_TTM_WS_Notify_Utils.DateTimeToString(notify.EOF_Data_Ora_Notifica_Annullamento__c);
				
		id_notification=notify.id;
        
        request_type=caseTTM.EOF_Categoria_Guasto__c;
        id_resource=notify.EOF_ID_Risorsa__c; 
        
        data_ora_beginning_fault=OF_TTM_WS_Notify_Utils.DateTimeToString(caseTTM.EOF_Data_Ora_Inizio_Guasto__c);
        
        //PG Mapping 28-03
        //name_client=caseTTM.Account.Name;
        name_client=caseTTM.Account.FirstName;
        ticketreason=caseTTM.EOF_Causale_Apertura__c;
        
        intervention_joint=notify.EOF_Intervento_Congiunto__c;
        
        //PG 28-03 mapping
        tec_olo=notify.EOF_tec_eof__c; 
        tel_tec_olo=notify.EOF_Tel_Tec_EOF__c;
        
        data_ora_intervento_congiunto=OF_TTM_WS_Notify_Utils.DateTimeToString(notify.EOF_Data_Ora_Intervento_Congiunto__c);
        sla_type=gettingSlaPremiumByCaseTTM (caseTTM); 
     	service_type=caseTTM.EOF_Tipologia_Servizio__c;   // da modificare
        
        region=blank; // to do: con il nuovo wsdl sarà cancellato
        address=caseTTM.EOF_Indirizzo_WS__c; // to do: con il nuovo wsdl sarà cancellato
        diagnosis_result=notify.Descrizione_Evento_Risoluzione__c; // to do: con il nuovo wsdl sarà cancellato
        
        //PG Mapping 28-03
        customer_surname=caseTTM.Account.LastName;
        
        customer_telephone_number_1=caseTTM.EOF_Recapito_Telefonico_Cliente_1__c;
        customer_telephone_number_2=caseTTM.EOF_Recapito_Telefonico_Cliente_2__c;
       
        nome_referente_tecnico_olo=caseTTM.EOF_Contact__c;
        telefono_referente_tecnico_olo=caseTTM.EOF_Telefono_Referente_Tecnico_OLO__c;
        email_referente_tecnico_olo=caseTTM.EOF_Email_Referente_Tecnico_OLO__c;
        
        note_cliente=caseTTM.Note_Cliente__c;        
        data_ora_joint_intervention=OF_TTM_WS_Notify_Utils.DateTimeToString(notify.EOF_Data_Ora_Intervento_Congiunto__c);
        type_resume_request=blank;
        data_ora_resumerequest=OF_TTM_WS_Notify_Utils.DateTimeToString(notify.EOF_Data_Ora_Notifica_Desospensione__c);       
        type_testok=blank;
        type_testko=blank;
        
        //Nuovi campi
        NUMERO_TICKET_ID_RISORSA=blank;
		counter_testko=blank;
		CAUSALE_RICHIESTA_ANNULLAMENTO=notify.Motivo_Rifiuto_Sospensione_Annullamento__c;
		CAUSALE_DESOSPENSIONE=caseTTM.EOF_Causale_Desospensione__c;
		DATA_ORA_INIZIO_SLA=OF_TTM_WS_Notify_Utils.DateTimeToString(OF_TTM_WS_Notify_Utils.now());
		
		DATA_ORA_NOTIFICA_OLO=OF_TTM_WS_Notify_Utils.DateTimeToString(notify.EOF_Data_Notifica__c); //to do: da capire come eseguire il mapping poichè i campi sono due: data_ora_testok; data_ora_testko;
		data_ora_testok=blank; // to do: per ora lasciar perdere il mapping
		data_ora_testko=blank; // to do: per ora lasciar perdere il mapping
		
		VERIFICA_APPARATO=caseTTM.EOF_Verifica_apparato_cliente__c;
		DESCRIZIONE_PROBLEMA=caseTTM.EOF_Descrizione_Problema__c;
		
		 //da qui Campi inseriti EC: Inserire il mapping relativo.
	    res=blank;
	    request_detail=blank;  // to do: con il nuovo wsdl sarà cancellato
	    request_time=blank;   // to do: con il nuovo wsdl sarà cancellato
	    
	    data_ora_notifica_sospensione=OF_TTM_WS_Notify_Utils.DateTimeToString(notify.EOF_Data_Ora_Notifica_Sospensione__c); // to do: con il nuovo wsdl sarà cancellato
		causale_sospensione=notify.Causale_Sospensione__c; // to do: con il nuovo wsdl sarà cancellato
		referente_sospensione=notify.EOF_Referente_desospensione__c	; //vedi validationRule Rule Name:OF_TT_Referente_Sospensione "Nel campo Referente Desospensione inserire il Referente Sospensione" AND( ISBLANK(EOF_Referente_desospensione__c), RecordType.Name ='Trouble Ticket - Notifica di Sospensione', NOT(ISBLANK(EOF_Rischedulazione_Appuntamento__c )))// to do: con il nuovo wsdl sarà cancellato
		rischedulazione_appuntamento=OF_TTM_WS_Notify_Utils.DateTimeToString(notify.EOF_Rischedulazione_Appuntamento__c); // to do: con il nuovo wsdl sarà cancellato
		data_ora_pauserequest=OF_TTM_WS_Notify_Utils.DateTimeToString(notify.EOF_Data_Ora_Notifica_Sospensione__c); //non c'è dal nome sembrerebbe la sospensione // to do: con il nuovo wsdl sarà cancellato
		type_pause_request=notify.Codice_Rifiuto_Sospensione_Annullamento__c; //non c'è dal nome sembrerebbe il codice Sospensione, il tipo di sospensione se tecnica o commerciale 
    }
    
    private String part_Initial_XML(){
       return '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:wfm="http://wfm.huawei.com"> <soapenv:Header> <wfm:authentication> <userName>'+userName+'</userName> <password>'+password+'</password> <token>'+token+'</token> </wfm:authentication> </soapenv:Header> <soapenv:Body> <wfm:'+nameService+'> <interface> ';
    }
      
    private String part_final_XML(){
      return '</interface> </wfm:'+nameService+'> </soapenv:Body> </soapenv:Envelope>';
    }
    
    public void AutoResetToClosed(String type_auto_reset_request, String data_ora_autoreset){
            
        requestTTM=part_Initial_XML();
        
        requestTTM=requestTTM+'<kind_communication>'+kind_communication+'</kind_communication> ';
     
      /*Campi res,olo_gw_ttid, id_resource, request_type, name_client
      	customer_surname, customer_telephone_number_1, customer_telephone_number_2,
      	nome_referente_tecnico_olo, telefono_referente_tecnico_olo,email_referente_tecnico_olo,
      	note_cliente, request_detail, attachments, orderid aggiunti come da OLOGW_TTM_Request0.2
        */
        requestTTM=requestTTM+'<res>'+res+'</res> ';
        requestTTM=requestTTM+'<olo_gw_ttid>'+olo_gw_ttid+'</olo_gw_ttid> ';
        requestTTM=requestTTM+'<id_resource>'+id_resource+'</id_resource> ';
        requestTTM=requestTTM+'<id_notification>'+id_notification+'</id_notification> ';
        requestTTM=requestTTM+'<request_type>'+request_type+'</request_type> ';
        requestTTM=requestTTM+'<data_ora_autoreset>'+data_ora_autoreset+'</data_ora_autoreset> ';
        requestTTM=requestTTM+'<name_client>'+name_client+'</name_client> ';
        requestTTM=requestTTM+'<customer_surname>'+customer_surname+'</customer_surname> ';
       	requestTTM=requestTTM+'<customer_telephone_number_1>'+customer_telephone_number_1+'</customer_telephone_number_1> ';
        requestTTM=requestTTM+'<customer_telephone_number_2>'+customer_telephone_number_2+'</customer_telephone_number_2> ';
        requestTTM=requestTTM+'<nome_referente_tecnico_olo>'+nome_referente_tecnico_olo+'</nome_referente_tecnico_olo> ';
        requestTTM=requestTTM+'<telefono_referente_tecnico_olo>'+telefono_referente_tecnico_olo+'</telefono_referente_tecnico_olo> ';
        requestTTM=requestTTM+'<email_referente_tecnico_olo>'+email_referente_tecnico_olo+'</email_referente_tecnico_olo> ';
       	requestTTM=requestTTM+'<note_cliente>'+note_cliente+'</note_cliente> ';
        requestTTM=requestTTM+'<request_detail>'+request_detail+'</request_detail> ';
        requestTTM=requestTTM+'<attachments>'+attachments+'</attachments> ';
        requestTTM=requestTTM+'<orderid>'+orderid+'</orderid> ';
        //  inseriti in ordine rispetto al WSDL nuovi fino a qui    
   	 /* i seguenti campi commentati non sono presenti su OLOGW_TTM_Request0.2
   	 
		requestTTM=requestTTM+'<olo_gw_ttid>'+olo_gw_ttid+'</olo_gw_ttid> '; 
        requestTTM=requestTTM+'<orderid>'+orderid+'</orderid> '; 
 		//posizione diversa il campo è stato inserito sopra: requestTTM=requestTTM+'<id_notification>'+id_notification+'</id_notification> ';                        
        requestTTM=requestTTM+'<type_auto_reset_request>'+type_auto_reset_request+'</type_auto_reset_request> '; 
        requestTTM=requestTTM+'<note>'+note+'</note> ';
        requestTTM=requestTTM+'<attachments>'+attachments+'</attachments> ';        
		//posizione diversa il campo è stato inserito sopra:   requestTTM=requestTTM+'<data_ora_autoreset>'+data_ora_autoreset+'</data_ora_autoreset> ';
		*/
        requestTTM=requestTTM+part_final_XML();
    }   
    
     public void Cancel(){
            
        requestTTM=part_Initial_XML();
        
        requestTTM=requestTTM+'<kind_communication>'+kind_communication+'</kind_communication> ';
        
        /* Campi res,olo_gw_ttid, request_type, id_resource, causale_richiesta_annullamento,
       name_client, customer_surname, customer_telephone_number_1, customer_telephone_number_2,
      	nome_referente_tecnico_olo, telefono_referente_tecnico_olo,email_referente_tecnico_olo,
      	note_cliente, request_detail, orderid, attachments  aggiunti come da OLOGW_TTM_Request0.2
        */
        
        requestTTM=requestTTM+'<res>'+res+'</res> ';
        requestTTM=requestTTM+'<olo_gw_ttid>'+olo_gw_ttid+'</olo_gw_ttid> ';
        requestTTM=requestTTM+'<id_notification>'+id_notification+'</id_notification> ';
        requestTTM=requestTTM+'<request_type>'+request_type+'</request_type> ';
        requestTTM=requestTTM+'<id_resource>'+id_resource+'</id_resource> ';
        requestTTM=requestTTM+'<data_ora_cancel>'+data_ora_cancel+'</data_ora_cancel> '; 
        requestTTM=requestTTM+'<causale_richiesta_annullamento>'+causale_richiesta_annullamento+'</causale_richiesta_annullamento> ';
        requestTTM=requestTTM+'<name_client>'+name_client+'</name_client> ';
        requestTTM=requestTTM+'<customer_surname>'+customer_surname+'</customer_surname> ';
       	requestTTM=requestTTM+'<customer_telephone_number_1>'+customer_telephone_number_1+'</customer_telephone_number_1> ';
        requestTTM=requestTTM+'<customer_telephone_number_2>'+customer_telephone_number_2+'</customer_telephone_number_2> ';
        requestTTM=requestTTM+'<nome_referente_tecnico_olo>'+nome_referente_tecnico_olo+'</nome_referente_tecnico_olo> ';
        requestTTM=requestTTM+'<telefono_referente_tecnico_olo>'+telefono_referente_tecnico_olo+'</telefono_referente_tecnico_olo> ';
        requestTTM=requestTTM+'<email_referente_tecnico_olo>'+email_referente_tecnico_olo+'</email_referente_tecnico_olo> ';
       	requestTTM=requestTTM+'<note_cliente>'+note_cliente+'</note_cliente> ';
        requestTTM=requestTTM+'<request_detail>'+request_detail+'</request_detail> ';
        requestTTM=requestTTM+'<orderid>'+orderid+'</orderid> ';
        requestTTM=requestTTM+'<attachments>'+attachments+'</attachments> ';
        
        /* i seguenti campi commentati non sono presenti su OLOGW_TTM_Request0.2
        requestTTM=requestTTM+'<olo_gw_ttid>'+olo_gw_ttid+'</olo_gw_ttid> '; 
        requestTTM=requestTTM+'<orderid>'+orderid+'</orderid> ';
	 // posizione diversa il campo è stato inserito sopra:  requestTTM=requestTTM+'<id_notification>'+id_notification+'</id_notification> ';
        requestTTM=requestTTM+'<type_cancel>'+type_cancel+'</type_cancel> ';   
        requestTTM=requestTTM+'<note>'+note+'</note> ';
        requestTTM=requestTTM+'<attachments>'+attachments+'</attachments> ';         
  	 // posizione diversa il campo è stato inserito sopra:        requestTTM=requestTTM+'<data_ora_cancel>'+data_ora_cancel+'</data_ora_cancel> ';
        */
        requestTTM=requestTTM+part_final_XML();
    }
    
    public void CreateDiscardedTT(){
    	/*prima vuoto, inserito da WSDL sulla base dei precedenti metodi EC
    	
    	*/
    	requestTTM=part_Initial_XML();
		
		requestTTM=requestTTM+'<kind_communication>'+kind_communication+'</kind_communication> ';
		requestTTM=requestTTM+'<res>'+res+'</res> ';
		requestTTM=requestTTM+'<olo_gw_ttid>'+olo_gw_ttid+'</olo_gw_ttid> ';
		requestTTM=requestTTM+'<request_type>'+request_type+'</request_type> ';
		requestTTM=requestTTM+'<id_notification>'+id_notification+'</id_notification> ';
		requestTTM=requestTTM+'<id_resource>'+id_resource+'</id_resource> ';
		requestTTM=requestTTM+'<data_ora_beginning_fault>'+data_ora_beginning_fault+'</data_ora_beginning_fault> ';
		requestTTM=requestTTM+'<request_time>'+request_time+'</request_time> ';
		requestTTM=requestTTM+'<name_client>'+name_client+'</name_client> ';
		requestTTM=requestTTM+'<customer_surname>'+customer_surname+'</customer_surname> ';
		requestTTM=requestTTM+'<customer_telephone_number_1>'+customer_telephone_number_1+'</customer_telephone_number_1> ';
		requestTTM=requestTTM+'<customer_telephone_number_2>'+customer_telephone_number_2+'</customer_telephone_number_2> ';
		requestTTM=requestTTM+'<nome_referente_tecnico_olo>'+nome_referente_tecnico_olo+'</nome_referente_tecnico_olo> ';
		requestTTM=requestTTM+'<telefono_referente_tecnico_olo>'+telefono_referente_tecnico_olo+'</telefono_referente_tecnico_olo> ';
		requestTTM=requestTTM+'<email_referente_tecnico_olo>'+email_referente_tecnico_olo+'</email_referente_tecnico_olo> ';
		requestTTM=requestTTM+'<note_cliente>'+note_cliente+'</note_cliente> ';
		requestTTM=requestTTM+'<request_detail>'+request_detail+'</request_detail> ';
		requestTTM=requestTTM+'<ticketreason>'+ticketreason+'</ticketreason> ';
		requestTTM=requestTTM+'<intervention_joint>'+intervention_joint+'</intervention_joint> ';
		requestTTM=requestTTM+'<tec_olo>'+tec_olo+'</tec_olo> ';
		requestTTM=requestTTM+'<tel_tec_olo>'+tel_tec_olo+'</tel_tec_olo> ';
		requestTTM=requestTTM+'<data_ora_intervento_congiunto>'+data_ora_intervento_congiunto+'</data_ora_intervento_congiunto> ';
		requestTTM=requestTTM+'<service_type>'+service_type+'</service_type> ';
		requestTTM=requestTTM+'<sla_type>'+sla_type+'</sla_type> ';
		requestTTM=requestTTM+'<region>'+region+'</region> ';
		requestTTM=requestTTM+'<address>'+address+'</address> ';
		requestTTM=requestTTM+'<diagnosis_result>'+diagnosis_result+'</diagnosis_result> ';
		requestTTM=requestTTM+'<attachments>'+attachments+'</attachments> ';
		requestTTM=requestTTM+'<orderid>'+orderid+'</orderid> ';
				
		requestTTM=requestTTM+part_final_XML();
    
    }
    
    public void CreateNewTT(){
    	
    	/* Campi res,olo_gw_ttid, request_type, id_resource,numero_ticket_id_risorsa,
    	request_time, customer_surname, customer_telephone_number_1, 
    	customer_telephone_number_2, nome_referente_tecnico_olo, 
    	telefono_referente_tecnico_olo,email_referente_tecnico_olo,
      	note_cliente, request_detail, verifica_apparato, descrizione_problema, 
      	ticketreason, intervention_joint, attachments, orderid  aggiunti come da OLOGW_TTM_Request0.2
        */
        kind_communication='1';
         
        requestTTM=part_Initial_XML();
        
        requestTTM=requestTTM+'<kind_communication>'+kind_communication+'</kind_communication> ';
        requestTTM=requestTTM+'<res>'+res+'</res> ';
		requestTTM=requestTTM+'<olo_gw_ttid>'+olo_gw_ttid+'</olo_gw_ttid> ';
		requestTTM=requestTTM+'<request_type>'+request_type+'</request_type> ';
		requestTTM=requestTTM+'<id_notification>'+id_notification+'</id_notification> ';
		requestTTM=requestTTM+'<id_resource>'+id_resource+'</id_resource> ';
		requestTTM=requestTTM+'<numero_ticket_id_risorsa>'+numero_ticket_id_risorsa+'</numero_ticket_id_risorsa> ';
        requestTTM=requestTTM+'<data_ora_beginning_fault>'+data_ora_beginning_fault+'</data_ora_beginning_fault> ';
        requestTTM=requestTTM+'<request_time>'+request_time+'</request_time> ';
        requestTTM=requestTTM+'<name_client>'+name_client+'</name_client> ';
        
        requestTTM=requestTTM+'<customer_surname>'+customer_surname+'</customer_surname> ';
		requestTTM=requestTTM+'<customer_telephone_number_1>'+customer_telephone_number_1+'</customer_telephone_number_1> ';
		requestTTM=requestTTM+'<customer_telephone_number_2>'+customer_telephone_number_2+'</customer_telephone_number_2> ';
		requestTTM=requestTTM+'<nome_referente_tecnico_olo>'+nome_referente_tecnico_olo+'</nome_referente_tecnico_olo> ';
		requestTTM=requestTTM+'<telefono_referente_tecnico_olo>'+telefono_referente_tecnico_olo+'</telefono_referente_tecnico_olo> ';
		requestTTM=requestTTM+'<email_referente_tecnico_olo>'+email_referente_tecnico_olo+'</email_referente_tecnico_olo> ';
		requestTTM=requestTTM+'<note_cliente>'+note_cliente+'</note_cliente> ';
		requestTTM=requestTTM+'<request_detail>'+request_detail+'</request_detail> ';
		
        requestTTM=requestTTM+'<verifica_apparato>'+verifica_apparato+'</verifica_apparato> ';
        requestTTM=requestTTM+'<descrizione_problema>'+descrizione_problema+'</descrizione_problema> ';
        requestTTM=requestTTM+'<ticketreason>'+ticketreason+'</ticketreason> ';
        requestTTM=requestTTM+'<intervention_joint>'+intervention_joint+'</intervention_joint> ';
        requestTTM=requestTTM+'<tec_olo>'+tec_olo+'</tec_olo> ';
        requestTTM=requestTTM+'<tel_tec_olo>'+tel_tec_olo+'</tel_tec_olo> ';
        requestTTM=requestTTM+'<data_ora_intervento_congiunto>'+data_ora_intervento_congiunto+'</data_ora_intervento_congiunto> ';
        requestTTM=requestTTM+'<service_type>'+service_type+'</service_type> ';
        requestTTM=requestTTM+'<sla_type>'+sla_type+'</sla_type> ';
        requestTTM=requestTTM+'<region>'+region+'</region> ';
        requestTTM=requestTTM+'<address>'+address+'</address> ';
        requestTTM=requestTTM+'<diagnosis_result>'+diagnosis_result+'</diagnosis_result> ';
        requestTTM=requestTTM+'<attachments>'+attachments+'</attachments> ';
		requestTTM=requestTTM+'<orderid>'+orderid+'</orderid> ';
  
        /* i seguenti campi commentati non sono presenti su OLOGW_TTM_Request0.2
        requestTTM=requestTTM+'<olo_gw_ttid>'+olo_gw_ttid+'</olo_gw_ttid> ';         
        requestTTM=requestTTM+'<orderid>'+orderid+'</orderid> ';
        requestTTM=requestTTM+'<request_type>'+request_type+'</request_type> ';
        //riportato sopra come ordine WSDL requestTTM=requestTTM+'<id_notification>'+id_notification+'</id_notification> ';
        //riportato sopra come ordine WSDL requestTTM=requestTTM+'<id_resource>'+id_resource+'</id_resource> ';
       // riportato sopra come ordine WSDL requestTTM=requestTTM+'<data_ora_beginning_fault>'+data_ora_beginning_fault+'</data_ora_beginning_fault> ';
       //riportato sopra come ordine WSDL  requestTTM=requestTTM+'<name_client>'+name_client+'</name_client> ';
        //campo NOTE aggiunto presente sul wsdl EC
        requestTTM=requestTTM+'<note>'+note+'</note> ';
        //
        requestTTM=requestTTM+'<ticketreason>'+ticketreason+'</ticketreason> ';
        requestTTM=requestTTM+'<intervention_joint>'+intervention_joint+'</intervention_joint> ';
       //riportato sopra come ordine WSDL  requestTTM=requestTTM+'<tec_olo>'+tec_olo+'</tec_olo> ';
       //riportato sopra come ordine WSDL  requestTTM=requestTTM+'<tel_tec_olo>'+tel_tec_olo+'</tel_tec_olo> ';
       //riportato sopra come ordine WSDL  requestTTM=requestTTM+'<data_ora_intervento_congiunto>'+data_ora_intervento_congiunto+'</data_ora_intervento_congiunto> ';
        */ 
        
        requestTTM=requestTTM+part_final_XML();
    }

    public void DiscardTicket(){
        kind_communication='99';
        
        /* praticamente uguale a CreateDiscardedTT, eccetto che per un campo qui mancante(request_time)*/

        requestTTM=part_Initial_XML();
        requestTTM=requestTTM+'<kind_communication>'+kind_communication+'</kind_communication> ';
        requestTTM=requestTTM+'<res>'+res+'</res> ';
		requestTTM=requestTTM+'<olo_gw_ttid>'+olo_gw_ttid+'</olo_gw_ttid> ';
		requestTTM=requestTTM+'<request_type>'+request_type+'</request_type> ';
		requestTTM=requestTTM+'<id_notification>'+id_notification+'</id_notification> ';
		requestTTM=requestTTM+'<id_resource>'+id_resource+'</id_resource> ';
		requestTTM=requestTTM+'<data_ora_beginning_fault>'+data_ora_beginning_fault+'</data_ora_beginning_fault> ';
		
		requestTTM=requestTTM+'<name_client>'+name_client+'</name_client> ';
		requestTTM=requestTTM+'<customer_surname>'+customer_surname+'</customer_surname> ';
		requestTTM=requestTTM+'<customer_telephone_number_1>'+customer_telephone_number_1+'</customer_telephone_number_1> ';
		requestTTM=requestTTM+'<customer_telephone_number_2>'+customer_telephone_number_2+'</customer_telephone_number_2> ';
		requestTTM=requestTTM+'<nome_referente_tecnico_olo>'+nome_referente_tecnico_olo+'</nome_referente_tecnico_olo> ';
		requestTTM=requestTTM+'<telefono_referente_tecnico_olo>'+telefono_referente_tecnico_olo+'</telefono_referente_tecnico_olo> ';
		requestTTM=requestTTM+'<email_referente_tecnico_olo>'+email_referente_tecnico_olo+'</email_referente_tecnico_olo> ';
		requestTTM=requestTTM+'<note_cliente>'+note_cliente+'</note_cliente> ';
		requestTTM=requestTTM+'<request_detail>'+request_detail+'</request_detail> ';
		requestTTM=requestTTM+'<ticketreason>'+ticketreason+'</ticketreason> ';
		requestTTM=requestTTM+'<intervention_joint>'+intervention_joint+'</intervention_joint> ';
		requestTTM=requestTTM+'<tec_olo>'+tec_olo+'</tec_olo> ';
		requestTTM=requestTTM+'<tel_tec_olo>'+tel_tec_olo+'</tel_tec_olo> ';
		requestTTM=requestTTM+'<data_ora_intervento_congiunto>'+data_ora_intervento_congiunto+'</data_ora_intervento_congiunto> ';
		requestTTM=requestTTM+'<service_type>'+service_type+'</service_type> ';
		requestTTM=requestTTM+'<sla_type>'+sla_type+'</sla_type> ';
		requestTTM=requestTTM+'<region>'+region+'</region> ';
		requestTTM=requestTTM+'<address>'+address+'</address> ';
		requestTTM=requestTTM+'<diagnosis_result>'+diagnosis_result+'</diagnosis_result> ';
		requestTTM=requestTTM+'<attachments>'+attachments+'</attachments> ';
		requestTTM=requestTTM+'<orderid>'+orderid+'</orderid> ';
		
        
        /*  i seguenti campi commentati non sono presenti su OLOGW_TTM_Request0.2
        requestTTM=requestTTM+'<olo_gw_ttid>'+olo_gw_ttid+'</olo_gw_ttid> ';         
        requestTTM=requestTTM+'<orderid>'+orderid+'</orderid> ';
        requestTTM=requestTTM+'<request_type>'+request_type+'</request_type> ';
        requestTTM=requestTTM+'<id_notification>'+id_notification+'</id_notification> ';
        requestTTM=requestTTM+'<id_resource>'+id_resource+'</id_resource> ';
        requestTTM=requestTTM+'<data_ora_beginning_fault>'+data_ora_beginning_fault+'</data_ora_beginning_fault> ';
        requestTTM=requestTTM+'<name_client>'+name_client+'</name_client> ';
        //campo NOTE aggiunto presente sul wsdl EC
        requestTTM=requestTTM+'<note>'+note+'</note> ';
        //
        requestTTM=requestTTM+'<ticketreason>'+ticketreason+'</ticketreason> ';
        requestTTM=requestTTM+'<intervention_joint>'+intervention_joint+'</intervention_joint> ';
        
        //campi service_type,sla_type,region,address aggiunti, presenti sul wsdl EC
        requestTTM=requestTTM+'<service_type>'+service_type+'</service_type> ';
        requestTTM=requestTTM+'<sla_type>'+sla_type+'</sla_type> ';
        requestTTM=requestTTM+'<region>'+region+'</region> ';
        requestTTM=requestTTM+'<address>'+address+'</address> ';
        //
        
        requestTTM=requestTTM+'<diagnosis_result>'+diagnosis_result+'</diagnosis_result> ';
        requestTTM=requestTTM+'<attachments>'+attachments+'</attachments> ';
        requestTTM=requestTTM+'<customer_surname>'+customer_surname+'</customer_surname> ';
        requestTTM=requestTTM+'<customer_telephone_number_1>'+customer_telephone_number_1+'</customer_telephone_number_1> ';
        requestTTM=requestTTM+'<customer_telephone_number_2>'+customer_telephone_number_2+'</customer_telephone_number_2> ';
        requestTTM=requestTTM+'<nome_referente_tecnico_olo>'+nome_referente_tecnico_olo+'</nome_referente_tecnico_olo> ';
        requestTTM=requestTTM+'<telefono_referente_tecnico_olo>'+telefono_referente_tecnico_olo+'</telefono_referente_tecnico_olo> ';
        requestTTM=requestTTM+'<email_referente_tecnico_olo>'+email_referente_tecnico_olo+'</email_referente_tecnico_olo> ';
        requestTTM=requestTTM+'<note_cliente>'+note_cliente+'</note_cliente> ';
        requestTTM=requestTTM+'<tec_olo>'+tec_olo+'</tec_olo> ';
        requestTTM=requestTTM+'<tel_tec_olo>'+tel_tec_olo+'</tel_tec_olo> ';
        requestTTM=requestTTM+'<data_ora_joint_intervention>'+data_ora_joint_intervention+'</data_ora_joint_intervention> ';
        */
        requestTTM=requestTTM+part_final_XML();
    }

    public void ResumeTicket(){
    	
    	/* Campi res,olo_gw_ttid,id_resource, id_notification,
    	 request_type, data_ora_resumerequest, name_client, customer_surname, customer_telephone_number_1, 
    	customer_telephone_number_2, nome_referente_tecnico_olo, 
    	telefono_referente_tecnico_olo,email_referente_tecnico_olo,
      	causale_desospensione, note_cliente, request_detail,
      	attachments, orderid  aggiunti come da OLOGW_TTM_Request0.2
        */

        requestTTM=part_Initial_XML();
        requestTTM=requestTTM+'<kind_communication>'+kind_communication+'</kind_communication> ';
        
        requestTTM=requestTTM+'<res>'+res+'</res> ';
		requestTTM=requestTTM+'<olo_gw_ttid>'+olo_gw_ttid+'</olo_gw_ttid> ';
		requestTTM=requestTTM+'<id_resource>'+id_resource+'</id_resource> ';
		requestTTM=requestTTM+'<id_notification>'+id_notification+'</id_notification> ';
		requestTTM=requestTTM+'<request_type>'+request_type+'</request_type> ';
		requestTTM=requestTTM+'<data_ora_resumerequest>'+data_ora_resumerequest+'</data_ora_resumerequest> ';
        
        requestTTM=requestTTM+'<name_client>'+name_client+'</name_client> ';
		requestTTM=requestTTM+'<customer_surname>'+customer_surname+'</customer_surname> ';
		requestTTM=requestTTM+'<customer_telephone_number_1>'+customer_telephone_number_1+'</customer_telephone_number_1> ';
		requestTTM=requestTTM+'<customer_telephone_number_2>'+customer_telephone_number_2+'</customer_telephone_number_2> ';
		requestTTM=requestTTM+'<nome_referente_tecnico_olo>'+nome_referente_tecnico_olo+'</nome_referente_tecnico_olo> ';
		requestTTM=requestTTM+'<telefono_referente_tecnico_olo>'+telefono_referente_tecnico_olo+'</telefono_referente_tecnico_olo> ';
		requestTTM=requestTTM+'<email_referente_tecnico_olo>'+email_referente_tecnico_olo+'</email_referente_tecnico_olo> ';
		requestTTM=requestTTM+'<causale_desospensione>'+causale_desospensione+'</causale_desospensione> ';
        requestTTM=requestTTM+'<note_cliente>'+note_cliente+'</note_cliente> ';
		requestTTM=requestTTM+'<request_detail>'+request_detail+'</request_detail> ';
		requestTTM=requestTTM+'<attachments>'+attachments+'</attachments> ';
		requestTTM=requestTTM+'<orderid>'+orderid+'</orderid> ';
		
      /*  i seguenti campi commentati non sono presenti su OLOGW_TTM_Request0.2  
        requestTTM=requestTTM+'<olo_gw_ttid>'+olo_gw_ttid+'</olo_gw_ttid> '; 
        requestTTM=requestTTM+'<orderid>'+orderid+'</orderid> ';
        requestTTM=requestTTM+'<id_notification>'+id_notification+'</id_notification> ';
        requestTTM=requestTTM+'<type_resume_request>'+type_resume_request+'</type_resume_request> ';   
        requestTTM=requestTTM+'<note>'+note+'</note> ';
        requestTTM=requestTTM+'<attachments>'+attachments+'</attachments> ';         
        requestTTM=requestTTM+'<data_ora_resumerequest>'+data_ora_resumerequest+'</data_ora_resumerequest> ';
        */
        requestTTM=requestTTM+part_final_XML();
    }
    
    public void SuspendTicket(){
    	 requestTTM=part_Initial_XML();
    	
    		requestTTM=requestTTM+'<kind_communication>'+kind_communication+'</kind_communication> ';
            requestTTM=requestTTM+'<res>'+res+'</res> ';
            requestTTM=requestTTM+'<olo_gw_ttid>'+olo_gw_ttid+'</olo_gw_ttid> ';
            requestTTM=requestTTM+'<id_notification>'+id_notification+'</id_notification> ';
            requestTTM=requestTTM+'<data_ora_notifica_sospensione>'+data_ora_notifica_sospensione+'</data_ora_notifica_sospensione> ';
            requestTTM=requestTTM+'<causale_sospensione>'+causale_sospensione+'</causale_sospensione> ';
            requestTTM=requestTTM+'<referente_sospensione>'+referente_sospensione+'</referente_sospensione> ';
            requestTTM=requestTTM+'<request_detail>'+request_detail+'</request_detail> ';
            requestTTM=requestTTM+'<rischedulazione_appuntamento>'+rischedulazione_appuntamento+'</rischedulazione_appuntamento> ';
            requestTTM=requestTTM+'<intervention_joint>'+intervention_joint+'</intervention_joint> ';
            requestTTM=requestTTM+'<tec_olo>'+tec_olo+'</tec_olo> ';
            requestTTM=requestTTM+'<tel_tec_olo>'+tel_tec_olo+'</tel_tec_olo> ';
            requestTTM=requestTTM+'<data_ora_intervento_congiunto>'+data_ora_intervento_congiunto+'</data_ora_intervento_congiunto> ';
            requestTTM=requestTTM+'<data_ora_pauserequest>'+data_ora_pauserequest+'</data_ora_pauserequest> ';
            requestTTM=requestTTM+'<data_ora_resumerequest>'+data_ora_resumerequest+'</data_ora_resumerequest> ';
            requestTTM=requestTTM+'<type_pause_request>'+type_pause_request+'</type_pause_request> ';
            requestTTM=requestTTM+'<attachments>'+attachments+'</attachments> ';
            requestTTM=requestTTM+'<orderid>'+orderid+'</orderid> ';
    	
    	
    	 requestTTM=requestTTM+part_final_XML();
    }
     
    public void TestKO(){
    	 requestTTM=part_Initial_XML();
    	 
         requestTTM=requestTTM+'<kind_communication>'+kind_communication+'</kind_communication> ';
		 requestTTM=requestTTM+'<res>'+res+'</res> ';
		 requestTTM=requestTTM+'<olo_gw_ttid>'+olo_gw_ttid+'</olo_gw_ttid> ';
		 requestTTM=requestTTM+'<request_type>'+request_type+'</request_type> ';
		 requestTTM=requestTTM+'<id_resource>'+id_resource+'</id_resource> ';
		 requestTTM=requestTTM+'<counter_testko>'+counter_testko+'</counter_testko> ';
		 requestTTM=requestTTM+'<id_notification>'+id_notification+'</id_notification> ';
		 requestTTM=requestTTM+'<data_ora_testko>'+data_ora_testko+'</data_ora_testko> ';
		 requestTTM=requestTTM+'<ticketreason>'+ticketreason+'</ticketreason> ';
		 requestTTM=requestTTM+'<name_client>'+name_client+'</name_client> ';
		 requestTTM=requestTTM+'<customer_surname>'+customer_surname+'</customer_surname> ';
		 requestTTM=requestTTM+'<customer_telephone_number_1>'+customer_telephone_number_1+'</customer_telephone_number_1> ';
		 requestTTM=requestTTM+'<customer_telephone_number_2>'+customer_telephone_number_2+'</customer_telephone_number_2> ';
		 requestTTM=requestTTM+'<nome_referente_tecnico_olo>'+nome_referente_tecnico_olo+'</nome_referente_tecnico_olo> ';
		 requestTTM=requestTTM+'<telefono_referente_tecnico_olo>'+telefono_referente_tecnico_olo+'</telefono_referente_tecnico_olo> ';
		 requestTTM=requestTTM+'<email_referente_tecnico_olo>'+email_referente_tecnico_olo+'</email_referente_tecnico_olo> ';
		 requestTTM=requestTTM+'<note_cliente>'+note_cliente+'</note_cliente> ';
		 requestTTM=requestTTM+'<request_detail>'+request_detail+'</request_detail> ';
	     requestTTM=requestTTM+'<intervention_joint>'+intervention_joint+'</intervention_joint> ';
		 requestTTM=requestTTM+'<tec_olo>'+tec_olo+'</tec_olo> ';
		 requestTTM=requestTTM+'<tel_tec_olo>'+tel_tec_olo+'</tel_tec_olo> ';
		 requestTTM=requestTTM+'<data_ora_intervento_congiunto>'+data_ora_intervento_congiunto+'</data_ora_intervento_congiunto> ';
		 requestTTM=requestTTM+'<attachments>'+attachments+'</attachments> ';
		 requestTTM=requestTTM+'<orderid>'+orderid+'</orderid> ';
    
    	 requestTTM=requestTTM+part_final_XML();
    }
    
    public void TestOKRequest(){
		//  i seguenti campi sono commentati perché non è presente il servizio su OLOGW_TTM_Request0.2  
        /*requestTTM=part_Initial_XML();
        requestTTM=requestTTM+'<kind_communication>'+kind_communication+'</kind_communication> ';
        requestTTM=requestTTM+'<olo_gw_ttid>'+olo_gw_ttid+'</olo_gw_ttid> '; 
        requestTTM=requestTTM+'<orderid>'+orderid+'</orderid> ';
        requestTTM=requestTTM+'<id_notification>'+id_notification+'</id_notification> ';
        requestTTM=requestTTM+'<data_ora_testok>'+data_ora_testok+'</data_ora_testok> ';
        requestTTM=requestTTM+'<type_testok>'+type_testok+'</type_testok> ';
        requestTTM=requestTTM+'<note>'+note+'</note> ';
        requestTTM=requestTTM+'<attachments>'+attachments+'</attachments> ';       
        requestTTM=requestTTM+part_final_XML();*/
    }

    public void TestOKRequestToClose(){
    	
    	/* Campi res,request_type,id_resource, request_type,
    	name_client, customer_surname, customer_telephone_number_1, 
    	customer_telephone_number_2, nome_referente_tecnico_olo, 
    	telefono_referente_tecnico_olo,email_referente_tecnico_olo,
    	data_ora_testok, note_cliente, request_detail aggiunti come da OLOGW_TTM_Request0.2
        */

        requestTTM=part_Initial_XML();
        
        requestTTM=requestTTM+'<kind_communication>'+kind_communication+'</kind_communication> ';
        requestTTM=requestTTM+'<res>'+res+'</res> ';
        requestTTM=requestTTM+'<olo_gw_ttid>'+olo_gw_ttid+'</olo_gw_ttid> '; 
        requestTTM=requestTTM+'<request_type>'+request_type+'</request_type> ';
		requestTTM=requestTTM+'<id_notification>'+id_notification+'</id_notification> ';
        requestTTM=requestTTM+'<id_resource>'+id_resource+'</id_resource> ';
		requestTTM=requestTTM+'<data_ora_testok>'+data_ora_testok+'</data_ora_testok> ';
          
        requestTTM=requestTTM+'<name_client>'+name_client+'</name_client> ';
		requestTTM=requestTTM+'<customer_surname>'+customer_surname+'</customer_surname> ';
		requestTTM=requestTTM+'<customer_telephone_number_1>'+customer_telephone_number_1+'</customer_telephone_number_1> ';
		requestTTM=requestTTM+'<customer_telephone_number_2>'+customer_telephone_number_2+'</customer_telephone_number_2> ';
		requestTTM=requestTTM+'<nome_referente_tecnico_olo>'+nome_referente_tecnico_olo+'</nome_referente_tecnico_olo> ';
		requestTTM=requestTTM+'<telefono_referente_tecnico_olo>'+telefono_referente_tecnico_olo+'</telefono_referente_tecnico_olo> ';
		requestTTM=requestTTM+'<email_referente_tecnico_olo>'+email_referente_tecnico_olo+'</email_referente_tecnico_olo> ';
		requestTTM=requestTTM+'<note_cliente>'+note_cliente+'</note_cliente> ';
		requestTTM=requestTTM+'<request_detail>'+request_detail+'</request_detail> ';
	    requestTTM=requestTTM+'<attachments>'+attachments+'</attachments> ';       
        requestTTM=requestTTM+'<orderid>'+orderid+'</orderid> ';
       
       /*   i seguenti campi commentati non sono presenti su OLOGW_TTM_Request0.2  
        requestTTM=requestTTM+'<data_ora_testko>'+data_ora_testko+'</data_ora_testko> ';
        requestTTM=requestTTM+'<type_testko>'+type_testko+'</type_testko> ';
        requestTTM=requestTTM+'<note>'+note+'</note> ';
        */
         
        requestTTM=requestTTM+part_final_XML();
    }
  
  
    private String gettingSlaPremiumByCaseTTM (Case caseTTM){
    	String tipoBE=blank;
    	for(PriceBookEntry pbe : [select id, Name from PriceBookEntry where OF_Asset__c =: caseTTM.AssetId and Name IN('Canone','Canone Premium')]){
        	if('Canone'.equalsIgnoreCase(pbe.Name)){
          	 	 tipoBE='Base';
       		}
       		 else if('Canone Premium'.equalsIgnoreCase(pbe.Name)){
           		 tipoBE='Premium';
        	}
    	}   
   	    return tipoBE;
   	}
}