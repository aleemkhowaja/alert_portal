<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt" uri="/path-toolbar-tags"%>

<ps:if test='(subscriptionCO.subscriptionTypeFlag=="SE" || subscriptionCO.subscriptionTypeFlag=="SP") && (subscriptionCO.ivCrud == "R") '>
		<%@include file="SubscribersList.jsp"%>
<br/>
</ps:if>
<ps:if test='(subscriptionCO.subscriptionTypeFlag=="EG" || subscriptionCO.subscriptionTypeFlag=="GP") && (subscriptionCO.ivCrud == "R")'>
		<%@include file="GroupsList.jsp"%>
<br/>
</ps:if>

<ps:if test='(subscriptionCO.subscriptionTypeFlag=="SE" || subscriptionCO.subscriptionTypeFlag=="EG") && (subscriptionCO.ivCrud == "R")'>
		<%@include file="EventsList.jsp"%>
<br/>
<psj:submit id="subscriptionMaint_populate_sub_${_pageRef}" button="true" freezeOnSubmit="true" onclick="populateSubscription()">
 	<ps:label key="populate_subscription_key" for="subscriptionMaint_populate_sub_${_pageRef}"/>
 </psj:submit>
<br/>
</ps:if>
<ps:if test='(subscriptionCO.subscriptionTypeFlag=="SP" || subscriptionCO.subscriptionTypeFlag=="GP") && (subscriptionCO.ivCrud == "R")'>
		<%@include file="PackageList.jsp"%>
<br/>
<psj:submit id="subscriptionMaint_populate_sub_${_pageRef}" button="true" freezeOnSubmit="true" onclick="populateSubscription()">
 	<ps:label key="populate_subscription_key" for="subscriptionMaint_populate_sub_${_pageRef}"/>
 </psj:submit>
<br/>
</ps:if>

<ps:if test='subscriptionCO.subscriptionTypeFlag=="SE"'>
		<%@include file="SubscribersEventsList.jsp"%>
</ps:if>
<ps:if test='subscriptionCO.subscriptionTypeFlag=="SP"'>
		<%@include file="SubscribersPackageList.jsp"%>
</ps:if>
<ps:if test='subscriptionCO.subscriptionTypeFlag=="EG"'>
		<%@include file="GroupsEventsList.jsp"%>
</ps:if>
<ps:if test='subscriptionCO.subscriptionTypeFlag=="GP"'>
		<%@include file="GroupsPackageList.jsp"%>
</ps:if>