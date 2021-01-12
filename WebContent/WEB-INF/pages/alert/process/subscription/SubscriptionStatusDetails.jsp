<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt" uri="/path-toolbar-tags"%>

<ps:set name="ivcrud_${_pageRef}" value="iv_crud" />
<ps:hidden id="iv_crud_${_pageRef}" name="iv_crud" />


 
<ps:form id="subscriptionStatusDetails_${_pageRef}">

<table width="100%" border="0"
			class="headerPortionContent ui-widget-content">

			<td width="10%"></td>
			<td width="1%"></td>
			<td width="1%"></td>
			<td width="1%"></td>
			<td width="0.5%"></td>
			<td width="0.5%"></td>
			<td width="0.5%"></td>
			<td width="0.5%"></td>
			<td width="0.5%"></td>
			<td width="0.5%"></td>
			<td width="1%"></td>
			<td width="1%"></td>
			<td width="1%"></td>
			<td width="1%"></td>
			<td width="1%"></td>
			<td width="10%"></td>
			
			
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			


			<tr align="left">
				<td align="left" class="fldLabelView" colspan="3">
					<ps:label key="subscription_id_key"
						id="lbl_Subscription_ID_Key_${_pageRef}"
						for="Subscription_ID_Key_${_pageRef}" />
				</td>
				<td class="fldDataEdit center" >
					<ps:textfield id="Subscription_ID_Key_${_pageRef}" tabindex="1"
						name="subscriptionCO.alrtSubEvtVO.ID" mode="text"
						readonly="true" maxlength="20" size="24"/>
				</td>
				<td colspan="7"></td>
				<td align="left" class="fldLabelView" colspan="8">
					<ps:label key="Status_key"
						id="lbl_Status_key_${_pageRef}"
						for="Status_key_${_pageRef}" />
				</td>
				<td class="fldDataEdit center" colspan="1">
					<ps:textfield id="Status_key_${_pageRef}" tabindex="2"
						name="subscriptionCO.alrtSubEvtVO.STATUS" mode="text"
						readonly="true" maxlength="20" size="24" />
				</td>
			</tr>
</table>

