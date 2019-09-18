<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>CA_Notifica_Daily_Ordine_on_Building</fullName>
        <description>CA Notifica Daily Ordine on Building</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Public/CA_Daily_Alert_Building_con_OL</template>
    </alerts>
    <alerts>
        <fullName>Case_Creation_Email_Alert</fullName>
        <description>Case Creation Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Email_from_Mail__c</field>
            <type>email</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/AutoreplyWeb</template>
    </alerts>
    <alerts>
        <fullName>PO_Nuovo_Case_Registrazione</fullName>
        <description>PO Nuovo Case Registrazione</description>
        <protected>false</protected>
        <recipients>
            <recipient>PO_Supporto_Vendite</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Public/PO_Nuovo_Case_Registrazione_to_BackOffice</template>
    </alerts>
    <alerts>
        <fullName>PO_Richiesta_di_registrazione_in_KO</fullName>
        <description>Richiesta di registrazione in KO</description>
        <protected>false</protected>
        <recipients>
            <field>PO_Email_Registrazione__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>integration@produzione.net</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Public/PO_Registrazione_KO</template>
    </alerts>
    <alerts>
        <fullName>PO_TP_Alert_AreaCentroAssignedCase</fullName>
        <description>Email di Notifica Case Assegnato a Coda SOC Centro</description>
        <protected>false</protected>
        <recipients>
            <recipient>TP_Group_Delivery_Centro</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Public/PO_TP_Template_EmailToAreaCentroAssignedCase</template>
    </alerts>
    <alerts>
        <fullName>PO_TP_Alert_AreaNordAssignedCase</fullName>
        <description>Email di Notifica Case Assegnato a Coda SOC Nord</description>
        <protected>false</protected>
        <recipients>
            <recipient>TP_Group_Delivery_Nord</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Public/PO_TP_Template_EmailToAreaCentroAssignedCaseNord</template>
    </alerts>
    <alerts>
        <fullName>PO_TP_Alert_AreaSudAssignedCase</fullName>
        <description>Email di Notifica Case Assegnato a Coda SOC Sud</description>
        <protected>false</protected>
        <recipients>
            <recipient>TP_Group_Delivery_Sud</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Public/PO_TP_Template_EmailToAreaSudAssignedCase</template>
    </alerts>
    <alerts>
        <fullName>PO_TP_Alert_OperationAssignedCase</fullName>
        <description>Email di Notifica Case Assegnato a Coda Operations</description>
        <protected>false</protected>
        <recipients>
            <recipient>TP_Group_Coda_Operations</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Public/PO_TP_Template_EmailToOperationAssignedCase</template>
    </alerts>
    <alerts>
        <fullName>PO_TP_Alert_SOCAssignedCase</fullName>
        <description>Email di Notifica Case Assegnato a Coda SOC</description>
        <protected>false</protected>
        <recipients>
            <recipient>TP_Group_Coda_SOC</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Public/PO_TP_Template_EmailToSocAssignedCase</template>
    </alerts>
    <alerts>
        <fullName>PO_TP_Alert_UserPortalClosedCase</fullName>
        <description>Email di Notifica Case Chiuso a User Portal</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>delivery@openfiber.it</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Public/PO_TP_Template_EmailToUserPortalClosedCase</template>
    </alerts>
    <alerts>
        <fullName>SN_EmailAlert</fullName>
        <description>SN_EmailAlert</description>
        <protected>false</protected>
        <recipients>
            <recipient>delivery_services@openfiber.it.delivery</recipient>
            <type>user</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/SUPPORT_Assigned_to_Delivery_SAMPLE</template>
    </alerts>
    <alerts>
        <fullName>SN_email_alert_approvato</fullName>
        <description>SN email alert approvato</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>SN_Approva_Case_Folder/SN_case_approvato</template>
    </alerts>
    <alerts>
        <fullName>SN_email_alert_non_approvato</fullName>
        <description>SN email alert non approvato</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>SN_Approva_Case_Folder/SN_case_non_approvato</template>
    </alerts>
    <fieldUpdates>
        <fullName>CA_Censimento_da_Esterno_a_Interno</fullName>
        <field>CA_Censimento__c</field>
        <literalValue>Interno</literalValue>
        <name>CA Censimento da Esterno a Interno</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CA_Status_In_Lavorazione</fullName>
        <field>Status</field>
        <literalValue>In Lavorazione</literalValue>
        <name>CA Status In Lavorazione</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CA_Ultima_modifica_Status</fullName>
        <field>CA_Ultima_modifica_Status__c</field>
        <formula>NOW()</formula>
        <name>CA Ultima modifica Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CA_Upper_on_Azienda</fullName>
        <field>CA_Azienda__c</field>
        <formula>UPPER(CA_Azienda__c)</formula>
        <name>CA Upper on Azienda</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Timeout_OK</fullName>
        <description>checka il timeout ok</description>
        <field>EOF_Timeout_OK__c</field>
        <literalValue>1</literalValue>
        <name>Ckeck Timeout OK</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Da_Lavorare_In_Lavorazione</fullName>
        <field>EOF_Fase__c</field>
        <literalValue>In Analisi</literalValue>
        <name>Da Lavorare - In Lavorazione</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Desospendi_TT</fullName>
        <field>EOF_Desospendi__c</field>
        <literalValue>1</literalValue>
        <name>Desospendi TT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Fase_Da_lavorare</fullName>
        <field>EOF_Fase__c</field>
        <literalValue>Da lavorare</literalValue>
        <name>Fase_Da lavorare</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Muovi_fase</fullName>
        <field>EOF_Fase__c</field>
        <literalValue>In Verifica BO</literalValue>
        <name>Muovi fase In verifica BO</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Muovi_fase_Coda_Tecnica</fullName>
        <field>EOF_Fase__c</field>
        <literalValue>In Lavorazione</literalValue>
        <name>Muovi fase Coda Tecnica</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Muovi_fase_cessazione</fullName>
        <field>EOF_Fase__c</field>
        <literalValue>In Lavorazione</literalValue>
        <name>Muovi fase cessazione</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PL</fullName>
        <field>RecordTypeId</field>
        <lookupValue>EOF_Caso_Attivazione</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>PL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PL1</fullName>
        <field>RecordTypeId</field>
        <lookupValue>EOF_Caso_Attivazione</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>PL1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PL2</fullName>
        <field>RecordTypeId</field>
        <lookupValue>EOF_Caso_Attivazione</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>PL2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PL3</fullName>
        <field>RecordTypeId</field>
        <lookupValue>EOF_Caso_Attivazione</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>PL3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PO_Assegna_Case_coda_registrazione</fullName>
        <field>OwnerId</field>
        <lookupValue>PO_Coda_Registrazione</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Assegna Case coda registrazione</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Previous_Case_Status</fullName>
        <field>Previous_Status__c</field>
        <formula>Text(PRIORVALUE((Status)))</formula>
        <name>Previous Case Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Restore_canModify</fullName>
        <field>canModify__c</field>
        <literalValue>0</literalValue>
        <name>Restore_canModify</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SN_AssignToQueue</fullName>
        <field>OwnerId</field>
        <lookupValue>SN_Coda_Social_Cases</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>SN Assign to Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SN_Data_Status_In_Lavorazione</fullName>
        <field>SN_Giacenza_Status_in_Lavorazione__c</field>
        <formula>NOW()</formula>
        <name>SN - Data Status In Lavorazione</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SN_Update_Social_Status</fullName>
        <field>Status</field>
        <literalValue>In Lavorazione</literalValue>
        <name>SN Update Social Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SN_case_approvato</fullName>
        <field>SN_StatoApprovazione__c</field>
        <literalValue>Approvato</literalValue>
        <name>SN case approvato</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Stato_Acquisito</fullName>
        <field>Status</field>
        <literalValue>Acquisito</literalValue>
        <name>Stato_Acquisito</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Stato_in_approvazione</fullName>
        <field>SN_StatoApprovazione__c</field>
        <literalValue>In attesa</literalValue>
        <name>Stato in approvazione</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Stato_in_non_approvato</fullName>
        <field>SN_StatoApprovazione__c</field>
        <literalValue>Non Approvato</literalValue>
        <name>Stato in non approvato</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UnsetApexContext</fullName>
        <field>ApexContext__c</field>
        <literalValue>0</literalValue>
        <name>UnsetApexContext</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Upd_Case_Subject</fullName>
        <field>Subject</field>
        <formula>IF( 
AND( ISPICKVAL(Type, &apos;1&apos;),  RecordType.Name = &apos;EOF Caso - TT&apos;),&apos;Richiesta risoluzione guasto&apos;,
IF(
AND( ISPICKVAL(Type, &apos;9&apos;),  RecordType.Name = &apos;EOF Caso - TT&apos;),&apos;Richiesta annullamento&apos;,
IF(
ISPICKVAL(Type, &apos;1&apos;) , &apos;Richiesta di attivazione&apos;,  IF( ISPICKVAL(Type, &apos;2&apos;), &apos;Richiesta di rimodulazione DAC&apos;,  IF(ISPICKVAL(Type, &apos;3&apos;), &apos;Richiesta di desospensione&apos;,  IF(ISPICKVAL(Type, &apos;4&apos;), &apos;Richiesta di annullamento&apos;,  IF(ISPICKVAL(Type, &apos;11&apos;), &apos;Richiesta di cessazione&apos;, IF( ISPICKVAL(Type, &apos;101&apos;), &apos;Richiesta attivazione&apos;, IF( ISPICKVAL(Type, &apos;111&apos;), &apos;Richiesta cessazione&apos;,&apos;&apos;) ) ) ) ) ) ) ) )</formula>
        <name>Upd Case Subject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Attivazione%3A Appuntamento KO</fullName>
        <actions>
            <name>PL1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Accettato KO</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.EOF_Fase__c</field>
            <operation>equals</operation>
            <value>Accettato KO</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>EOF Caso - Attivazione,EOF Caso - Cessazione</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.EOF_Order_Manager__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Attivazione%3A Appuntamento OK%2FKO</fullName>
        <actions>
            <name>PL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Accettato</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.EOF_Fase__c</field>
            <operation>equals</operation>
            <value>Da contattare</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>EOF Caso - Attivazione,EOF Caso - Cessazione</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.EOF_Order_Manager__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Attivazione%3A Presa in carico BO</fullName>
        <actions>
            <name>Muovi_fase</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Acquisito</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.EOF_Fase__c</field>
            <operation>equals</operation>
            <value>Da lavorare</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>notEqual</operation>
            <value>Coda Operatori BO</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.EOF_Order_Manager__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>EOF Caso - Attivazione,EOF Caso - Cessazione</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Attivazione%3A Presa in carico Op%2E Tecnico</fullName>
        <actions>
            <name>Muovi_fase_Coda_Tecnica</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Accettato</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.EOF_Fase__c</field>
            <operation>equals</operation>
            <value>Appuntamento Fissato</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>notEqual</operation>
            <value>Coda Operatori Tecnici</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>EOF Caso - Attivazione,EOF Caso - Cessazione</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.EOF_Order_Manager__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CA Censimento da Esterno a Interno</fullName>
        <actions>
            <name>CA_Censimento_da_Esterno_a_Interno</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CA_Status_In_Lavorazione</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CA Amministratori</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Censimento Interno OK</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CA_Censimento__c</field>
            <operation>equals</operation>
            <value>Esterno</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CA Daily Alert Building con OL</fullName>
        <active>false</active>
        <formula>AND(          LEFT(OwnerId, 3) &lt;&gt; &quot;005&quot;,         RecordType.DeveloperName = &apos;CA_Amministratori&apos;, 				    NOT(ISBLANK(CA_Codice_Ordine_in_Corso__c)),         IsClosed=FALSE  														 								)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>CA_Notifica_Daily_Ordine_on_Building</name>
                <type>Alert</type>
            </actions>
            <timeLength>12</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>CA Ultima modifica Status</fullName>
        <actions>
            <name>CA_Ultima_modifica_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( 				ISCHANGED(Status), 				(RecordType.DeveloperName=&apos;CA_Amministratori&apos;) 				)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CA Upper on Azienda</fullName>
        <actions>
            <name>CA_Upper_on_Azienda</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CA Amministratori</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CaseCreationEmailNotification</fullName>
        <actions>
            <name>Case_Creation_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 3) AND 2</booleanFilter>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>SN Social Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Inviato</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>SN_Email_Request</value>
        </criteriaItems>
        <description>Create case when inbound email saved in salesforce</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Cessazione%3A Presa in carico BO</fullName>
        <actions>
            <name>Muovi_fase_cessazione</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Acquisito</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.EOF_Fase__c</field>
            <operation>equals</operation>
            <value>Da lavorare</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>notEqual</operation>
            <value>Coda Operatori BO</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Subject</field>
            <operation>equals</operation>
            <value>Richiesta di cessazione</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OF_TT_Accettazione_Trouble_Ticket</fullName>
        <actions>
            <name>Da_Lavorare_In_Lavorazione</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Trouble Ticket</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>In Lavorazione</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.EOF_Fase__c</field>
            <operation>equals</operation>
            <value>Da lavorare</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>notEqual</operation>
            <value>Trouble Ticket - Coda Analisi</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OF_TT_Desosp_con_Appuntamento</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Sospeso</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Trouble Ticket</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.EOF_Rischedulazione_Appuntamento__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.EOF_Desospendi__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Desospendi_TT</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Case.EOF_Data_Ritorno_In_Lavorazione__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>OF_TT_Timeout_OK</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Richiesta Chiusura</value>
        </criteriaItems>
        <description>Dopo l&apos;invio della richiesta di chiusura, se non riceve un flusso di test OK/test KO entro 8 ore, in automatico invia la richiesta di chiusura</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Check_Timeout_OK</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>8</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>PO Assegna Case coda registrazione</fullName>
        <actions>
            <name>PO_Nuovo_Case_Registrazione</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>PO_Assegna_Case_coda_registrazione</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>PO_Registrazione</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Nuovo</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PO Previous Status Of the Case</fullName>
        <actions>
            <name>Previous_Case_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( 
ISCHANGED(Status), 
OR( 
RecordType.DeveloperName=&apos;PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb&apos;, 
RecordType.DeveloperName=&apos;PO_Collegamento_Fiber_Lease&apos;, 
RecordType.DeveloperName=&apos;PO_Collegamento_Fiber_link&apos;, 
RecordType.DeveloperName=&apos;PO_Collegamento_IRU&apos;, 
RecordType.DeveloperName=&apos;PO_Collegamento_P2P&apos;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PO Registrazione KO</fullName>
        <actions>
            <name>PO_Richiesta_di_registrazione_in_KO</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>PO_Registrazione</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Chiuso KO</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PO_TP_CaseAssigned_Operation_Rule</fullName>
        <actions>
            <name>PO_TP_Alert_OperationAssignedCase</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>PO - TP - TicketProvisioning Case,PO - TP - TicketProvisioning Case</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>Incident - IT Operations</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PO_TP_CaseAssigned_SOC_AreaCentro_Rule</fullName>
        <actions>
            <name>PO_TP_Alert_AreaCentroAssignedCase</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>PO - TP - TicketProvisioning Case</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>TT - Coda Centro Ordini in Attivazione</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PO_TP_CaseAssigned_SOC_AreaNord_Rule</fullName>
        <actions>
            <name>PO_TP_Alert_AreaNordAssignedCase</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>PO - TP - TicketProvisioning Case</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>TT - Coda Nord Ordini in Attivazione</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PO_TP_CaseAssigned_SOC_AreaSud_Rule</fullName>
        <actions>
            <name>PO_TP_Alert_AreaSudAssignedCase</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>PO - TP - TicketProvisioning Case</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>TT - Coda Sud Ordini in Attivazione</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PO_TP_CaseAssigned_SOC_Rule</fullName>
        <actions>
            <name>PO_TP_Alert_SOCAssignedCase</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>PO - TP - TicketProvisioning Case</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>TT - Coda SOC Ordini in Attivazione</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PO_TP_CaseClosed_UserPortal_Rule</fullName>
        <actions>
            <name>PO_TP_Alert_UserPortalClosedCase</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>PO - TP - TicketProvisioning Case</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Chiuso</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Page Layout normal</fullName>
        <actions>
            <name>PL2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Sospeso</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.EOF_Fase__c</field>
            <operation>equals</operation>
            <value>Sospeso BO,Sospeso Tecn.</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Trouble Ticket</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Restore canModify</fullName>
        <actions>
            <name>Restore_canModify</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.canModify__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SN - Data Status In Lavorazione</fullName>
        <actions>
            <name>SN_Data_Status_In_Lavorazione</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 3)AND 2</booleanFilter>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>SN Social Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>In Lavorazione</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>SN_Email_Request</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SN_SocialAssignToQueue</fullName>
        <actions>
            <name>SN_AssignToQueue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(Owner:User.FirstName = &apos;User&apos;,Owner:User.LastName = &apos;Social&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SN_SocialUpdateStatus</fullName>
        <actions>
            <name>SN_Update_Social_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(OR(RecordType.DeveloperName = &apos;SN_Social_Request&apos;,RecordType.DeveloperName = &apos;SN_Email_Request&apos;),OR(PRIORVALUE(OwnerId) =&apos;00G58000003omZf&apos;,PRIORVALUE(OwnerId) =&apos;00G58000003omZp&apos;,PRIORVALUE(OwnerId) =&apos;00G58000002oeVV&apos;,PRIORVALUE(OwnerId) =&apos;00G58000003omZk&apos;), ISCHANGED(OwnerId)  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Tecnico page layout</fullName>
        <actions>
            <name>PL3</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Accettato</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.EOF_Fase__c</field>
            <operation>equals</operation>
            <value>Appuntamento Fissato</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Trouble Ticket</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>UnsetApexContext</fullName>
        <actions>
            <name>UnsetApexContext</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.ApexContext__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Case Subject</fullName>
        <actions>
            <name>Upd_Case_Subject</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Trouble Ticket,SN Social Request</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
