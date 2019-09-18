<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Controllo_Maiuscole_ISP</fullName>
        <field>OF_CQS_ISP_Comune__c</field>
        <formula>UPPER(OF_CQS_ISP_Comune__c)</formula>
        <name>Controllo Maiuscole ISP</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Controllo_Maiuscole_ISP_Prov</fullName>
        <field>OF_CQS_ISP_Provincia__c</field>
        <formula>UPPER(OF_CQS_ISP_Provincia__c)</formula>
        <name>Controllo Maiuscole ISP Prov</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OF_CQS_Controllo_Maiuscole_ISP_VIA</fullName>
        <field>OF_CQS_ISP_VIA__c</field>
        <formula>UPPER(OF_CQS_ISP_VIA__c)</formula>
        <name>Controllo Maiuscole ISP VIA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>OF_CQS_Controllo Maiuscole ISP</fullName>
        <actions>
            <name>Controllo_Maiuscole_ISP</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Controllo_Maiuscole_ISP_Prov</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OF_CQS_Controllo_Maiuscole_ISP_VIA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OF_CQS_Ispezione__c.OF_CQS_ISP_Comune__c</field>
            <operation>notEqual</operation>
            <value>@@@@@</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
