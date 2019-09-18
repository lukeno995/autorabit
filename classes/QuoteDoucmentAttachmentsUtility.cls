public class QuoteDoucmentAttachmentsUtility {
    
    public static Boolean hasAlreadyRun = false;
    
    public static void AttachmentInsertion(list<contentDocument> attachments)
    {
        set<id> myids =new set<id>();
        
        for(ContentDocument ct : attachments )
        {
            myids.add(ct.id);
        }
        system.debug('myids ====='+myids );
        
        map<id,ContentDocumentLink> vlstlinks =new map<id,ContentDocumentLink> ([SELECT Id, LinkedEntityId, ContentDocumentId, Visibility, IsDeleted, ShareType,
                                                                                 ContentDocument.Title, ContentDocument.createdDate, ContentDocument.FileType
                                                                                 FROM ContentDocumentLink 
                                                                                 WHERE ContentDocumentId IN: myids ]);
        set<id> qtids = new set<id>();
        for(ContentDocumentLink cl : vlstlinks.values())
        {
            string str = cl.LinkedEntityId;
            if(str.contains('0Q0'))
            {
                qtids.add(cl.LinkedEntityId);
            }
        }
        
        system.debug('QUoteids====='+qtids);
        system.debug('vlstlinks ====='+vlstlinks );
        set<id> ParentCaseOppids = new set<id>();
        list<quote> quotelst = [select id,name,opportunityid from Quote where id in : qtids];
        for(quote qt : quotelst)
        {
            ParentCaseOppids.add(qt.OpportunityId);
        }
        map<id,quotedocument> quotedocs = new map<id,QuoteDocument>([SELECT Document,Id,Name,QuoteId FROM QuoteDocument where QuoteId IN : qtids]);
        list<attachment> vlstAttachments = new list<attachment>();
        system.debug('ParentCaseOppids======'+ParentCaseOppids);
        system.debug('quotedocs======'+quotedocs);
        set<id> caseids = new set<id>();
      //  Id caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO_Richiesta_a_servizio_a_fattibilit').getRecordTypeId();
        map<id,opportunity> vmapopps = new map<id,opportunity>([select id,PO_Richiesta_fattibilit__c,PO_Richiesta_fattibilit__r.recordtype.developername from opportunity where id in :ParentCaseOppids and PO_Richiesta_fattibilit__r.recordtype.developername = 'PO_Richiesta_a_servizio_a_fattibilit' ]);
        if (!vmapopps.isEmpty()) {
            QuoteDoucmentAttachmentsUtility.hasAlreadyRun = false;
        }
        List<ContentVersion> cvList = [SELECT ContentDocumentId,FileType,Id,Title,VersionData FROM ContentVersion WHERE ContentDocumentId IN :attachments];
        list<Quote> qtlst = new list<quote>();
        try
        {
            for(quote qte : quotelst)
            {
                for(ContentDocumentLink qtdoc : vlstlinks.values())
                {
                    for(ContentVersion cd : cvList)
                    {
                        string str = qtdoc.LinkedEntityId;
                        if(str.contains('0Q0'))
                        { 
                            if(qte.id == str && qtdoc.ContentDocumentId == cd.ContentDocumentId)
                            {
                                attachment att = new attachment();
                                att.name = cd.Title;
                                 
                                att.Body = cd.VersionData;
                                // System.debug('OpportunityId = ' + qte.OpportunityId);
                                opportunity opp = vmapopps.get(qte.OpportunityId);
                                System.debug('opp = ' + opp);
                                if (opp != null) {
                                    // System.debug('opp.PO_Richiesta_fattibilit__c = ' + opp.PO_Richiesta_fattibilit__c);
                                    att.ParentId = opp.PO_Richiesta_fattibilit__c;
                                }
                                vlstAttachments.add(att);
                                caseids.add( att.ParentId);
                                
                            }
                        }
                    }
                }
            }
            map<id,attachment> vlstatt = new map<id,attachment>([select id,name,parentid from attachment where parentid IN :caseids]);
            map<id,attachment> attinsert = new map<id,attachment>();
            list<attachment> vlstinserting = new list<attachment>();
            if(vlstatt.size()>0 && vlstAttachments.size()>0)
            {
                for(attachment att : vlstatt.values())
                {
                    for(attachment attach : vlstAttachments)
                    {
                        if(att.parentid == attach.parentid && att.name != attach.name)
                        {
                            attinsert.put(attach.id,attach);
                        }
                    }
                    
                    
                }
            }
            else
            {
                vlstinserting.addAll(vlstAttachments);
            }
            
            system.debug('attinsert===='+attinsert);
            if(attinsert.values().size()>0 && !attinsert.values().isEmpty())
            {
                upsert attinsert.values();
            }
            if(vlstinserting.size()>0 && !vlstinserting.isEmpty())
            {
                insert vlstinserting;
            }
        }
        catch(exception e)
        {
            system.debug('error message====='+e.getStackTraceString());
            system.debug('erro========='+e.getMessage());
        }
    }

}