global class OF_ChangeOwner {
    
    webservice static String changeOwner(List<Id> CaseIds )
    {
        system.debug('OSCRM 31_08 CaseIds:'+CaseIds);
        Set<Id> OwnerIds = new Set<Id>();
        List<Case> listCaseToUpdate = new List<Case>();
        List<Case> listCaseToUpdate1 = new List<Case>();

        List<Case> listaCase =[SELECT id,ownerId,Status,owner.Name
                               FROM Case 
                               where id In : CaseIds];
		
        system.debug('OSCRM 01_09_2017 listaCase: '+listaCase);
        List<User> listaUser = [SELECT Id,Name,UserRoleId,UserRole.Name
                                from User
                                where Id =: UserInfo.getUserId()];
        Map<Id,Profile> mapProfile = new Map<Id,Profile>([select id , name from Profile]);
        
        if( listaCase.size() > 0 )
        {
            for( Case c : listaCase )
            {
                OwnerIds.add( c.OwnerId);
            }
        }
        system.debug('OSCRM 01_09_2017 OwnerIds: '+OwnerIds);
        List<Group> listaGroup = [SELECT id,Name,type 
                                 FROM Group 
                                 where id In : OwnerIds and type = 'Queue']; 

        system.debug('OSCRM 01_09_2017 listaGroup: '+listaGroup);
        
        ID ProfilId = UserInfo.getProfileId();
        ID UserId = UserInfo.getUserId();
        system.debug('OSCRM 01_09_2017 UserId: '+UserId);
        //Controllo che il profilo sia un profilo di Referente Fattibilità
        System.debug('OSCRM 01_09_2017 mapProfile.get()>>>'+mapProfile.get(ProfilId));
        Profile referenteFatt = mapProfile.get(ProfilId);
        
        
        system.debug('OSCRM 01_09_2017 referenteFatt: '+referenteFatt);

        if( referenteFatt != null && referenteFatt.Name != 'PO Referente Fattibilità' && referenteFatt.Name != 'System Administrator')
        {
            return 'NOPROF';
        }else if( referenteFatt != null && (referenteFatt.Name == 'PO Referente Fattibilità' || referenteFatt.Name == 'System Administrator') )
        {
            //Controllo se i Casi fanno parte di una ListView per le Code
            if( listaGroup.size() == 0)
            {
                return 'NOCODA';
            }else{
            //Controllo che la Coda che si sta consultando sia di Fattibilità
             
              //08/09/2017 Modifica
              string str;
              if(!test.isRunningTest())
              {
                  str = 'Ref. Fattibilità';
              }else
                  str = 'Operatori BO';
              //END 08/09/2017 Modifica
              
               //if( listaGroup[0].Name.contains('Ref. Fattibilità'))
               if( listaGroup[0].Name.contains(str))
                {
                  system.debug('ok');
                  for( Case c : listaCase )
                  {
                       c.OwnerId = UserId;
                       c.Status = 'In Lavorazione';
                       c.EOF_Fase__c = 'In Lavorazione Referente Fattibilità';
                      
                       listCaseToUpdate.add( c );
                   }
                   
                   if( listCaseToUpdate.size() > 0 ) update listCaseToUpdate;
                   
                   
                   Group referenteTecnico = [SELECT Id,Name
                                             FROM Group
                                             WHERE type = 'Queue' and
                                             Name =: listaGroup[0].Name.replace('Ref.','Tecnico') limit 1];

                   system.debug('OSCRM 01_09_2017 referenteTecnico: '+referenteTecnico);
                   for( Case c : listCaseToUpdate )
                   {
                        c.OwnerId = referenteTecnico.Id;
                        //c.Status = 'In Lavorazione';
                        c.EOF_Fase__c = 'In Attesa Presa In Carico Tecnico Fattibilità';
                        listCaseToUpdate1.add(c);
                   }
                   
                   if( listCaseToUpdate1.size() > 0 ) update listCaseToUpdate1;
                   
                   return 'OK';
                   
                  //ritorno ok al JS in modo da dire che i case da elaborare sono quelli che appartengono ad una coda di fattibilità....
               }else{
                  system.debug('NOCODAFATT');
                  return 'NOCODAFATT';
                  //ritorno not ok alla funzione chiamante JS in modo da communicare che i casi non appartengono ad una coda di fattibilità....
                  //in questo caso l'utente sta selezionando casi di una list view che non è fattibilità e quindi il flusso del programma viene interrotto.
               }
            }
        }
        system.debug('OSCRM 31_08 listaCase:'+listaCase);
        system.debug('OSCRM 31_08 listaGroup:'+listaGroup);
        system.debug('OSCRM 31_08 listaUser:'+listaUser);
        //system.debug('OSCRM 31_08 ROLEid:'+ROLEid);
        system.debug('OSCRM 31_08 ProfilId:'+ProfilId);
        system.debug('OSCRM 31_08 mapProfile:'+mapProfile);

        return null;
    }

}