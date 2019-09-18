@isTest
public class PO_P2P_Attiva_Utils_Test {
 	@isTest
     static void testMethod1(){
       
         PO_P2P_Attiva_Utils PO=new PO_P2P_Attiva_Utils();
     }  
        
//     public static void testMethod1(){
//         TestDataFactory.CreateTestRecords(null, null, null);
//         RecordType rt = [SELECT Id,DeveloperName FROM RecordType WHERE DeveloperName = 'PO_Collegamento_P2P_Attiva'];
//         Case fattCase = new Case(Status = 'In lavorazione',
//                                  Origin = 'Web',
//                                  Priority = 'Medium');
//         Case collCase = new Case(Status = 'In lavorazione',
//                                  Origin = 'Web',
//                                  Priority = 'Medium',
//                                  RecordType = rt);
//         System.debug('@@@ FD1 collCase.RecordType.DeveloperName ' + collCase.RecordType.DeveloperName);
//         insert fattCase;
//         insert collCase;
//         PO_P2P_Attiva_Utils.creaP2PAttOpportunity(fattCase, collCase);
//         PO_P2P_Attiva_Utils.getListino(new List<String>{'PO_Fattibilita','Extra'});
//         (new PO_P2P_Attiva_Utils()).mappaNomeCeI();
//     }
}