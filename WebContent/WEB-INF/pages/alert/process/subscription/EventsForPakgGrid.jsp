<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>

<ps:url id="individualEventGrid" escapeAmp="false" action="IndividualEventListAction_returnIndividualEventListForPackage" namespace="/path/alert/events/event">
	<ps:param name="indEventSC.packageId" value="subscriptionSC.PKG_ID"></ps:param>
	<ps:param name="_pageRef" value="_pageRef"></ps:param>
</ps:url>

<psjg:grid 
	id="eventsForPakgGridTbl_Id_${_pageRef}" 
	href="%{individualEventGrid}" 
	dataType="json"
	caption=""
	hiddengrid="false"
	pager="true" 
	sortable="true" 
	filter="true" 
	gridModel="gridModel"
	rowNum="5" 
	rowList="5,10,15,20"
	viewrecords="true"
	navigator="true"
	navigatorDelete="false" 
	navigatorEdit="false" 
	navigatorRefresh="true"
	navigatorAdd="false" 
	navigatorSearch="true"
	navigatorSearchOptions="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
	altRows="true" 
	ondblclick=""
	addfunc="" 
	height="125" >

	<psjg:gridColumn id="EVT_ID_${_pageRef}" colType="number" name="EVT_ID"
		index="EVT_ID" title="%{getText('event_id_key')}" editable="false"
		search="true" leadZeros="" />

	<psjg:gridColumn id="DESC_ENG_${_pageRef}" colType="text"
		name="DESC_ENG" index="DESC_ENG" title="%{getText('desceng_key')}"
		editable="false" search="true" />
		
	<psjg:gridColumn id="EVT_TYPE_${_pageRef}" colType="text"
		name="EVT_TYPE" index="EVT_TYPE" title="%{getText('evt_type_key')}"
		editable="false" search="true" />
	
	<psjg:gridColumn id="STATUS_${_pageRef}" colType="text" name="STATUS"
		index="STATUS" title="%{getText('Status_key')}" editable="false"
		search="true" />

</psjg:grid>