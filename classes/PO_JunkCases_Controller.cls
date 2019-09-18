public class PO_JunkCases_Controller {
    public String attachId {get;set;}
    public String parentCaseId {get;set;}

    public PO_JunkCases_Controller(){
        attachId = ApexPages.currentPage().getParameters().get('id');
        parentCaseId = ApexPages.currentPage().getParameters().get('parentId');
    }
    /*public void executeDML(){
        List<Case> parentCasesList = [SELECT Id, Status, PO_Motivazioni_rifiuto__c
                                      FROM Case
                                      WHERE Id = :parentCaseId];
        if(!parentCasesList.isEmpty()){
            Case parentCase = parentCasesList.get(0);
            parentCase.Status = 'Scartato';
            parentCase.PO_Motivazioni_rifiuto__c = 'Import massivo fallito';
            update parentCase;
        }
    }*/ 
    public PageReference annulla()
    {
        return new PageReference('/apex/PO_Index'); 
    }
}