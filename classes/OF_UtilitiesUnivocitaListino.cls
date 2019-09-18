public class OF_UtilitiesUnivocitaListino {

    public OF_UtilitiesUnivocitaListino() {}

    /***************************START SERVIZI PASSIVI***************************/

    //Metodo che mi restituisce true se i due listini con gli stessi valori per i campi: OF_ServizioBillingElement__c, Name, OF_IDContract__c, OF_TipologiaApparato__c, OF_ProgettoSpeciale__c
    // public static boolean UnivocitaDetailPassivi (OF_Listino__c lis, OF_Listino__c lis1){

    //     boolean check;

    //     try{
    //         if(
    //             (lis.OF_ServizioBillingElement__c == lis1.OF_ServizioBillingElement__c) &&
    //             (lis.Name == lis1.Name) &&
    //             (lis.OF_IDContract__c == lis1.OF_IDContract__c) &&
    //             (lis.OF_TipologiaApparato__c == lis1.OF_TipologiaApparato__c) &&
    //             (lis.OF_ProgettoSpeciale__c == lis1.OF_ProgettoSpeciale__c)
    //             ){
    //                 system.debug('DG_OF_UtilitiesUnivocitaListino - UnivocitaDetailPassivi dentro if');
    //                 check = true;
    //                 return check;
    //             }
    //         else{
    //             system.debug('DG_OF_UtilitiesUnivocitaListino - UnivocitaDetailPassivi dentro else');
    //             check = false;
    //             return check;
    //         }

    //     }catch( Exception e )
    //     {
    //      OF_Utility.logMessage(true,'E',
    //      'Classe: OF_UtilitiesUnivocitaListino',
    //      'Metodo: UnivocitaDetailPassivi',
    //      'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
    //       ); 
    //       return check;  
    //     }
    // }

    // //Metodo che mi restituisce true se i due listini hanno date che si sovrappongono
    // public static boolean UnivocitaDatePassivi (OF_Listino__c lis, OF_Listino__c lis1){

    //     boolean check;

    //     try{

    //         if(
    //             (lis.OF_ServizioBillingElement__c == lis1.OF_ServizioBillingElement__c) &&
    //             (lis.OF_IDContract__c == lis1.OF_IDContract__c) &&
    //             (lis.OF_TipologiaApparato__c == lis1.OF_TipologiaApparato__c) &&
    //             (lis.OF_ProgettoSpeciale__c == lis1.OF_ProgettoSpeciale__c) &&
    //             (
    //             //Verifica sovrapposizione date
    //             ((lis.OF_DataInizioValidita__c >= lis1.OF_DataInizioValidita__c) && (lis.OF_DataInizioValidita__c <= lis1.OF_DataFineValidita__c)) ||
    //             ((lis.OF_DataFineValidita__c >= lis1.OF_DataInizioValidita__c) && (lis.OF_DataFineValidita__c <= lis1.OF_DataFineValidita__c)) ||
    //             ((lis.OF_DataInizioValidita__c <= lis1.OF_DataInizioValidita__c) && (lis.OF_DataFineValidita__c >= lis1.OF_DataFineValidita__c))
    //             )
    //             )
    //             {
    //                 system.debug('DG_OF_UtilitiesUnivocitaListino - UnivocitaDatePassivi dentro if');
    //                 check = true;
    //                 return check;
    //             }
    //         else{
    //             system.debug('DG_OF_UtilitiesUnivocitaListino - UnivocitaDatePassivi dentro else');
    //             check = false;
    //             return check;
    //         }
    //     }catch( Exception e )
    //     {
    //      OF_Utility.logMessage(true,'E',
    //      'Classe: OF_UtilitiesUnivocitaListino',
    //      'Metodo: UnivocitaDatePassivi',
    //      'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
    //       ); 
    //       return check;  
    //     }
    // }
    // /***************************END SERVIZI PASSIVI***************************/

    // /***************************START OPEN STREAM***************************/

    // //Metodo che mi restituisce true se i due listini con gli stessi valori per i campi: OF_ServizioBillingElement__c, Name, OF_IDContract__c, OF_TipologiaApparato__c, OF_Promozione__c, OF_ClusterPromozione__c, OF_CodiceProgettoSpeciale__c
    // public static boolean UnivocitaDetailOpenStream (OF_Listino__c lis, OF_Listino__c lis1){

    //     boolean check;

    //     try{

    //         if(
    //             (lis.OF_ServizioBillingElement__c == lis1.OF_ServizioBillingElement__c) &&
    //             (lis.Name == lis1.Name) &&
    //             (lis.OF_IDContract__c == lis1.OF_IDContract__c) &&
    //             (lis.OF_TipologiaApparato__c == lis1.OF_TipologiaApparato__c) &&
    //             (lis.OF_Promozione__c == lis1.OF_Promozione__c) &&
    //             (lis.OF_ClusterPromozione__c == lis1.OF_ClusterPromozione__c) &&
    //             (lis.OF_CodiceProgettoSpeciale__c == lis1.OF_CodiceProgettoSpeciale__c)
    //             ){
    //                 system.debug('DG_OF_UtilitiesUnivocitaListino - UnivocitaDetailOpenStream dentro if');
    //                 check = true;
    //                 return check;
    //             }
    //         else{
    //             system.debug('DG_OF_UtilitiesUnivocitaListino - UnivocitaDetailOpenStream dentro else');
    //             check = false;
    //             return check;
    //         }

    //     }catch( Exception e )
    //     {
    //      OF_Utility.logMessage(true,'E',
    //      'Classe: OF_UtilitiesUnivocitaListino',
    //      'Metodo: UnivocitaDetailOpenStream',
    //      'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
    //       );  
    //       return check; 
    //     }
    // }

    // //Metodo che mi restituisce true se i due listini hanno date che si sovrappongono
    // public static boolean UnivocitaDateOpenStream (OF_Listino__c lis, OF_Listino__c lis1){

    //     boolean check;

    //     try{

    //         if(
    //             (lis.Name == lis1.Name) &&
    //             (lis.OF_ServizioBillingElement__c == lis1.OF_ServizioBillingElement__c) &&
    //             (lis.OF_IDContract__c == lis1.OF_IDContract__c) &&
    //             (lis.OF_TipologiaApparato__c == lis1.OF_TipologiaApparato__c) &&
    //             (lis.OF_Promozione__c == lis1.OF_Promozione__c) &&
    //             (lis.OF_ClusterPromozione__c == lis1.OF_ClusterPromozione__c) &&
    //             (lis.OF_CodiceProgettoSpeciale__c == lis1.OF_CodiceProgettoSpeciale__c) &&
    //             (
    //             //Verifica sovrapposizione date
    //             ((lis.OF_DataInizioValidita__c >= lis1.OF_DataInizioValidita__c) && (lis.OF_DataInizioValidita__c <= lis1.OF_DataFineValidita__c)) ||
    //             ((lis.OF_DataFineValidita__c >= lis1.OF_DataInizioValidita__c) && (lis.OF_DataFineValidita__c <= lis1.OF_DataFineValidita__c)) ||
    //             ((lis.OF_DataInizioValidita__c <= lis1.OF_DataInizioValidita__c) && (lis.OF_DataFineValidita__c >= lis1.OF_DataFineValidita__c))
    //             )
    //             )
    //             {
    //                 system.debug('DG_OF_UtilitiesUnivocitaListino - UnivocitaDateOpenStream dentro if');
    //                 check = true;
    //                 return check;
    //             }
    //         else{
    //             system.debug('DG_OF_UtilitiesUnivocitaListino - UnivocitaDateOpenStream dentro else');
    //             check = false;
    //             return check;
    //         }
    //     }catch( Exception e )
    //     {
    //      OF_Utility.logMessage(true,'E',
    //      'Classe: OF_UtilitiesUnivocitaListino',
    //      'Metodo: UnivocitaDateOpenStream',
    //      'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
    //       );
    //       return check; 
    //     }
    // }    

    // //24/07/2017 DG Aggiunto metodo per canone Open stream
    // //Metodo che mi restituisce true se i due listini di canone hanno lo stesso nome
    // public static boolean UnivocitaCanone (OF_Listino__c lis, OF_Listino__c lis1){

    //     boolean check;

    //     try{

    //         if(lis.Name == lis1.Name){
    //                 system.debug('DG_OF_UtilitiesUnivocitaListino - UnivocitaCanone dentro if');
    //                 check = true;
    //                 return check;
    //             }
    //         else{
    //             system.debug('DG_OF_UtilitiesUnivocitaListino - UnivocitaCanone dentro else');
    //             check = false;
    //             return check;
    //         }

    //     }catch( Exception e )
    //     {
    //      OF_Utility.logMessage(true,'E',
    //      'Classe: OF_UtilitiesUnivocitaListino',
    //      'Metodo: UnivocitaCanone',
    //      'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
    //       );  
    //       return check; 
    //     }
    // }
    // //END 24/07/2017 DG

    // /***************************END OPEN STREAM***************************/

    // /***************************START EXTRA***************************/

    // //Metodo che mi restituisce true se i due listini con gli stessi valori per i campi:
    // public static boolean UnivocitaDetailExtra (OF_Listino__c lis, OF_Listino__c lis1){

    //     boolean check;

    //     try{

    //         if(
    //             (lis.OF_ServizioBillingElement__c == lis1.OF_ServizioBillingElement__c) &&
    //             (lis.Name == lis1.Name) &&
    //             (lis.OF_IDContract__c == lis1.OF_IDContract__c)
    //             ){
    //                 system.debug('DG_OF_UtilitiesUnivocitaListino - UnivocitaDetailExtra dentro if');
    //                 check = true;
    //                 return check;
    //             }
    //         else{
    //             system.debug('DG_OF_UtilitiesUnivocitaListino - UnivocitaDetailExtra dentro else');
    //             check = false;
    //             return check;
    //         }

    //     }catch( Exception e )
    //     {
    //      OF_Utility.logMessage(true,'E',
    //      'Classe: OF_UtilitiesUnivocitaListino',
    //      'Metodo: UnivocitaDetailExtra',
    //      'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
    //       );  
    //       return check; 
    //     }
    // }

    // //Metodo che mi restituisce true se i due listini hanno date che si sovrappongono
    // public static boolean UnivocitaDateExtra (OF_Listino__c lis, OF_Listino__c lis1){

    //     boolean check;

    //     try{

    //         if(
    //             (lis.OF_ServizioBillingElement__c == lis1.OF_ServizioBillingElement__c) &&
    //             (lis.OF_IDContract__c == lis1.OF_IDContract__c) &&
    //             (
    //             //Verifica sovrapposizione date
    //             ((lis.OF_DataInizioValidita__c >= lis1.OF_DataInizioValidita__c) && (lis.OF_DataInizioValidita__c <= lis1.OF_DataFineValidita__c)) ||
    //             ((lis.OF_DataFineValidita__c >= lis1.OF_DataInizioValidita__c) && (lis.OF_DataFineValidita__c <= lis1.OF_DataFineValidita__c)) ||
    //             ((lis.OF_DataInizioValidita__c <= lis1.OF_DataInizioValidita__c) && (lis.OF_DataFineValidita__c >= lis1.OF_DataFineValidita__c))
    //             )
    //             )
    //             {
    //                 system.debug('DG_OF_UtilitiesUnivocitaListino - UnivocitaDateExtra dentro if');
    //                 check = true;
    //                 return check;
    //             }
    //         else{
    //             system.debug('DG_OF_UtilitiesUnivocitaListino - UnivocitaDateExtra dentro else');
    //             check = false;
    //             return check;
    //         }
    //     }catch( Exception e )
    //     {
    //      OF_Utility.logMessage(true,'E',
    //      'Classe: OF_UtilitiesUnivocitaListino',
    //      'Metodo: UnivocitaDateExtra',
    //      'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
    //       );
    //       return check; 
    //     }
    // }    

    // /***************************END EXTRA***************************/

    // /***************************START UNIVOCITA' DEFAULT***************************/

    // //Metodo che mi restituisce true se esiste già un listino default
    // public static boolean UnivocitaDefault (OF_Listino__c lis, OF_Listino__c lis1){

    //     boolean check;

    //     try{
    //         system.debug('DG_OF_UtilitiesUnivocitaListino_UnivocitaDefault - lis.OF_ServizioBillingElement__c: ' + lis.OF_ServizioBillingElement__c);
    //         system.debug('DG_OF_UtilitiesUnivocitaListino_UnivocitaDefault - lis1.OF_ServizioBillingElement__c: ' + lis1.OF_ServizioBillingElement__c);
    //         if(
    //             (lis.OF_ListinoDefault__c == true) &&
    //             (lis.OF_ListinoDefault__c == lis1.OF_ListinoDefault__c) &&
    //             (lis.OF_ServizioBillingElement__c == lis1.OF_ServizioBillingElement__c)
    //             )
    //             {
    //                 system.debug('DG_OF_UtilitiesUnivocitaListino - UnivocitaDefault dentro if');
    //                 check = true;
    //                 return check;
    //             }
    //         else{
    //             system.debug('DG_OF_UtilitiesUnivocitaListino - UnivocitaDefault dentro else');
    //             check = false;
    //             return check;
    //         }
    //     }catch( Exception e )
    //     {
    //      OF_Utility.logMessage(true,'E',
    //      'Classe: OF_UtilitiesUnivocitaListino',
    //      'Metodo: UnivocitaDefault',
    //      'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
    //       );
    //       return check; 
    //     }
    // }

    // //Metodo che mi restituisce true se esiste già un listino default per la fattibilità
    // /*
    // public static boolean UnivocitaDefaultFattibi (OF_Listino__c lis, OF_Listino__c lis1){

    //     boolean check;

    //     try{
    //         system.debug('DG_OF_UtilitiesUnivocitaListino_UnivocitaDefaultFattibi - lis.PO_Servizio_Billing_Element_Fattibilita__c: ' + lis.PO_Servizio_Billing_Element_Fattibilita__c);
    //         system.debug('DG_OF_UtilitiesUnivocitaListino_UnivocitaDefaultFattibi - lis1.PO_Servizio_Billing_Element_Fattibilita__c: ' + lis1.PO_Servizio_Billing_Element_Fattibilita__c);

    //         if(
    //             (lis.OF_ListinoDefault__c == true) &&
    //             (lis.OF_ListinoDefault__c == lis1.OF_ListinoDefault__c) &&
    //             (lis.PO_Servizio_Billing_Element_Fattibilita__c == lis1.PO_Servizio_Billing_Element_Fattibilita__c)
    //             )
    //             {
    //                 system.debug('DG_OF_UtilitiesUnivocitaListino - UnivocitaDefaultFattibi dentro if');
    //                 check = true;
    //                 return check;
    //             }
    //         else{
    //             system.debug('DG_OF_UtilitiesUnivocitaListino - UnivocitaDefaultFattibi dentro else');
    //             check = false;
    //             return check;
    //         }
    //     }catch( Exception e )
    //     {
    //      OF_Utility.logMessage(true,'E',
    //      'Classe: OF_UtilitiesUnivocitaListino',
    //      'Metodo: UnivocitaDefaultFattibi',
    //      'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
    //       );
    //       return check; 
    //     }

    // }
    // */
    // /***************************END UNIVOCITA' DEFAULT***************************/

    // /***************************START MESSAGGI ERRORE***************************/

    // public static string MsgErroreUnivLisDefault (OF_Listino__c lis1){

    //     string errmessage = ' Esiste già un listino default ( Listino: ';
    //     errmessage += '<a href=\'/'+  lis1.id +'\'> '+ lis1.Name + '</a>'; 
    //     errmessage += ' ) per questo Billing Element: "' + lis1.OF_ServizioBillingElement__r.OF_BillingElement__r.name + '" appartenente a questo servizio: "' + lis1.RecordType.name + '"';
           
    //     return errmessage;
    // }
    // public static string MsgErroreUnivLisDefaultFatt (OF_Listino__c lis1){
        
    //     string errmessage = ' Esiste già un listino default ( Listino: ';
    //     errmessage += '<a href=\'/'+  lis1.id +'\'> '+ lis1.Name + '</a>'; 
    //     errmessage += ' ) per questo Billing Element: "' + lis1.PO_Servizio_Billing_Element_Fattibilita__r.OF_BillingElement__r.name + '" appartenente a questo servizio: "' + lis1.OF_Servizio__c + '"';

    //     return errmessage;
    // }

    // public static string MsgErroreDate (OF_Listino__c lis1){

    //     string errmessage = ' Non è possibile inserire queste date di validità in quanto si sovrappongono con quelle del listino: ';
    //     errmessage += '<a href=\'/'+  lis1.id +'\'> '+ lis1.Name + '</a>'; 

    //     return errmessage;
    // }

    // public static string MsgErroreUnivLis (OF_Listino__c lis1){

    //     string errmessage = ' Esiste già un listino con queste caratteristiche. Listino: ';
    //     errmessage += '<a href=\'/'+  lis1.id +'\'> '+ lis1.Name + '</a>'; 

    //     return errmessage;
    // }  

    /***************************END MESSAGGI ERRORE***************************/                      
}