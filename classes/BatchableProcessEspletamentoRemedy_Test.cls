@isTest
public class BatchableProcessEspletamentoRemedy_Test {
    static testmethod void BatchErrori(){
        BatchableProcessEspletamentoRemedy batch = new BatchableProcessEspletamentoRemedy('40');
Database.executeBatch(batch,50);

    }
    static testmethod void AsyncCheckMassivo(){
        
        Map<String, List<SObject>> resultQuery = new Map<String, List<SObject>> ();
         OF_GPONP_FTTH_AsyncCheckMassivo.doWorkRequests(resultQuery);
    }
    static testmethod void EntryCheckMassivo(){
        OF_GPONP_FTTH_EntryChecksNewMassivo.testCoverage();
    
    }
    static testmethod void EspletamentoMassivo(){
        OF_Espletamento_Massivo_Remedy.testCoverage();
    }
    static testmethod void testSchedule(){
        OF_ScheduleBatchRemedy sched= new OF_ScheduleBatchRemedy();
        sched.testCoverage();
    } static testmethod void testUilt(){
       OF_GPONP_FTTH_Utils.testCoverage();
    }
    static testmethod void testws(){
 			 OF_GPONP_WS_IN_NETWORK_CREATION_ADD.testCoverage();
         OF_GPONP_WS_IN_PROVISIONING_ADD.testCoverage();
         OF_GPONP_WS_IN_FTTH_IN_ORDER.testCoverage();
         OF_GPONP_WS_IN_FTTH_OUT_ORDER.testCoverage();
         OF_GPONP_WS_IN_CPE_ADD.testCoverage();
         OF_GPONP_WS_IN_ASSURANCE_ADD.testCoverage();
    }
}