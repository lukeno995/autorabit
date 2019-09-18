<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>CQS_Risorse_Impiegate_reminder</fullName>
        <description>CQS Risorse Impiegate reminder</description>
        <protected>false</protected>
        <recipients>
            <recipient>CQS_City_Manager_Nord</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>CQS_City_Manager_Sud</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>OF_CQS_City_Manager_Centro</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Public/CQS_Risorse_Impiegate</template>
    </alerts>
</Workflow>
