<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt" uri="/path-toolbar-tags"%>

<ps:set name="record_reactivated_key"
	value="%{getEscText('record_reactivated_key')}" />
	
<ps:set name="event_communication_key"
	value="%{getEscText('event_communication_key')}" />
	
<ps:set name="customization_key"
	value="%{getEscText('customization_key')}" />
	
<ps:set name="ivcrud_${_pageRef}" value="iv_crud" />
<ps:hidden id="iv_crud_${_pageRef}" name="iv_crud" />
<ps:hidden id="enable_omni" name="enable_omni" />

<div id="infoBar">
	<table width="100%"
		class="ui-widget-header ui-state-focus ui-corner-all">
		<tr>
			<td nowrap="nowrap">
				<ps:property value="_pageRef" escapeHtml="true"/>
			</td>
		</tr>
	</table>
</div>
 
<ps:form id="subscriptionMaintForm_${_pageRef}">

<ps:hidden id="selSerialNo_S_${_pageRef}"></ps:hidden>
<ps:hidden id="all_rows_S_${_pageRef}"></ps:hidden>
<ps:hidden id="selSerialNo_G_${_pageRef}"></ps:hidden>
<ps:hidden id="all_rows_G_${_pageRef}"></ps:hidden>
<ps:hidden id="selSerialNo_P_${_pageRef}"></ps:hidden>
<ps:hidden id="all_rows_P_${_pageRef}"></ps:hidden>
<ps:hidden id="selSerialNo_E_${_pageRef}"></ps:hidden>
<ps:hidden id="all_rows_E_${_pageRef}"></ps:hidden>
<ps:hidden id="selSerialNo_SE_${_pageRef}"></ps:hidden>
<ps:hidden id="all_rows_SE_${_pageRef}"></ps:hidden>
<ps:hidden id="selSerialNo_SP_${_pageRef}"></ps:hidden>
<ps:hidden id="all_rows_SP_${_pageRef}"></ps:hidden>
<ps:hidden id="selSerialNo_EG_${_pageRef}"></ps:hidden>
<ps:hidden id="all_rows_EG_${_pageRef}"></ps:hidden>
<ps:hidden id="selSerialNo_GP_${_pageRef}"></ps:hidden>
<ps:hidden id="all_rows_GP_${_pageRef}"></ps:hidden>
<ps:hidden id="populatedYN_${_pageRef}"></ps:hidden>
<ps:hidden id="subscription_type_${_pageRef}" name="subscriptionCO.subscriptionType"></ps:hidden>
<ps:hidden id="selSerialNoDet_${_pageRef}" name="subscriptionCO.selSerialNoDet"></ps:hidden>
			
	<div id="subGrids_<ps:property value="_pageRef" escapeHtml="true"/>" style="padding: 5px; width: 98%" >
		<%@include file="SubscriptionList.jsp"%>
  	</div>
	<br/>
<ptt:toolBar id="subscription_toolbar">
    <psj:submit id="subscriptionMaint_delete_selected_${_pageRef}" button="true" freezeOnSubmit="true" onclick="deleteSubscription()">
    	<ps:label key="approve_delete_key" for="subscriptionMaint_delete_selected_${_pageRef}"/>
    </psj:submit>
        <psj:submit id="subscriptionMaint_save_populated_${_pageRef}" cssStyle="margin-left: -3px;" button="true" freezeOnSubmit="true" onclick="saveSubscription()">
    	<ps:label key="save_key" for="subscriptionMaint_save_populated_${_pageRef}"/>
    </psj:submit>
     <psj:submit id="subscriptionMaint_approve_${_pageRef}" cssStyle="margin-left: -6px;" button="true" freezeOnSubmit="true" onclick="approveSubscription()">
    	<ps:label key="approve_key" for="subscriptionMaint_approve_${_pageRef}"/>
    </psj:submit>
     <psj:submit id="subscriptionMaint_toBeDeleted_${_pageRef}" cssStyle="margin-left: -9px;" button="true" freezeOnSubmit="true" onclick="toBeDeletedSubscription()">
    	<ps:label key="btn.toDel" for="subscriptionMaint_toBeDeleted_${_pageRef}"/>
    </psj:submit>
     <psj:submit id="subscriptionMaint_reject_${_pageRef}" button="true" freezeOnSubmit="true" onclick="toBeDeletedSubscription(1)">
    	<ps:label key="reject_key" for="subscriptionMaint_reject_${_pageRef}"/>
    </psj:submit>
    <psj:submit id="subscriptionMaint_updateAfterApprove_${_pageRef}" cssStyle="margin-left: -15px;" button="true" freezeOnSubmit="true" onclick="updateAfterApproveSubscription()">
    	<ps:label key="Update_After_Approve_key" for="subscriptionMaint_updateAfterApprove_${_pageRef}"/>
    </psj:submit>
    <psj:submit id="subscriptionMaint_toBeSuspend_${_pageRef}" cssStyle="margin-left: -18px;" button="true" freezeOnSubmit="true" onclick="toBeSuspendSubscription()">
    	<ps:label key="Suspend_key" for="subscriptionMaint_toBeSuspend_${_pageRef}"/>
    </psj:submit>
    <psj:submit id="subscriptionMaint_suspend_${_pageRef}" cssStyle="margin-left: -21px;" button="true" freezeOnSubmit="true" onclick="suspendSubscription()">
    	<ps:label key="Authorize_Suspend_key" for="subscriptionMaint_suspend_${_pageRef}"/>
    </psj:submit>
    <psj:submit id="subscriptionMaint_toBeReactivate_${_pageRef}" cssStyle="margin-left: -25px;" button="true" freezeOnSubmit="true" onclick="toBeReactivateSubscription()">
    	<ps:label key="Reactivate_key" for="subscriptionMaint_toBeReactivate_${_pageRef}"/>
    </psj:submit>
    <psj:submit id="subscriptionMaint_reactivate_${_pageRef}" cssStyle="margin-left: -28px;" button="true" freezeOnSubmit="true" onclick="reactivateSubscription()">
    	<ps:label key="	Authorize_Reactivate_key" for="subscriptionMaint_reactivate_${_pageRef}"/>
    </psj:submit>
</ptt:toolBar>

</ps:form>
<script type="text/javascript">
var record_reactivated_key = '<ps:property value="record_reactivated_key"  escapeHtml="false" escapeJavaScript="true"/>'; 
var event_communication_key = '<ps:property value="event_communication_key"  escapeHtml="false" escapeJavaScript="true"/>';
var customization_key = '<ps:property value="customization_key"  escapeHtml="false" escapeJavaScript="true"/>';

$.struts2_jquery.require("SubscriptionMaint.js",null,jQuery.contextPath+"/path/js/alert/subscription/");

</script>					
						
