<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>OF_TT_Update_Inviata</fullName>
        <field>EOF_Inviata__c</field>
        <literalValue>1</literalValue>
        <name>Trouble Ticket - Update Inviata</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateInviata</fullName>
        <field>EOF_Inviata__c</field>
        <literalValue>1</literalValue>
        <name>UpdateInviata</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>No_edit</fullName>
        <actions>
            <name>UpdateInviata</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>EOF_Notify__c.Updated__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>EOF_Notify__c.RecordTypeId</field>
            <operation>notContain</operation>
            <value>Trouble Ticket</value>
        </criteriaItems>
        <description>Updates the field inviata to true in order to stop any further modification to the notify</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OF_TT_No_Edit</fullName>
        <actions>
            <name>OF_TT_Update_Inviata</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>EOF_Notify__c.RecordTypeId</field>
            <operation>contains</operation>
            <value>Trouble Ticket</value>
        </criteriaItems>
        <criteriaItems>
            <field>EOF_Notify__c.Updated__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Updates the field inviata to true in order to stop any further modification to the notify</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
