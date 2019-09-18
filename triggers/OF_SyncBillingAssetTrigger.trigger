trigger OF_SyncBillingAssetTrigger on Asset (after update) {
    
    Verticali__c verticaliCS = Verticali__c.getOrgDefaults();
    String rTypes = verticaliCS.RecordTypesAssets__c;
    rTypes = rTypes.replaceAll('\'','') ;
    List<string> RecorTypes = rTypes.split(',');
    
    system.debug('@@@@@@@@RecorTypes: '+RecorTypes);
    
    List<RecordType> recs = [select id from RecordType where DeveloperName in :RecorTypes];    
    List<string> recIds = new  List<string>();
    
    for(RecordType r  :recs)
    {
        recIds.add(r.Id);
    }
    
    system.debug('@@@@@@@@recIds: '+recIds);
    List<Asset> assets = new List<Asset>();
    
    for(Asset ass :Trigger.new)
    {
        system.debug('@@@@@@@@ass.RecordTypeId: '+ass.RecordTypeId);
        if(recIds.contains(ass.RecordTypeId))
        {
            assets.add(ass);
        }
    }
    system.debug('@@@@@@@@assets: '+assets);
    if(assets.size()>0)
    {      
        for(Asset ass :assets)
        {
            Asset oldAsse = Trigger.oldMap.get(ass.ID); 
            if(oldAsse.Sync_Verticali__c != ass.Sync_Verticali__c && ass.Sync_Verticali__c)
            {
                SyncBillingAssetUtils.callVerticalBatch(ass.Id);
            }
            if(oldAsse.OF_SyncNoVert__c != ass.OF_SyncNoVert__c && ass.OF_SyncNoVert__c)
            {
                SyncBillingAssetUtils.callFattibilitaBatch(ass.Id);
            }
        }
    }
}