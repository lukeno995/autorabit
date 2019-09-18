global class CQS_Isp_SignatureComponentController {

    public id objParentId{get;set;}
    OF_CQS_Ispezione__c isp {get;set;}
    
     public ApexPages.StandardSetController stdCntrlr {get; set;}

	 public  CQS_Isp_SignatureComponentController(ApexPages.StandardSetController controller) {

      //  stdCntrlr = controller;
        this.isp = (OF_CQS_Ispezione__c)controller.getRecord();       
        
    }
        
    
   
 @RemoteAction
 global static boolean saveSignature(String signatureBody, id parentId){
      try{
       system.debug('Record== ' + parentId);
       system.debug(signatureBody);
       Attachment a = new Attachment();
       a.ParentId = parentId;
       a.Body = EncodingUtil.base64Decode(signatureBody);
       a.ContentType = 'image/png';
       a.Name = 'Signature Capture.png';
       insert a;
     
       Schema.SObjectType sobjectType = parentId.getSObjectType();
       String sobjectName = sobjectType.getDescribe().getName();
       sObject s = Schema.getGlobalDescribe().get(sobjectName).newSObject() ;
       s.put('Id',parentId);
       // at this point you can edit any fields you have on the parentId.
       // I have SignaureId__(text[18]) on objects where I want to capture the id of the signature
       // attachment on the record.
       s.put('SignatureId__c', a.Id);
       update s;
           closeAfterSave();
        return true;
         
       //return '{success:true, attachId:' + a.Id + ', sObject: ' + c + '}';
      }
      catch(Exception e){
       system.debug(e);
       return false;
      }
 //	return null;
 }
    
    global static PageReference closeAfterSave(){
        PageReference pageRef = new PageReference('javascript: window.close()');
		pageRef.setRedirect(true);
        return pageRef;     
    }

}