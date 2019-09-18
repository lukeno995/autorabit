public without sharing class Export_CD_ListaRichiesteInserite_Ctrl{
    
    public String soql {get;set;}
    public List<EOF_EAI_Service_Log__c> listRichiesteTP {get;set;}

    //Start - Add by PG - 30-11 - Export Lista Richieste Inserite OpenStream C&D
    public PageReference fetchList_OpStr_CD(){
        
        System.debug('#fetchList_OpStr_CD');
        String DataFineNotifica = System.currentPagereference().getParameters().get('DataFineNotifica');
        String DataInizioCreazione = System.currentPagereference().getParameters().get('DataInizioCreazione');
        String DataFineCreazione = System.currentPagereference().getParameters().get('DataFineCreazione');
        String ListTipoT = System.currentPagereference().getParameters().get('ListTipo');
        String ListStatusT = System.currentPagereference().getParameters().get('ListStatus');
        String valPOP = System.currentPagereference().getParameters().get('valPOP');
        String valCodOrdOLO = System.currentPagereference().getParameters().get('valCodOrdOLO');
        String valIDRisorsa = System.currentPagereference().getParameters().get('valIDRisorsa');
        
        System.debug('#DataFineNotifica'+DataFineNotifica);
        System.debug('##DataInizioCreazione'+DataInizioCreazione);
        System.debug('###DataFineCreazione'+DataFineCreazione);
        System.debug('####ListTipo'+ListTipoT);
        System.debug('#####ListStatus'+ListStatusT);
        System.debug('#####valPOP'+valPOP);
        System.debug('#####valCodOrdOLO'+valCodOrdOLO);
        System.debug('#####valIDRisorsa'+valIDRisorsa);
        
        User attuale = [select Id, Account.EOF_Codice_Operatore__c 
                        from user 
                        where Id=:userinfo.getUserId()];
        
        System.debug('User Attuale '+ attuale +' Account.EOF_Codice_Operatore__c '+ Account.EOF_Codice_Operatore__c);
        
        soql = 'select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,' 
            +'EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,'
            +'EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,'
            +'EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,'
            +'EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,'
            +'OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,'
            +'OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_Tipo_Comunicazione_String__c,'
            +'EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,PO_SA_Data_Inserimento_Ordine__c,EOF_ID_Risorsa__c '
            +' from EOF_EAI_Service_Log__c where (recordType.developerName=\'PO_SA_CD_Log_OpenStreamRequest\' OR recordType.developerName=\'PO_SA_CD_Log_ChangeOrderRequest\') AND EOF_Stato_Richiesta__c=\'Inserita Portale\''
            +' and EOF_Codice_Operatore__c=\'' + attuale.Account.EOF_Codice_Operatore__c + '\'  ';
            
        if (!DataInizioCreazione.equals(''))
        {
            DataInizioCreazione=DataInizioCreazione.replace(' ','+');
            soql += ' and EOF_Data_Notifica__c >='+String.escapeSingleQuotes(DataInizioCreazione);
        }
        if (!DataFineNotifica.equals('')) 
        {
            DataFineNotifica=DataFineNotifica.replace(' ','+');
            soql += ' and EOF_Data_Notifica__c <='+String.escapeSingleQuotes(DataFineNotifica);
        }
        if (!DataInizioCreazione.equals(''))
        {
            DataInizioCreazione=DataInizioCreazione.replace(' ','+');
            soql += ' and PO_SA_Data_Inserimento_Ordine__c >='+String.escapeSingleQuotes(DataInizioCreazione);
        }
        if (!DataFineCreazione.equals(''))
        {
            DataFineCreazione=DataFineCreazione.replace(' ','+');
            soql += ' and PO_SA_Data_Inserimento_Ordine__c <='+String.escapeSingleQuotes(DataFineCreazione);
        }
        
        if(String.isNotBlank(ListTipoT))
        {
            List<String> ListTipo = (List<String>)System.JSON.deserialize(ListTipoT, List<String>.class);
            if(ListTipo!=null && !ListTipo.isEmpty())   
            {
                soql += ' and EOF_Tipo_Comunicazione_String__c in (';
                for (string mystring:ListTipo){
                    soql +='\'' + mystring + '\',';
                }
                soql = soql.removeEnd(',');
                soql += ')';          
            }
        }
        if(String.isNotBlank(ListStatusT)){
            List<String> ListStatus = (List<String>)System.JSON.deserialize(ListStatusT, List<String>.class);
            if(ListStatus!=null && !ListStatus.isEmpty())   
            {
                soql += ' and EOF_STATO_ORDINE__c in (';
                for (string mystring:ListStatus){
                    soql +='\'' + mystring + '\',';
                }
                soql = soql.removeEnd(',');
                soql += ')';  
            }
        }
        if (!valPOP.equals(''))
        {
            soql += ' and EOF_ID_Pop__c =\''+String.escapeSingleQuotes(valPOP)+'\'';
        }
        if (!valCodOrdOLO.equals(''))
        {
            soql += ' and EOF_Codice_Ordine_OLO__c =\''+String.escapeSingleQuotes(valCodOrdOLO)+'\'';
        }
        if (!valIDRisorsa.equals(''))
        {
            soql += ' and EOF_ID_Risorsa__c =\''+String.escapeSingleQuotes(valIDRisorsa)+'\'';
        }
        system.debug('*******soql' +soql);
        system.debug('*******listRichiesteTP' +listRichiesteTP);  
        listRichiesteTP = Database.query(soql + ' order by CreatedDate DESC');
        return null;
    }
    //End - Add by PG - 30-11 - Export Lista Richieste Inserite OpenStream C&D
    
    
    //Start - Add by PG - 30-11 - Export Lista Richieste Inserite GPON Passiva C&D
    public PageReference fetchList_GPON_Pass_CD(){
        
        System.debug('#fetchList_GPON_Pass_CD');
        String DataFineNotifica = System.currentPagereference().getParameters().get('DataFineNotifica');
        String DataInizioCreazione = System.currentPagereference().getParameters().get('DataInizioCreazione');
        String DataFineCreazione = System.currentPagereference().getParameters().get('DataFineCreazione');
        String ListTipoT = System.currentPagereference().getParameters().get('ListTipo');
        String ListStatusT = System.currentPagereference().getParameters().get('ListStatus');
        String valPOP = System.currentPagereference().getParameters().get('valPOP');
        String valCodOrdOLO = System.currentPagereference().getParameters().get('valCodOrdOLO');
        String valIDRisorsa = System.currentPagereference().getParameters().get('valIDRisorsa');
        
        System.debug('#DataFineNotifica'+DataFineNotifica);
        System.debug('##DataInizioCreazione'+DataInizioCreazione);
        System.debug('###DataFineCreazione'+DataFineCreazione);
        System.debug('####ListTipo'+ListTipoT);
        System.debug('#####ListStatus'+ListStatusT);
        System.debug('#####valPOP'+valPOP);
        System.debug('#####valCodOrdOLO'+valCodOrdOLO);
        System.debug('#####valIDRisorsa'+valIDRisorsa);
        
        User attuale = [select Id, Account.EOF_Codice_Operatore__c 
                        from user 
                        where Id=:userinfo.getUserId()];
        
        System.debug('User Attuale '+ attuale +' Account.EOF_Codice_Operatore__c '+ Account.EOF_Codice_Operatore__c);
        
        soql = 'select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,' 
            +'EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,'
            +'EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,'
            +'EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,'
            +'EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,'
            +'OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,'
            +'OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_Tipo_Comunicazione_String__c,'
            +'EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,PO_SA_Data_Inserimento_Ordine__c,EOF_ID_Risorsa__c '
            +' from EOF_EAI_Service_Log__c where (recordType.developerName=\'PO_SA_CD_Log_GPONPRequest\') AND EOF_Stato_Richiesta__c=\'Inserita Portale\''
            +' and EOF_Codice_Operatore__c=\'' + attuale.Account.EOF_Codice_Operatore__c + '\'  ';
            
        if (!DataInizioCreazione.equals(''))
        {
            DataInizioCreazione=DataInizioCreazione.replace(' ','+');
            soql += ' and EOF_Data_Notifica__c >='+String.escapeSingleQuotes(DataInizioCreazione);
        }
        if (!DataFineNotifica.equals('')) 
        {
            DataFineNotifica=DataFineNotifica.replace(' ','+');
            soql += ' and EOF_Data_Notifica__c <='+String.escapeSingleQuotes(DataFineNotifica);
        }
        if (!DataInizioCreazione.equals(''))
        {
            DataInizioCreazione=DataInizioCreazione.replace(' ','+');
            soql += ' and PO_SA_Data_Inserimento_Ordine__c >='+String.escapeSingleQuotes(DataInizioCreazione);
        }
        if (!DataFineCreazione.equals(''))
        {
            DataFineCreazione=DataFineCreazione.replace(' ','+');
            soql += ' and PO_SA_Data_Inserimento_Ordine__c <='+String.escapeSingleQuotes(DataFineCreazione);
        }
        
        if(String.isNotBlank(ListTipoT))
        {
            List<String> ListTipo = (List<String>)System.JSON.deserialize(ListTipoT, List<String>.class);
            if(ListTipo!=null && !ListTipo.isEmpty())   
            {
                soql += ' and EOF_Tipo_Comunicazione_String__c in (';
                for (string mystring:ListTipo){
                    soql +='\'' + mystring + '\',';
                }
                soql = soql.removeEnd(',');
                soql += ')';          
            }
        }
        if(String.isNotBlank(ListStatusT)){
            List<String> ListStatus = (List<String>)System.JSON.deserialize(ListStatusT, List<String>.class);
            if(ListStatus!=null && !ListStatus.isEmpty())   
            {
                soql += ' and EOF_STATO_ORDINE__c in (';
                for (string mystring:ListStatus){
                    soql +='\'' + mystring + '\',';
                }
                soql = soql.removeEnd(',');
                soql += ')';  
            }
        }
        if (!valPOP.equals(''))
        {
            soql += ' and EOF_ID_Pop__c =\''+String.escapeSingleQuotes(valPOP)+'\'';
        }
        if (!valCodOrdOLO.equals(''))
        {
            soql += ' and EOF_Codice_Ordine_OLO__c =\''+String.escapeSingleQuotes(valCodOrdOLO)+'\'';
        }
        if (!valIDRisorsa.equals(''))
        {
            soql += ' and EOF_ID_Risorsa__c =\''+String.escapeSingleQuotes(valIDRisorsa)+'\'';
        }
        system.debug('*******soql' +soql);
        system.debug('*******listRichiesteTP' +listRichiesteTP);  
        listRichiesteTP = Database.query(soql + ' order by CreatedDate DESC');
        return null;
    }
    //End - Add by PG - 30-11 - Export Lista Richieste Inserite GPON Passiva C&D
}