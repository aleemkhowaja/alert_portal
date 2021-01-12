<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>

<script type="text/javascript">
function subscriptionEventsInPkg_viewDetails(cellvalue, options, rowObject)
{
	return '<a href="#" onclick="subscriptionEventsInPkg_viewDetailsList(\''+options.rowId+'\')">'+evt_in_pkg_key+'</a>';
}

function subscriptionEventsInPkg_viewDetailsList(_rowid)
{
	if($('#openSubscriberEventsListPopup_'+_pageRef).length > 0)
	{
		$('#openSubscriberEventsListPopup_'+_pageRef).remove();
	}

	var PKG_ID = $('#subscriptionsPckgGridTbl_Id_'+_pageRef).jqGrid("getCell", _rowid, 'alrtSubEvtTmpVO.EVT_ID');
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

<ps:url id="subscribersPackageGrid" escapeAmp="false"
	action="SubscriptionListAction_LoadSubscribersEvtGrid"
	namespace="/path/alert/subscription">
	 <ps:param name="subscriptionSC.type" value="'SP'"></ps:param>
	 <ps:param name="subscriptionSC.crud" value="subscriptionCO.ivCrud"></ps:param>
	 <ps:param name="subscriptionSC.cif" value="cifNo_${_pageRef}"></ps:param>
	 <ps:param name="subscriptionSC.subscriberId" value="individualSubscriberId_${_pageRef}"></ps:param>
</ps:url>

<psjg:grid id="subscriptionsPckgGridTbl_Id_${_pageRef}"
	href="%{subscribersPackageGrid}" 
	dataType="json"
	caption ="%{getText('subscriptions_key')}"
	hiddengrid="false" 
	pager='true' 
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
	onSelectRowTopics='onSelectRowPackagesSubscription'
	onSelectAllTopics="onSelectAllRowsPackagesSubscription"
	onGridCompleteTopics="onGridCompletePackagesSubscriptions"
	onEditInlineBeforeTopics="onEditInlineBeforeTopicsFuncSPDet"
	> <%/* to be checked ondblclick and addfunc */ %>
	
		<psjg:gridColumn name="alrtSubEvtTmpVO.REL_ID" title="" 
		index="REL_ID" colType="number" hidden="true" editable="false" 
		sortable="true" search="true" id="LINE_NO_${_pageRef}"/>
		
		<psjg:gridColumn name="alrtSubEvtTmpVO.REL_TYPE" title="" 
		index="REL_TYPE" colType="text" hidden="true" editable="false" 
		sortable="true" search="true" id="RelType_${_pageRef}"/>
			
		<psjg:gridColumn id="PackSub_ID_${_pageRef}" colType="number"
		name="alrtSubEvtTmpVO.SUB_ID" index="SUB_ID"
		title="%{getText('sub_id_key')}" editable="false" sortable="true"
		search="true" leadZeros="" width="100" hidden='%{_pageRef == "IND00MT" || _pageRef == "IND00P" || _pageRef == "IND00MA" || _pageRef == "IND00ML"}' />
		
		<psjg:gridColumn id="PackSub_TypeVal_${_pageRef}" colType="text"
		name="alrtSubEvtTmpVO.SUB_TYPE" index="SUB_TYPE"
		title="%{getText('sub_type_key')}" hidden="true"/>	
		
		<%-- <psjg:gridColumn id="PackSub_Type_${_pageRef}" colType="text"
		name="subType" index="subType"
		title="%{getText('sub_type_key')}" editable="false" sortable="true"
		search="true" width="100" hidden='%{_pageRef == "IND00MT" || _pageRef == "IND00P" || _pageRef == "IND00MA" || _pageRef == "IND00ML"}'/>
		 --%>
		<psjg:gridColumn id="PackSub_Description_${_pageRef}" colType="text"
		name="alrtSubEvtTmpVO.FULL_NAME_ENG" index="FULL_NAME_ENG"
		title="%{getText('subscriber_description_key')}" editable="false" sortable="true"
		search="true" width="300" hidden='%{_pageRef == "IND00MT" || _pageRef == "IND00P" || _pageRef == "IND00MA" || _pageRef == "IND00ML"}'/>
		
		<psjg:gridColumn id="alrtSubEvtTmpVO_CIF_NO_${_pageRef}" colType="text"
			name="alrtSubEvtTmpVO.CIF_NO" index="alrtSubEvtTmpVO.CIF_NO" search="true" sortable="true" editable="false"
			title="%{getText('cif_number_key')}" hidden="false"/>
		
		<psjg:gridColumn id="alrtSubEvtTmpVO_USR_ID_${_pageRef}" colType="text"
			name="alrtSubEvtTmpVO.USR_ID" index="alrtSubEvtTmpVO.USR_ID" search="true" sortable="true" editable="false"
			title="%{getText('imal_user_key')}" hidden="false"/>
		
		<psjg:gridColumn id="alrtSubEvtTmpVO_CHANNEL_END_USR_ID_${_pageRef}" colType="text"
			name="alrtSubEvtTmpVO.CHANNEL_END_USR_ID" index="alrtSubEvtTmpVO.CHANNEL_END_USR_ID" 
			search="true" sortable="true" editable="false" title="%{getText('channel_end_user_key')}" hidden="false"/>
		
		<psjg:gridColumn id="SubPack_ID_${_pageRef}" colType="number"
		name="alrtSubEvtTmpVO.EVT_ID" index="EVT_ID"
		title="%{getText('package_id_key')}" editable="false" sortable="true"
		search="true" width="100"  />
		
		<psjg:gridColumn id="SubPack_Description_${_pageRef}" colType="text"
		name="alrtSubEvtTmpVO.EVT_DESC_ENG" index="EVT_DESC_ENG"
		title="%{getText('package_description_key')}" editable="false" sortable="true"
		search="true" width="300" tooltip="Subscription Desc test" tooltipDelay="300000"/>
		<%--
		<psjg:gridColumn colType="liveSearch" id="subscriberPackageAccountId_${_pageRef}"
			name="packageAccountNumber" index="packageAccountNumber"
			title="%{getText('excluded_accounts_key')}" editable="true" sortable="true" 
			search="false"
			autoSearch="true"
			paramList="criteria.cif_no:lookuptxt_cifNumber_${_pageRef}"
			dataAction="${pageContext.request.contextPath}/path/alert/subscriber/individual/IndividualSubscriberCIFLookupAction_constructAccountQueryLookup"
			resultList="excludedEventAccounts:packageAccountNumber_lookuptxt"
			dependencySrc="${pageContext.request.contextPath}/path/alert/subscriber/individual/IndividualSubscriberDepAction_dependencyByAccCif"
			params="ndividualSubscriberCO.alrtSubVO.CIF_NO:lookuptxt_cifNumber_${_pageRef}"
			dependency="lookuptxt_cifNumber_${_pageRef}:individualSubscriberCO.alrtSubVO.CIF_NO"
			multiSelect="true" multiResultInput="packageCifMultiselectedAccounts"
			selectColumn="BRANCH_CODE,CURRENCY_CODE,GL_CODE,CIF_SUB_NO,SL_NO"
			tooltip="true"  
			 />
		--%>
 		<psjg:gridColumn id="packageCifMultiselectedAccounts" colType="text"
			name="packageCifMultiselectedAccounts" title="%{getText('multi_selected_account_key')}" editable="true"
			sortable="false" search="true" width="150" hidden="true" />
			
		<ps:if test='_pageRef == "SBT00SPS" || _pageRef == "SBT00SPRA" || _pageRef == "SBT00SPAD"'>
			<psjg:gridColumn id="SubPack_Status_Desc_${_pageRef}" colType="text"
				name="toBeStatusDesc" index="statusDesc"
				title="%{getText('subscription_status_key')}" editable="false"
				sortable="true" search="true" width="150" />
		</ps:if>
		<ps:else>
			<psjg:gridColumn id="SubPack_Status_Desc_${_pageRef}" colType="text"
				name="statusDesc" index="statusDesc"
				title="%{getText('subscription_status_key')}" editable="false"
				sortable="true" search="true" width="150" />
		</ps:else>
		<%-- <psjg:gridColumn id="SubPack_Status_Desc_${_pageRef}" colType="text"
			name="statusDesc" index="statusDesc"
			title="%{getText('subscription_status_key')}" editable="false" sortable="true"
			search="true" width="150"/> --%>
		
		<psjg:gridColumn id="SubPack_Status_${_pageRef}" colType="text"
		name="alrtSubEvtTmpVO.SUB_EVT_STATUS" index="SUB_EVT_STATUS"
		title="%{getText('subscription_status_key')}" editable="false" sortable="true"
		search="true" width="150" hidden="true"/>
		
			<psjg:gridColumn id="include_all_events_${_pageRef}" colType="checkbox" formatter="checkbox" 
			edittype="checkbox" editoptions="{value:'Y:N'}" 
			name="alrtPkgVO.INCLUDE_ALL_EVT_YN" index="INCLUDE_ALL_EVT_YN" align="center"
			title="%{getText('include_all_events_key')}" editable="false" sortable="true"
			search="true" width="220" />
			
		
		<psjg:gridColumn name="alrtSubEvtVO.DATE_UPDATED" id="DATE_UPDATED"  
			formatoptions="{srcformat:'Y-m-d H:i:s.u',newformat:'d/m/Y H:i:s:u' }"  index="DATE_UPDATED"
			colType="date" title="DATE_UPDATED" sortable="true" editable="false" hidden="true"/>
		
		<psjg:gridColumn id="subscriberEventsList_${_pageRef}" 
			 name="subscriberEventsList"
			 index="subscriberEventsList" 
			 colType="text" 
		     formatter="subscriptionEventsInPkg_viewDetails"
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
	$.struts2_jquery.require("SubscriptionMaint.js", null, jQuery.contextPath
			+ "/path/js/alert/subscription/");
	
	$("#subscriptionsPckgGridTbl_Id_" + _pageRef).subscribe("onSelectRowPackagesSubscription",function(obj)
	{
		var subsType = $("#subscription_type_"+_pageRef).val();
		if(_pageRef == "IND00MT" || _pageRef == "IND00P" || _pageRef == "IND00MA" || _pageRef == "IND00ML")
		{
			individualSubscriberMaint_packAndEvntselect(obj);
		}
		else if(subsType != null && subsType != "" && subsType == "SP")
		{
			dynamicGridSelectRowFuncDet(obj,'SP');
		}
		else
		{
			dynamicGridSelectRowFuncDet(obj,'SE');
		}
	});
	
	$("#subscriptionsPckgGridTbl_Id_" + _pageRef).subscribe("onSelectAllRowsPackagesSubscription",function(obj)
	{
		var subsType = $("#subscription_type_"+_pageRef).val();
		if(_pageRef == "IND00MT" || _pageRef == "IND00P" || _pageRef == "IND00MA" || _pageRef == "IND00ML")
		{
		}
		else if(subsType != null && subsType != "" && subsType == "SP")
		{
			dynamicGridSelectAllFuncDet(obj,'SP');
		}
		else
		{
			dynamicGridSelectAllFuncDet(obj,'SE');
		}
	});

	$("#subscriptionsPckgGridTbl_Id_" + _pageRef).subscribe("onGridCompletePackagesSubscriptions",function(obj)
	{
		var subsType = $("#subscription_type_"+_pageRef).val();
		if(_pageRef == "IND00MT" || _pageRef == "IND00P" || _pageRef == "IND00MA" || _pageRef == "IND00ML")
		{
			individualSubscriberMaint_gridLayoutSetting("subscriptionsPckgGridTbl_Id");
		}
		else if(subsType != null && subsType != "" && subsType == "SP")
		{
			onAfterBatchDetailScreenLoadDet(obj,'SP');
		}
		else
		{
			onAfterBatchDetailScreenLoadDet(obj,'SE');
		}
	});
	
	$("#subscriptionsPckgGridTbl_Id_" + _pageRef).subscribe('onEditInlineBeforeTopicsFuncSPDet', function(obj) 
	{
		if(_pageRef == "IND00MT" || _pageRef == "IND00P" || _pageRef == "IND00MA")
		{
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
		}
	});
</script>
		
	