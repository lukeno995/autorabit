<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>CQS_Email_Alert_Grave_Infortunio_Inserted</fullName>
        <description>Email_Alert_Grave_Infortunio_Inserted</description>
        <protected>false</protected>
        <recipients>
            <recipient>roberta.sisti@openfiber.it</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>roberto.patuzzo@openfiber.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CQS_Email_Template/CQS_Email_Alert_Infortunio</template>
    </alerts>
    <alerts>
        <fullName>CQS_Evento_Inserito</fullName>
        <description>Evento Inserito</description>
        <protected>false</protected>
        <recipients>
            <recipient>roberta.sisti@openfiber.it</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>roberto.patuzzo@openfiber.it</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>serena.agresti@hse.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CQS_Email_Template/Incidente_Email_Template</template>
    </alerts>
    <alerts>
        <fullName>CQS_Grave_Incidente_Inserito</fullName>
        <description>Grave Incidente Inserito</description>
        <protected>false</protected>
        <recipients>
            <recipient>roberta.sisti@openfiber.it</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>roberto.patuzzo@openfiber.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CQS_Email_Template/Incidente_Email_Template</template>
    </alerts>
    <alerts>
        <fullName>CQS_PraticaAncoraAperta</fullName>
        <description>CQS_PraticaAncoraAperta</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CQS_Email_Template/OF_CQS_Email_Alert_Danno_Interferenza_Pratica_ancor_Aperta_da_almeno_2_settimane</template>
    </alerts>
    <alerts>
        <fullName>OF_CQS_2Email_Alert_Incidente_AN</fullName>
        <description>Email_Alert_Incidente_AN</description>
        <protected>false</protected>
        <recipients>
            <recipient>rl_gfilottrani@prod.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CQS_Email_Template/Incidente_Email_Template</template>
    </alerts>
    <alerts>
        <fullName>OF_CQS_2Email_Alert_Incidente_FEFCRA</fullName>
        <ccEmails>eleonora.caravello@enel.com</ccEmails>
        <description>Email_Alert_Incidente_FE_FC_RA</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>CQS_Email_Template/Incidente_Email_Template</template>
    </alerts>
    <alerts>
        <fullName>OF_CQS_2Email_Alert_Incidente_Inserted</fullName>
        <description>Email_Alert_Incidente_Inserted</description>
        <protected>false</protected>
        <recipients>
            <recipient>OF_CQS_City_Manager_Centro</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CQS_Email_Template/Incidente_Email_Template</template>
    </alerts>
    <alerts>
        <fullName>OF_CQS_2Email_Alert_Incidente_PA</fullName>
        <description>Email_Alert_Incidente_PA</description>
        <protected>false</protected>
        <recipients>
            <recipient>daniele.dipietrantonio@openfiber.it</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rl_anastri@prod.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CQS_Email_Template/Incidente_Email_Template</template>
    </alerts>
    <alerts>
        <fullName>OF_CQS_2Email_Alert_Incidente_PD</fullName>
        <description>Email_Alert_Incidente_PD</description>
        <protected>false</protected>
        <recipients>
            <recipient>paolo.giardini@openfiber.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CQS_Email_Template/Incidente_Email_Template</template>
    </alerts>
    <alerts>
        <fullName>OF_CQS_Pratica_Danneggiamento_Interferenza_ancora_Aperta_dopo_2_settimane</fullName>
        <description>Pratica Danneggiamento o Interferenza ancora Aperta dopo 2 settimane</description>
        <protected>false</protected>
        <recipients>
            <recipient>OF_CQS_CSE_Centro</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>OF_CQS_Direttore_Lavori_Centro</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>OF_CQS_Responsabile_Lavori_Centro</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CQS_Email_Template/OF_CQS_Email_Alert_Danno_Interferenza_Pratica_ancor_Aperta_da_almeno_2_settimane</template>
    </alerts>
    <alerts>
        <fullName>OF_CQS_Pratica_ancora_Aperta_dopo_2_settimane</fullName>
        <description>Pratica Infortunio ancora Aperta dopo 2 settimane</description>
        <protected>false</protected>
        <recipients>
            <recipient>OF_CQS_CSE_Centro</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>OF_CQS_Direttore_Lavori_Centro</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>OF_CQS_Responsabile_Lavori_Centro</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CQS_Email_Template/OF_CQS_Email_Alert_Infortunio_Pratica_ancora_Aperta_da_almeno_2_settimane</template>
    </alerts>
    <fieldUpdates>
        <fullName>CQS_Controllo_Gravit_Infortunio_Mortale</fullName>
        <field>OF_CQS_Indice_Gravita_Infortunio__c</field>
        <literalValue>Mortale</literalValue>
        <name>Controllo Gravità Infortunio Mortale</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CQS_EV_DataChiusuraEventoAutomatica</fullName>
        <description>Per Danneggiamenti e Interferenze a sottoservizi una volta eseguito l&apos;update dello stato della pratica è necessario popolare la data di chiusura della pratica con la data dell&apos;update</description>
        <field>OF_CQS_Data_Chiusura_Pratica__c</field>
        <formula>Today()</formula>
        <name>CQS_DataChiusuraEventoAutomatica</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CQS_EV_Inf_dataChiusuraPratica</fullName>
        <field>OF_CQS_Data_Chiusura_Pratica__c</field>
        <formula>Today()</formula>
        <name>CQS_EV_Inf_dataChiusuraPratica</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CQS_EV_StatoPraticaChiuso</fullName>
        <description>Per Danneggiamenti e Interferenze a sottoservizi  quando si dichiara se  i lavori di riparazione sono eseguiti dall&apos;ente o dall&apos;impresa fare l&apos;update dello stato della pratica e poi popolare la data di chiusura della pratica</description>
        <field>OF_CQS_Stato_Pratica__c</field>
        <literalValue>Chiuso</literalValue>
        <name>CQS_StatoPraticaChiuso</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Controllo_Gravit_Infortunio_MInore30gg</fullName>
        <field>OF_CQS_Indice_Gravita_Infortunio__c</field>
        <literalValue>&lt; 30gg di prognosi</literalValue>
        <name>Controllo Gravità Infortunio &lt;30gg</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Controllo_Gravit_Infortunio_Maggiore30</fullName>
        <field>OF_CQS_Indice_Gravita_Infortunio__c</field>
        <literalValue>&gt; 30gg di prognosi</literalValue>
        <name>Controllo Gravità Infortunio &gt;30</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Controllo_Maiuscole</fullName>
        <field>OF_CQS_Comune_Text__c</field>
        <formula>UPPER(OF_CQS_Comune_Text__c)</formula>
        <name>Controllo Maiuscole</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Controllo_Maiuscole_2</fullName>
        <field>OF_CQS_Provincia_Evento__c</field>
        <formula>UPPER(OF_CQS_Provincia_Evento__c)</formula>
        <name>Controllo Maiuscole 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OF_CQS_Controllo_Maiuscole_VIA</fullName>
        <field>VIA__c</field>
        <formula>UPPER(VIA__c)</formula>
        <name>Controllo Maiuscole VIA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OF_CQS_Ente_Field_Update</fullName>
        <field>OF_CQS_Ente__c</field>
        <formula>UPPER(OF_CQS_Ente__c )</formula>
        <name>Ente Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OF_CQS_Update_Field_Data_Primo_Conteggio</fullName>
        <field>OF_CQS_Data_Primo_Conteggio__c</field>
        <formula>TODAY()</formula>
        <name>Update Field Data Primo Conteggio</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>upField_Check_GG_Prognosi_ADD</fullName>
        <field>OF_CQS_Giorni_Prognosi_Add_Inseriti__c</field>
        <literalValue>1</literalValue>
        <name>upField Check GG Prognosi ADD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>CQS_Chiusurapratica</fullName>
        <actions>
            <name>CQS_EV_DataChiusuraEventoAutomatica</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CQS_EV_StatoPraticaChiuso</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>OF_CQS_Evento__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Danneggiamento a Terzi,Interferenza a Sotto-servizi</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Riparazione_Danno__c</field>
            <operation>notEqual</operation>
            <value>Non Eseguita</value>
        </criteriaItems>
        <description>Per Danneggiamenti e Interferenze a sottoservizi  quando si dichiara se  i lavori di riparazione sono eseguiti dall&apos;ente o dall&apos;impresa fare l&apos;update dello stato della pratica e poi popolare la data di chiusura della pratica. Utilizzare i due field update</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CQS_DataChiusuraInfortunioAutomatica</fullName>
        <actions>
            <name>CQS_EV_Inf_dataChiusuraPratica</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>OF_CQS_Evento__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Infortunio</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Stato_Pratica__c</field>
            <operation>equals</operation>
            <value>Chiuso</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Data_Chiusura_Pratica__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Quando lo stato di una pratica di infortunio cambia correttamente da aperta a chiuso popolare la data chiusura infortunio con la data odierna</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CQS_Email Alert Incidente Lieve%2FMedia_FERAFC</fullName>
        <actions>
            <name>OF_CQS_2Email_Alert_Incidente_FEFCRA</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND (2 OR 3 OR 4)</booleanFilter>
        <criteriaItems>
            <field>OF_CQS_Evento__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Danneggiamento a Terzi,Interferenza a Sotto-servizi</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.CQS_EV_Progetto_WF_EA__c</field>
            <operation>equals</operation>
            <value>Ferrara Lotto 6</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.CQS_EV_Progetto_WF_EA__c</field>
            <operation>equals</operation>
            <value>Cesena Lotto 10a</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.CQS_EV_Progetto_WF_EA__c</field>
            <operation>equals</operation>
            <value>Ravenna Lotto 5</value>
        </criteriaItems>
        <description>Workflow momentaneo per la gestione dell&apos;invio delle email al CityManager Di Ferrara,Ravenna;Cesena</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CQS_Email Alert Incidente Lieve%2FMedia_UDVE</fullName>
        <active>false</active>
        <booleanFilter>1 AND  (2 OR 3 OR 4)</booleanFilter>
        <criteriaItems>
            <field>OF_CQS_Evento__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Danneggiamento a Terzi,Interferenza a Sotto-servizi</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.CQS_EV_Progetto_WF_EA__c</field>
            <operation>equals</operation>
            <value>Udine Lotto 5</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.CQS_EV_Progetto_WF_EA__c</field>
            <operation>equals</operation>
            <value>Venezia Lotto 1 Venezia Sacca Fisola</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.CQS_EV_Progetto_WF_EA__c</field>
            <operation>equals</operation>
            <value>Venezia Lotto 2 Venezia Mestre Barca</value>
        </criteriaItems>
        <description>Workflow momentaneo per la gestione dell&apos;invio delle email al CityManager Di Udine e Venezia</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CQS_Email Alert Incidente_AN</fullName>
        <actions>
            <name>OF_CQS_2Email_Alert_Incidente_AN</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND (2 OR 3) AND 4</booleanFilter>
        <criteriaItems>
            <field>OF_CQS_Evento__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Danneggiamento a Terzi,Interferenza a Sotto-servizi</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.CQS_EV_Progetto_WF_EA__c</field>
            <operation>equals</operation>
            <value>Ancona Nord - Lotto 9b</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.CQS_EV_Progetto_WF_EA__c</field>
            <operation>equals</operation>
            <value>Ancona Sud - Lotto 9a</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.Skip_Email__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Workflow momentaneo per la gestione dell&apos;invio delle email al CityManager Di Ancona</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CQS_Email Alert Incidente_PA</fullName>
        <actions>
            <name>OF_CQS_2Email_Alert_Incidente_PA</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND (2 OR 3 OR 4) AND 5</booleanFilter>
        <criteriaItems>
            <field>OF_CQS_Evento__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Danneggiamento a Terzi,Interferenza a Sotto-servizi</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.CQS_EV_Progetto_WF_EA__c</field>
            <operation>equals</operation>
            <value>Palermo - Lotto 7 PALERMO - Brancaccio Cusmano Rocca</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.CQS_EV_Progetto_WF_EA__c</field>
            <operation>equals</operation>
            <value>Palermo - Lotto 6a PALERMO</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.CQS_EV_Progetto_WF_EA__c</field>
            <operation>equals</operation>
            <value>Palermo - Lotto 6 PALERMO - Palermo T. Natale</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.Skip_Email__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Workflow momentaneo per la gestione dell&apos;invio delle email al CityManager Di Palermo</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CQS_Email Alert Incidente_PD</fullName>
        <actions>
            <name>OF_CQS_2Email_Alert_Incidente_PD</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND (2 OR 3 OR 4) AND 5</booleanFilter>
        <criteriaItems>
            <field>OF_CQS_Evento__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Danneggiamento a Terzi,Interferenza a Sotto-servizi</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.CQS_EV_Progetto_WF_EA__c</field>
            <operation>equals</operation>
            <value>Padova - Lotto 4</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.CQS_EV_Progetto_WF_EA__c</field>
            <operation>equals</operation>
            <value>Padova - Lotto 5</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.CQS_EV_Progetto_WF_EA__c</field>
            <operation>equals</operation>
            <value>Padova - Lotto 5a</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.Skip_Email__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Workflow momentaneo per la gestione dell&apos;invio delle email al CityManager Di Palermo</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OF_CQS_Alert Pratica Danneggiamento o Interferenza ancora Aperta</fullName>
        <active>false</active>
        <criteriaItems>
            <field>OF_CQS_Evento__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Danneggiamento a Terzi,Interferenza a Sotto-servizi</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Stato_Pratica__c</field>
            <operation>equals</operation>
            <value>Aperta</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>OF_CQS_Pratica_Danneggiamento_Interferenza_ancora_Aperta_dopo_2_settimane</name>
                <type>Alert</type>
            </actions>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>OF_CQS_Pratica_Danneggiamento_Interferenza_ancora_Aperta_dopo_2_settimane</name>
                <type>Alert</type>
            </actions>
            <timeLength>15</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>OF_CQS_Alert Pratica Infortunio ancora Aperta</fullName>
        <active>false</active>
        <criteriaItems>
            <field>OF_CQS_Evento__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Infortunio</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Stato_Pratica__c</field>
            <operation>equals</operation>
            <value>Aperta</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>OF_CQS_Pratica_ancora_Aperta_dopo_2_settimane</name>
                <type>Alert</type>
            </actions>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>OF_CQS_Pratica_ancora_Aperta_dopo_2_settimane</name>
                <type>Alert</type>
            </actions>
            <timeLength>15</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>OF_CQS_Check True GG  Prognosi Add</fullName>
        <actions>
            <name>upField_Check_GG_Prognosi_ADD</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Decesso__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Prognosi_Riservata__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Prognosi_aggiuntiva__c</field>
            <operation>greaterOrEqual</operation>
            <value>1</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>OF_CQS_Controllo Gravità Infortunio %3C30</fullName>
        <actions>
            <name>Controllo_Gravit_Infortunio_MInore30gg</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Giorni_Persi_e__c</field>
            <operation>lessOrEqual</operation>
            <value>30</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Decesso__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>OF_CQS_Controllo Gravità Infortunio %3E30gg</fullName>
        <actions>
            <name>Controllo_Gravit_Infortunio_Maggiore30</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Giorni_Persi_e__c</field>
            <operation>greaterThan</operation>
            <value>30</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Decesso__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>OF_CQS_Controllo Gravità Infortunio Mortale</fullName>
        <actions>
            <name>CQS_Controllo_Gravit_Infortunio_Mortale</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Decesso__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>OF_CQS_Controllo Maiuscole Evento</fullName>
        <actions>
            <name>OF_CQS_Ente_Field_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Comune_Text__c</field>
            <operation>notEqual</operation>
            <value>@@@@</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>OF_CQS_Controllo Maiuscole_WF</fullName>
        <actions>
            <name>Controllo_Maiuscole</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Controllo_Maiuscole_2</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OF_CQS_Controllo_Maiuscole_VIA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Comune_Text__c</field>
            <operation>notContain</operation>
            <value>@@@</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>OF_CQS_Definisci Data Primo Conteggio</fullName>
        <actions>
            <name>OF_CQS_Update_Field_Data_Primo_Conteggio</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Prognosi_Riservata__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Decesso__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Giorni_Prognosi_Add_Inseriti__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OF_CQS_Email Alert Incidente Grave</fullName>
        <actions>
            <name>CQS_Grave_Incidente_Inserito</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>OF_CQS_Evento__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Danneggiamento a Terzi</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Interferenza a Sotto-servizi</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c</field>
            <operation>equals</operation>
            <value>A - Alta</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>OF_CQS_Email Alert Incidente Lieve%2FMedia</fullName>
        <actions>
            <name>OF_CQS_2Email_Alert_Incidente_Inserted</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>OF_CQS_Evento__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Danneggiamento a Terzi,Interferenza a Sotto-servizi</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.CQS_Indice_Gravita_Taglio_Danneggiamento__c</field>
            <operation>equals</operation>
            <value>L - Lieve,M - Media</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OF_CQS_Email Alert Infortunio</fullName>
        <actions>
            <name>CQS_Email_Alert_Grave_Infortunio_Inserted</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND (2 OR 3 OR 4)</booleanFilter>
        <criteriaItems>
            <field>OF_CQS_Evento__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Infortunio</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Indice_Gravita_Infortunio__c</field>
            <operation>equals</operation>
            <value>Mortale</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Indice_Gravita_Infortunio__c</field>
            <operation>equals</operation>
            <value>&gt; 30gg di prognosi</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Giorni_Persi_e__c</field>
            <operation>greaterOrEqual</operation>
            <value>30</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OF_CQS_Nuovo_Evento_Inserito</fullName>
        <actions>
            <name>CQS_Evento_Inserito</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>OF_CQS_Evento__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Bad Practice,Danneggiamento a Terzi,Infortunio,Interferenza a Sotto-servizi</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>OF_CQS_Pratica_ancora_Aperta</fullName>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>OF_CQS_Evento__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Bad Practice in Lavorazione,Danneggiamento a Terzi in Lavorazione,Interferenza a Sotto-servizi in Lavorazione</value>
        </criteriaItems>
        <criteriaItems>
            <field>OF_CQS_Evento__c.OF_CQS_Stato_Pratica__c</field>
            <operation>equals</operation>
            <value>In Lavorazione</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>CQS_PraticaAncoraAperta</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>OF_CQS_Evento__c.CreatedDate</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
