<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>

<ps:url id="subscribersEventsGrid" escapeAmp="false" action="SubscriptionListAction_LoadSubscribersEvtGrid" namespace="/path/alert/subscription">
 	<ps:param name="subscriptionSC.progRef" value="'${_pageRef}'"></ps:param>
 	<ps:param name="subscriptionSC.type" value="'SE'"></ps:param>
 	<ps:param name="subscriptionSC.crud" value="subscriptionCO.ivCrud"></ps:param>
 	<ps:param name="subscriptionSC.cif" value="cifNo_${_pageRef}"></ps:param>
 	<ps:param name="subscriptionSC.subscriberId" value="individualSubscriberId_${_pageRef}"></ps:param>
</ps:url>

<script>
	$.struts2_jquery.require("SubscriptionMaint.js", null, jQuery.contextPath+ "/path/js/alert/subscription/");
</script>
<ps:hidden name="updates" id="subscriptionsEvtGrid_${_pageRef}"></ps:hidden>
<ps:hidden name="subscriptionCO.allRowsSE" id="selectAllSubEvtGridFlag_${_pageRef}"></ps:hidden>

<psjg:grid 
    id="subscriptionsEvtGridTbl_Id_${_pageRef}"
	href="%{subscribersEventsGrid}" 
	dataType="json"
	caption ="%{getText('subscriptions_key')}"
	hiddengrid="false" 
	pager='<%=("SBT00SEUP".equals((String) request.getAttribute("_pageRef"))?"false":"true")%>' 
	sortable="true" 
	filter="true" 
	gridModel="gridModel" 
	rowNum="5" 
	rowList="5,10,15,20"
	viewrecords="true" 
	navigator="true" 
	navigatorDelete="false"
	navigatorEdit="false" 
	navigatorRefresh="true" 
	navigatorAdd="false"
	navigatorSearch="true" 
	navigatorSearchOptions="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
	altRows="true" 
	ondblclick="" 
	addfunc="" 
	height="130" 
	multiselect='%{_pageRef != "IND00MT" && _pageRef != "IND00P" && _pageRef != "IND00MA" && _pageRef != "IND00ML"}'
	editinline="true"
	editurl	="abc"
	shrinkToFit="true"
	onSelectRowTopics='onSelectRowEventsSubscription'
	onSelectAllTopics="onSelectAllRowsEventsSubscription"
	onGridCompleteTopics="onGridCompleteEventsSubscriptions"
	onEditInlineBeforeTopics="onEditInlineBeforeTopicsEventsFuncDet">

   <psjg:gridColumn name="alrtSubEvtTmpVO.ID" title="" index="ID"
		colType="number" hidden="true" editable="false" sortable="true"
		search="true" id="ID_${_pageRef}"
		 />
		
	<psjg:gridColumn name="alrtSubEvtTmpVO.REL_ID" title="" index="REL_ID"
		colType="number" hidden="true" editable="false" sortable="true"
		search="true" id="LINE_NO_${_pageRef}" />

	<psjg:gridColumn name="alrtSubEvtTmpVO.REL_TYPE" title=""
		index="REL_TYPE" colType="text" hidden="true" editable="false"
		sortable="true" search="true" id="RelType_${_pageRef}" />

	<psjg:gridColumn id="EventSub_ID_${_pageRef}" colType="number"
		name="alrtSubEvtTmpVO.SUB_ID" index="SUB_ID"
		title="%{getText('sub_id_key')}" editable="false" sortable="true"
		search="true" leadZeros="" width="100" hidden='%{_pageRef == "IND00MT" || _pageRef == "IND00P" || _pageRef == "IND00MA" || _pageRef == "IND00ML"}' 
		searchoptions="{sopt:['eq']}"
		/>

	<psjg:gridColumn id="briefName_${_pageRef}" colType="text"
		name="alrtSubEvtTmpVO.FULL_NAME_ENG" index="FULL_NAME_ENG"
		title="%{getText('brief_name_key')}" editable="false" sortable="true"
		search="true" width="100" hidden='%{_pageRef == "IND00MT" || _pageRef == "IND00P" || _pageRef == "IND00MA" || _pageRef == "IND00ML"}' />

	<psjg:gridColumn id="cifNo_${_pageRef}" colType="number"
		name="alrtSubEvtTmpVO.CIF_NO" index="CIF_NO" title="%{getText('cif_number_key')}"
		editable="false" width="100" hidden='%{_pageRef == "IND00MT" || _pageRef == "IND00P" || _pageRef == "IND00MA" || _pageRef == "IND00ML"}'
		searchoptions="{sopt:['eq']}" />
		
	<psjg:gridColumn id="EventSub_TypeVal_${_pageRef}" colType="text"
		name="alrtSubEvtTmpVO.SUB_TYPE" index="SUB_TYPE"
		title="%{getText('sub_type_key')}" hidden="true" />
		
	<psjg:gridColumn id="EventSub_Description_${_pageRef}" colType="text"
		name="alrtSubEvtTmpVO.FULL_NAME_ENG" index="FULL_NAME_ENG"
		title="%{getText('subscriber_description_key')}" editable="false"
		sortable="true" search="true" width="300"  hidden="true" />
		
	<psjg:gridColumn id="SubEvent_ID_${_pageRef}" colType="number"
		name="alrtSubEvtTmpVO.EVT_ID" index="EVT_ID"
		title="%{getText('event_id_key')}" editable="false" sortable="true"
		search="true" width="100"  />

	<psjg:gridColumn id="SubEvent_TypeHid_${_pageRef}" colType="text"
		name="alrtSubEvtTmpVO.EVT_TYPE" index="EVT_TYPE"
		title="%{getText('event_type_key')}" hidden="true" />
		
	<psjg:gridColumn id="SubEvent_CifNo_${_pageRef}" colType="text"
		name="cifNo" index="cifNo"
		title="%{getText('cifNo_key')}" hidden="true" />
		
	<psjg:gridColumn id="SubEvent_Type_${_pageRef}" colType="text"
		name="evtType" index="evtType"
		title="%{getText('event_type_key')}" editable="false" sortable="true"
		search="true" width="100" />

	<psjg:gridColumn id="SubEvent_Description_${_pageRef}" colType="text"
		name="alrtSubEvtTmpVO.EVT_DESC_ENG" index="EVT_DESC_ENG"
		title="%{getText('event_description_key')}" editable="false"
		sortable="true" search="true" width="300" />
	
 	<psjg:gridColumn colType="liveSearch" id="subscriberEventAccountId_${_pageRef}"
		name="eventAccountNumber" index="eventAccountNumber"
		title="%{getText('excluded_accounts_key')}" sortable="false"  editable="true"
		search="false"
		autoSearch="true"
		paramList="criteria.cif_no:lookuptxt_cifNumber_${_pageRef}" 
		dataAction="${pageContext.request.contextPath}/path/alert/subscriber/individual/IndividualSubscriberCIFLookupAction_constructAccountQueryLookup"
		resultList="excludedEventAccounts:eventAccountNumber_lookuptxt"
		dependencySrc="${pageContext.request.contextPath}/path/alert/subscriber/individual/IndividualSubscriberDepAction_dependencyByAccCif"
		params="ndividualSubscriberCO.alrtSubVO.CIF_NO:cifNoForExcludeAccounts_${_pageRef}"
		dependency="lookuptxt_cifNumber_${_pageRef}:cifNo" 
		multiSelect="true" multiResultInput="eventCifMultiselectedAccounts"
		selectColumn="BRANCH_CODE,CURRENCY_CODE,GL_CODE,CIF_SUB_NO,SL_NO,ADDITIONAL_REFERENCE,IBAN_ACC_NO"
		onSuccessTopics="excludeAccounntsOnComplete"
		reConstruct="true"
		hidden='%{_pageRef != "IND00MT" && _pageRef != "IND00P" && _pageRef != "IND00MA" && _pageRef != "IND00ML"}'
		/>
	
 	<psjg:gridColumn id="eventCifMultiselectedAccounts" colType="text"
		name="eventCifMultiselectedAccounts" title="%{getText('multi_selected_account_key')}" editable="true"
		sortable="false" search="true" width="150" hidden="true" />

 	<psjg:gridColumn id="CommunicationType_${_pageRef}" 
					 name="CommunicationType"
					 index="CommunicationType" 
					 colType="text" 
				     formatter="eventSubscriberEventCommunicationType_viewDetails"
					 title="%{getText('event_communication_key')}" 
					 sortable="false"
					 search="false" 
					 width="180" 
					 editable="false" 
					 tabindex = "6"
					 align="center"
					 hidden='%{_pageRef == "IND00MT" || _pageRef == "IND00P" || _pageRef == "IND00MA" || _pageRef == "IND00ML"}'
					 />
	
	<psjg:gridColumn id="alrtSubEvtVO_SRC_CONTACT"
		name="alrtSubEvtVO.SRC_CONTACT_TYPE" index="SRC_CONTACT_TYPE"
		title="%{getText('src_contact_key')}" editable="true" sortable="false"
		edittype="select" colType="select" search="true"  formatter="select"
		editoptions="{value:function() {  return loadCombo('${pageContext.request.contextPath}/path/alert/subscription/SubscriptionListAction_LoadsrcContactSelect','srcContactList', 'code', 'descValue');},
		dataEvents: [{ type: 'change', fn: function(e) {onSelectChange(this); SubscriptionMaint_changeForm(); }}]}" 
		hidden='%{_pageRef == "IND00MT" || _pageRef == "IND00P" || _pageRef == "IND00MA" || _pageRef == "IND00ML"}' />
		
	<ps:if test='_pageRef == "SBT00SED" || _pageRef == "SBT00SES" || _pageRef == "SBT00SERA"'>
		<psjg:gridColumn id="SubEvent_Status_Desc_${_pageRef}" colType="text"
			name="toBeStatusDesc" index="statusDesc"
			title="%{getText('subscription_status_key')}" editable="false"
			sortable="true" search="true" width="150" />
	</ps:if>
	<ps:else>
		<psjg:gridColumn id="SubEvent_Status_Desc_${_pageRef}" colType="text"
			name="statusDesc" index="statusDesc"
			title="%{getText('subscription_status_key')}" editable="false"
			sortable="true" search="true" width="150" />
	</ps:else>

	<psjg:gridColumn id="SubEvent_Status_${_pageRef}" colType="text"
		name="alrtSubEvtTmpVO.SUB_EVT_STATUS" index="SUB_EVT_STATUS"
		title="%{getText('subscription_status_key')}" editable="false"
		sortable="true" search="true" width="150" hidden="true" />
		
	<psjg:gridColumn name="alrtSubEvtVO.DATE_UPDATED" id="DATE_UPDATED"  
		formatoptions="{srcformat:'Y-m-d H:i:s.u',newformat:'d/m/Y H:i:s:u' }"  index="DATE_UPDATED"
		colType="date" title="DATE_UPDATED" sortable="true" editable="false" hidden="true"/>
	
	<psjg:gridColumn id="customDetails_${_pageRef}" colType="text"
		name="customDetails" index="customDetails"
		title="%{getText('customDetails')}" editable="false"
		sortable="true" search="true" width="150" hidden="true"/> 

