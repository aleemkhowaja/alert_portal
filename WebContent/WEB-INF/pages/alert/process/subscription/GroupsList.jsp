<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>

<script type="text/javascript">
function subscriberInGrp_viewDetails(cellvalue, options, rowObject)
{
	return '<a href="#" onclick="subscriberInGrp_viewDetailsList(\''+options.rowId+'\')">'+sub_in_grp_key+'</a>';
}

function subscriberInGrp_viewDetailsList(_rowid)
{
	if($('#openSubscriberListPopup_'+_pageRef).length > 0)
	{
		$('#openSubscriberListPopup_'+_pageRef).remove();
	}

	var GRP_ID = $('#groupsGridTbl_Id_'+_pageRef).jqGrid("getCell", _rowid, 'alrtGrpVO.GRP_ID');
	var	openCommunicationTypePopup = $("<div id='openSubscriberListPopup_"+_pageRef+"' class='path-common-sceen'></div>");
	openCommunicationTypePopup.css("padding","0");
	openCommunicationTypePopup.insertAfter($('body'));
	
	var reloadParams = {};
	reloadParams["_pageRef"] = _pageRef;
	reloadParams["subscriptionSC.GRP_ID"] = GRP_ID;
	
	var _dialogOptions = {modal:true, 
        title: sub_in_grp_key ,
        autoOpen:false,
        show:'slide',
        width:returnMaxWidth(550),
        height:returnMaxHeight(300),
        position:'center', 
		buttons:[{
			text: "Ok",
            id:"okid" ,//by this id set now you can do all operation base on this id
            click:function(){
                      $('#openSubscriberListPopup_'+_pageRef).dialog("destroy");
                      $('#openSubscriberListPopup_'+_pageRef).remove();
			}
		},
		{
		close: function (){
		     var theDialog = $(this);
		     theDialog.dialog("destroy");
		     theDialog.remove();
		}}]
	};
	
	var mySrc = jQuery.contextPath+ "/path/alert/subscription/SubscriptionMaintAction_loadSubscribersForGrpGridPage.action";
	$('#openSubscriberListPopup_' + _pageRef).load(mySrc,reloadParams, function()
	{
	});
	$('#openSubscriberListPopup_'+_pageRef).dialog(_dialogOptions);
	$('#openSubscriberListPopup_' + _pageRef).dialog('open');
}//end function

</script>

 <ps:url id="groupsGrid" escapeAmp="false"
	action="SubscriptionListAction_LoadGroupsGrid" namespace="/path/alert/subscription"> 
</ps:url>

