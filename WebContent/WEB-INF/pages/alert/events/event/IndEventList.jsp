<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>

<ps:set name="ivcrud_${_pageRef}" value="iv_crud" />
<ps:hidden id="iv_crud_${_pageRef}" name="iv_crud" />
<jsp:include page="/WEB-INF/pages/common/login/InfoBar.jsp" />

<ps:url id="individualEventGrid" escapeAmp="false" action="IndividualEventListAction_returnIndividualEventDataForGrid" namespace="/path/alert/events/event">
	<ps:param name="iv_crud" value="ivcrud_${_pageRef}"></ps:param>
	 <ps:param name="_pageRef" value="_pageRef"></ps:param>
</ps:url>


<psjg:grid 
	id="individualEventGridTbl_Id_${_pageRef}" 
	caption=" "
	href="%{individualEventGrid}" 
	dataType="json" 
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
	altRows="true" 
	ondblclick="individualEventList_onDbClickedEvent()"
	addfunc="individualEventList_NewClicked"
	shrinkToFit="true"
	autowidth="true"
	height="125"
	sortorder="DESC"
	sortname="EVT_ID">


	<psjg:gridColumn id="EVT_ID_${_pageRef}" colType="number" name="EVT_ID"
		index="EVT_ID" title="%{getText('event_id_key')}" editable="false"
		search="true" leadZeros="" />

	<psjg:gridColumn id="DESC_ENG_${_pageRef}" colType="text"
		name="DESC_ENG" index="DESC_ENG" title="%{getText('desceng_key')}"
		editable="false" search="true" />
		
	<psjg:gridColumn id="EVT_TYPE_${_pageRef}" colType="text"
		name="EVT_TYPE" index="EVT_TYPE" title="%{getText('evt_type_key')}"
		editable="false" search="true" />
	
	<ps:if test='_pageRef == "EVT01S"'>
		<psjg:gridColumn 
			id="TO_BE_STATUS_BY_${_pageRef}" 
			colType="text" 
			name="TO_BE_STATUS_BY"
			index="STATUS" 
			title="%{getText('alrt_suspended_by_key')}" 
			editable="false"
			search="true"  />
	</ps:if>
	<ps:if test='_pageRef == "EVT01A"'>
		<psjg:gridColumn 
			id="TO_BE_STATUS_BY_${_pageRef}" 
			colType="text" 
			name="TO_BE_STATUS_BY"
			index="STATUS" 
			title="%{getText('reactivated_by')}" 
			editable="false"
			search="true"  />
	</ps:if>
	<ps:if test='_pageRef == "EVT01S" || _pageRef == "EVT01A"'>
		<psjg:gridColumn id="STATUS_${_pageRef}" colType="text" name="TO_BE_STATUS"
			index="STATUS" title="%{getText('Status_key')}" editable="false"
			search="true" />
	</ps:if>
	<ps:else>
		<psjg:gridColumn id="STATUS_${_pageRef}" colType="text" name="STATUS"
			index="STATUS" title="%{getText('Status_key')}" editable="false"
			search="true" />
	</ps:else>

</psjg:grid>


<div id="individualEventMaintPage_id_<ps:property value="_pageRef" escapeHtml="true"/>" style="width: 100%;">
	 <ps:if test='iv_crud == "R"'>
		<%@include file="/WEB-INF/pages/alert/events/event/IndEventMaint.jsp"%>
	</ps:if>
</div>


<script type="text/javascript">
	$("#gview_individualEventGridTbl_Id_${_pageRef} div.ui-jqgrid-titlebar").hide();
	$.struts2_jquery.require("common.js", null, jQuery.contextPath+ "/path/js/alert/common/");
	$.struts2_jquery.require("IndividualEventList.js", null, jQuery.contextPath+ "/path/js/alert/events/event/");
	$.struts2_jquery.require("ParamGrid.js", null, jQuery.contextPath+ "/path/js/alert/events/event/");
</script>