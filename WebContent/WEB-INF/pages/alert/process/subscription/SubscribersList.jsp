<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>

<ps:hidden name="subscriptionCO.allRowsSUB" id="selectAllSubFlag_${_pageRef}"></ps:hidden>


<ps:url id="subscribersGrid" escapeAmp="false"
	action="SubscriptionListAction_LoadSubscribersGrid"
	namespace="/path/alert/subscription">
</ps:url>

<psjg:grid id="subscriberGridTbl_Id_${_pageRef}"
	href="%{subscribersGrid}" dataType="json"
	caption="%{getText('subscribers_key')}" hiddengrid="false"
	pager="true" sortable="true" filter="true" gridModel="gridModel"
	rowNum="5" rowList="5,10,15,20" viewrecords="true" navigator="true"
	navigatorDelete="false" navigatorEdit="false" navigatorRefresh="false"
	navigatorAdd="false" navigatorSearch="true"
	navigatorSearchOptions="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
	altRows="true" ondblclick="" addfunc="" shrinkToFit="true"
	 multiselect="true" loadonce="false"
	onSelectRowTopics="dynamicGridSelectRowFunc1_${_pageRef}"
	onSelectAllTopics="dynamicGridSelectAllFunc1_${_pageRef}"
	onGridCompleteTopics="onAfterBatchDetailScreenLoad1_${_pageRef}"
	onEditInlineBeforeTopics="onEditInlineBeforeTopicsFunc1_${_pageRef}">



	<psjg:gridColumn id="SUB_ID_${_pageRef}" colType="number"
		name="alrtSubVO.ID" index="ID" title="%{getText('sub_id_key')}"
		editable="false" sortable="true" search="true" width="100" />

	<psjg:gridColumn id="briefName_${_pageRef}" colType="text"
		name="alrtSubLangVO.BRIEF_NAME" index="BRIEF_NAME"
		title="%{getText('brief_name_key')}" editable="false" sortable="true"
		search="true" width="100" />

	<psjg:gridColumn id="cifNo_${_pageRef}" colType="number"
		name="alrtSubVO.CIF_NO" index="CIF_NO" title="%{getText('cif_number_key')}"
		editable="false" width="100"/>

<%-- 	<psjg:gridColumn id="cifType_${_pageRef}" colType="text"
		name="cifType" index="cifType" width="250"
		title="%{getText('Cif_Type_key')}" editable="false" sortable="true"
		search="true" hidden="%{enable_omni}" /> --%>
		
	<psjg:gridColumn id="imalUserId_${_pageRef}" colType="text"
		name="alrtSubVO.USR_ID" index="USR_ID"
		title="%{getText('imal_user_key')}" editable="false"
		sortable="true" search="true" width="250" />
		
	<psjg:gridColumn id="channelEndUserId_${_pageRef}" colType="text"
		name="alrtSubVO.CHANNEL_END_USR_ID" index="CHANNEL_END_USR_ID"
		title="%{getText('channel_end_user_key')}" editable="false"
		sortable="true" search="true" width="250" />
		
	<psjg:gridColumn id="emailId_${_pageRef}" colType="text"
		name="alrtSubVO.EMAIL_ID" index="EMAIL_ID"
		title="%{getText('email_address_key')}" editable="false"
		sortable="true" search="true" width="250" />
		
	<psjg:gridColumn id="mobilePhone_${_pageRef}" colType="text"
		name="alrtSubVO.MOBILE_PHONE" index="MOBILE_PHONE"
		title="%{getText('Mobile_key')}" editable="false"
		sortable="true" search="true" width="250" />	
</psjg:grid>

<script type="text/javascript">
	$.struts2_jquery.require("SubscriptionMaint.js", null, jQuery.contextPath
			+ "/path/js/alert/subscription/");
	
	$("#subscriberGridTbl_Id_" + _pageRef).unsubscribe("dynamicGridSelectRowFunc1_"+_pageRef);
	$("#subscriberGridTbl_Id_" + _pageRef).subscribe("dynamicGridSelectRowFunc1_"+_pageRef,
			function(obj)
			{	
					if($("#selectAllSubFlag_"+_pageRef).val() != "1" )
					{
						dynamicGridSelectRowFunc(obj,'S');
					}
			});
	$("#subscriberGridTbl_Id_" + _pageRef).unsubscribe("dynamicGridSelectAllFunc1_"+_pageRef);
	$("#subscriberGridTbl_Id_" + _pageRef).subscribe("dynamicGridSelectAllFunc1_"+_pageRef,
			function(obj)
			{
				/**
				 * show select all check box on grid only for maintenance and approve screen
				 */
				if(_pageRef != "SBT00SEMT" && _pageRef != "SBT00SEP")
				{
					dynamicGridSelectAllFunc(obj,'S');
				}
				
			});
	$("#subscriberGridTbl_Id_" + _pageRef).unsubscribe("onAfterBatchDetailScreenLoad1_"+_pageRef);		
	$("#subscriberGridTbl_Id_" + _pageRef).subscribe("onAfterBatchDetailScreenLoad1_"+_pageRef,
			function(obj)
			{
				if($("#selectAllSubFlag_"+_pageRef).val() == "1" )
					{
						SubscriptionMaint_selectRecordForAllSelectedRecords("subscriberGridTbl_Id", "selectAllSubFlag");
					}
				else
					{
						onAfterBatchDetailScreenLoad(obj,'S');
					}
				
				
				
			});
	$("#subscriberGridTbl_Id_" + _pageRef).unsubscribe("onEditInlineBeforeTopicsFunc1_"+_pageRef);
	$("#subscriberGridTbl_Id_" + _pageRef).subscribe("onEditInlineBeforeTopicsFunc1_"+_pageRef,
			function(obj)
			{
				var $table = $("#subscriberGridTbl_Id_" + _pageRef);
				var rowId = obj.originalEvent.id;
				var selectedRowId = $table.jqGrid('getGridParam', 'selarrrow');
				if (obj.originalEvent.status == false)
				{
					$table.jqGrid('saveRow', rowId);
				}

			});

	$(document).ready(function() {
	    $('#cb_subscriberGridTbl_Id_'+_pageRef).change(function() {
	        if($(this).is(":checked")) {
	        	$("#selectAllSubFlag_"+_pageRef).val("1");
	        }
	        else
	        {
	        	$("#selectAllSubFlag_"+_pageRef).val("0");
	        }
	    });
	});
	
</script>