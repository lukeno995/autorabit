public class OF_ContrattoServizioTriggerHandler {
    public static void controlloUnivocita(List<OF_ContrattoServizio__c> nuoviCS){
        Set<Id> accountsId = new Set<Id>();
        Set<Id> contractsId = new Set<Id>();
        Set<Id> contractInsert = new Set<Id>();
        Map<Id, List<OF_ContrattoServizio__c>> serviziXcontratto = new Map<Id, List<OF_ContrattoServizio__c>>();
        Map<Id, List<Contract>> contractsXAccountId = new Map<Id, List<Contract>>();
        Map<Id, Id> contractIdXAccountId = new Map<Id,Id>();
        for(OF_ContrattoServizio__c nuovoCS : nuoviCS)
            contractInsert.add(nuovoCS.OF_Contract__c);
        for(Contract c : [SELECT AccountId FROM Contract WHERE Id IN: contractInsert])    
            accountsId.add(c.AccountId); //account coinvolti dal trigger
        //Contratti per ogni account coinvolto
        for(Account a : [SELECT Id, (SELECT Id FROM Contracts) FROM Account WHERE Id IN: accountsId])
            contractsXAccountId.put(a.Id, a.Contracts);
        for(Id idAccount : accountsId){
            System.debug('@@@ ' + contractsXAccountId.get(idAccount) );
            for(Contract c : contractsXAccountId.get(idAccount))
                contractsId.add(c.Id); //contratti di ogni account coinvolto
        }
        //Servizi per ogni contratto di ogni account coinvolto
        for(Contract c : [SELECT Id, AccountId, (SELECT Id, OF_Servizio__r.Name from Contratti_Servizi__r) FROM Contract WHERE Id IN: contractsId] ){
            serviziXcontratto.put(c.Id, c.Contratti_Servizi__r);
            contractIdXAccountId.put(c.Id, c.AccountId);
        }
        //Controllo che 
        for(OF_ContrattoServizio__c newCS : nuoviCS){
            Boolean presente = false;
            System.debug('@@@ newCS.OF_Servizio__c' + newCS.OF_Servizio__c);
            System.debug('@@@ contractIdXAccountId' + contractIdXAccountId.get(newCS.OF_Contract__c));
            System.debug('@@@ contractsXAccountId' + contractsXAccountId.get(contractIdXAccountId.get(newCS.OF_Contract__c)));
            for(Contract c : contractsXAccountId.get(contractIdXAccountId.get(newCS.OF_Contract__c))){ //per tutti i contratti legati all'OLO interessato
                System.debug('@@@ serviziXcontratto' + serviziXcontratto.get(c.Id));
                for(OF_ContrattoServizio__c csEsistente : serviziXcontratto.get(c.Id)){ // per tutti i servizi ad essi legati
                    System.debug('@@@ csEsistente.OF_Servizio__c' + csEsistente.OF_Servizio__c);
                    if( csEsistente.OF_Servizio__c == newCS.OF_Servizio__c) presente = true; //ne esista uno con lo stesso nome
                }
            }
            if(presente) newCS.addError('Servizio pre-esistente per questo OLO');
        }
    }
}