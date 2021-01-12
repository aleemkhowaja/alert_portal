<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<jsp:include page="/WEB-INF/pages/common/login/InfoBar.jsp" />


<ps:set name="ivcrud_${_pageRef}"    value="iv_crud"/>
<ps:hidden id="iv_crud_${_pageRef}"  name="iv_crud"/>

<ps:url id="urlreportQueryListGrid" escapeAmp="false"
	action="ReportQueryListAction_loadReportQueryGrid"
	namespace="/path/reportQuery">
	<ps:param name="iv_crud" value="ivcrud_${_pageRef}"></ps:param>
	<ps:param name="_pageRef" value="_pageRef"></ps:param>
</ps:url>
<psjg:grid id="reportQueryListGridTbl_Id_${_pageRef}" caption=" "
	href="%{urlreportQueryListGrid}" dataType="json" hiddengrid='%{iv_crud== "R"}'
	pager="true" sortable="true" filter="true" gridModel="gridModel"
	rowNum="5" rowList="5,10,15,20" viewrecords="true" navigator="true"
	navigatorDelete="false" navigatorEdit="false" navigatorAdd="false"
	navigatorSearch="true"
	navigatorSearchOptions="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
	altRows="true" ondblclick="reportQueryList_onDbClickedEvent()"
	addfunc="reportQueryList_onAddClicked" autowidth="true">

	<psjg:gridColumn name="reportQueryVO.REP_QUER_ID" id="REP_QUER_ID"
		searchoptions="{sopt:['eq','ne','lt','gt','le','ge']}"
		index="REP_QUER_ID" colType="number" title="%{getText('Code_key')}"
		sortable="true" search="true" key="true" />
	<psjg:gridColumn name="reportQueryVO.QUERY_ID" id="QUERY_ID"
		searchoptions="{sopt:['eq','ne','lt','gt','le','ge']}"
		index="QUERY_ID" colType="number" title="%{getText('queryIdkey')}"
		sortable="true" search="true" key="true" />
	<psjg:gridColumn name="statusDesc" id="STATUS_DESC"
		searchoptions="{sopt:['eq','ne','bw','bn','ew','en','cn','nc']}"
		index="STATUS_DESC" colType="text" title="%{getText('Status_key')}"
		sortable="true" />
	<psjg:gridColumn name="queryDesc" id="QUERY_DESC"
		searchoptions="{sopt:['eq','ne','bw','bn','ew','en','cn','nc']}"
		index="QUERY_DESC" colType="text" title="%{getText('queryName')}"
		sortable="true" />
	<psjg:gridColumn id="SUBSC_DESC" name="subscrDesc"
		index="SUBSCR_DESC"
		searchoptions="{sopt:['eq','ne','bw','bn','ew','en','cn','nc']}"
		colType="text" title="%{getText('type_key')}" editable="false"
		sortable="true" search="true" />
	<psjg:gridColumn id="QYERY_TYPE" name="reportQueryVO.QYERY_TYPE"
		index="QYERY_TYPE"
		searchoptions="{sopt:['eq','ne','bw','bn','ew','en','cn','nc']}"
		colType="text" title="%{getText('QYERY_TYPE_key')}" editable="false"
		sortable="true" search="true" hidden="true"/>
	<psjg:gridColumn id="STATUS"
		searchoptions="{sopt:['eq','ne','bw','bn','ew','en','cn','nc']}"
		colType="text" name="reportQueryVO.STATUS" index="STATUS"
		title="%{getText('STATUS_key')}" hidden="true" />

</psjg:grid>
<div id="reportQueryListMaintDiv_id_<ps:property value="_pageRef" escapeHtml="true"/>"  style="width: 100%;">
	<ps:if test='iv_crud == "R"'>
		<%@include file="ReportQueryMaint.jsp"%>
	</ps:if>
</div>
<script type="text/javascript">
	$.struts2_jquery.require("ReportQueryList.js,ReportQueryMaint.js", null,
			jQuery.contextPath + "/path/js/reportquery/");
	$(
			"#gview_reportQueryListGridTbl_Id_" + _pageRef
					+ " div.ui-jqgrid-titlebar").hide();
</script>