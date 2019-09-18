@isTest
public class OF_AssetExtraTEST {
    //Insert
    static testmethod void Metodo1(){
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
        
    }
    
    
    //Update
     static testmethod void Metodo2(){
      OF_Configurazioni__c CustSett = new OF_Configurazioni__c(
            Name = '001',
            DataSwitchOM__c = datetime.newInstance(2017, 01, 01, 00, 00, 0),
            OF_ServizioExtraName__c = Decimal.valueof(1)
        );
        insert CustSett;
List<RecordType> rtypes = [Select Name,DeveloperName, Id From RecordType
where sObjectType IN ('Account','Asset','case','OF_CommercialElementIstanziato__c','pricebook2') and isActive=true];
Map<String,String> RecordTypes = new Map<String,String>{};
for(RecordType rt: rtypes)
RecordTypes.put(rt.DeveloperName,rt.Id);

account acc = new account(
EOF_Codice_Operatore__c = 'WN',
Type = 'OLO',
name = 'Wind',
RecordTypeId = RecordTypes.get('OLO')
);
insert acc;

asset ass1 = new asset(
Name = 'test',
AccountId = acc.id,
Status = 'Attivo',
RecordTypeId = RecordTypes.get('Fiber_Link'),
Data_Avvio_Fatturazione__c = system.today()
);
insert ass1;

OF_CommercialElementIstanziato__c ceIst = new OF_CommercialElementIstanziato__c(
OF_Stato__c = null,
//RecordTypeId = RecordTypes.get('OF_GPONPassiva'),
OF_Asset__c = ass1.id
);
insert ceIst;

//Pricebook
pricebook2 prb = new pricebook2(
name = 'Test'
//RecordTypeId = RecordTypes.get('Pricebook')
);
insert prb;

//Product
product2 pr = new product2(
name = 'TestProd'
);
insert pr;

//Pricebook standard
ID id = Test.getStandardPricebookId();
PriceBook2 pb2 = new PriceBook2();
pb2.Id=id;
update pb2;

//PriceBookEntry Standard
pricebookentry pbe = new pricebookentry(
UnitPrice = -9999,
IsActive = true,
Product2ID = pr.id,
Pricebook2ID = pb2.id  //pricebook standard
);
insert pbe;

//PriceBookEntry
PriceBookEntry prE = new PriceBookEntry(
Product2Id = pr.Id,           
Pricebook2Id = prb.Id,
OF_Asset__c = ass1.id,
UnitPrice = -9.999
);
insert prE;
case parentcas = new case(
            EOF_Account_OLO__c = acc.id,
            RecordtypeId = RecordTypes.get('PO_Ordine_Fiber_Link'),
            Status = 'Espletato',
            PO_Durata_mesi__c = 2,
            //OF_IDContratto__c = contr.id,
            OF_Servizio__c = 'GPON Passiva'
           // assetid = ass1.id
        );
        insert parentcas ;
          parentcas =[select id,PO_Durata_mesi__c from case where id=:parentcas.id];
          system.debug('test++++'+parentcas);
        case parentcas1 = new case(
            EOF_Account_OLO__c = acc.id,
            PO_Richiesta_a_fattibilit__c=parentCas.id,
            RecordtypeId = RecordTypes.get('PO_Ordine_Fiber_Link'),
            Status = 'Espletato',
            //OF_IDContratto__c = contr.id,
            OF_Servizio__c = 'GPON Passiva',
            PO_Durata_mesi__c = 2  
           // assetid = ass1.id
        );
        insert parentcas1 ;
         parentcas1 =[select id,PO_Richiesta_a_fattibilit__r.PO_Durata_mesi__c from case where id=:parentcas1.id];
         system.debug('test++++'+parentcas1 );
  case cas = new case(
            EOF_Account_OLO__c = acc.id,
            RecordtypeId = RecordTypes.get('PO_Ordine_Fiber_Lease'),
            Status = 'Espletato',
            //OF_IDContratto__c = contr.id,
            OF_Servizio__c = 'GPON Passiva',
            PO_Case_Collegamento__c=parentcas1.id,
            PO_Durata_mesi__c  = 2,
            assetid = ass1.id
        );
        insert cas;
        Cas=[select id,PO_Case_Collegamento__r.PO_Richiesta_a_fattibilit__r.PO_Durata_mesi__c from case where id=:cas.id];
system.debug('test++++'+cas.PO_Case_Collegamento__r.PO_Richiesta_a_fattibilit__r.PO_Durata_mesi__c  );
ass1.Data_Avvio_Fatturazione__c = system.today() + 1;
update ass1;

} 
    

    
}