public class SN_VistoController {

    public String MyId;    
	public Set<String> MySetId=new Set<String>();
    public List<String> MyListId;
    private final Case cas;
    
 
    public SN_VistoController(ApexPages.StandardController stdController) {
        this.cas = (Case)stdController.getRecord();
        
    }
 
    public void updateField() {
        //Get the user info from the current user        
    		MyId = UserInfo.getUserId();       
		    Boolean needUpdate=false;
 
    //Get the account record to be updated        
    Case c = [select SN_SetId__c,SN_NuovoPost__c from case where id = :cas.id limit 1];        
 	
        if (String.isNotBlank(c.SN_SetId__c)){
            MyListId = c.SN_SetId__c.split(',');
            MySetId.addAll(MyListId);
            
        }    
        
        if (!MySetId.contains(MyId)){
            MySetId.add(MyId);
            String collegeString = '';
            for(String s:MySetId) {
                collegeString += (collegeString==''?'':',')+s;
            }
            if(collegeString.length()>255){
                collegeString.substring(0, 255);
            }
            c.SN_SetId__c = collegeString;
            needUpdate=true;
        }
        /*
        If(c.SN_NuovoPost__c==true){
            c.SN_NuovoPost__c = false;
            needUpdate=true; 
        }
		*/
    //Assign values to Last Viewed By field &amp; update the record        
            
        if(needUpdate==true){
          	update c;
        }
    }
}