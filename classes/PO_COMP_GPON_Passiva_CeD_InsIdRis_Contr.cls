public class PO_COMP_GPON_Passiva_CeD_InsIdRis_Contr{
    
	public String idRisorsa{get;set;}
	public boolean idRisorsaNonValido{get;set;}
	public String codOp{get;set;}
	
	public PO_COMP_GPON_Passiva_CeD_InsIdRis_Contr() 
	{  
		if(ApexPages.currentPage().getParameters().get('valid')!=null){
			idRisorsaNonValido=true;
		}
		else{
			idRisorsaNonValido=false;
		}	
	}
	
	public pagereference routeRequest()
	{
		//check IdRisorsa
		codOp = [SELECT Account.EOF_Codice_Operatore__c 
		        FROM User
		        WHERE id = :userinfo.getuserid() LIMIT 1].Account.EOF_Codice_Operatore__c;
		
		List<Asset> assetList = [SELECT Id, name, status
								 FROM Asset Where 
							     RecordType.DeveloperName = 'OF_CD_Asset_GPON_Passiva' 
								 AND Status = 'Attivo' 
								 AND Account.EOF_Codice_Operatore__c=:codOp 
								 AND Name=:idRisorsa]; 
								
		if(assetList.isEmpty()){
			idRisorsaNonValido=true;
		}
		else{
			idRisorsaNonValido=false;
		}

		Pagereference pg = new PageReference('/PO_GPON_Passiva_CeD_InsertNewReq');
		/*
		if(ApexPages.currentPage().getParameters().get('proc') == 'InserimentoRichiestaCHANORD')
		{
			if (idRisorsaNonValido)
			{
				pg.getParameters().put('proc','InserimentoRichiestaCHANORD');
				pg.getParameters().put('valid','false'); 
			}
			else
			{
				pg = new PageReference('/PO_DetailChange');
				pg.getParameters().put('origId',assetList[0].id);
			}
		}
		
		else
		{
		*/
		if(idRisorsaNonValido)
	    {
			pg.getParameters().put('proc','InserimentoRichiestaCESS');
			pg.getParameters().put('valid','false'); 
		}
		else
		{
			pg.getParameters().put('proc','CESS');
			pg.getParameters().put('IdRisorsa',idRisorsa); 
			pg.getParameters().remove('valid');
		}		
		//}
		return pg;
	}
}