<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>PO_EMAIL_OLO_Reschedule</fullName>
        <description>PO Email OLO Reschedule</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Public/PO_OLO_Reschedule</template>
    </alerts>
    <alerts>
        <fullName>PO_Email_OLO_Status_Update</fullName>
        <description>PO Email OLO Status Update</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Public/PO_OLO_StatusUpdate</template>
    </alerts>
    <alerts>
        <fullName>PO_Email_OLO_Status_Update_ChangeOrder</fullName>
        <description>PO Email OLO Status Update ChangeOrder</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/PO_OLO_StatusUpdate_CO</template>
    </alerts>
    <alerts>
        <fullName>PO_Email_OLO_Status_Update_TT</fullName>
        <description>PO Email OLO Status Update TT</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/PO_OLO_StatusUpdate_TT</template>
    </alerts>
    <rules>
        <fullName>PO_ModificaDataAttivazioneDaPortale</fullName>
        <actions>
            <name>PO_EMAIL_OLO_Reschedule</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(OR(RecordType.DeveloperName = &apos;PO_SA_FiberRequest&apos;,RecordType.DeveloperName = &apos;Trouble_Ticket&apos;),  				NOT(ISCHANGED(EOF_STATO_ORDINE__c)), 				 EOF_Stato_Richiesta__c = &apos;Inserita Portale&apos;, 				ISCHANGED(EOF_DATA_PREVISTA_ATTIVAZIONE__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PO_ModificaStatusLogPortale</fullName>
        <actions>
            <name>PO_Email_OLO_Status_Update</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(RecordType.DeveloperName = &apos;PO_SA_FiberRequest&apos;,  				 EOF_Stato_Richiesta__c = &apos;Inserita Portale&apos;, 				ISCHANGED(EOF_STATO_ORDINE__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PO_ModificaStatusLogPortale_CO</fullName>
        <actions>
            <name>PO_Email_OLO_Status_Update_ChangeOrder</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(RecordType.DeveloperName = &apos;PO_CO_FiberRequest&apos;, EOF_Stato_Richiesta__c = &apos;Inserita Portale&apos;, ISCHANGED(EOF_STATO_ORDINE__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PO_ModificaStatusLogPortale_TT</fullName>
        <actions>
            <name>PO_Email_OLO_Status_Update_TT</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(RecordType.DeveloperName = &apos;PO_TT_TroubleTicketRequest&apos;,  				 EOF_Stato_Richiesta__c = &apos;Inserita Portale&apos;, 				ISCHANGED(EOF_STATO_ORDINE__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
