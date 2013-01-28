<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Event_Site_Location</fullName>
        <field>EV_SiteLocation__c</field>
        <formula>SUBSTITUTE( EV_Title__c, &apos; &apos;, &apos;&apos;)</formula>
        <name>Event Site Location</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Event Site Location Rule</fullName>
        <actions>
            <name>Event_Site_Location</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event__c.EV_HostingTimeZone__c</field>
            <operation>equals</operation>
            <value>Indian Standard Time(IST),Eastern Time(USA),Central Time(USA),Pacific Time(USA),Mountain Time(USA)</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
