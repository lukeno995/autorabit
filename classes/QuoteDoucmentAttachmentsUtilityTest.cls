@isTest
public class QuoteDoucmentAttachmentsUtilityTest {
	public static testmethod void QuoteDoucmentAttachment() {

		Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case;
			Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
			Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
			Id rtId2 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();

			OF_FiberLeaseListinoPrezzoAnnuo__c fiberPrezzo= new OF_FiberLeaseListinoPrezzoAnnuo__c();
			fiberPrezzo.Name='13';
			fiberPrezzo.Prezzo__c=70;
			fiberPrezzo.Anno__c= 'Anno13';
			insert fiberPrezzo;

			OF_FiberLeasePrezzoMedioAnnuo__c fiberPrezzo1= new OF_FiberLeasePrezzoMedioAnnuo__c();
			fiberPrezzo1.Name='Backbone1';
			fiberPrezzo1.Prezzo__c=70;

			insert fiberPrezzo1;

			OF_FiberLeasePrezzoMedioAnnuo__c fiberPrezzo2= new OF_FiberLeasePrezzoMedioAnnuo__c();
			fiberPrezzo2.Name='Backbone2';
			fiberPrezzo2.Prezzo__c=70;

			insert fiberPrezzo2;

			OF_FiberLeasePrezzoMedioAnnuo__c fiberPrezzo3= new OF_FiberLeasePrezzoMedioAnnuo__c();
			fiberPrezzo3.Name='Drop1';
			fiberPrezzo3.Prezzo__c=70;

			insert fiberPrezzo3;

			OF_FiberLeasePrezzoMedioAnnuo__c fiberPrezzo4= new OF_FiberLeasePrezzoMedioAnnuo__c();
			fiberPrezzo4.Name='Drop2';
			fiberPrezzo4.Prezzo__c=70;

			insert fiberPrezzo4;

			Account acc = new Account(name = 'Test Account');
			insert acc;

            //Id rtRichiestaFatt = [SELECT Id FROM RecordType WHERE DeveloperName = 'PO_Richiesta_a_servizio_a_fattibilit' LIMIT 1].Id;
			Case parentCase = new Case(PO_Offerta__c = 'P2P Base',
									   PO_Tipo_percorso__c = 'Singola Via',
									   RecordTypeId = rtId2,
									   PO_Costo_lavori_civili__c = 100,
									   PO_Costo_lavori_ottici__c = 100,
									   PO_Incluso_nell_offerta__c= true,
									   PO_Posa_1_nuovo_Drop__c=100,

									   PO_BB_1_interessato__c = 2,
									   PO_BB_2_interessato__c =2,
									   Status ='Acquisito',
									   Priority = 'Medium',
									   Origin = 'Email');
			insert parentCase;

			List<case> caseList = new List<case>();
			Case childCase1 = new Case(ParentId = parentCase.Id,
									   PO_Richiesta_a_fattibilit__c = parentCase.Id,
									   RecordTypeId = rtId2,
									   PO_Offerta__c = 'P2P Base',
									   PO_Tipo_percorso__c = 'Singola Via',
									   PO_BB_1_interessato__c = 2,
									   PO_BB_2_interessato__c =2,
									   PO_Costo_lavori_civili__c = 100,
									   PO_Costo_lavori_ottici__c = 100,
									   PO_Incluso_nell_offerta__c= true,
									   PO_Posa_1_nuovo_Drop__c=100,
									   Status ='Acquisito',
									   Priority = 'Medium',
									   Origin = 'Email');
			insert childCase1;
			caseList.add(childCase1);

			Opportunity opp = new Opportunity(name = 'testoppty',PO_Richiesta_fattibilit__c = parentCase.Id, PO_Collegamento__c=parentCase.Id,AccountId = acc.id,stageName = 'Qualification',closedate = system.today());
			insert opp;

			Opportunity Childopp = new Opportunity(name = 'testoppty',PO_Collegamento__c=childCase1.Id,AccountId = acc.id,stageName = 'Qualification',closedate = system.today());
			insert Childopp;

			Quote quoteObj = New Quote();
			quoteObj.Name = 'Test Quote';
			quoteObj.OpportunityId = opp.Id;
			Insert quoteObj;

			QuoteDocument qDoc = New QuoteDocument();
			qDoc.QuoteId = quoteObj.Id;
			qDoc.Document = Blob.toPdf('Test Document');
			insert qDoc;

			ContentVersion Content = new ContentVersion();
			Content.Title = 'UnitTest';
			Content.PathOnClient = 'UnitTest.jpg';
			Blob bodyBlob = Blob.valueOf('UnitTest ContentVersion Body');
			Content.VersionData = bodyBlob;
			Content.origin = 'H';
			insert Content;
			
			System.debug('Content.ContentDocumentId: '+Content.ContentDocumentId);

			//List<ContentDocument> cdList = [select Id from ContentDocument ORDER BY CreatedDate LIMIT 1];
			//System.debug('CD LIST: '+cdList);
			List<contentversion> documents = [select contentdocumentid from contentversion where id =: content.id];

			ContentDocumentLink contentlink = new ContentDocumentLink();
			contentlink.LinkedEntityId = quoteObj.id;
			contentlink.ContentDocumentId = documents[0].contentdocumentid;
			//contentlink.ContentDocumentId = cdList[0].Id;
			contentlink.ShareType = 'V';
			contentlink.Visibility = 'AllUsers';
			insert contentlink;

			//System.debug('contentlink.ContentDocumentId: '+contentlink.ContentDocumentId);
			//Content.ContentDocumentId = cdList[0].Id;
			//update Content;

			test.starttest();
			//List<contentversion> documents1 = [select contentdocumentid from contentversion where id =: content.id];
			Id contentId =[select contentdocumentid from contentversion where id =: content.id LIMIT 1].contentdocumentid;
			List<ContentDocument> docObj = [select id from ContentDocument where id =: contentId];
			QuoteDoucmentAttachmentsUtility QuoteDocObj = new QuoteDoucmentAttachmentsUtility();
			QuoteDoucmentAttachmentsUtility.AttachmentInsertion(docObj);
			test.stoptest();
	}

}