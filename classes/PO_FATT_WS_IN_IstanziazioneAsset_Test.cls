@isTest
public class PO_FATT_WS_IN_IstanziazioneAsset_Test
{
    @isTest
public static  void PO_FATT_WS_IS_IstanziazioneAssetMethod(){
    
     
        PO_FATT_WS_IN_IstanziazioneAsset istan = new PO_FATT_WS_IN_IstanziazioneAsset ();
          
        PO_FATT_WS_IN_IstanziazioneAsset.PO_AssetFields pac=new  PO_FATT_WS_IN_IstanziazioneAsset.PO_AssetFields(DateTime.now(),'Testing',1,'Testing',true); 
     																		/*This for testing if the contructor 
																				is working fine or not*/
        
    	system.assertEquals(pac.Attenuazione, 'Testing');                  /*This is for checking the values 
																				basically debugging*/
        system.debug('value=' + pac.Attenuazione); 
    
        PO_FATT_WS_IN_IstanziazioneAsset.mapRT();                         /*This is for calling mapRT() functioning*/
  
    
        Account acnt = new Account();                                    /*This is account creation which is to be  
																				used during order creation*/
        acnt.name = 'Account1';
    	insert(acnt);
    	
    	contract cont1=new contract();
        cont1.AccountId = acnt.id;
        cont1.name='test';
    	cont1.OF_Rinnovabile__c=true;
        insert cont1;
        
    	
    	list<order> ordersli=new list<order>();
    	order ord1 = new order();
    	Id orctype = Schema.SObjectType.order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();
    	ord1.RecordTypeId=orctype;
        ord1.AccountId = acnt.Id;
        ord1.Name ='test1';												/* Here we have created 3 different orders for checking
         																		differnt conditions statements */
    	ord1.Status = 'Aperto';
    	ord1.EffectiveDate = Date.newInstance(2018,2,1);
    	ord1.OF_TipologiaDiServizio__c='Attivo';
    	ord1.PO_IsFromOpportunity__c=true;
    	ord1.isFiberLink__c =true;
    	ord1.ContractId=cont1.Id;
    	ord1.PO_DataAttivazioneOrdine__c=Date.newInstance(2018,4,1);
    	ord1.PO_Attenuazione__c='Testing1';
    	ord1.PO_LunghezzaOttica__c=2;
    	ord1.PO_PosizioneRilascioCircuitoOSU__c='Testing11';
    	ord1.OF_IDBuilding__c='Tb1';
    	ord1.OF_IdentificativoDelPOP__c='TIDP1';
    	ord1.OF_GPONAttestazione__c='TGP1';
    	ord1.OF_Comune__c='TC1';
    	ord1.OF_Provincia__c='TP1';
    	ord1.OF_ParticellaToponomastica__c='TPLT1';
    	ord1.OF_Indirizzo__c='TIC1';
    	ord1.OF_Civico__c='TCO1';
    	ord1.OF_ScalaPalazzina__c='TSC1';
        ord1.OF_PosizioneSplitterSecondario__c='TPSS1';
    	ord1.OF_ProgettoSpeciale__c='TOPS1';
    	ord1.OF_ProfiloOpenStream__c='TPFI1';
    	ord1.OF_Promozione__c='TM1';
    	ord1.OF_ClusterPromozione__c='TCPZ1';
    	ord1.OF_TipologiaApparato__c='TA1';
    	ord1.OF_CodiceProgettoSpeciale__c='CPS1';
        ordersli.add(ord1); 
    	
    	order ord2 = new order();
    	Id orctype1 = Schema.SObjectType.order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();
    	ord2.RecordTypeId=orctype1;
        ord2.AccountId = acnt.Id;
        ord2.Name ='test2';
    	ord2.Status = 'Aperto';
    	ord2.EffectiveDate = Date.newInstance(2018,2,2);
    	ord2.OF_TipologiaDiServizio__c='Passivo';
    	ord2.PO_IsFromOpportunity__c=true;
    	ord2.isFiberLease__c=true;
    	ord2.ContractId=cont1.Id;
    	ord2.PO_DataAttivazioneOrdine__c=Date.newInstance(2018,4,1);
    	ord2.PO_Attenuazione__c='Testing2';
    	ord2.PO_LunghezzaOttica__c=2;
    	ord2.PO_PosizioneRilascioCircuitoOSU__c='Testing22';
    	ord2.OF_IDBuilding__c='Tb2';
    	ord2.OF_IdentificativoDelPOP__c='TIDP2';
    	ord2.OF_GPONAttestazione__c='TGP2';
    	ord2.OF_Comune__c='TC2';
    	ord2.OF_Provincia__c='TP2';
    	ord2.OF_ParticellaToponomastica__c='TPLT2';
    	ord2.OF_Indirizzo__c='TIC2';
    	ord2.OF_Civico__c='TCO2';
    	ord2.OF_ScalaPalazzina__c='TSC2';
    	ord2.OF_PosizioneSplitterSecondario__c='TPSS2';
    	ord2.OF_ProgettoSpeciale__c='TOPS2';
    	ord2.OF_ProfiloOpenStream__c='TPFI2';
    	ord2.OF_Promozione__c='TM2';
    	ord2.OF_ClusterPromozione__c='TCPZ2';
    	ord2.OF_TipologiaApparato__c='TA2';
    	ord2.OF_CodiceProgettoSpeciale__c='CPS2';
        ordersli.add(ord2); 
      
    	order ord3 = new order();
    	Id orctype2 = Schema.SObjectType.order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();
    	ord3.RecordTypeId=orctype2;
        ord3.AccountId = acnt.Id;
        ord3.Name ='test3';
    	ord3.Status = 'Aperto';
    	ord3.EffectiveDate = Date.newInstance(2018,2,3);
    	ord3.OF_TipologiaDiServizio__c='Passivo';
    	ord3.PO_IsFromOpportunity__c=true;
    	ord3.isFiberLease__c=false;
    	ord3.isFiberLink__c =false;
    	ord3.ContractId=cont1.Id;
    	ord3.PO_DataAttivazioneOrdine__c=Date.newInstance(2018,4,1);
    	ord3.PO_Attenuazione__c='Testing2';
    	ord3.PO_LunghezzaOttica__c=2;
    	ord3.PO_PosizioneRilascioCircuitoOSU__c='Testing33';
    	ord3.OF_IDBuilding__c='Tb3';
    	ord3.OF_IdentificativoDelPOP__c='TIDP3';
    	ord3.OF_GPONAttestazione__c='TGP3';
    	ord3.OF_Comune__c='TC3';
    	ord3.OF_Provincia__c='TP3';
    	ord3.OF_ParticellaToponomastica__c='TPLT3';
    	ord3.OF_Indirizzo__c='TIC3';
    	ord3.OF_Civico__c='TCO3';
    	ord3.OF_ScalaPalazzina__c='TSC3';
    	ord3.OF_PosizioneSplitterSecondario__c='TPSS3';
    	ord3.OF_ProgettoSpeciale__c='TOPS3';
    	ord3.OF_ProfiloOpenStream__c='TPFI3';
    	ord3.OF_Promozione__c='TM3';
    	ord3.OF_ClusterPromozione__c='TCPZ3';
    	ord3.OF_TipologiaApparato__c='TA3';
    	ord3.OF_CodiceProgettoSpeciale__c='CPS3';
        ordersli.add(ord3); 
    	insert(ordersli);
       
        PO_FATT_WS_IN_IstanziazioneAsset.OrderContract(ordersli);             /* Here we have passed the list of orders which consist 
                                                                               of different values for different orders*/
    
        
    	Schema.DescribeSObjectResult recordtSchema = Schema.SObjectType.Asset; 
        Map<String,Schema.RecordTypeInfo> AssetRecordTypeInfo = recordtSchema.getRecordTypeInfosByName();
    
        Id rt1 = AssetRecordTypeInfo.get('GPON Passiva').getRecordTypeId();
    
        Id rt2 = AssetRecordTypeInfo.get('Open Stream').getRecordTypeId();      /*Here we have taken record type of Asset dynamically
                                                                                 and then passed it to function and as all the fuctions
																					are static so they are called directly by class but
																					not by object name*/
    
        Id rt3 = AssetRecordTypeInfo.get('P2P').getRecordTypeId();
    
        Id rt4 = AssetRecordTypeInfo.get('Fiber Link').getRecordTypeId();
    
        Id rt5 = AssetRecordTypeInfo.get('Fiber Lease').getRecordTypeId();
       
        PO_FATT_WS_IN_IstanziazioneAsset.CreazioneAssetFromProcess(ordersli,rt1,rt2,rt3,rt4,rt5); 
}
 
    }