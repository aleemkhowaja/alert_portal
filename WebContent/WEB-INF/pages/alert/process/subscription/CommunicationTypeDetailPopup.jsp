<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt" uri="/path-toolbar-tags"%>

<div style="padding: 5px;">
	<ps:hidden name="rowId" id="rowId_${_pageRef}"></ps:hidden>
	
	<ps:url id="CommunicationTypeDetailPopupGridUrl" escapeAmp="false"
		action="SubscriptionListAction_LoadCommunicationTypeDetailPopupGrid"
		namespace="/path/alert/subscription">
		 	<ps:param name="_pageRef" value="_pageRef"></ps:param>
		 	<ps:param name="subscriptionSC.EVT_ID" value="subscriptionSC.EVT_ID"></ps:param>
		 	<ps:param name="subscriptionSC.SUB_ID" value="subscriptionSC.SUB_ID"></ps:param>
		 	<ps:param name="subscriptionSC.ID" value="subscriptionSC.ID"></ps:param>
	</ps:url>
	
	<psjg:grid 
	    id="communicationTypeDetailPopup_${_pageRef}"
		href="%{CommunicationTypeDetailPopupGridUrl}" 
		dataType="json"
		caption=""
		hiddengrid="false"
		pager="false" 
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
		height="125" 
		editinline="true"
		onGridCompleteTopics="disableCheckBox"
		>
		
		<psjg:gridColumn id="excludeYn_${_pageRef}"
				name="EXCLUDE_YN" index="EXCLUDE_YN"
				title="%{getText('exclude_key')}" 
				colType="checkbox" 
				edittype="checkbox"
				formatter="checkbox"
				editable="true"
				sortable="false" 
				search="false" 
				width="50" 
				editoptions="{value:'1:0',align:'middle', dataEvents: [{ type: 'click', fn: function(e) { }}]}"
				align="center"
				searchoptions="{sopt:['eq']}"
				formatoptions="{disabled:false}"
			/>	
			
		<psjg:gridColumn id="COMMUNICATION_TYPE_DESC_${_pageRef}" colType="text"
			name="COMMUNICATION_TYPE_DESC" index="COMMUNICATION_TYPE_DESC"
			title="%{getText('Communication_type')}" editable="false"
			sortable="false" search="false" width="100"/>
			
		<psjg:gridColumn id="communicationType_${_pageRef}" colType="text"
			name="alrtEvtCommModeVO.COMMUNICATION_TYPE" index="alrtEvtCommModeVO.COMMUNICATION_TYPE"
			title="%{getText('Communication_type')}" editable="false" hidden="true"
			sortable="true" search="true" width="100" />
			
		<psjg:gridColumn id="checked_${_pageRef}" colType="text"
			name="checked" index="Checked"
			title="%{getText('checked')}" editable="false"
			sortable="true" search="true" width="10" hidden="true"/>
			
		<psjg:gridColumn id="readOnly_${_pageRef}" colType="text"
			name="readOnly" index="ReadOnly"
			title="%{getText('read_only')}" editable="false"
			sortable="true" search="true" width="10" hidden="true" />		
	</psjg:grid>
</div>
<script type="text/javascript">
$("#communicationTypeDetailPopup_" + _pageRef).subscribe("disableCheckBox",function(event,data)
{
	disableCheckBox(event,data);
});
</script>