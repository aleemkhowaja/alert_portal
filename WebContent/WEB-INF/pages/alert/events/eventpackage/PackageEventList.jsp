<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>

<ps:set name="ivcrud_${_pageRef}" value="iv_crud" />
<ps:hidden id="iv_crud_${_pageRef}" name="iv_crud" />
<jsp:include page="/WEB-INF/pages/common/login/InfoBar.jsp" />

<ps:url id="packageEventGrid" escapeAmp="false"
	action="PackageEventListAction_loadData"
	namespace="/path/alert/events/eventpackage">
	<ps:param name="iv_crud" value="ivcrud_${_pageRef}"></ps:param>
	<ps:param name="pkgId" value="packagEventCO.alrtPkgVO.PKG_ID"></ps:param>
</ps:url>

<psjg:grid id="packageEventGridTbl_Id_${_pageRef}" caption=" "
	href="%{packageEventGrid}" dataType="json"
	hiddengrid='%{iv_crud == "R"}' pager="true" sortable="true"
	filter="true" gridModel="gridModel" rowNum="5" rowList="5,10,15,20"
	viewrecords="true" navigator="true" navigatorDelete="false"
	navigatorEdit="false" navigatorRefresh="false" navigatorAdd="false"
	navigatorSearch="true"
	navigatorSearchOptions="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
	altRows="true" ondblclick="packageEvent_onDbClickedEvent()"
	addfunc="addRowGrid_PkgEvt" shrinkToFit="true" height="125"
	sortorder="DESC"
	sortname="PKG_ID">

	<psjg:gridColumn id="PKG_ID_${_pageRef}" colType="number" name="PKG_ID"
		index="PKG_ID" title="%{getText('package_id_key')}" editable="false"
		sortable="true" search="true" leadZeros="" />

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
		sortable="true" search="true" />
</psjg:grid>

<div id="packageEventMaintPage_id_<ps:property value="_pageRef" escapeHtml="true"/>"  style="width: 100%;">
	<ps:if test='iv_crud == "R"'>
		<%@include
			file="/WEB-INF/pages/alert/events/eventpackage/PackageEventMaint.jsp"%>
	</ps:if>
</div>

<script type="text/javascript">
	$.struts2_jquery.require("PackageEventList.js", null, jQuery.contextPath
			+ "/path/js/alert/events/eventpackage/");
	$("#gview_packageEventGridTbl_Id_" + _pageRef + " div.ui-jqgrid-titlebar")
			.hide();
</script>

