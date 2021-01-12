<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>


<ps:set name="ivcrud_${_pageRef}" value="iv_crud" />
<ps:hidden id="iv_crud_${_pageRef}" name="iv_crud" />
<ps:hidden name="subscriptionCO.allRowsEvt" id="selectAllEvtsFlag_${_pageRef}"></ps:hidden>

<ps:url id="eventsGrid" escapeAmp="false"
	action="SubscriptionListAction_LoadEventsGrid" namespace="/path/alert/subscription"> 
	
	<ps:param name="iv_crud" value="ivcrud_${_pageRef}"></ps:param>
    <ps:param name="_pageRef" value="_pageRef"></ps:param>
</ps:url>

<psjg:grid id="eventsGridTbl_Id_${_pageRef}"
	href="%{eventsGrid}" dataType="json"
	caption ="%{getText('events_key')}"
	hiddengrid="false" pager="true" sortable="true"
	filter="true" gridModel="gridModel" rowNum="5" rowList="5,10,15,20"
	viewrecords="true" navigator="true" navigatorDelete="false"
	navigatorEdit="false" navigatorRefresh="false" navigatorAdd="false"
	navigatorSearch="true" 
	navigatorSearchOptions="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
	altRows="true" ondblclick="" 
	addfunc="" shrinkToFit="true" loadonce="false"
	multiselect="true"
	onSelectRowTopics="dynamicGridSelectRowFunc2_${_pageRef}"
	onSelectAllTopics="dynamicGridSelectAllFunc2_${_pageRef}"
	onGridCompleteTopics="onAfterBatchDetailScreenLoad2_${_pageRef}"
	onEditInlineBeforeTopics="onEditInlineBeforeTopicsFunc2_${_pageRef}"> 
			
		<psjg:gridColumn id="Event_ID_${_pageRef}" colType="number"
		name="alrtEvtVO.EVT_ID" index="EVT_ID"
		title="%{getText('event_id_key')}" editable="false" sortable="true"
		search="true" leadZeros="" width="100" />
		
		<psjg:gridColumn id="Events_Type_${_pageRef}" colType="text"
		name="alrtEvtVO.EVT_TYPE" index="EVT_TYPE"
		title="%{getText('type_key')}" editable="false" sortable="true"
		search="true" width="100"/>
		
		<psjg:gridColumn id="Events_Description_${_pageRef}" colType="text"
		name="alrtEvtVO.DESC_ENG" index="DESC_ENG"
		title="%{getText('desc_key')}" editable="false" sortable="true"
		search="true" width="300"/>
		
		<%/* check name */ %>
		<psjg:gridColumn id="Events_Additional_Info_${_pageRef}" colType="text"
		name="eventAddInfo" index="ADDITIONAL_INFO"
		title="%{getText('additional_information_key')}" editable="false" sortable="true"
		search="true" width="300" />
		
		<%-- <psjg:gridColumn id="Events_Mode_${_pageRef}" colType="text"
		name="alrtEvtVO.EVT_MODE" index="EVT_MODE" hidd
		title="%{getText('mode_key')}" editable="false" sortable="true"
		search="true" width="100"/> --%>
		
		<psjg:gridColumn id="statusEvent_${_pageRef}" colType="text"
		name="alrtEvtVO.STATUS" index="STATUS"
		title="%{getText('status_key')}" editable="false" sortable="true"
		search="true" width="110"/>
		
		<psjg:gridColumn id="EventType_${_pageRef}" colType="text"
		name="evtType" index="evtType"
		title="%{getText('type_key')}" hidden="true" />
		
		</psjg:grid>
	
	
<script type="text/javascript">
	$.struts2_jquery.require("SubscriptionMaint.js", null, jQuery.contextPath
			+ "/path/js/alert/subscription/");
	
	$("#eventsGridTbl_Id_" + _pageRef).unsubscribe("dynamicGridSelectRowFunc2_"+_pageRef);
	$("#eventsGridTbl_Id_" + _pageRef).subscribe("dynamicGridSelectRowFunc2_"+_pageRef,
			function(obj)
			{
				dynamicGridSelectRowFunc(obj,'E');
			});
	$("#eventsGridTbl_Id_" + _pageRef).unsubscribe("dynamicGridSelectAllFunc2_"+_pageRef);		
	$("#eventsGridTbl_Id_" + _pageRef).subscribe("dynamicGridSelectAllFunc2_"+_pageRef,
			function(obj)
			{
				/**
				 * show select all check box on grid only for maintenance and approve screen
				 */
				if(_pageRef != "SBT00SEMT" && _pageRef != "SBT00SEP")
				{
					dynamicGridSelectAllFunc(obj,'E');
				}
			});
	$("#eventsGridTbl_Id_" + _pageRef).unsubscribe("onAfterBatchDetailScreenLoad2_"+_pageRef);		
	$("#eventsGridTbl_Id_" + _pageRef).subscribe("onAfterBatchDetailScreenLoad2_"+_pageRef,
			function(obj)
			{
				if($("#selectAllEvtsFlag_"+_pageRef).val() == "1" )
				{
					SubscriptionMaint_selectRecordForAllSelectedRecords("eventsGridTbl_Id", "selectAllEvtsFlag");
				}
				else
				{
					onAfterBatchDetailScreenLoad(obj,'E');
				}
			});
	$("#eventsGridTbl_Id_" + _pageRef).unsubscribe("onEditInlineBeforeTopicsFunc2_"+_pageRef);
	$("#eventsGridTbl_Id_" + _pageRef).subscribe("onEditInlineBeforeTopicsFunc2_"+_pageRef,
			function(obj)
			{

				var $table = $("#eventsGridTbl_Id_" + _pageRef);
				var rowId = obj.originalEvent.id;
				var selectedRowId = $table.jqGrid('getGridParam', 'selarrrow');
				if (obj.originalEvent.status == false)
				{
					$table.jqGrid('saveRow', rowId);
				}

			});
	
	/**
	set flag while select all records
	**/
	$(document).ready(function() {
	    $('#cb_eventsGridTbl_Id_'+_pageRef).change(function() {
	        if($(this).is(":checked")) {
	        	$("#selectAllEvtsFlag_"+_pageRef).val("1");
	        }
	        else
	        {
	        	$("#selectAllEvtsFlag_"+_pageRef).val("0");
	        }
	    });
	});
	
</script>
