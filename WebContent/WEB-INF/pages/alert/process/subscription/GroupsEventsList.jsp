<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>

<ps:url id="groupsEventsGrid" escapeAmp="false"
	action="SubscriptionListAction_LoadSubscribersEvtGrid"
	namespace="/path/alert/subscription">
	<ps:param name="subscriptionSC.type" value="'EG'"></ps:param>
	<ps:param name="subscriptionSC.crud" value="subscriptionCO.ivCrud"></ps:param>
</ps:url>

<script type="text/javascript">
function subscribersInGrpList_viewDetails(cellvalue, options, rowObject)
{
	return '<a href="#" onclick="subscribersInGrpList_viewDetailsList(\''+options.rowId+'\')">'+sub_in_grp_key+'</a>';
}

function subscribersInGrpList_viewDetailsList(_rowid)
{
	if($('#opensubscriberInGrpListPopup_'+_pageRef).length > 0)
	{
		$('#opensubscriberInGrpListPopup_'+_pageRef).remove();
	}

	var GRP_ID = $('#groupsEvtGridTbl_Id_'+_pageRef).jqGrid("getCell", _rowid, 'alrtSubEvtTmpVO.SUB_ID');
	var	openCommunicationTypePopup = $("<div id='opensubscriberInGrpListPopup_"+_pageRef+"' class='path-common-sceen'></div>");
	openCommunicationTypePopup.css("padding","0");
	openCommunicationTypePopup.insertAfter($('body'));

	var reloadParams = {};
	reloadParams["_pageRef"] = _pageRef;
	reloadParams["subscriptionSC.GRP_ID"] = GRP_ID;
	
	var _dialogOptions = {modal:true, 
        title: sub_in_grp_key ,
        autoOpen:false,
        show:'slide',
        width:returnMaxWidth(450),
        height:returnMaxHeight(300),
        position:'center', 
		buttons:[{
			text: "Ok",
            id:"okid" ,//by this id set now you can do all operation base on this id
            click:function(){
                      $('#opensubscriberInGrpListPopup_'+_pageRef).dialog("destroy");
                      $('#opensubscriberInGrpListPopup_'+_pageRef).remove();
			}
		},
		{
		close: function (){
		     var theDialog = $(this);
		     theDialog.dialog("destroy");
		     theDialog.remove();
		}}]
	};
	
	mySrc = jQuery.contextPath+ "/path/alert/subscription/SubscriptionMaintAction_loadSubscribersForGrpGridPage.action";
	$('#opensubscriberInGrpListPopup_' + _pageRef).load(mySrc,reloadParams, function()
	{
	});
	$('#opensubscriberInGrpListPopup_'+_pageRef).dialog(_dialogOptions);
	$('#opensubscriberInGrpListPopup_' + _pageRef).dialog('open');
}//end function	
</script>

<ps:hidden name="updates" id="groupsEvtGrid_${_pageRef}"></ps:hidden>