</psjg:grid>

<div class="clearfix">
     <ps:url id="communicationTypeDetailUrl"  namespace="/path/alert/subscription/" action="SubscriptionListAction_LoadCommunicationTypeGrid">
           <ps:param name="_pageRef" value="_pageRef"> </ps:param>
           <ps:param name="subscriptionSC.EVT_ID" value="subscriptionCO.alrtSubEvtTmpVO.EVT_ID"></ps:param>
           <ps:param name="subscriptionSC.SUB_ID" value="subscriptionCO.alrtSubEvtTmpVO.SUB_ID"></ps:param>
     </ps:url>
     <psj:dialog
           id="openCommunicationTypePopup_${_pageRef}" 
           href=""
           autoOpen="false"
           dataType="html"
           modal="true" 
           title="%{getText('Details_key')}"
           width="450"
           height="300"
     />    
</div>
<ps:hidden id="rowStatus_${_pageRef}" name="rowStatus"></ps:hidden>
<script type="text/javascript">
	
	$("#subscriptionsEvtGridTbl_Id_" + _pageRef).subscribe("onSelectRowEventsSubscription",function(obj)
	{
		if(_pageRef != "IND00MT" && _pageRef != "IND00P" && _pageRef != "IND00MA" && _pageRef != "IND00ML")
		{
			dynamicGridSelectRowFuncDet(obj,'SE');
			//individualSubscriberMaint_packAndEvntselect(obj);
			var ivCrud = $("#iv_crud_" + _pageRef).val();
			if(ivCrud != null && ivCrud != "" && ivCrud == "R")
			{
				var theform = document.getElementById("subscriptionMaintForm_"+ _pageRef);
				$.data(theform, 'changeTrack', true);
			}
		}
	});
					
	$("#subscriptionsEvtGridTbl_Id_" + _pageRef).subscribe("onSelectAllRowsEventsSubscription",function(obj)
	{
		if(_pageRef == "IND00MT" || _pageRef == "IND00P" || _pageRef == "IND00MA" || _pageRef == "IND00ML")
		{
		}
		else
		{
			dynamicGridSelectAllFuncDet(obj,'SE');
		}
	});

	$("#subscriptionsEvtGridTbl_Id_" + _pageRef).subscribe("onGridCompleteEventsSubscriptions",function(obj)
	{
		if(_pageRef == "IND00MT" || _pageRef == "IND00P" || _pageRef == "IND00MA" || _pageRef == "IND00ML")
		{
			individualSubscriberMaint_gridLayoutSetting("subscriptionsEvtGridTbl_Id");
		}
		else
		{
			onAfterBatchDetailScreenLoadDet(obj,'SE');
			
			SubscriptionMaint_selectRecordForAllSelectedRecords("subscriptionsEvtGridTbl_Id", "selectAllSubEvtGridFlag");
		}
	});
					
	$("#subscriptionsEvtGridTbl_Id_" + _pageRef).subscribe('onEditInlineBeforeTopicsEventsFuncDet', function(obj) 
	{
		if(_pageRef == "IND00MT" || _pageRef == "IND00P" || _pageRef == "IND00MA" || _pageRef == "IND00ML")
		{
			subscriptionsEvtGridLoaded();
		}
		else
		{
			var $table = $("#subscriptionsEvtGridTbl_Id_" + _pageRef);
			var rowId = obj.originalEvent.id;
			var selectedRowId = $table.jqGrid('getGridParam', 'selarrrow');
			if (obj.originalEvent.status == false)
			{
				$table.jqGrid('saveRow', rowId);
			}
			checkSubType(rowId);
		
		//	var id= rowId+"_eventAccountNumber";
		//	liveSearch_makeReadOnly(true, id);
		}
	});
	
	$(document).ready(function() {
	    $('#cb_subscriptionsEvtGridTbl_Id_'+_pageRef).change(function() {
	        if($(this).is(":checked")) {
	        	$("#selectAllSubEvtGridFlag_"+_pageRef).val("1");
	        }
	        else
	        {
	        	$("#selectAllSubEvtGridFlag_"+_pageRef).val("0");
	        }
	    });
	});
	
</script>
