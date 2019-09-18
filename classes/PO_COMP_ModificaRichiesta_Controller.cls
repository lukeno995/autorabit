public class PO_COMP_ModificaRichiesta_Controller {
    public static EOF_EAI_Service_Log__c slOrig{get;set;}
    public EOF_EAI_Service_Log__c sl{get;set;}
    
    public PO_COMP_ModificaRichiesta_Controller(){
    	sl=slOrig;
    }
    public pagereference savesl(){
    	update sl;
    	PageReference pageRef = new PageReference('/PO_OpenStreamService_InsertNewRequest');
    	return pageref;
    }
    public pagereference annullasl(){
    	PageReference pageRef = new PageReference('/PO_OpenStreamService_InsertNewRequest');
    	return pageref;
    }
}