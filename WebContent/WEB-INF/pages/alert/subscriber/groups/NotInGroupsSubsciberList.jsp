<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@taglib prefix="pt" uri="/path-toolbar-tags"%>

<ps:hidden id="selSerialNo_${_pageRef}"></ps:hidden>
<ps:hidden id="all_rows_${_pageRef}" ></ps:hidden>
<ps:hidden id="changetags_${_pageRef}"/>
<ps:url id="subNotInGrpGrid" escapeAmp="false"
	action="GroupsNotSubListAction_loadNotSubGridData"
	namespace="/path/alert/subscriber/groups">
	<ps:param name="iv_crud" value="ivcrud_${_pageRef}"></ps:param>
	<ps:param name="groupId" value="groupsSubscriberCO.alrtGrpVO.GRP_ID"></ps:param>
</ps:url>

<psjg:grid id="subNotInGrp_${_pageRef}"
	caption="%{getText('sub_not_in_grp_key')}" 
	href="%{subNotInGrpGrid}"
	dataType="json" 
	hiddengrid='false' 
	pager="false" 
	sortable="true"
	filter="true" 
	gridModel="gridModel" 
	rowNum="100" 
	viewrecords="true"
	rowList="5,10,15,20,50,100" 
	navigator="true"
	navigatorDelete="false" 
	navigatorEdit="false" 
	navigatorRefresh="false"
	navigatorAdd="false" 
	navigatorSearch="false" 
	altRows="true"
	multiselect="true" 
	addfunc="" 
	shrinkToFit="false" 
	autowidth="false"
	height="200"
	width="500" 
	dragLockColName = '%{_pageRef == "M009M" ? "s_approlusrVO.TO_BE_DELETED" : ""}'
    dragLockRowColor = "cyan" 
	dragLockColVal   = "Y"
	onSelectRowTopics="dynamicGridSelectRowFuncGroup"
	onSelectAllTopics="dynamicGridSelectAllFuncGroup"
	onGridCompleteTopics="onAfterBatchDetailScreenLoadGroup" 
	onEditInlineBeforeTopics="onEditInlineBeforeTopicsFuncGroup"
	loadonce="true">


	<psjg:gridColumn id="SUB_ID_${_pageRef}" colType="number" name="alertSubVO.ID"
		index="alertSubVO.ID" width="80" title="%{getText('sub_id_key')}"
		editable="false" sortable="true" search="true" hidden="false" />

	<psjg:gridColumn id="BRIEF_NAME_${_pageRef}" colType="text"
		name="alertSubLangVO.BRIEF_NAME" index="alertSubLangVO.BRIEF_NAME" width="250"
		title="%{getText('brief_name_key')}" editable="false" sortable="true"
		search="true" hidden="false" />
		
	<psjg:gridColumn id="CIF_NO_${_pageRef}" colType="text"
		name="alertSubVO.CIF_NO" index="alertSubVO.CIF_NO" width="80"
		title="%{getText('cif_no_key')}" editable="false" sortable="true"
		search="true" hidden="false" />
		
	<psjg:gridColumn id="CIF_TYPE_${_pageRef}" colType="text"
		name="CIF_TYPE" index="CIF_TYPE" width="100"
		title="%{getText('Cif_Type_key')}" editable="false" sortable="true"
		search="true" hidden="%{enable_omni}" />
		
	<psjg:gridColumn id="USR_ID_${_pageRef}" colType="text"
		name="alertSubVO.USR_ID" index="alertSubVO.USR_ID" width="120"
		title="%{getText('user_id_key')}" editable="false" sortable="true"
		search="true" hidden="false" />
			
	<psjg:gridColumn id="CHANNEL_END_USR_ID_${_pageRef}" colType="text"
		name="alertSubVO.CHANNEL_END_USR_ID" index="alertSubVO.CHANNEL_END_USR_ID" width="120"
		title="%{getText('channel_end_user_key')}" editable="false" sortable="true"
		search="true" hidden="false" />

	<psjg:gridColumn id="LINE_NO_${_pageRef}" colType="text" name="LINE_NO"
		index="LINE_NO" width="250" title="%{getText('LINE_NO')}"
		editable="false" sortable="false" search="false" hidden="true" />
		
	<psjg:gridColumn id="STATUS_${_pageRef}" colType="text" name="STATUS"
		index="STATUS" width="100" title="%{getText('status_key')}"
		editable="false" sortable="true" search="true" hidden="true" />
		
	<psjg:gridColumn id="selectedRow_${_pageRef}" colType="text" name="selectedRow"
		index="selectedRow" width="250" title="%{getText('selectedRows')}"
		editable="false" sortable="false" search="false" hidden="true" />

</psjg:grid>

<script type="text/javascript">
	$.struts2_jquery.require("SubNotInGroupsSubscriberList.js", null,
			jQuery.contextPath + "/path/js/alert/subscriber/groups/");

	$("#subNotInGrp_${_pageRef}").subscribe("dynamicGridSelectRowFuncGroup",
			function(obj)
			{
				if ("${_pageRef}" =='GRP00MT' && $("#status_"+_pageRef).val()!='Approved')
				{
					dynamicGridSelectRowFuncGroup(obj);
				}
				if ("${_pageRef}" =='GRP00P')
				{
					dynamicGridSelectRowFuncAprGroup(obj);
				}
			})
	$("#subNotInGrp_${_pageRef}").subscribe("dynamicGridSelectAllFuncGroup",
			function(obj)
			{
				dynamicGridSelectAllFuncGroup(obj);
			})
	$("#subNotInGrp_${_pageRef}").subscribe("onAfterBatchDetailScreenLoadGroup",
			function(obj)
			{
				onAfterBatchDetailScreenLoadGroup(obj);
			})
	$("#subNotInGrp_${_pageRef}").subscribe("onEditInlineBeforeTopicsFuncGroup",
			function(obj)
			{

				var $table = $("#subNotInGrp_" + _pageRef);
				var rowId = obj.originalEvent.id;
				var selectedRowId = $table.jqGrid('getGridParam', 'selarrrow');
				if (obj.originalEvent.status == false)
				{
					$table.jqGrid('saveRow', rowId);
				}

			})
</script>