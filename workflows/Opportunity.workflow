<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>PO_Richiesta_Approvazione</fullName>
        <description>PO Richiesta Approvazione</description>
        <protected>false</protected>
        <recipients>
            <recipient>PO_Supervisore_Commerciale</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Public/PO_Richiesta_Approvazione</template>
    </alerts>
    <fieldUpdates>
        <fullName>PO_Approvazione_rifiutata</fullName>
        <field>StageName</field>
        <literalValue>Approvazione rifiutata</literalValue>
        <name>PO Approvazione rifiutata</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PO_Record_Type_Evento_Fiber_Link</fullName>
        <field>RecordTypeId</field>
        <lookupValue>PO_Oppty_Richiesta_fattibilit_Fiber_Link</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>PO Record Type Evento Fiber Link</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PO_Record_Type_Evento_Temporaneo</fullName>
        <field>RecordTypeId</field>
        <lookupValue>PO_Oppty_Richiesta_fattibilit_Evento_Temporaneo</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>PO Record Type Evento Temporaneo</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PO_Record_Type_Fiber_Lease</fullName>
        <field>RecordTypeId</field>
        <lookupValue>PO_Oppty_Richiesta_fattibilit_Fiber_Lease</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>PO Record Type Fiber Lease</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PO_Record_Type_IRU</fullName>
        <field>RecordTypeId</field>
        <lookupValue>PO_Oppty_Richiesta_fattibilit_IRU</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>PO Record Type IRU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PO_Record_Type_Misto_Lease_Link</fullName>
        <field>RecordTypeId</field>
        <lookupValue>PO_Oppty_Richiesta_fattibilit_Misto_Lease_Link_per_FW</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>PO Record Type Misto Lease-Link</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PO_Record_Type_P2P</fullName>
        <field>RecordTypeId</field>
        <lookupValue>PO_Oppty_Richiesta_fattibilit</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>PO Record Type P2P</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PO_Stage_Approvato</fullName>
        <field>StageName</field>
        <literalValue>Approvata Supervisore Commerciale</literalValue>
        <name>PO Stage Approvato</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PO_Stage_in_approvazione</fullName>
        <field>StageName</field>
        <literalValue>In approvazione Supervisore Commerciale</literalValue>
        <name>PO Stage in approvazione</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
