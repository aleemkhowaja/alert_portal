<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>

<ps:set name="ivcrud_${_pageRef}" value="iv_crud" />
<ps:hidden id="iv_crud_${_pageRef}" name="iv_crud"/>
<jsp:include page="/WEB-INF/pages/common/login/InfoBar.jsp" />
 <ps:url id="groupsSubscriberGrid" escapeAmp="false"
	action="GroupsListAction_loadData" namespace="/path/alert/subscriber/groups">
	<ps:param name="iv_crud" value="ivcrud_${_pageRef}"></ps:param>
	<ps:param name="grpId" value="groupsSubscriberCO.alrtGrpVO.GRP_ID"></ps:param>
</ps:url>

<psjg:grid 
	id="groupsSubscriberGridTbl_Id_${_pageRef}"
	href="%{groupsSubscriberGrid}" 
	dataType="json" 
	caption=" "
	loadonce="false"
	hiddengrid='%{iv_crud == "R"}' 
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
	navigatorRefresh="false" 
	navigatorAdd="false"
	navigatorSearch="true"
	navigatorSearchOptions="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
	altRows="true" ondblclick="groupsSubscriber_onDbClickedEvent()"
	addfunc="addRowGrid_GrpSub" 
	shrinkToFit="true" 
	height="125"
	sortorder="DESC"
	sortname="GRP_ID"
	>

	<psjg:gridColumn id="GRP_ID_${_pageRef}" colType="number" name="GRP_ID"
		index="GRP_ID" title="%{getText('Group_ID_key')}" editable="false"
		sortable="true" search="true" leadZeros="" width="80"/>

	<psjg:gridColumn id="BRIEF_DESC_ENG_${_pageRef}" colType="text"
		name="BRIEF_DESC_ENG" index="BRIEF_DESC_ENG"
		title="%{getText('brief_eng_desc_key')}" editable="false"
		sortable="true" search="true" />

	<psjg:gridColumn id="BRIEF_DESC_ARAB_${_pageRef}" colType="text"
		name="BRIEF_DESC_ARAB" index="BRIEF_DESC_ARAB"
		title="%{getText('brief_arab_desc_key')}" editable="false"
		sortable="true" search="true" />

	<psjg:gridColumn id="LONG_DESC_ENG_${_pageRef}" colType="text"
		name="LONG_DESC_ENG" index="LONG_DESC_ENG"
		title="%{getText('long_eng_desc_key')}" editable="false"
		sortable="true" search="true" />

	<psjg:gridColumn id="LONG_DESC_ARAB_${_pageRef}" colType="text"
		name="LONG_DESC_ARAB" index="LONG_DESC_ARAB"
		title="%{getText('long_arab_desc_key')}" editable="false"
		sortable="true" search="true" />

	<psjg:gridColumn id="CREATED_BY_${_pageRef}" colType="text"
		name="CREATED_BY" index="CREATED_BY" title="%{getText('CREATED_BY')}"
		editable="false" sortable="true" hidden="true" search="true" />

	<psjg:gridColumn id="DATE_CREATED_${_pageRef}" colType="Date"
		name="DATE_CREATED" index="DATE_CREATED"
		title="%{getText('DATE_CREATED')}" editable="false" sortable="true"
		hidden="true" search="true" />
		
	<psjg:gridColumn id="STATUS_${_pageRef}" colType="text" name="STATUS"
		index="STATUS" title="%{getText('Status_key')}" editable="false"
		sortable="true" search="true"  width="80"/>
</psjg:grid>

<div id="groupsSubscriberMaintPage_id_<ps:property value="_pageRef" escapeHtml="true"/>"  style="width: 100%;">
 <ps:if test='iv_crud == "R"'>
	<%@include file="/WEB-INF/pages/alert/subscriber/groups/GroupsSubscriberMaint.jsp"%>
</ps:if>
</div>

<script type="text/javascript">
$.struts2_jquery.require("GroupsSubscriberList.js", null, jQuery.contextPath+ "/path/js/alert/subscriber/groups/");
$.struts2_jquery.require("common.js", null, jQuery.contextPath + "/path/js/alert/common/");

$("#gview_groupsSubscriberGridTbl_Id_"+_pageRef+" div.ui-jqgrid-titlebar").hide();


	$("#groupsSubscriberGridTbl_Id_"+_pageRef).subscribe("setGridLayout",function(rowObj)
	{
		common_setLayout("groupsSubscriberGridTbl_Id");		
	});
</script>


