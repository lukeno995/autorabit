global with sharing class PO_Desospensione {
    
    webservice static void DesospensioneAssetBECE(ID AssetID)
    {
           List<PricebookEntry> listaPBE = new List<PricebookEntry>();
           List<OF_CommercialElementIstanziato__c> listaCE = new List<OF_CommercialElementIstanziato__c>();
           Datetime dt;    
           
           Asset ass = [SELECT Id,Name,OF_DataCessazione2__c,OF_Rinnovabile__c,OF_DataScadenza__c,
                        OF_DataSospensione__c,Status,OF_Contract__c,OF_DataDesospensione__c,
                             (SELECT Id,IsActive,OF_DataCessazione2__c,OF_Data_Desospensione__c 
                              FROM Price_Book_Entries__r ),
                             (SELECT Id,Status 
                              FROM Tasks),
                             (SELECT Id,OF_Stato__c,OF_DataSospensione__c,OF_DataCessazione__c,OF_CommercialElementName__c/*,
                                     PO_Data_Desospensione__c*/   
                              FROM Commercial_element_istanziati__r)
                        FROM Asset 
                        WHERE Id =: AssetId ];
           /*
           string str = string.valueof( system.today() );
           string str1 = str + ' ' + '00:00:00';
           dt = DateTime.valueof(str1);
           */
           if( ass.Price_Book_Entries__r.size() > 0 )
           {
              for( PricebookEntry pbE : ass.Price_Book_Entries__r )
              {
                  pbE.IsActive = true;
                  pbE.OF_Data_Desospensione__c = System.Datetime.now();
                  listaPBE.add( pbE );
                  
              }
           }
           
           if( ass.Commercial_element_istanziati__r.size() > 0 )
           {
               for( OF_CommercialElementIstanziato__c CE : ass.Commercial_element_istanziati__r )
               {
                   CE.OF_Stato__c = 'Attivo';
                   CE.OF_Data_Desospensione__c = System.Datetime.now();
                   listaCE.add( CE );
               }
           }
           
           ass.Status = 'Attivo';
           ass.OF_DataDesospensione__c = System.DateTime.now();
           
           
           if( listaPBE.size() > 0 ) update listaPBE;
           if( listaCE.size() > 0 ) update listaCE;
           update ass;
           
           return;
           
    }

}