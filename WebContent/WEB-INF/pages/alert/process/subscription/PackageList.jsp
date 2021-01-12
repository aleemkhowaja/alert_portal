<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>

<script type="text/javascript">
function eventsInPkg_viewDetails(cellvalue, options, rowObject)
{
	return '<a href="#" onclick="eventsInPkg_viewDetailsList(\''+options.rowId+'\')">'+evt_in_pkg_key+'</a>';
}

function eventsInPkg_viewDetailsList(_rowid)
{
	if($('#openEventsListPopup_'+_pageRef).length > 0)
	{
		$('#openEventsListPopup_'+_pageRef).remove();
	}

	var PKG_ID = $('#packagesGridTbl_Id_'+_pageRef).jqGrid("getCell", _rowid, 'alrtPkgVO.PKG_ID');
	var	openCommunicationTypePopup = $("<div id='openEventsListPopup_"+_pageRef+"' class='path-common-sceen'></div>");
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
                      $('#openEventsListPopup_'+_pageRef).dialog("destroy");
                      $('#openEventsListPopup_'+_pageRef).remove();
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
	$('#openEventsListPopup_' + _pageRef).load(mySrc,reloadParams, function()
	{
	});
	$('#openEventsListPopup_'+_pageRef).dialog(_dialogOptions);
	$('#openEventsListPopup_' + _pageRef).dialog('open');
}//end function

</script>

 <ps:url id="packageGrid" escapeAmp="false"
	action="SubscriptionListAction_LoadPackageGrid" namespace="/path/alert/subscription"> 
</ps:url>

<psjg:grid id="packagesGridTbl_Id_${_pageRef}"
	href="%{packageGrid}" dataType="json"
	caption ="%{getText('packages_key')}"
	hiddengrid="false" pager="true" sortable="true"
	filter="true" gridModel="gridModel" rowNum="5" rowList="5,10,15,20"
	viewrecords="true" navigator="true" navigatorDelete="false"
	navigatorEdit="false" navigatorRefresh="false" navigatorAdd="false"
	navigatorSearch="true" 
	navigatorSearchOptions="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
	altRows="true" ondblclick="" 
	addfunc="" shrinkToFit="true" loadonce="false"
	multiselect="true"
	onSelectRowTopics="dynamicGridSelectRowFunc4"
	onSelectAllTopics="dynamicGridSelectAllFunc4"
	onGridCompleteTopics="onAfterBatchDetailScreenLoad4"
	onEditInlineBeforeTopics="onEditInlineBeforeTopicsFunc4">
		
		<psjg:gridColumn id="Package_ID_${_pageRef}" colType="number"
		name="alrtPkgVO.PKG_ID" index="PKG_ID"
		title="%{getText('package_id_key')}" editable="false" sortable="true"
		search="true"  width="100" 
		 />
		
		<psjg:gridColumn id="Package_Brief_Eng_Desc_${_pageRef}" colType="text"
		name="alrtPkgVO.BRIEF_DESC_ENG" index="BRIEF_DESC_ENG"
		title="%{getText('brief_eng_desc_key')}" editable="false" sortable="true"
		search="true" width="220"  />
		
		<psjg:gridColumn id="Package_Long_Eng_Desc_${_pageRef}" colType="text"
		name="alrtPkgVO.LONG_DESC_ENG" index="LONG_DESC_ENG"
		title="%{getText('long_eng_desc_key')}" editable="false" sortable="true"
		search="true" width="220" />
		
		<psjg:gridColumn id="Package_Brief_Arab_Desc_${_pageRef}" colType="text"
		name="alrtPkgVO.BRIEF_DESC_ARAB" index="BRIEF_DESC_ARAB"
		title="%{getText('brief_arab_desc_key')}" editable="false" sortable="true"
		search="true" width="220" />
		
		<psjg:gridColumn id="Package_Long_Arabic_Desc_${_pageRef}" colType="text"
		name="alrtPkgVO.LONG_DESC_ARAB" index="LONG_DESC_ARAB"
		title="%{getText('long_arab_desc_key')}" editable="false" sortable="true"
		search="true" width="220" />
		
		<psjg:gridColumn id="statusEvent_${_pageRef}" colType="text"
		name="alrtPkgVO.STATUS" index="alrtPkgVO.STATUS"
		title="%{getText('status_key')}" editable="false" sortable="true"
		search="true" width="80"/>
		
		<psjg:gridColumn id="include_all_events_${_pageRef}" colType="checkbox" formatter="checkbox" 
		edittype="checkbox" editoptions="{value:'Y:N'}" 
		name="alrtPkgVO.INCLUDE_ALL_EVT_YN" index="INCLUDE_ALL_EVT_YN" align="center"
		title="%{getText('include_all_events_key')}" editable="false" sortable="true"
		search="true" width="220" />
		
		<psjg:gridColumn id="eventsList_${_pageRef}" 
			 name="eventsList"
			 index="eventsList" 
			 colType="text" 
		     formatter="eventsInPkg_viewDetails"
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
        id="openEventsListPopup_${_pageRef}" 
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
	
	$("#packagesGridTbl_Id_" + _pageRef).unsubscribe("dynamicGridSelectRowFunc4");
	$("#packagesGridTbl_Id_" + _pageRef).subscribe("dynamicGridSelectRowFunc4",
	function(obj)
	{
		dynamicGridSelectRowFunc(obj,'P');
	});
	$("#packagesGridTbl_Id_" + _pageRef).unsubscribe("dynamicGridSelectAllFunc4");
	$("#packagesGridTbl_Id_" + _pageRef).subscribe("dynamicGridSelectAllFunc4",
	function(obj)
	{
		dynamicGridSelectAllFunc(obj,'P');
	});
	$("#packagesGridTbl_Id_" + _pageRef).unsubscribe("onAfterBatchDetailScreenLoad4");
	$("#packagesGridTbl_Id_" + _pageRef).subscribe("onAfterBatchDetailScreenLoad4",
	function(obj)
	{
		onAfterBatchDetailScreenLoad(obj,'P');
	});
	$("#packagesGridTbl_Id_" + _pageRef).unsubscribe("onEditInlineBeforeTopicsFunc4");
	$("#packagesGridTbl_Id_" + _pageRef).subscribe("onEditInlineBeforeTopicsFunc4",
	function(obj)
	{
		var $table = $("#packagesGridTbl_Id_" + _pageRef);
		var rowId = obj.originalEvent.id;
		var selectedRowId = $table.jqGrid('getGridParam', 'selarrrow');
		if (obj.originalEvent.status == false)
		{
			$table.jqGrid('saveRow', rowId);
		}
	})
</script>