<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>

<script type="text/javascript">
function groupPackageList_viewDetails(cellvalue, options, rowObject)
{
	return '<a href="#" onclick="groupPackageList_viewDetailsList(\''+options.rowId+'\')">'+sub_in_grp_key+'</a>';
}

function eventsInPkgGroup_viewDetails(cellvalue, options, rowObject)
{
	return '<a href="#" onclick="eventsInPkgGroup_viewDetailsList(\''+options.rowId+'\')">'+evt_in_pkg_key+'</a>';
}

function groupPackageList_viewDetailsList(_rowid)
{
	if($('#opensubscriberInGrpListPopup_'+_pageRef).length > 0)
	{
		$('#opensubscriberInGrpListPopup_'+_pageRef).remove();
	}

	var GRP_ID = $('#groupPckgGridTbl_Id_'+_pageRef).jqGrid("getCell", _rowid, 'alrtSubEvtTmpVO.SUB_ID');
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

function eventsInPkgGroup_viewDetailsList(_rowid)
{
	if($('#openSubscriberEventsListPopup_'+_pageRef).length > 0)
	{
		$('#openSubscriberEventsListPopup_'+_pageRef).remove();
	}

	var PKG_ID = $('#groupPckgGridTbl_Id_'+_pageRef).jqGrid("getCell", _rowid, 'alrtSubEvtTmpVO.EVT_ID');
	var	openCommunicationTypePopup = $("<div id='openSubscriberEventsListPopup_"+_pageRef+"' class='path-common-sceen'></div>");
	openCommunicationTypePopup.css("padding","0");
	openCommunicationTypePopup.insertAfter($('body'));

	var reloadParams = {};
	reloadParams["_pageRef"] = _pageRef;
	reloadParams["subscriptionSC.PKG_ID"] = PKG_ID;
	
	var _dialogOptions = {modal:true, 
        title: evt_in_pkg_key ,
        autoOpen:false,
        show:'slide',
        width:returnMaxWidth(450),
        height:returnMaxHeight(300),
        position:'center', 
		buttons:[{
			text: "Ok",
            id:"okid" ,//by this id set now you can do all operation base on this id
            click:function(){
                      $('#openSubscriberEventsListPopup_'+_pageRef).dialog("destroy");
                      $('#openSubscriberEventsListPopup_'+_pageRef).remove();
			}
		},
		{
		close: function (){
		     var theDialog = $(this);
		     theDialog.dialog("destroy");
		     theDialog.remove();
		}}]
	};
	
	mySrc = jQuery.contextPath+ "/path/alert/subscription/SubscriptionMaintAction_loadEventsForPakgGridPage.action";
	$('#openSubscriberEventsListPopup_' + _pageRef).load(mySrc,reloadParams, function()
	{
	});
	$('#openSubscriberEventsListPopup_'+_pageRef).dialog(_dialogOptions);
	$('#openSubscriberEventsListPopup_' + _pageRef).dialog('open');
}//end function
</script>

<ps:url id="groupsPackageGrid" escapeAmp="false"
	action="SubscriptionListAction_LoadSubscribersEvtGrid"
	namespace="/path/alert/subscription">
	 <ps:param name="subscriptionSC.type" value="'GP'"></ps:param>
	 <ps:param name="subscriptionSC.crud" value="subscriptionCO.ivCrud"></ps:param>
</ps:url>

<psjg:grid id="groupPckgGridTbl_Id_${_pageRef}"
	href="%{groupsPackageGrid}" 
	dataType="json"
	caption ="%{getText('subscriptions_key')}"
	hiddengrid="false" 
	pager='true' 
	sortable="true"
	filter="true" 
	gridModel="gridModel" 
	rowNum="5" 
	rowList="5,10,15,20"
	viewrecords="true" navigator="true" navigatorDelete="false"
	navigatorEdit="false" navigatorRefresh="true" navigatorAdd="false"
	navigatorSearch="true" 
	navigatorSearchOptions="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
	altRows="true" ondblclick="" 
	addfunc="" 
	shrinkToFit="true" 
	autowidth="true"
	height="125"
	multiselect="true"
	onSelectRowTopics="dynamicGridSelectRowFuncGPDet"
	onSelectAllTopics="dynamicGridSelectAllFuncGPDet"
	onGridCompleteTopics="onAfterBatchDetailScreenLoadGPDet"
	onEditInlineBeforeTopics="onEditInlineBeforeTopicsFuncGPDet">
	
		<psjg:gridColumn name="alrtSubEvtTmpVO.REL_ID" title="" 
		index="alrtSubEvtTmpVO.REL_ID" colType="number" hidden="true" editable="false" 
		sortable="true" search="true" id="LINE_NO_${_pageRef}"/>
		
		<psjg:gridColumn name="alrtSubEvtTmpVO.REL_TYPE" title="" 
		index="alrtSubEvtTmpVO.REL_TYPE" colType="text" hidden="true" editable="false" 
		sortable="true" search="true" id="RelType_${_pageRef}"/>
			
		<psjg:gridColumn id="PackGrp_ID_${_pageRef}" colType="number"
		name="alrtSubEvtTmpVO.SUB_ID" index="alrtSubEvtTmpVO.SUB_ID"
		title="%{getText('Group_Id_key')}" editable="false" sortable="true"
		search="true" leadZeros="" width="100"/>
		
		<psjg:gridColumn id="PackGrp_Description_${_pageRef}" colType="text"
		name="alrtSubEvtTmpVO.FULL_NAME_ENG" index="alrtSubEvtTmpVO.FULL_NAME_ENG"
		title="%{getText('Group_Description_key')}" editable="false" sortable="true"
		search="true" width="300"/>
		
		<psjg:gridColumn id="GrpPack_ID_${_pageRef}" colType="number"
		name="alrtSubEvtTmpVO.EVT_ID" index="alrtSubEvtTmpVO.EVT_ID"
		title="%{getText('package_id_key')}" editable="false" sortable="true"
		search="true" width="100" />
		
		<psjg:gridColumn id="GrpPack_Description_${_pageRef}" colType="text"
		name="alrtSubEvtTmpVO.EVT_DESC_ENG" index="alrtSubEvtTmpVO.EVT_DESC_ENG"
		title="%{getText('package_description_key')}" editable="false" sortable="true"
		search="true" width="300"/>
		
		<psjg:gridColumn id="packageCifMultiselectedAccounts" colType="text"
			name="packageCifMultiselectedAccounts" title="%{getText('multi_selected_account_key')}" editable="true"
			sortable="false" search="true" width="150" hidden="true" />
			
		<ps:if test='_pageRef == "SBT00GPAD" || _pageRef == "SBT00GPAS" || _pageRef == "SBT00GPRA"'>
			<psjg:gridColumn id="GrpPack_Status_Desc_${_pageRef}" colType="text"
				name="toBeStatusDesc" index="statusDesc"
				title="%{getText('subscription_status_key')}" editable="false"
				sortable="true" search="true" width="150" />
		</ps:if>
		<ps:else>
			<psjg:gridColumn id="GrpPack_Status_Desc_${_pageRef}" colType="text"
				name="statusDesc" index="statusDesc"
				title="%{getText('subscription_status_key')}" editable="false"
				sortable="true" search="true" width="150" />
		</ps:else>
			<%-- <psjg:gridColumn id="GrpPack_Status_Desc_${_pageRef}" colType="text"
		name="statusDesc" index="statusDesc"
		title="%{getText('subscription_status_key')}" editable="false" sortable="true"
		search="true" width="150"/> --%>
		
		<psjg:gridColumn id="GrpPack_Status_${_pageRef}" colType="text"
		name="alrtSubEvtTmpVO.SUB_EVT_STATUS" index="alrtSubEvtTmpVO.SUB_EVT_STATUS"
		title="%{getText('subscription_status_key')}" editable="false" sortable="true"
		search="true" width="150" hidden="true"/>
		
		<psjg:gridColumn name="alrtSubEvtVO.DATE_UPDATED" id="DATE_UPDATED"  
			formatoptions="{srcformat:'Y-m-d H:i:s.u',newformat:'d/m/Y H:i:s:u' }"  index="DATE_UPDATED"
			colType="date" title="DATE_UPDATED" sortable="true" editable="false" hidden="true"/>
		
		<psjg:gridColumn id="include_all_subscribers_${_pageRef}" colType="checkbox" formatter="checkbox" 
			edittype="checkbox" editoptions="{value:'Y:N'}" 
			name="alrtGrpVO.INCLUDE_ALL_SUB_YN" index="INCLUDE_ALL_SUB_YN" align="center"
			title="%{getText('include_all_subscribers_key')}" editable="false" sortable="true"
			search="true" width="220" />
		
		<psjg:gridColumn id="subscribersInGrpList_${_pageRef}" 
			 name="subscribersInGrpList"
			 index="subscribersInGrpList" 
			 colType="text" 
		     formatter="groupPackageList_viewDetails"
			 title="%{getText('sub_in_grp_key')}" 
			 sortable="false"
			 search="false" 
			 width="100" 
			 editable="false" 
			 tabindex = "6"
			 align="center"
		/>
		
		<psjg:gridColumn id="include_all_events_${_pageRef}" colType="checkbox" formatter="checkbox" 
		edittype="checkbox" editoptions="{value:'Y:N',dataEvents: [{ type: 'change', fn: function(e) {   } }]}" 
		name="alrtPkgVO.INCLUDE_ALL_EVT_YN" index="INCLUDE_ALL_EVT_YN" align="center"
		title="%{getText('include_all_events_key')}" editable="false" sortable="true"
		search="true" width="220" />
		
		<psjg:gridColumn id="eventsInPkgList_${_pageRef}" 
			 name="eventsInPkgList"
			 index="eventsInPkgList" 
			 colType="text" 
		     formatter="eventsInPkgGroup_viewDetails"
			 title="%{getText('evt_in_pkg_key')}" 
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
<div class="clearfix">
    <psj:dialog
        id="openSubscriberEventsListPopup_${_pageRef}" 
        href=""
        autoOpen="false"
        dataType="html"
        modal="true" 
        title="%{getText('evt_in_pkg_key')}"
        width="450"
        height="300"
     />    
</div>
<script type="text/javascript">
	$.struts2_jquery.require("SubscriptionMaint.js", null, jQuery.contextPath+ "/path/js/alert/subscription/");
	
	$("#groupPckgGridTbl_Id_" + _pageRef).unsubscribe("dynamicGridSelectRowFuncGPDet");
	$("#groupPckgGridTbl_Id_" + _pageRef).subscribe("dynamicGridSelectRowFuncGPDet",
	function(obj)
	{	
		dynamicGridSelectRowFuncDet(obj,'GP');
	});
	$("#groupPckgGridTbl_Id_" + _pageRef).unsubscribe("dynamicGridSelectAllFuncGPDet");
	$("#groupPckgGridTbl_Id_" + _pageRef).subscribe("dynamicGridSelectAllFuncGPDet",
	function(obj)
	{
		dynamicGridSelectAllFuncDet(obj,'GP');
	});
	$("#groupPckgGridTbl_Id_" + _pageRef).unsubscribe("onAfterBatchDetailScreenLoadGPDet");		
	$("#groupPckgGridTbl_Id_" + _pageRef).subscribe("onAfterBatchDetailScreenLoadGPDet",
	function(obj)
	{
		onAfterBatchDetailScreenLoadDet(obj,'GP');
	});
	$("#groupPckgGridTbl_Id_" + _pageRef).unsubscribe("onEditInlineBeforeTopicsFuncGPDet");
	$("#groupPckgGridTbl_Id_" + _pageRef).subscribe("onEditInlineBeforeTopicsFuncGPDet",
	function(obj)
	{
		var $table = $("#groupPckgGridTbl_Id_" + _pageRef);
		var rowId = obj.originalEvent.id;
		var selectedRowId = $table.jqGrid('getGridParam', 'selarrrow');
		if (obj.originalEvent.status == false)
		{
			$table.jqGrid('saveRow', rowId);
		}
	});	
</script>
		