<psjg:grid id="groupsEvtGridTbl_Id_${_pageRef}"
	href="%{groupsEventsGrid}" 
	dataType="json"
	caption="%{getText('subscriptions_key')}" 
	hiddengrid="false"
	pager='true' 
	sortable="true" filter="true" 
	gridModel="gridModel"
	rowNum="5" rowList="5,10,15,20" viewrecords="true" navigator="true"
	navigatorDelete="false" navigatorEdit="false" navigatorRefresh="true"
	navigatorAdd="false" navigatorSearch="true"
	navigatorSearchOptions="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
	altRows="true" ondblclick="" addfunc="" 
	shrinkToFit="true" 
	autowidth="true"
	height="130" 
	multiselect="true"
	onSelectRowTopics="dynamicGridSelectRowFuncEGDet"
	onSelectAllTopics="dynamicGridSelectAllFuncEGDet"
	onGridCompleteTopics="onAfterBatchDetailScreenLoadEGDet"
	onEditInlineBeforeTopics="onEditInlineBeforeTopicsFuncEGDet"
	editinline="true" 
	editurl=" ">

	<psjg:gridColumn name="alrtSubEvtTmpVO.REL_ID" title="" index="alrtSubEvtTmpVO.REL_ID"
		colType="number" hidden="true" editable="false" sortable="true"
		search="true" id="LINE_NO_${_pageRef}" />

	<psjg:gridColumn name="alrtSubEvtTmpVO.REL_TYPE" title=""
		index="alrtSubEvtTmpVO.REL_TYPE" colType="text" hidden="true" editable="false"
		sortable="true" search="true" id="RelType_${_pageRef}" />

	<psjg:gridColumn id="EventGrp_ID_${_pageRef}" colType="number"
		name="alrtSubEvtTmpVO.SUB_ID" index="alrtSubEvtTmpVO.SUB_ID"
		title="%{getText('Group_Id_key')}" editable="false" sortable="true"
		search="true" leadZeros="" width="100" />


	<psjg:gridColumn id="EventGrp_Description_${_pageRef}" colType="text"
		name="alrtSubEvtTmpVO.FULL_NAME_ENG" index="alrtSubEvtTmpVO.FULL_NAME_ENG"
		title="%{getText('Group_Description_key')}" editable="false"
		sortable="true" search="true" width="300" />

	<psjg:gridColumn id="GrpEvent_ID_${_pageRef}" colType="number"
		name="alrtSubEvtTmpVO.EVT_ID" index="alrtSubEvtTmpVO.EVT_ID"
		title="%{getText('event_id_key')}" editable="false" sortable="true"
		search="true" width="100" />

	<psjg:gridColumn id="GrpEvent_TypeVal_${_pageRef}" colType="text"
		name="alrtSubEvtTmpVO.EVT_TYPE" index="alrtSubEvtTmpVO.EVT_TYPE"
		title="%{getText('event_type_key')}" hidden="true" />

	<psjg:gridColumn id="GrpEvent_Type_${_pageRef}" colType="text"
		name="evtType" index="evtType"
		title="%{getText('event_type_key')}" editable="false" sortable="true"
		search="true" width="100" />
		
	<psjg:gridColumn id="GrpEvent_Description_${_pageRef}" colType="text"
		name="alrtSubEvtTmpVO.EVT_DESC_ENG" index="alrtSubEvtTmpVO.EVT_DESC_ENG"
		title="%{getText('event_description_key')}" editable="false"
		sortable="true" search="true" width="300" />

	<ps:if test='_pageRef == "SBT00GEAD" || _pageRef == "SBT00GEAS" || _pageRef == "SBT00GERA"'>
		<psjg:gridColumn id="GrpEvent_Status_Desc_${_pageRef}" colType="text"
			name="toBeStatusDesc" index="statusDesc"
			title="%{getText('subscription_status_key')}" editable="false"
			sortable="true" search="true" width="150" />
	</ps:if>
	<ps:else>
		<psjg:gridColumn id="GrpEvent_Status_Desc_${_pageRef}" colType="text"
			name="statusDesc" index="statusDesc"
			title="%{getText('subscription_status_key')}" editable="false"
			sortable="true" search="true" width="150" />
	</ps:else>
	<%-- <psjg:gridColumn id="GrpEvent_Status_Desc_${_pageRef}" colType="text"
		name="statusDesc" index="statusDesc"
		title="%{getText('subscription_status_key')}" editable="false"
		sortable="true" search="true" width="150" /> --%>

	<psjg:gridColumn id="GrpEvent_Status_${_pageRef}" colType="text"
		name="alrtSubEvtTmpVO.SUB_EVT_STATUS" index="alrtSubEvtTmpVO.SUB_EVT_STATUS"
		title="%{getText('subscription_status_key')}" editable="false"
		sortable="true" search="true" width="150" hidden="true" />
		
	<%-- <psjg:gridColumn id="alrtSubEvtVO_SRC_CONTACT" hidden="true"
		name="alrtSubEvtVO.SRC_CONTACT_TYPE" index="alrtSubEvtVO.SRC_CONTACT_TYPE"
		title="%{getText('src_contact_key')}" editable="true" sortable="false"
		edittype="select" colType="select" search="true"  formatter="select"
		editoptions="{value:function() {  return loadCombo('${pageContext.request.contextPath}/path/alert/subscription/SubscriptionListAction_LoadsrcContactSelect','srcContactList', 'code', 'descValue');},
		dataEvents: [{ type: 'change', fn: function(e) {onSelectChange() }}]}" />
		 --%>
	<psjg:gridColumn name="alrtSubEvtVO.DATE_UPDATED" id="DATE_UPDATED"  
			formatoptions="{srcformat:'Y-m-d H:i:s.u',newformat:'d/m/Y H:i:s:u' }"  index="DATE_UPDATED"
			colType="date" title="DATE_UPDATED" sortable="true" editable="false" hidden="true"/>
	
	<psjg:gridColumn id="include_all_subscribers_${_pageRef}" colType="checkbox" formatter="checkbox" 
		edittype="checkbox" editoptions="{value:'Y:N',dataEvents: [{ type: 'change', fn: function(e) {   } }]}" 
		name="alrtGrpVO.INCLUDE_ALL_SUB_YN" index="INCLUDE_ALL_SUB_YN" align="center"
		title="%{getText('include_all_subscribers_key')}" editable="false" sortable="true"
		search="true" width="220" />
				
	<psjg:gridColumn id="subscribersInGrpList_${_pageRef}" 
		 name="subscribersInGrpList"
		 index="subscribersInGrpList" 
		 colType="text" 
	     formatter="subscribersInGrpList_viewDetails"
		 title="%{getText('sub_in_grp_key')}" 
		 sortable="false"
		 search="false" 
		 width="100" 
		 editable="false" 
		 tabindex = "6"
		 align="center"
	/>	
