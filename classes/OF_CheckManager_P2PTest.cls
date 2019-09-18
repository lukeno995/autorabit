@isTest
public with sharing class OF_CheckManager_P2PTest {

    static OF_StatusUpdate_P2P.Request rqst = null;
    
    @isTest
    static void checkUpdateRqstTestEsitoOKTypeOrdine() {
        buildUpdateRqst();
        OF_StatusUpdate_P2P.Response rspnse = OF_CheckManager_P2P.checkUpdateRqst(rqst);

        System.assertEquals(OF_CheckManager_P2P.ESITO_OK, rspnse.esito);
        System.assertEquals(rqst.id_notifica, rspnse.id_notifica);
        
    }

    @isTest
    static void checkUpdateRqstTestMissingIdOrdine() {
        buildUpdateWrongRqst();
        OF_StatusUpdate_P2P.Response rspnse = OF_CheckManager_P2P.checkUpdateRqst(rqst);

        System.assertEquals(OF_CheckManager_P2P.ESITO_KO, rspnse.esito);  
        System.assertEquals(rspnse.motivazione, 'Campo id_ordine obbligatorio non valorizzato.');   
    }

    @isTest
    static void checkStringFieldTestMissingValue() {
        OF_CheckManager_P2P.ErrorField err = new OF_CheckManager_P2P.ErrorField();
        err.errorCode = OF_CheckManager_P2P.OBB_ERROR_CODE;
        err.field = 'id_notifica';

        OF_CheckManager_P2P.ErrorField response = OF_CheckManager_P2P.checkStringField('', 'id_notifica', 0);

        System.assertEquals(response.errorCode, err.errorCode);
    }

     @isTest
    static void checkStringFieldTestValueTooLong() {
        OF_CheckManager_P2P.ErrorField err = new OF_CheckManager_P2P.ErrorField();
        err.errorCode = OF_CheckManager_P2P.TYPE_ERROR_CODE;
        err.field = 'id_notifica';

        OF_CheckManager_P2P.ErrorField response = OF_CheckManager_P2P.checkStringField('stringa troppo lunga', 'id_notifica', 5);

        System.assertEquals(response.errorCode, err.errorCode);
    }
    
@isTest
    static void checkDataEspletamentoOrdineKO() {
        buildDataEspletamentoOrdineKO();
        OF_StatusUpdate_P2P.Response rspnse = OF_CheckManager_P2P.checkUpdateRqst(rqst);

        System.assertEquals(OF_CheckManager_P2P.ESITO_KO, rspnse.esito);
    }
    @isTest
    static void checkDataEspletamentoOrdineKO2() {
        buildDataEspletamentoOrdineKO2();
        OF_StatusUpdate_P2P.Response rspnse = OF_CheckManager_P2P.checkUpdateRqst(rqst);

        System.assertEquals(OF_CheckManager_P2P.ESITO_KO, rspnse.esito);  
    }
     @isTest
    static void checkStatoOrdineKO() {
        OF_CheckManager_P2P.ErrorField err = new OF_CheckManager_P2P.ErrorField();
        err.errorCode = OF_CheckManager_P2P.OBB_ERROR_CODE;
		OF_CheckManager_P2P.ErrorField rspnse = OF_CheckManager_P2P.checkStatoOrdine(null, 'stato_ordine');
		err.field = 'stato_ordine';
		
        System.assertEquals(err.errorCode, rspnse.errorCode);
    }
    @isTest
    static void checkStatoOrdineKO2() {
        OF_CheckManager_P2P.ErrorField err = new OF_CheckManager_P2P.ErrorField();
        err.errorCode = OF_CheckManager_P2P.TYPE_ERROR_CODE;
		OF_CheckManager_P2P.ErrorField rspnse = OF_CheckManager_P2P.checkStatoOrdine('1', 'stato_ordine');
		err.field = 'stato_ordine';
		
        System.assertEquals(err.errorCode, rspnse.errorCode);
    }
      @isTest
    static void checkTipoNotificaKO() {
        OF_CheckManager_P2P.ErrorField err = new OF_CheckManager_P2P.ErrorField();
        err.errorCode = OF_CheckManager_P2P.OBB_ERROR_CODE;
		OF_CheckManager_P2P.ErrorField rspnse = OF_CheckManager_P2P.checkTipoNotifica(null, 'tipo_notifica');
		err.field = 'tipo_notifica';
		
        System.assertEquals(err.errorCode, rspnse.errorCode);
    }
    @isTest
    static void checkTipoNotificaKO2() {
        OF_CheckManager_P2P.ErrorField err = new OF_CheckManager_P2P.ErrorField();
        err.errorCode = OF_CheckManager_P2P.TYPE_ERROR_CODE;
		OF_CheckManager_P2P.ErrorField rspnse = OF_CheckManager_P2P.checkTipoNotifica('Sfruttamento', 'tipo_notifica');
		err.field = 'tipo_notifica';
		
        System.assertEquals(err.errorCode, rspnse.errorCode);
    }
    @isTest
    static void checkTipoNotificaKit() {
		/*
        OF_CheckManager_P2P.ErrorField err = new OF_CheckManager_P2P.ErrorField();
        err.errorCode = OF_CheckManager_P2P.OBB_ERROR_CODE;
		OF_CheckManager_P2P.ErrorField rspnse = OF_CheckManager_P2P.checkTipoNotifica('Kit', 'tipo_notifica');
		err.field = 'tipo_notifica';
		
        System.assertEquals(err.errorCode, rspnse.errorCode);
		*/
		 buildTipoNotificaKit();
        OF_StatusUpdate_P2P.Response rspnse = OF_CheckManager_P2P.checkUpdateRqst(rqst);
        
        System.assertEquals(OF_CheckManager_P2P.ESITO_KO, rspnse.esito);
    }
	@isTest
    static void checkDataNotificaKO() {
        dataNotificaKO();
        OF_StatusUpdate_P2P.Response rspnse = OF_CheckManager_P2P.checkUpdateRqst(rqst);

        System.assertEquals(OF_CheckManager_P2P.ESITO_KO, rspnse.esito);
		/* non va in classe master
		   OF_CheckManager_P2P.ErrorField err = new OF_CheckManager_P2P.ErrorField();
        err.errorCode = OF_CheckManager_P2P.OBB_ERROR_CODE;
		OF_CheckManager_P2P.ErrorField rspnse = OF_CheckManager_P2P.checkDataNotifica(null, 'data_notifica');
		err.field = 'data_notifica';
		*/
    }
     @isTest
    static void checkAttachment() {
        buildAttachment();
        OF_StatusUpdate_P2P.Response rspnse = OF_CheckManager_P2P.checkUpdateRqst(rqst);
        
        System.debug('OF_CheckManager_P2P.ESITO_OK '+OF_CheckManager_P2P.ESITO_OK+' ,rspnse.esito '+rspnse.esito);
    }
    /*
	 @isTest
    static void checkAttachmentKO() {
        buildAttachment();
		OF_CheckManager_P2P.ErrorField err = new OF_CheckManager_P2P.ErrorField();
        err.errorCode = OF_CheckManager_P2P.OBB_ERROR_CODE;
        Case objcase=new Case();
        insert objcase;
        Blob b = Blob.valueOf('Test Data');

		OF_CheckManager_P2P.ErrorField rspnse = OF_CheckManager_P2P.checkAttachment(b, '');
		err.field = 'attachment';
		
        System.assertEquals(err.errorCode, rspnse.errorCode);
    }
    */
    
    static void buildUpdateRqst() {
        rqst = new OF_StatusUpdate_P2P.Request();
        rqst.id_notifica = '1234id';
        rqst.id_esito = '1234dom';
        rqst.data_notifica = System.now();
        rqst.id_fattibilita = '123456789';
        rqst.tipo_notifica = 'Ordine';
        rqst.id_ordine = 'tis_111';
        rqst.id_ordine_kit = '';
        rqst.stato_ordine = '2';
        rqst.id_risorsa = 'r1';
        rqst.data_espletamento_ordine = '2019-05-22';
        rqst.attachment = null;
    }

    static void buildUpdateWrongRqst() {
        rqst = new OF_StatusUpdate_P2P.Request();
        rqst.id_notifica = '1234id';
        rqst.id_esito = '1234dom';
        rqst.data_notifica = System.now();
        rqst.id_fattibilita = '123456789';
        rqst.tipo_notifica = 'Ordine';
        rqst.id_ordine_kit = '';
        rqst.stato_ordine = '2';
        rqst.id_risorsa = 'r1';
        rqst.data_espletamento_ordine = '2019-05-22';
        rqst.attachment = null;
    }
     static void buildDataEspletamentoOrdineKO() {
        rqst = new OF_StatusUpdate_P2P.Request();
        rqst.id_notifica = '1234id';
        rqst.id_esito = '1234dom';
        rqst.data_notifica = System.now();
        rqst.id_fattibilita = '123456789';
        rqst.tipo_notifica = 'Ordine';
        rqst.id_ordine = 'tis_111';
        rqst.id_ordine_kit = '';
        rqst.stato_ordine = '2';
        rqst.id_risorsa = 'r1';
        rqst.data_espletamento_ordine = '0-0';
        rqst.attachment = null;
    }
    static void buildDataEspletamentoOrdineKO2() {
        rqst = new OF_StatusUpdate_P2P.Request();
        rqst.id_notifica = '1234id';
        rqst.id_esito = '1234dom';
        rqst.data_notifica = System.now();
        rqst.id_fattibilita = '123456789';
        rqst.tipo_notifica = 'Ordine';
        rqst.id_ordine = 'tis_111';
        rqst.id_ordine_kit = '';
        rqst.stato_ordine = '2';
        rqst.id_risorsa = 'r1';
        rqst.data_espletamento_ordine = '0-0-0';
    }    
     static void dataNotificaKO() {
        rqst = new OF_StatusUpdate_P2P.Request();
        rqst.id_notifica = '1234id';
        rqst.id_esito = '1234dom';
        rqst.id_fattibilita = '123456789';
        rqst.tipo_notifica = 'Sfruttamento';
        rqst.id_ordine = 'tis_111';
        rqst.id_ordine_kit = '';
        rqst.stato_ordine = '2';
        rqst.id_risorsa = 'r1';
        rqst.data_espletamento_ordine = '';
        rqst.attachment = null;
    }
	static void buildTipoNotificaKit() {
        rqst = new OF_StatusUpdate_P2P.Request();
        rqst.id_notifica = '1234id';
        rqst.id_esito = '1234dom';
        rqst.data_notifica = System.now();
        rqst.id_fattibilita = '123456789';
        rqst.tipo_notifica = 'Kit';
        rqst.id_ordine = 'tis_111';
        rqst.id_ordine_kit = '';
        rqst.stato_ordine = '2';
        rqst.id_risorsa = 'r1';
        rqst.data_espletamento_ordine = '';
        rqst.attachment = null;
    }
    static void buildAttachment() {
        rqst = new OF_StatusUpdate_P2P.Request();
        rqst.id_notifica = '1234id';
        rqst.id_esito = '1234dom';
        rqst.data_notifica = System.now();
        rqst.id_fattibilita = '123456789';
        rqst.tipo_notifica = 'Ordine';
        rqst.id_ordine = 'tis_111';
        rqst.id_ordine_kit = '';
        rqst.stato_ordine = '2';
        rqst.id_risorsa = 'r1';
        rqst.data_espletamento_ordine = '2019-05-22';
        
        Case objcase=new Case();
        insert objcase;
        Blob b = Blob.valueOf('Test Data');
    	
    	Attachment attachment = new Attachment();
    	attachment.Name = 'Test Attachment for CheckManager';
    	attachment.Body = b;
    	attachment.ParentId = objcase.id;
    	insert(attachment);
        rqst.attachment = attachment.Body;
    }
}