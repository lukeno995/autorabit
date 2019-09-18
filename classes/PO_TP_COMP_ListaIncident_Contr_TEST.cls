@isTest
public class PO_TP_COMP_ListaIncident_Contr_TEST
{
    public static OF_Tibco_userID__c UserTibcoCreation(){
     
        OF_Tibco_userID__c tibco_user = new OF_Tibco_userID__c();
        tibco_user.Name = 'Tibco UserID';
        tibco_user.OF_Tibco_ID__c = '00558000001f743AAA';   
        insert tibco_user;
        return tibco_user;
    }    

    static testmethod void test_method1()
    {  
        OF_Enable_PO_UpdateOppCase_Trigger__c trig_PO_Upd = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trig_PO_Upd.Name = 'Status';
        trig_PO_Upd.OF_Enable_Trigger__c = true;
        insert trig_PO_Upd; 

        OF_Tibco_userID__c utente_tibco = UserTibcoCreation();  
       
        
        Map<String,ID> profiles = new Map<String,ID>();
       List<Profile> ps = [select id, name from Profile where name = 
         'Standard User' or name = 'System Administrator'];

       for(Profile p : ps){
         profiles.put(p.name, p.id);
       }

      // Create the users to be used in this test.  
    
      // First make a new user.  
    

       User standard = new User(alias = 'standt', 
       email='standarduser@testorg.com', 
       emailencodingkey='UTF-8', 
       lastname='Testing', languagelocalekey='en_US', 
       localesidkey='en_US', 
       profileid = profiles.get('System Administrator'), 
       timezonesidkey='America/Los_Angeles', 
       username='standarduser1234*@testorg.com');

       insert standard;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO - TP - TicketProvisioning Case').getRecordTypeId();
        Case c = new Case();
        c.Subject = 'Incident Management';
        c.Status = 'Acquisito';
        c.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        c.PO_TP_Causale_Apertura_Segnalazione__c = 'Problema tecnico/applicativo';
        c.PO_TP_Escalation__c = false;
        c.PO_TP_Descrizione_Causale__c = 'Sollecito';
        c.EOF_Codice_Operatore_WS__c =standard.contact.account.name;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.Origin = 'Portal';
        insert c;

        system.runas(standard){
        test.startTest();
        PageReference pageRef1 = page.PO_TP_DisplayRequest;               
        pageRef1.getParameters().put('azione','Incident');
        pageRef1.getParameters().put('mess','escalated');
        
        Test.setCurrentPageReference(pageRef1);
      
        PO_TP_COMP_ListaIncident_Controller.optionApex opt = new PO_TP_COMP_ListaIncident_Controller.optionApex('A','B');
        PO_TP_COMP_ListaIncident_Controller.optionApex opt1 = new PO_TP_COMP_ListaIncident_Controller.optionApex(true,false);
        PO_TP_COMP_ListaIncident_Controller lista_ric_cont_1 = new PO_TP_COMP_ListaIncident_Controller();        
        Double x = lista_ric_cont_1.offset;
        lista_ric_cont_1.runSearch();
        lista_ric_cont_1.runQuery();
        lista_ric_cont_1.vaiInEscalation();
        Integer A = 1;
       // PO_TP_COMP_ListaIncident_Controller.codeCoverage(A);

        PageReference pageD = lista_ric_cont_1.ViewCaseDettail();
        lista_ric_cont_1.listRichiesteTP.add(c);
        lista_ric_cont_1.offset_page = 10;
        lista_ric_cont_1.setPagination(true);
		PageReference pageRefUp = lista_ric_cont_1.pageUp();
        PageReference pageRefDown = lista_ric_cont_1.pageDown();
        lista_ric_cont_1.preparePage();

        PageReference pageRef2 = page.PO_TP_DisplayRequest;               
        Test.setCurrentPageReference(pageRef2);
      
        PO_TP_COMP_ListaIncident_Controller lista_ric_cont_2 = new PO_TP_COMP_ListaIncident_Controller();

        test.stopTest();
        }
    }  
}