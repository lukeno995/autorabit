@isTest
public class OF_EditPriceControllerTEST {
    
    public static testMethod pricebookentry datiTest() {
       	
        OF_Configurazioni__c CustSett = new OF_Configurazioni__c(
            Name = '001',
            DataSwitchOM__c = datetime.newInstance(2017, 01, 01, 00, 00, 0),
        	OF_ServizioExtraName__c = Decimal.valueof(1)
        );
        insert CustSett;
        
        List<RecordType> rtypes = [Select Name, Id From RecordType
                  where (sObjectType='Account' or sObjectType = 'Asset' or sObjectType = 'case') and isActive=true];
        Map<String,String> RecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
            RecordTypes.put(rt.Name,rt.Id);
        
        account acc = new account(
            EOF_Codice_Operatore__c = 'WN',
            Type = 'OLO',
            name = 'Wind',
            RecordTypeId = RecordTypes.get('OLO')
        );
        insert acc;
        
        contract contr = new contract(
            AccountId = acc.id,
            OF_IdContratto__c = 'WindGPONPASSIVA',
            StartDate = system.today(),
            ContractTerm = 600,
            Status = 'Attivo'
        );
        insert contr;
        
        
        asset ass1 = new asset(
            Name = 'test',
            AccountId = acc.id,
            Status = 'Attivo',
            RecordTypeId = RecordTypes.get('GPON Passiva')
        );
        insert ass1;
        
        case cas = new case(
        	EOF_Account_OLO__c = acc.id,
            RecordtypeId = RecordTypes.get('EOF Caso - Attivazione'),
            Status = 'Espletato',
            OF_IDContratto__c = contr.id,
            OF_Servizio__c = 'GPON Passiva',
            assetid = ass1.id
        );
        insert cas;
        
        asset ass = new asset(
            Name = 'test',
            AccountId = acc.id,
            Status = 'Attivo',
            RecordTypeId = RecordTypes.get('Intervento a vuoto'),
            OF_Case__c = cas.id,
            OF_ServizioRichiesto__c = 'GPON Passiva',
            OF_TipoDiProcesso__c = 'Assurance',
            OF_Data__c = system.now()
        );
        insert ass;
        
        product2 prod = new product2(
            name = 'test',
            isActive = true
        );
        insert prod;
        
        Id pricebookId = Test.getStandardPricebookId();
		
        pricebook2 priceB = new Pricebook2(
        	name = 'test',
        	Isactive = true
        );
        insert priceB;
        
        pricebookentry pbeStd = new pricebookentry(
        	Product2Id = prod.id,
            Pricebook2Id = pricebookId,
            isActive = true,
            unitprice = -9999
        );
        insert pbeStd;
        
        pricebookentry pbe = new pricebookentry(
            Product2Id = prod.id,
            Pricebook2Id = priceB.Id,
            isActive = true,
            UnitPrice = -9999,
            OF_asset__c = ass.id
        );
        insert pbe;
        return pbe;
    }
    
    public static testMethod void EditPrice() {
        
        pricebookentry pbe = datiTest();
        
        ApexPages.currentPage().getParameters().put('id', pbe.Id);
        ApexPages.currentPage().getParameters().put('idAsset', pbe.OF_Asset__r.Id);
		OF_EditPriceController controller = new OF_EditPriceController(); 
		
        controller.newPrice = 10;
        
        controller.toReturn();  
        controller.save();  
    }
    
    //Testa il catch del metodo save()
    public static testMethod void EditPrice1() {
        
        pricebookentry pbe = datiTest();
        
        ApexPages.currentPage().getParameters().put('id', pbe.Id);
        ApexPages.currentPage().getParameters().put('idAsset', pbe.OF_Asset__r.Id);
		OF_EditPriceController controller = new OF_EditPriceController(); 
		        
        controller.toReturn();  
        controller.save(); 

    }
}