<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>OF_CQSMaiuscolo_Particella_Toponomastica</fullName>
        <field>OF_CQS_Particella_Toponomastica__c</field>
        <formula>UPPER(OF_CQS_Particella_Toponomastica__c)</formula>
        <name>Maiuscolo Particella Toponomastica</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OF_CQS_Maiuscolo_Comune</fullName>
        <field>OF_CQS_Comune__c</field>
        <formula>UPPER(OF_CQS_Comune__c)</formula>
        <name>Maiuscolo Comune</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OF_CQS_Maiuscolo_Nome_Impresa2</fullName>
        <field>Name</field>
        <formula>UPPER(Name)</formula>
        <name>Maiuscolo Nome Impresa</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OF_CQS_Maiuscolo_Provincia</fullName>
        <field>OF_CQS_Provincia__c</field>
        <formula>UPPER(OF_CQS_Provincia__c)</formula>
        <name>Maiuscolo Provincia</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OF_CQS_Minuscolo_Website</fullName>
        <field>OF_CQS_Website__c</field>
        <formula>LOWER(OF_CQS_Website__c)</formula>
        <name>Minuscolo Website</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OF_CQS_Minuscolo_indirizzo_email</fullName>
        <field>OF_CQS_Indirizzo_Email__c</field>
        <formula>LOWER(OF_CQS_Indirizzo_Email__c)</formula>
        <name>Minuscolo indirizzo email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