<div id="SubscriptionStatusDetails_${_pageRef}"
	class="connectedSortable ui-helper-reset">
	<br>
	<div id="SubscriptionStatusDetails_${_pageRef}"
		class="collapsibleContainer"
		title="<ps:text name='Date_Suspended_key'/>">
		<table width="100%" border="0"
			class="headerPortionContent ui-widget-content">

			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>


			<tr align="left">
				<td align="left" class="fldLabelView" colspan="1">
					<ps:label key="created_by_key"
						id="lbl_Created_By_${_pageRef}"
						for="Created_By_${_pageRef}" />
				</td>
				<td class="fldDataEdit center" colspan="2">
					<ps:textfield id="Created_By_${_pageRef}" tabindex="3"
						name="subscriptionCO.alrtSubEvtVO.CREATED_BY" mode="text"
						readonly="true" maxlength="20" />
				</td>
				<td colspan="1"></td>
				<td align="left" class="fldLabelView" colspan="1">
					<ps:label key="Modified_By_key"
						id="lbl_Modified_By_${_pageRef}"
						for="Modified_By_${_pageRef}" />
				</td>
				<td class="fldDataEdit center" colspan="2">
					<ps:textfield id="Modified_By_${_pageRef}" tabindex="4"
						name="subscriptionCO.alrtSubEvtVO.MODIFIED_BY" mode="text"
						readonly="true" maxlength="20" />
				</td>
			</tr>

			<tr align="left">
				<td align="left" class="fldLabelView" colspan="1">
					<ps:label key="date_created_key"
						id="lbl_Date_Created_${_pageRef}"
						for="Date_Created_${_pageRef}" />
				</td>
				<td class="fldDataEdit center" colspan="2">
					<psj:datepicker timepicker="true" id="Date_Created_${_pageRef}" tabindex="5"
						name="subscriptionCO.alrtSubEvtVO.DATE_CREATED" disabled="true"
						readonly="true"  buttonImageOnly="true" timepickerFormat="hh:mm:ss"  />
				</td>
				<td colspan="1"></td>
				<td align="left" class="fldLabelView" colspan="1">
					<ps:label key="Date_Modified_key"
						id="lbl_Date_Modified_${_pageRef}"
						for="Date_Modified_${_pageRef}" />
				</td>
				<td class="fldDataEdit center" colspan="2">
					<psj:datepicker id="Date_Modified_${_pageRef}" tabindex="6"
						name="subscriptionCO.alrtSubEvtVO.DATE_MODIFIED" disabled="true"
						readonly="true"  buttonImageOnly="true" timepicker="true" timepickerFormat="hh:mm:ss" />
				</td>
			</tr><tr>
			</tr><tr>
			</tr><tr>
			</tr><tr>
			</tr><tr>
			</tr><tr>
			</tr>
			<tr align="left">
				<td align="left" class="fldLabelView" colspan="1">
					<ps:label key="Authorized_by_key"
						id="lbl_Authorized_By_${_pageRef}"
						for="Authorized_By_${_pageRef}" />
				</td>
				<td class="fldDataEdit center" colspan="2">
					<ps:textfield id="Authorized_By_${_pageRef}" tabindex="7"
						name="subscriptionCO.alrtSubEvtVO.AUTHORIZED_BY" mode="text"
						readonly="true" maxlength="20" />
				</td>
				<td colspan="1"></td>
				<td align="left" class="fldLabelView" colspan="1">
					<ps:label key="Suspended_by_key"
						id="lbl_Suspended_By_${_pageRef}"
						for="Suspended_By_${_pageRef}" />
				</td>
				<td class="fldDataEdit center" colspan="2">
					<ps:textfield id="Suspended_By_${_pageRef}" tabindex="8"
						name="subscriptionCO.alrtSubEvtVO.SUSPENDED_BY" mode="text"
						readonly="true" maxlength="20" />
				</td>
			</tr>

			<tr align="left">
				<td align="left" class="fldLabelView" colspan="1">
					<ps:label key="date_authorized_key"
						id="lbl_Date_Authorized_${_pageRef}"
						for="Date_Authorized_${_pageRef}" />
				</td>
				<td class="fldDataEdit center" colspan="2">
					<psj:datepicker id="Date_Authorized_${_pageRef}" tabindex="9"
						name="subscriptionCO.alrtSubEvtVO.DATE_AUTHORIZED" disabled="true"
						readonly="true"  buttonImageOnly="true" timepicker="true"  timepickerFormat="hh:mm:ss"/>
				</td>
				<td colspan="1"></td>
				<td align="left" class="fldLabelView" colspan="1">
					<ps:label key="Date_Suspended_key"
						id="lbl_Date_Suspended_${_pageRef}"
						for="Date_Suspended_${_pageRef}" />
				</td>
				<td class="fldDataEdit center" colspan="2">
					<psj:datepicker id="Date_Suspended_${_pageRef}" tabindex="10"
						name="subscriptionCO.alrtSubEvtVO.DATE_SUSPENDED" disabled="true"
						readonly="true"  buttonImageOnly="true" timepicker="true" timepickerFormat="hh:mm:ss"/>
				</td>
			</tr>
			</tr><tr>
			</tr><tr>
			</tr><tr>
			</tr><tr>
			</tr><tr>
			</tr><tr>
			<tr align="left">
				<td align="left" class="fldLabelView" colspan="1">
					<ps:label key="Deleted_By_key"
						id="lbl_Deleted_By_${_pageRef}"
						for="Deleted_By_${_pageRef}" />
				</td>
				<td class="fldDataEdit center" colspan="2">
					<ps:textfield id="Deleted_By_${_pageRef}" tabindex="11"
						name="subscriptionCO.alrtSubEvtVO.DELETED_BY" mode="text"
						readonly="true" maxlength="20" />
				</td>
			</tr>
			<tr align="left">
				<td align="left" class="fldLabelView" colspan="1">
					<ps:label key="Date_Deleted_key"
						id="lbl_Date_Deleted_${_pageRef}"
						for="Date_Deleted_${_pageRef}" />
				</td>
				<td class="fldDataEdit center" colspan="2">
					<psj:datepicker id="Date_Deleted_${_pageRef}" tabindex="12"
						name="subscriptionCO.alrtSubEvtVO.DATE_DELETED" disabled="true"
						readonly="true"  buttonImageOnly="true" timepicker="true" timepickerShowSecond="true"/>
				</td>
			</tr>
			
		</table>
	</div>
</div>

</ps:form>