<psjg:grid id="groupsGridTbl_Id_${_pageRef}"
	href="%{groupsGrid}" dataType="json"
	caption ="%{getText('groups_key')}"
	hiddengrid="false" pager="true" sortable="true"
	filter="true" gridModel="gridModel" rowNum="5" rowList="5,10,15,20"
	viewrecords="true" navigator="true" navigatorDelete="false"
	navigatorEdit="false" navigatorRefresh="false" navigatorAdd="false"
	navigatorSearch="true" 
	navigatorSearchOptions="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
	altRows="true" ondblclick="" 
	addfunc="" shrinkToFit="true" loadonce="false"
	multiselect="true"
	onSelectRowTopics="dynamicGridSelectRowFunc3"
	onSelectAllTopics="dynamicGridSelectAllFunc3"
	onGridCompleteTopics="onAfterBatchDetailScreenLoad3"
	onEditInlineBeforeTopics="onEditInlineBeforeTopicsFunc3"	
	>
		<psjg:gridColumn id="Group_ID_${_pageRef}" colType="number"
		name="alrtGrpVO.GRP_ID" index="GRP_ID"
		title="%{getText('Group_Id_key')}" editable="false" sortable="true"
		search="true" leadZeros="" width="100"
		/>
		
		<psjg:gridColumn id="Groups_Brief_Eng_Desc_${_pageRef}" colType="text"
		name="alrtGrpVO.BRIEF_DESC_ENG" index="BRIEF_DESC_ENG"
		title="%{getText('brief_eng_desc_key')}" editable="false" sortable="true"
		search="true" width="220" />
		
		<psjg:gridColumn id="Groups_Long_Eng_Desc_${_pageRef}" colType="text"
		name="alrtGrpVO.LONG_DESC_ENG" index="LONG_DESC_ENG"
		title="%{getText('long_eng_desc_key')}" editable="false" sortable="true"
		search="true" width="220" />
		
		<psjg:gridColumn id="Groups_Brief_Arab_Desc_${_pageRef}" colType="text"
		name="alrtGrpVO.BRIEF_DESC_ARAB" index="BRIEF_DESC_ARAB"
		title="%{getText('brief_arab_desc_key')}" editable="false" sortable="true"
		search="true" width="220" />
		
		<psjg:gridColumn id="Groups_Long_Arabic_Desc_${_pageRef}" colType="text"
		name="alrtGrpVO.LONG_DESC_ARAB" index="LONG_DESC_ARAB"
		title="%{getText('long_arab_desc_key')}" editable="false" sortable="true"
		search="true" width="220" />
		
		<psjg:gridColumn id="include_all_subscribers_${_pageRef}" colType="checkbox" formatter="checkbox" 
		edittype="checkbox" editoptions="{value:'Y:N',dataEvents: [{ type: 'change', fn: function(e) {   } }]}" 
		name="alrtGrpVO.INCLUDE_ALL_SUB_YN" index="INCLUDE_ALL_SUB_YN" align="center"
		title="%{getText('include_all_subscribers_key')}" editable="false" sortable="true"
		search="true" width="220" />
		
		<psjg:gridColumn id="subscribersList_${_pageRef}" 
			 name="subscribersList"
			 index="subscribersList" 
			 colType="text" 
		     formatter="subscriberInGrp_viewDetails"
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
        id="openSubscriberListPopup_${_pageRef}" 
        href=""
        autoOpen="false"
        dataType="html"
        modal="true" 
        title="%{getText('sub_in_grp_key')}"
        width="550"
        height="300"
     />    
</div>

<script type="text/javascript">
	
	$.struts2_jquery.require("SubscriptionMaint.js", null, jQuery.contextPath+ "/path/js/alert/subscription/");
	
	$("#groupsGridTbl_Id_" + _pageRef).unsubscribe("dynamicGridSelectRowFunc3");
	$("#groupsGridTbl_Id_" + _pageRef).subscribe("dynamicGridSelectRowFunc3",
	function(obj)
	{
		dynamicGridSelectRowFunc(obj,'G');
	});
	$("#groupsGridTbl_Id_" + _pageRef).unsubscribe("dynamicGridSelectAllFunc3");
	$("#groupsGridTbl_Id_" + _pageRef).subscribe("dynamicGridSelectAllFunc3",
	function(obj)
	{
		dynamicGridSelectAllFunc(obj,'G');
	});
	$("#groupsGridTbl_Id_" + _pageRef).unsubscribe("onAfterBatchDetailScreenLoad3");
	$("#groupsGridTbl_Id_" + _pageRef).subscribe("onAfterBatchDetailScreenLoad3",
	function(obj)
	{
		onAfterBatchDetailScreenLoad(obj,'G');
	});
	$("#groupsGridTbl_Id_" + _pageRef).unsubscribe("onEditInlineBeforeTopicsFunc3");
	$("#groupsGridTbl_Id_" + _pageRef).subscribe("onEditInlineBeforeTopicsFunc3",
	function(obj)
	{
		var $table = $("#groupsGridTbl_Id_" + _pageRef);
		var rowId = obj.originalEvent.id;
		var selectedRowId = $table.jqGrid('getGridParam', 'selarrrow');
		if (obj.originalEvent.status == false)
		{
			$table.jqGrid('saveRow', rowId);
		}
	});
</script>