</psjg:grid>

<div class="clearfix">
    <psj:dialog
        id="opensubscriberInGrpListPopup_${_pageRef}" 
        href=""
        autoOpen="false"
        dataType="html"
        modal="true" 
        title="%{getText('sub_in_grp_key')}"
        width="450"
        height="300"
     />    
</div>

<script type="text/javascript">
	$.struts2_jquery.require("SubscriptionMaint.js", null, jQuery.contextPath+ "/path/js/alert/subscription/");
	
	$("#groupsEvtGridTbl_Id_" + _pageRef).unsubscribe("dynamicGridSelectRowFuncEGDet");
	$("#groupsEvtGridTbl_Id_" + _pageRef).subscribe("dynamicGridSelectRowFuncEGDet",
	function(obj)
	{	
		dynamicGridSelectRowFuncDet(obj,'EG');
	});
	$("#groupsEvtGridTbl_Id_" + _pageRef).unsubscribe("dynamicGridSelectAllFuncEGDet");
	$("#groupsEvtGridTbl_Id_" + _pageRef).subscribe("dynamicGridSelectAllFuncEGDet",
	function(obj)
	{
		dynamicGridSelectAllFuncDet(obj,'EG');
	});
	$("#groupsEvtGridTbl_Id_" + _pageRef).unsubscribe("onAfterBatchDetailScreenLoadEGDet");		
	$("#groupsEvtGridTbl_Id_" + _pageRef).subscribe("onAfterBatchDetailScreenLoadEGDet",
	function(obj)
	{
		onAfterBatchDetailScreenLoadDet(obj,'EG');
	});
	$("#groupsEvtGridTbl_Id_" + _pageRef).unsubscribe("onEditInlineBeforeTopicsFuncEGDet");
	$("#groupsEvtGridTbl_Id_" + _pageRef).subscribe("onEditInlineBeforeTopicsFuncEGDet",
	function(obj)
	{
		var $table = $("#groupsEvtGridTbl_Id_" + _pageRef);
		var rowId = obj.originalEvent.id;
		var selectedRowId = $table.jqGrid('getGridParam', 'selarrrow');
		if (obj.originalEvent.status == false)
		{
			$table.jqGrid('saveRow', rowId);
		}
		checkSubType(rowId);
	});
</script>
