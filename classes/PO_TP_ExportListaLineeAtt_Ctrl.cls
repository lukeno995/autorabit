public  class PO_TP_ExportListaLineeAtt_Ctrl {
	public String soql {get;set;}
  public List<Asset> listRichiesteTP {get;set;}
  public List<AssetWrapper> listRichiesteW {get;set;}
  public String listRichiesteTPstring {get;set;}
    public List<AssetWrapper> populateWrapper(List<Asset> lista,      List<PriceBookEntry> lspbe){
        List<AssetWrapper>  lsWp=new List<AssetWrapper>();
        for (Asset ass: lista){
            
            PriceBookEntry c=(PriceBookEntry)R.of(lspbe).find(R.whereEq.apply(new Map<String, Object>{
                'OF_Asset__c' => ass.Id}))
                .toSObject();
            
            if (c!=null){
                AssetWrapper elem = new AssetWrapper();
                elem.Listino=c.Pricebook2.Name;
                elem.id = ass.id;
                elem.IDRisorsa=ass.Name;
                elem.Profilo=ass.OF_ProfiloOpenStream__c;
                elem.Stato=ass.Status;
                elem.DataAttivazione=string.valueOfGmt(ass.OF_DataAttivazione2__c);
                elem.DataCessazione=string.valueOfGmt(ass.OF_DataCessazione2__c);
                lsWp.add(elem);
            }
        }
        return lsWp;
    }
	public PageReference fetchList(){
 system.debug('hello');
 String DataInizio= System.currentPagereference().getParameters().get('DataInizio');
		String DataFine= System.currentPagereference().getParameters().get('DataFine');
 	
		String IDRisorsa= System.currentPagereference().getParameters().get('IDRisorsa');
		String Profilo= System.currentPagereference().getParameters().get('Profilo');
		String statusJSON= System.currentPagereference().getParameters().get('statusJSON');
    String Listino= System.currentPagereference().getParameters().get('Listino');
	system.debug('profilo'+Profilo);
 	
		
		 Id accId =  [SELECT AccountId FROM User where id=:userinfo.getuserid() LIMIT 1].AccountId;
        soql='SELECT Id,Name,ContactId,Product2id, EOF_ID_Risorsa__c, OF_DataAttivazione2__c,OF_DataCessazione2__c,'+
                'OF_ProfiloOpenStream__c,Status from ASSET where Id IN (SELECT OF_Asset__c FROM PricebookEntry WHERE isActive = true AND Name = \'Canone\') AND AccountId=\''+accId+'\''+
                'AND RecordType.DeveloperName=\'OF_OpenStream\'';
                
        
        system.debug('***Soql value '+soql);
        if (DataInizio!=null && !DataInizio.equals('')){
			DataInizio= DataInizio.replace(' ','+'); 
            soql += ' and OF_DataAttivazione2__c >='+String.escapeSingleQuotes(DataInizio); 
        }
        if (DataFine!=null && !DataFine.equals('')){
				DataFine = DataFine.replace(' ','+');
            soql += ' and OF_DataCessazione2__c <='+String.escapeSingleQuotes(DataFine);
        }
        if (IDRisorsa!=null&& !IDRisorsa.equals('')){
            soql += ' and EOF_ID_Risorsa__c =\''+String.escapeSingleQuotes(IDRisorsa)+'\'';     
        }
        if (Profilo!=null&& !Profilo.equals('')){                       
            soql += ' and OF_ProfiloOpenStream__c =\''+String.escapeSingleQuotes(Profilo)+'\'';
        }
        System.debug('QUERY FORMATTATA !!!! ' + soql);
		  if(String.isNotBlank(statusJSON)){
            List<String> ListStatus = (List<String>)System.JSON.deserialize(statusJSON, List<String>.class);
            if(ListStatus!=null && !ListStatus.isEmpty()){
                soql += ' and Status in (';
                //soql +=' and in Case_Portale__r.Status  (';
                for (string mystring:ListStatus){
                    soql +='\'' + mystring + '\',';
                }
                soql = soql.removeEnd(',');
                soql += ')';  
            }
        }

        	listRichiesteTP  =Database.query(soql + ' order by CreatedDate DESC');

  if(listRichiesteTP.size()>0){
            List<Id> assIdList = R.of(listRichiesteTP)
                .pluck('Id')
                .debug()
                .toStringList();
            
            List<PriceBook2> lsPb  =new  List<PriceBook2>();
            List<PricebookEntry> lsPbe=null;

            if (Listino!=null && !Listino.equals('')){    
                lsPbe=[Select Pricebook2Id,Pricebook2.Name,OF_Asset__c from PricebookEntry where OF_Asset__c in: assIdList and  isActive = true AND Name = 'Canone' and Pricebook2.Name=:Listino];
            }else{
                lsPbe=[Select Pricebook2Id,Pricebook2.Name,OF_Asset__c from PricebookEntry where OF_Asset__c in: assIdList and  isActive = true AND Name = 'Canone'];
            }
            listRichiesteW=populateWrapper(listRichiesteTP,lsPbe);
            listRichiesteTPString= JSON.serialize(listRichiesteW);
        }
		return null;
	}
	public class AssetWrapper{
        public String IDRisorsa{get;set;}
        public string id{get;set;}
        public String Profilo{get;set;}
        public String Listino{get;set;}
        public String Stato{get;set;}
        public String DataCessazione{get;set;}
        public String DataAttivazione{get;set;}
        public AssetWrapper(){}
    }
}