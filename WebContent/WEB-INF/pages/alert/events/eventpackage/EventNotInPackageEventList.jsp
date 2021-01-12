<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>

<ps:hidden id="changetags_${_pageRef}"/>
<ps:url id="evtNotInPkgGrid" escapeAmp="false"
	action="EventNotInPackageListAction_loadEvtNotInPkgData"
	namespace="/path/alert/events/eventpackage">
	<ps:param name="iv_crud" value="ivcrud_${_pageRef}"></ps:param>
	<ps:param name="pkgId" value="packageEventCO.alrtPkgVO.PKG_ID"></ps:param>
</ps:url>

<psjg:grid id="evtNotInPkg_${_pageRef}"
	caption="%{getText('evt_not_in_pkg_key')}" 
	href="%{evtNotInPkgGrid}"
	dataType="json" 
	hiddengrid='false' 
	pager="false" 
	sortable="true"
	filter="true" 
	gridModel="gridModel" 
	rowNum="1000000" 
	viewrecords="true"
	navigator="true" 
	navigatorDelete="false" 
	navigatorEdit="false"
	navigatorRefresh="false"
	navigatorAdd="false" 
	navigatorSearch="false"
	altRows="false" 
	multiselect="true" 
	addfunc="" 
	shrinkToFit="false"
	height="300" 
	width="400" 
	onSelectRowTopics="dynamicGridSelectRowFunc2Pkg"
	onSelectAllTopics="dynamicGridSelectAllFunc2Pkg"
	sortorder="ASC"
	sortname="EVT_ID"
	loadonce="true">


	<psjg:gridColumn 
		id="EVT_ID_${_pageRef}" 
		colType="number" 
		name="EVT_ID"
		index="EVT_ID" 
		width="150" 
		title="%{getText('event_id_key')}"
		editable="false" 
		sortable="true" 
		search="true" 
		hidden="false" 
		key="true" />

	<psjg:gridColumn 
		id="EVT_TYPE_${_pageRef}" 
		colType="text"
		name="EVT_TYPE" 
		index="EVT_TYPE" 
		width="90"
		title="%{getText('evt_type_key')}" 
		editable="false" 
		sortable="true"
		search="true" 
		hidden="false" />

	<psjg:gridColumn 
		id="DESCRIPTION_${_pageRef}" 
		colType="text"
		name="DESCRIPTION" 
		index="DESCRIPTION" 
		width="150"
		title="%{getText('DESC_NAME_KEY')}" 
		editable="false" 
		sortable="true"
		search="true" 
		hidden="false" />
	
	<psjg:gridColumn 
		id="EVT_STATUS_${_pageRef}" 
		colType="text"
		name="STATUS" 
		index="STATUS" 
		width="90"
		title="%{getText('status_key')}" 
		editable="false" 
		sortable="true"
		search="true" 
		hidden="false" />
		
	<psjg:gridColumn 
		id="LINE_NO_${_pageRef}" 
		colType="text" 
		name="LINE_NO"
		index="LINE_NO" 
		width="250" 
		title="%{getText('LINE_NO')}"
		editable="false" 
		sortable="false" 
		search="false" 
		hidden="true" />

	<psjg:gridColumn 
		id="EVT_MODE_${_pageRef}" 
		colType="text"
		name="EVT_MODE" 
		index="EVT_MODE" 
		width="250"
		title="%{getText('EVT_MODE')}" 
		editable="false" 
		sortable="false"
		search="false" 
		hidden="true" />
</psjg:grid>

<script type="text/javascript">

	$.struts2_jquery.require("PackageEventMaint.js", null,jQuery.contextPath + "/path/js/alert/events/eventpackage/");
	
	$("#evtNotInPkg_${_pageRef}").subscribe("dynamicGridSelectRowFunc2Pkg",
	function(obj)
	{
		if ("${_pageRef}" =='PKG00MT')
		{
			dynamicGridSelectRowFunc2Pkg(obj);
		}
		if ("${_pageRef}" =='PKG00P')
		{
			dynamicGridSelectRowFunc2AprPkg(obj);
		}
	})
	
	$("#evtNotInPkg_${_pageRef}").subscribe("dynamicGridSelectAllFunc2Pkg",
	function(obj)
	{
		dynamicGridSelectAllFunc2Pkg(obj);
	})
</script>
