<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt"  uri="/path-toolbar-tags" %>

<ps:hidden id="oldFixedEvent_${_pageRef}" name="individualEventCO.fixedEventId" />

<table width="100%" border="0">
	<tr>
		<td width="5%"></td>
		<td width="12%"></td>
		<td width="73%"></td>
	</tr>
	<tr>
		<td colspan="1" class="fldLabelView"><ps:label
			key="generic_filter_key" id="lbl_fixedEvent_${_pageRef}"
			for="lookuptxt_fixedEventid_${_pageRef}" />
		</td>
		<td colspan="1">
			<ps:select
				id="fixedEventTypeId_${_pageRef}"
			 	list="fixedEventTypeList"  
			 	listKey="code" 
			 	listValue="descValue" 
			 	name="individualEventCO.alrtEvtVO.FIXED_EVENT_ID"
				tabindex="9"
				parameter="individualEventCO.alrtEvtVO.EVT_TYPE:eventType_${_pageRef},individualEventCO.alrtEvtVO.SOURCE_OF_CONTACT:SOURCE_OF_CONTACT_${_pageRef},individualEventCO.alrtEvtVO.FIXED_EVENT_ID:fixedEventTypeId_${_pageRef}"
				dependencySrc="${pageContext.request.contextPath}/path/alert/events/event/IndividualEventMaintAction_applyDisplaySettingFields"
				dependency="fixedEventTypeId_${_pageRef}:individualEventCO.alrtEvtVO.FIXED_EVENT_ID"
				cssStyle="width: 100%;"
				onchange="fixEventdetails_conformOnChangeFixedEvent();showHideSms()"
			/>
			
							<%-- onchange="loadFixEventform('1')" --%>
			
		</td>
		<td colspan="2">
			<psj:submit button="true" type="button" onclick="fixEventdetails_onCustomExpressionClicked();">
				<ps:text name="custom_expression"/>
			</psj:submit>
		</td>
	</tr>
</table>
<table  width="100%">
	<tr>
		<td colspan="4">
			<div id="fixEventParamsdetails_${_pageRef}" class="connectedSortable ui-helper-reset">
				<div id="fixEventParamssDetails_Inner_${_pageRef}" class="collapsibleContainer collapsed" title="<ps:text name='fixed_parameters'/>">
					<%@include file="IndFixedParamList.jsp"%>
				</div>
			</div>
		</td>
	</tr>
</table>