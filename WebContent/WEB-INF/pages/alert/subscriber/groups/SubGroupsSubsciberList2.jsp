<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@taglib prefix="pt" uri="/path-toolbar-tags"%>


<ps:hidden id="selSerialNo2_${_pageRef}"></ps:hidden>
<ps:hidden id="all_rows2_${_pageRef}" ></ps:hidden>
<ps:hidden id="changetags_${_pageRef}"/>
<ps:url id="subInGrpGrid" escapeAmp="false"
	action="GroupsSubListAction_loadSubGridData"
	namespace="/path/alert/subscriber/groups">
	<ps:param name="iv_crud" value="ivcrud_${_pageRef}"></ps:param>
	<ps:param name="groupId" value="groupsSubscriberCO.alrtGrpVO.GRP_ID"></ps:param>
</ps:url>

<psjg:grid id="subInGrp_${_pageRef}"
	caption="%{getText('sub_in_grp_key')}" href="%{subInGrpGrid}"
	dataType="json" hiddengrid='false' pager="true" sortable="true"
	filter="true" gridModel="gridModel" rowNum="100" viewrecords="true"
	rowList="5,10,15,20,50,100" loadonce="false"
	navigator="true" navigatorDelete="false" navigatorEdit="false"
	navigatorRefresh="false" navigatorAdd="false" navigatorSearch="false"
	altRows="false" multiselect="true" addfunc="" shrinkToFit="true"
	height="300" width="500"
	onSelectRowTopics="dynamicGridSelectRowFunc2Group"
	onSelectAllTopics="dynamicGridSelectAllFunc2Group"
	onGridCompleteTopics="onAfterBatchDetailScreenLoad2Group" 
	onEditInlineBeforeTopics="onEditInlineBeforeTopicsFunc2Group"
	sortorder="ASC"
	sortname="SUB_ID">


	<psjg:gridColumn id="SUB_ID_${_pageRef}" colType="number" name="alertSubVO.ID"
		index="SUB_ID" width="150" title="%{getText('sub_id_key')}"
		editable="false" sortable="true" search="true" hidden="false" />

	<psjg:gridColumn id="BRIEF_NAME_${_pageRef}" colType="text"
		name="alertSubLangVO.BRIEF_NAME" index="BRIEF_NAME" width="250"
		title="%{getText('brief_name_key')}" editable="false" sortable="true"
		search="true" hidden="false" />
			<psjg:gridColumn id="CIF_NO_${_pageRef}" colType="text"
		name="alrtSubVO.CIF_NO" index="CIF_NO" width="250"
		title="%{getText('cif_no_key')}" editable="false" sortable="true"
		search="true" hidden="false" />
		
			<psjg:gridColumn id="USR_ID_${_pageRef}" colType="text"
		name="alrtSubVO.USR_ID" index="USR_ID" width="250"
		title="%{getText('user_id_key')}" editable="false" sortable="true"
		search="true" hidden="false" />
			<psjg:gridColumn id="CHANNEL_END_USR_ID_${_pageRef}" colType="text"
		name="alrtSubVO.CHANNEL_END_USR_ID" index="CHANNEL_END_USR_ID" width="250"
		title="%{getText('channel_end_user_id_key')}" editable="false" sortable="true"
		search="true" hidden="false" />
		
	<psjg:gridColumn id="LINE_NO_${_pageRef}" colType="text" name="LINE_NO"
		index="LINE_NO" width="250" title="%{getText('LINE_NO')}"
		editable="false" sortable="false" search="false" hidden="true" />
		
	<psjg:gridColumn id="selectedRow_${_pageRef}" colType="text" name="selectedRow"
		index="selectedRow" width="250" title="%{getText('selectedRows')}"
		editable="false" sortable="false" search="false" hidden="true" />

</psjg:grid>


<script type="text/javascript">
	$.struts2_jquery.require("SubInGroupsSubscriberList.js", null,
			jQuery.contextPath + "/path/js/alert/subscriber/groups/");
	$("#subInGrp_${_pageRef}").subscribe("dynamicGridSelectRowFunc2Group",
			function(obj)
			{
				if ("${_pageRef}" =='GRP00MT')
				{
					dynamicGridSelectRowFunc2Group(obj);
				}
				if ("${_pageRef}" =='GRP00P')
				{
					dynamicGridSelectRowFunc2AprGroup(obj);
				}
				if ("${_pageRef}" =='GRP00MA')
				{
					dynamicGridSelectRowFunc2Group(obj);
				}
			})
			
	$("#subInGrp_${_pageRef}").subscribe("dynamicGridSelectAllFunc2Group",
			function(obj)
			{
				dynamicGridSelectAllFunc2Group(obj);
			})
	$("#subInGrp_${_pageRef}").subscribe("onAfterBatchDetailScreenLoad2Group",
			function(obj)
			{
				onAfterBatchDetailScreenLoad2Group(obj);
			})
	$("#subInGrp_${_pageRef}").subscribe("onEditInlineBeforeTopicsFunc2Group",
			function(obj)
			{

				var $table = $("#subInGrp_" + _pageRef);
				var rowId = obj.originalEvent.id;
				var selectedRowId = $table.jqGrid('getGridParam', 'selarrrow');
				if (obj.originalEvent.status == false)
				{
					$table.jqGrid('saveRow', rowId);
				}

			})
</script>