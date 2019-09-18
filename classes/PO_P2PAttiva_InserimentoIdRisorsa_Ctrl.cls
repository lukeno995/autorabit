public class PO_P2PAttiva_InserimentoIdRisorsa_Ctrl {
	public String idRisorsa{get;set;}
	public boolean idRisorsaNonValido{get;set;}
	public String codOp{get;set;}
	public String nomeProgetto{get;set;}
	
	public PO_P2PAttiva_InserimentoIdRisorsa_Ctrl() {  
		if(	ApexPages.currentPage().getParameters().get('valid')!=null){
			idRisorsaNonValido=true;
		}else{
			idRisorsaNonValido=false;
		}	
		nomeProgetto = ApexPages.currentPage().getParameters().get('Nome');
	}
	
	public pagereference routeRequest(){
		//check IdRisorsa
		codOp = [SELECT Account.EOF_Codice_Operatore__c FROM User WHERE id = :userinfo.getuserid() LIMIT 1].Account.EOF_Codice_Operatore__c;
		List<Asset> assetList = [SELECT Id, name, status
								FROM Asset Where 
							    RecordType.DeveloperName = 'PO_P2P_Attiva' 
								AND Status='Attivo' 
								AND Account.EOF_Codice_Operatore__c=:codOp 
								AND Name=:idRisorsa]; 
		if (assetList.isEmpty()){
			idRisorsaNonValido=false;
		}else{
			idRisorsaNonValido=false;
		}

		Pagereference pg;
		if (idRisorsaNonValido){
			pg = new PageReference('/PO_P2PAttiva_InserimentoIdRisorsa');
			pg.getParameters().put('Nome', nomeProgetto);
			pg.getParameters().put('valid','false'); 
		}else{
			pg = new PageReference('/PO_P2PAttiva_Cessazione');
			pg.getParameters().put('proc','CESS');
			pg.getParameters().put('IdRisorsa',idRisorsa); 
			pg.getParameters().put('Nome', nomeProgetto);
			pg.getParameters().remove('valid');
		}		
		//}
		return pg;
	}
    

}