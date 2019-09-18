<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CQS_Impresa_Esecutrice_Collaborazioni</fullName>
        <field>CQS_Impresa_Esecutrice_Collaborazioni__c</field>
        <formula>UPPER(CQS_Impresa_Esecutrice_Collaborazioni__c)</formula>
        <name>Maiuscolo Impresa Esecutrice</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Maiuscolo_Comune_Collaborazioni</fullName>
        <field>CQS_Comune_Collaborazione__c</field>
        <formula>UPPER(CQS_Comune_Collaborazione__c)</formula>
        <name>Maiuscolo Comune</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Maiuscolo_Provincia_Collaborazioni</fullName>
        <field>CQS_Provincia_Collaborazioni__c</field>
        <formula>UPPER(CQS_Provincia_Collaborazioni__c)</formula>
        <name>Maiuscolo Pv</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OF_CQS_Maiuscolo_IM_COLLABORAZIONI</fullName>
        <field>CQS_Impresa_Mandataria_Collaborazioni__c</field>
        <formula>UPPER(CQS_Impresa_Mandataria_Collaborazioni__c )</formula>
        <name>Maiuscolo IM</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
