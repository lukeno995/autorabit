public class OF_EditPriceController {

    public PriceBookEntry  pbEntry { public get; public set; }
    public Decimal newPrice { public get; public set; }
    public Decimal oldPrice { public get; public set; }
    Id idAsset;

    public OF_EditPriceController () {
    
    	Id id = ApexPages.currentPage().getParameters().get('id');
	    idAsset = ApexPages.currentPage().getParameters().get('idAsset');
	    pbEntry= [SELECT Id,Name,Product2.Name,Pricebook2.Name,UnitPrice,OF_Asset__c,OF_DataAttivazione2__c,OF_DataCessazione2__c FROM PriceBookEntry WHERE Id =: id];
	    oldPrice = decimal.valueOf(String.ValueOf(pbEntry.UnitPrice));
    }
      
    public PageReference save() {
        try {
        	//Aggiornamento della pricebookentry col nuovo prezzo
           	pbEntry.UnitPrice = newPrice;
           	upsert(pbEntry);
			
			//Inserimento dei dati nell'oggetto OF_PriceTracking__c
            OF_PriceTracking__c pt = new OF_PriceTracking__c();
            pt.OF_Prezzo1__c = oldPrice;
            pt.OF_Prezzo2__c = newPrice;
            //DG 25/05/2017 aggiunti i campi per creare il link alla pricebookentry
            //Aggiunta la valorizzazione della lookup all'asset per la related list del price tracking sotto l'asset
            pt.Asset__c = idAsset;
            pt.OF_PriceBookEntryID__c = pbEntry.Id;
            pt.OF_PriceBookEntryName__c = pbEntry.name;
            insert pt;
            PageReference pg = new PageReference('/' + idAsset);
            pg.setRedirect(true);
            return pg;
        } catch(Exception e) {
	          OF_Utility.logMessage(true,'E',
		             'Classe: OF_EditPriceController',
		             'Method: save',
		             'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
		              );           
		      return null;
        }
    }
       

    public PageReference toReturn() {
    	try{
	    	PageReference pg = new PageReference('/' + idAsset);
	        pg.setRedirect(true);
	        return pg;
    	}catch(Exception e) {
	          OF_Utility.logMessage(true,'E',
		             'Classe: OF_EditPriceController',
		             'Method: toReturn',
		             'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
		              );           
		      return null;
        }
    }
       
}