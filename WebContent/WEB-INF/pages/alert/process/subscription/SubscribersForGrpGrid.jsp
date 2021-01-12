<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>

<ps:url id="individualSubscriberGrid" escapeAmp="false" action="IndividualSubscriberListAction_loadData" namespace="/path/alert/subscriber/individual">
	<ps:param name="iv_crud" value='"R"'></ps:param>
    <ps:param name="indSubSC.groupId" value="subscriptionSC.GRP_ID"></ps:param>
</ps:url> 

<psjg:grid 
	id="subscriberForGrpGridTbl_Id_${_pageRef}"
	href="%{individualSubscriberGrid}" 
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
	height="125" 
	sortname="ID"
	sortorder="desc"
	>
		
	<psjg:gridColumn id="ID_${_pageRef}" colType="number"
		name="ID" index="ID"
		title="%{getText('ID_key')}" editable="false" sortable="true"
		search="true" leadZeros="" width="20" />
		
	<psjg:gridColumn id="CIF_NO_${_pageRef}" colType="number"
		name="CIF_NO" index="CIF_NO"
		title="%{getText('cif_number_key')}" editable="false"
		sortable="true" search="true" width="20" />
		
    <psjg:gridColumn id="USR_ID_${_pageRef}" colType="text"
		name="USR_ID" index="USR_ID" title="%{getText('user_id_key')}"
		editable="false" sortable="true" search="true" width="30" />
		
	<psjg:gridColumn id="BRIEF_NAME_${_pageRef}" colType="text"
		name="BRIEF_NAME" index="BRIEF_NAME"
		title="%{getText('brief_name_key')}" editable="false"
		sortable="true" search="true" width="40"  />
		
	<psjg:gridColumn id="CHANNEL_END_USR_ID_${_pageRef}" colType="text"
		name="CHANNEL_END_USR_ID" index="CHANNEL_END_USR_ID"
		title="%{getText('channel_end_user_key')}" editable="false"
		sortable="true" search="true" width="30" />

	<psjg:gridColumn id="STATUS_${_pageRef}" colType="text"
		name="STATUS_DESC" index="STATUS_DESC" title="%{getText('Status_key')}"
		editable="false" sortable="true" search="true" width="20" />
</psjg:grid>