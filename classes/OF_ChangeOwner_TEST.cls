@isTest
public class OF_ChangeOwner_TEST {
    
    @testSetup
    static void createData()
    {
        string uID = userinfo.getUserId();
        
        group gr = new group(
        	name = 'Coda Operatori BO',
            type = 'Queue'
        );
        insert gr;
        
        groupmember grMem = new groupmember(
        	UserOrGroupId = uID,
            GroupId = gr.id
        );
        insert grMem;
    }
        
    static testmethod void Metodo1()
    {
        list<id> casesId = new list<id>();
        
        list<group> gr = [select id from group where name ='Coda Operatori BO' ANd Type = 'Queue'];
        
        case cas = new case(
            status = 'Accettato',
            Origin = 'Web',
            Priority = 'Medium',
            ownerid = gr[0].id
        );
        insert cas;
		
        casesId.add(cas.id);
        
        Test.startTest();
        OF_ChangeOwner.changeOwner(casesId);
        Test.StopTest();
        
    }
    
}