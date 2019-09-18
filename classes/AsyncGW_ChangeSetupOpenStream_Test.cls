@isTest
global class AsyncGW_ChangeSetupOpenStream_Test 
{
    global static testmethod void Metodo1(){
        AsyncGW_ChangeSetupOpenStream ob1 =new AsyncGW_ChangeSetupOpenStream();
		AsyncGW_ChangeSetupOpenStream.AsyncChangeSetupOpenStreamPortTypeEndpoint1 ob2= new AsyncGW_ChangeSetupOpenStream.AsyncChangeSetupOpenStreamPortTypeEndpoint1();
    	Test.setMock(WebServiceMock.class, new AsyncGW_ChangeSetupOpenStreamMockCls());
        GW_ChangeSetupOpenStream_Input ob3=new GW_ChangeSetupOpenStream_Input ();
        GW_ChangeSetupOpenStream_Input.VLAN_element Vlan=new  GW_ChangeSetupOpenStream_Input.VLAN_element();
        List< GW_ChangeSetupOpenStream_Input.VLAN_element> VlanList = new List< GW_ChangeSetupOpenStream_Input.VLAN_element>();
         Vlan.INFORMAZIONI_VLAN='Test 1';
        Vlanlist.add(Vlan);    
        Continuation cont = new Continuation(120);  
        DateTime DATA_NOTIFICA= Datetime.now();
        ob2.beginChangeSetupOpenStream(cont,'String TIPO_COMUNICAZIONE','String CODICE_OPERATORE','String CODICE_ORDINE_OLO','String CODICE_ORDINE_OF',DATA_NOTIFICA,'String ID_NOTIFICA','String ID_RISORSA','String CODICE_PROGETTO_SPECIALE','String PROMOZIONE','String CLUSTER_PROMOZIONE','String NOTE','String ID_SERVIZIO','String PROFILO',Vlanlist)  ;                      
  
                  
       
    }
    
}