//02/03/2017
//Trigger per creare  il pricebook e il product quando viene salvato un listino

trigger OF_CreateProduct2PriceBook2 on OF_Listino__c (after insert, before delete, after update) {
    OF_Listino__c l = trigger.new[0];
//  try {
//     if(trigger.isInsert && trigger.isAfter){
               
//         list<Product2> listProduct2 = new list<Product2>();
//         list<Product2> listProduct2Fattibil = new list<Product2>();
//         list<Pricebook2> listPriceBook2 = new list<Pricebook2>();
//         list<Pricebook2> listPriceBook2Fattibil = new list<Pricebook2>();
        
//         set<id> IDs = new set<id>();
//         for (OF_Listino__c lis : trigger.new){
//             IDs.add(lis.OF_ServizioBillingElement__c);
//             //04/08/2017 Modifica CRM
//             IDs.add(lis.PO_Servizio_Billing_Element_Fattibilita__c);
//         }
        
//         list<OF_ServizioBillingElement__c> SBElist = new list<OF_ServizioBillingElement__c>([select id, OF_BillingElement__c, OF_BillingElement__r.name, OF_BillingElement__r.OF_attivo__c from OF_ServizioBillingElement__c where id =: IDs]);
//         system.debug('DG_OF_CreateProduct2PriceBook2 SBElist: ' + SBElist);
        
//         //04/08/2017 DG Aggiunto recordtype
//         string PriceRecordType = Schema.SObjectType.Pricebook2.getRecordTypeInfosByName().get('Pricebook').getRecordTypeId();

//         for (OF_Listino__c lis : trigger.new){
//             for(OF_ServizioBillingElement__c SBE1 : SBElist){
//                 system.debug('DG_OF_CreateProduct2PriceBook2 dentro for - SBE1.id: ' + SBE1.id);
                
//                 //GPON Passiva e Open Stream
//                 if(lis.OF_ServizioBillingElement__c == SBE1.id){
                        
//                     system.debug('DG_OF_CreateProduct2PriceBook2 dentro if != Fattibilità');
                    
//                     //Creazione Product2
//                     Product2 p = new Product2(
//                         OF_BillingElement__c = SBE1.OF_BillingElement__r.Id,
//                         name = SBE1.OF_BillingElement__r.name,
//                         isActive = SBE1.OF_BillingElement__r.OF_Attivo__c,
//                         OF_ListinoCustom__c = lis.Id
//                     );
//                     listProduct2.add(p);
                    
//                     //Creazione Pricebook2
//                     Pricebook2 pb =new Pricebook2(
//                         //04/08/2017 DG Aggiunto recordtype
//                         recordtypeId = PriceRecordType,
//                         name = lis.Name,
//                         isActive = lis.OF_attivo__c,
//                         OF_Listino__c = lis.Id
//                     );
//                     listPriceBook2.add(pb);
                    
//                 }
                
//                 //Fattibilità
//                 if(lis.PO_Servizio_Billing_Element_Fattibilita__c == SBE1.id)
//                 {
//                     system.debug('DG_OF_CreateProduct2PriceBook2 dentro if == Fattibilità');
                    
//                     //Creazione Product2
//                     Product2 p = new Product2(
//                         OF_BillingElement__c = SBE1.OF_BillingElement__r.Id,
//                         name = SBE1.OF_BillingElement__r.name,
//                         isActive = SBE1.OF_BillingElement__r.OF_Attivo__c,
//                         OF_ListinoCustom__c = lis.Id
//                     );
//                     listProduct2Fattibil.add(p);
                    
//                     //Creazione Pricebook2
//                     Pricebook2 pb =new Pricebook2(
//                         //04/08/2017 DG Aggiunto recordtype
//                         recordtypeId = PriceRecordType,
//                         name = lis.Name,
//                         isActive = lis.OF_attivo__c,
//                         OF_Listino__c = lis.Id
//                     );
//                     listPriceBook2Fattibil.add(pb);
//                 }
//             }
//         }
        
//         if((listProduct2.size()>0) && (listPriceBook2.size()>0))
//         {
//             system.debug('Dentro insert attivi passivi');
//             insert listProduct2;
//             insert listPriceBook2;
//         }
        
//         //04/08/2017 Modifica CRM
//         if( (listProduct2Fattibil.size()>0) && (listPriceBook2Fattibil.size()>0) )
//         {
//             system.debug('Dentro insert fattibilità');
//             insert listProduct2Fattibil;
//             insert listPriceBook2Fattibil;
//         }
//         //END 04/08/2017 Modifica CRM
        
//         //Inserimento StandardPricebook - si può creare una classe

//         list<pricebookentry> StndPBEList = new list<pricebookentry>();
        
//         list<Pricebook2> StndPBList = new list<Pricebook2>([select id, IsStandard from pricebook2 where isstandard = true limit 1]);
//         system.debug('DG_test StndPBList : ' + StndPBList);
//         if(StndPBList.size()>0){
//             for(product2 p2 : listProduct2){
//                 pricebookentry pbe = new pricebookentry(
//                     //25/05/2017 cambiato la unitprice da 0 a -9999
//                     UnitPrice = -9999,
//                     IsActive = true,
//                     Product2ID = p2.id,
//                     Pricebook2ID = StndPBList[0].id     //pricebook standard
//                 );
//                 StndPBEList.add(pbe);
//             }
//             //04/08/2017 Modifica CRM
//             for(product2 p2 : listProduct2Fattibil){
//                 pricebookentry pbe = new pricebookentry(
//                     //25/05/2017 cambiato la unitprice da 0 a -9999
//                     UnitPrice = -9999,
//                     IsActive = true,
//                     Product2ID = p2.id,
//                     Pricebook2ID = StndPBList[0].id     //pricebook standard
//                 );
//                 StndPBEList.add(pbe);
//             }
//             //END 04/08/2017 Modifica CRM
//         }
         
//          system.debug('DG - StndPBEList ' + StndPBEList);
//          if(StndPBEList.size()>0)        insert StndPBEList; 
        
//     }
    
//     // 02/03/2017 DG - DA COMPLETARE
//     // Quando un listino viene aggiornato bisogna anche aggiornare i product2 e pricebook2 che sono associati a quel listino. (pricebook2/product2.OF_ListinoCustom__c = OF_listino__c.id)
//     If(trigger.isUpdate && trigger.isAfter){
    
//         map<id,Product2> ProductToUpdate = new map<id,Product2>();
//         map<id,Pricebook2> PriceBookToUpdate = new map<id,Pricebook2>();

//         set<id> IDs1 = new set<id>();
//         set<id> IDs2 = new set<id>();
//         set<id> IDs3 = new set<id>();

//         for(OF_Listino__c lis1: Trigger.new) {
//             IDs1.add(lis1.id);
//             IDs2.add(lis1.OF_ServizioBillingElement__c);
//             IDs3.add(lis1.OF_ServizioBillingElement__r.OF_BillingElement__c);
//         }

//         system.debug('DG - IDs1: ' + IDs1);
//         system.debug('DG - IDs2: ' + IDs2);


//         map<id,OF_ServizioBillingElement__c> SBEmap = new map<id,OF_ServizioBillingElement__c>([select id, OF_BillingElement__c, OF_BillingElement__r.name, OF_BillingElement__r.OF_attivo__c from OF_ServizioBillingElement__c where id =: IDs2]);

//         system.debug('DG - SBEmap: ' + SBEmap);
        
//         map<id,OF_BillingElement__c> BEmap = new map<id,OF_BillingElement__c>([select id, name, OF_attivo__c from OF_BillingElement__c where id =: IDs3]);


//         map<id,Product2> ProductMap = new map<id,Product2>([select id, name, isActive from Product2 where OF_ListinoCustom__c =: IDs1]);

//         map<id,Pricebook2> PriceBookMap = new map<id,Pricebook2>([select id, name, isActive from Pricebook2 where OF_Listino__c =: IDs1]);  

//         system.debug('DG - ProductMap: ' + ProductMap);
//         system.debug('DG - PriceBookMap: ' + PriceBookMap);
        
//         for(OF_Listino__c lis: Trigger.new) {
//             /* Aggiornamento Product2
            
//             if(trigger.oldMap.get(lis.Id).OF_ServizioBillingElement__r.OF_BillingElement__c != trigger.newMap.get(lis.Id).OF_ServizioBillingElement__r.OF_BillingElement__c){
//                 for(id IDSsbe : SBEmap.keyset()){
//                     if(SBEmap.get(IDSsbe).id == trigger.newMap.get(lis.Id).OF_ServizioBillingElement__c){
//                         for(id IDSlis : ProductMap.keySet()){
//                             ProductMap.get(IDSlis).name = SBEmap.get(IDSsbe).OF_BillingElement__r.name;
//                             ProductMap.get(IDSlis).isActive = SBEmap.get(IDSsbe).OF_BillingElement__r.OF_attivo__c;
                            
//                             ProductToUpdate.put(IDSlis,ProductMap.get(IDSlis));
//                         }
//                     }
//                 }
//             }*/
            
//             //Aggiornamento Pricebook
//             if(trigger.oldMap.get(lis.Id).name != trigger.newMap.get(lis.Id).name) {
                
//                 for(id IDSlis1 : PriceBookMap.keySet()){
//                         PriceBookMap.get(IDSlis1).name = lis.name;
                        
//                         PriceBookToUpdate.put(IDSlis1,PriceBookMap.get(IDSlis1));
//                 }
//             }
            
//             if(trigger.oldMap.get(lis.Id).OF_attivo__c != trigger.newMap.get(lis.Id).OF_attivo__c){
                
//                 for(id IDSlis1 : PriceBookMap.keySet()){
//                         PriceBookMap.get(IDSlis1).IsActive = lis.OF_attivo__c;
                        
//                         PriceBookToUpdate.put(IDSlis1,PriceBookMap.get(IDSlis1));
//                 }
//             }
//         }
        
//         system.debug('DG - ProductToUpdate: ' + ProductToUpdate);
//         system.debug('DG - PriceBookToUpdate: ' + PriceBookToUpdate);
//         Update ProductToUpdate.values();
//         Update PriceBookToUpdate.values();

//     }
    
//     //Eliminazione listino
//     If(trigger.isDelete){
//         set<id> IDs1 = new set<id>();
        
//         for(OF_Listino__c lis1: Trigger.old) {
//             IDs1.add(lis1.id);
//         }
                
//         map<id,Product2> ProductMap = new map<id,Product2>([select id, OF_ListinoCustom__c from Product2 where OF_ListinoCustom__c =: IDs1]);

//         map<id,Pricebook2> PriceBookMap = new map<id,Pricebook2>([select id, OF_Listino__c from Pricebook2 where OF_Listino__c =: IDs1]);

//         map<id,Product2> ProductToDelete = new map<id,Product2>();
//         map<id,Pricebook2> PriceBookToDelete = new map<id,Pricebook2>();
        
//         for(OF_Listino__c lis2: Trigger.old) {                                  
//             for(id IDSlis : ProductMap.keySet()){
//                 if (ProductMap.get(IDSlis).OF_ListinoCustom__c == lis2.id){
//                     ProductToDelete.put(IDSlis, ProductMap.get(IDSlis));
//                 }  
//             }
//             for(id IDSlis1 : PriceBookMap.keySet()){
//                 if (PriceBookMap.get(IDSlis1).OF_Listino__c == lis2.id){
//                     PriceBookToDelete.put(IDSlis1, PriceBookMap.get(IDSlis1));
//                 }  
//             }
//         }

//         if(ProductToDelete.size()>0)    delete ProductToDelete.values();
//         if(PriceBookToDelete.size()>0)  delete PriceBookToDelete.values();
        
//     }
    
    
//     }
//       catch(Exception e){
//             OF_Utility.logMessage(true,'E',
//                     'Trigger: OF_CreateProduct2PriceBook2',
//                     'SObject: OF_Listino',
//                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
//                 );        
//           } 
}