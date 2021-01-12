<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@include file="/WEB-INF/pages/alert/common/AlertAppTrans.jsp"%>
<%@taglib prefix="pt" uri="/path-toolbar-tags"%>
<div id="controlRecordMaintPage_id_<ps:property value="_pageRef" escapeHtml="true"/>"  style="width: 100%;">
<jsp:include page="/WEB-INF/pages/common/login/InfoBar.jsp" />


<ps:form useHiddenProps="true" id="userSelectionFormId_${_pageRef}"
	namespace="/path/assets/userselection">


<!-- <script type="text/javascript">
var myText = '<ps:property value="controlRecordCO.activFlag" />';
</script> -->
<%-- 
<ps:property value="controlRecordCO.activFlag" />
 --%>
<ps:hidden id="sle_pass_hidden_${_pageRef}" name="controlRecordCO.passwordChanged"></ps:hidden>
<ps:hidden name="webServiceExplorerCO.mappingID"  id="mappingId_${_pageRef}" />

<ps:set name="mailDialogTitleKey" value="%{getEscText('mail_dialog_config_title_key')}"/>
<ps:set name="smsDialogTitleKey" value="%{getEscText('sms_dialog_config_title_key')}"/>
<ps:set name="omniDialogTitleKey" value="%{getEscText('omni_dialog_config_title_key')}"/>

 <script type="text/javascript">
$.struts2_jquery.require("ControlRecordMaint.js", null, jQuery.contextPath
		+ "/path/js/alert/controlrecord/");
$.struts2_jquery.require("CommonPwsMappingMaint.js", null, jQuery.contextPath
		+ "/path/js/commonpwsmapping/pwsmapping/");

$("#system_events_" + _pageRef).collapsiblePanel();
$("#communicationType_" + _pageRef).collapsiblePanel();

// @todo fix those as constant
var mailDialogTitleKey = "${mailDialogTitleKey}";
var mailMappingID = 1;

var smsDialogTitleKey = "${smsDialogTitleKey}";
var smsMappingID = 2;

var omniDialogTitleKey = "${omniDialogTitleKey}";
var omniMappingID = 3;
</script>

<script>
$(document).ready(function() {
	var protType = $("#protocol_type_" + _pageRef).val();
	if (protType == "O") {
		$("#sle_pass_" + _pageRef).hide();
	}
	else{
		document.getElementById("sle_pass_${_pageRef}").value = document.getElementById("sle_pass_hidden_${_pageRef}").value;
		 
	}
});
</script>
			
<div id="system_events_${_pageRef}" title="<ps:text name="system_events_key"/>"  style="margin-bottom:5px;">			
	<table border="0" width="95%">
		<tr>
			<td width="30%"></td>
			<td width="2%" ></td>
			<td width="10%"></td>
			<td width="1%"></td>			
			<td width="6%"></td>
			<td></td>								
		</tr>
		<tr>
			 <td>
				<div class="left">
					<ps:checkbox 
						id="ddb_activation_${_pageRef}"
						key="activate_notification_on_subscription_key"
						name="controlRecordCO.activFlag" tabindex="1"
						valOpt="1:0"
						cssClass="ui-widget-content checkboxheight" 
						dependencySrc="${pageContext.request.contextPath}/path/alert/controlrecord/ControlRecordDepAction_dependencyByBoxes"
						parameter="controlRecordCO.checkBoxFlag:ddb_activation_${_pageRef},controlRecordCO.id:'sle_evt_id',controlRecordCO.name:'controlRecordCO.activEvt',controlRecordCO.progRef:'CTRL00MT'"
						dependency="sle_evt_id_${_pageRef}:controlRecordCO.activEvt"/>
		       </div>
			</td>
			<td>
			</td>
			<td  align="right">
				<ps:label 
					key="system_event_id_key" 
					id="lbl_sle_evt_id_${_pageRef}"
					for="lookuptxt_sle_evt_id_${_pageRef}" />
			</td>
			<td>
			</td>
			<td width="5%">
				<psj:livesearch
					name="controlRecordCO.activEvt"
					id="sle_evt_id_${_pageRef}" 
					mode="number" 
					maxlength ="8" 
					tabindex="2" 
					minValue="0" 
					resultList="EVT_ID:lookuptxt_sle_evt_id_${_pageRef}"
					actionName="${pageContext.request.contextPath}/path/alert/controlrecord/systemEvtLookupAction_constructSysEvtLookup"
					dependencySrc=""
					dependency=""
					parameter=""
					searchElement="" >
				</psj:livesearch>
			</td>
			<td></td>
		</tr> 
		<tr>
			<td>
				<div class="left">
					<ps:checkbox 
						id="ddlb_reactivation_${_pageRef}"
						key="activate_notification_on_subscription_reactivation_key"
						name="controlRecordCO.reactivFlag" 
						tabindex="3"
						cssClass="ui-widget-content checkboxheight"
						valOpt="1:0"
						dependencySrc="${pageContext.request.contextPath}/path/alert/controlrecord/ControlRecordDepAction_dependencyByBoxes"
					    parameter="controlRecordCO.checkBoxFlag:ddlb_reactivation_${_pageRef},controlRecordCO.id:'react_evt_id',controlRecordCO.name:'controlRecordCO.reactivEvt',controlRecordCO.progRef:'CTRL00MT'"
						dependency="react_evt_id_${_pageRef}:controlRecordCO.reactivEvt"
					/>
				</div>
			</td>
			<td></td>
			<td  align="right">
				<ps:label 
					key="system_event_id_key" 
					id="lbl_react_evt_id_${_pageRef}"
					for="lookuptxt_react_evt_id_${_pageRef}" />
			</td>
			<td></td>
			<td width="5%">		
			    <psj:livesearch
					name="controlRecordCO.reactivEvt"
					id="react_evt_id_${_pageRef}" 
					mode="number" 
					maxlength ="8" 
					tabindex="2" 
					minValue="0" 
					resultList="EVT_ID:lookuptxt_react_evt_id_${_pageRef}"
					actionName="${pageContext.request.contextPath}/path/alert/controlrecord/systemEvtLookupAction_constructSysEvtLookup"
					dependencySrc=""
					dependency=""
					parameter=""
					searchElement="" >
				</psj:livesearch>
			</td>
			<td>
			</td>
		</tr>
		<tr>
			<td>
				<div class="left">
					<ps:checkbox 
						id="ddlb_suspend_${_pageRef}"
						key="activate_notification_on_subscription_suspension_key"
						name="controlRecordCO.suspendFlag" tabindex="5"
						cssClass="ui-widget-content checkboxheight" 
						valOpt="1:0"
						dependencySrc="${pageContext.request.contextPath}/path/alert/controlrecord/ControlRecordDepAction_dependencyByBoxes"
						parameter="controlRecordCO.checkBoxFlag:ddlb_suspend_${_pageRef},controlRecordCO.id:'susp_evt_id',controlRecordCO.name:'controlRecordCO.suspendEvt',controlRecordCO.progRef:'CTRL00MT'"
						dependency="susp_evt_id_${_pageRef}:controlRecordCO.suspendEvt"
					/>
	       		</div>
			</td>
			<td>
			</td>
			<td align="right">
				<ps:label 
					key="system_event_id_key" 
					id="lbl_susp_evt_id_${_pageRef}"
					for="lookuptxt_susp_evt_id_${_pageRef}" />
			</td>
			<td></td>
			<td width="5%">		
			    <psj:livesearch
					name="controlRecordCO.suspendEvt"
					id="susp_evt_id_${_pageRef}" 
					mode="number" 
					maxlength ="8" 
					tabindex="2" 
					minValue="0" 
					resultList="EVT_ID:lookuptxt_susp_evt_id_${_pageRef}"
					actionName="${pageContext.request.contextPath}/path/alert/controlrecord/systemEvtLookupAction_constructSysEvtLookup"
					dependencySrc=""
					dependency=""
					parameter=""
					searchElement="" >
				</psj:livesearch>
			</td>
			
			<td></td>
		</tr>
		<tr>
			<td>
				<div class="left">
					<ps:checkbox 
						id="ddlb_mobileupdate_${_pageRef}"
						key="enable_mob_num_update_service_key"
						name="controlRecordCO.mobileFlag" 
						tabindex="7"
						cssClass="ui-widget-content checkboxheight" 
						valOpt="1:0"
						dependencySrc="${pageContext.request.contextPath}/path/alert/controlrecord/ControlRecordDepAction_dependencyByBoxes"
						parameter="controlRecordCO.checkBoxFlag:ddlb_mobileupdate_${_pageRef},controlRecordCO.id:'mobile_evt_id',controlRecordCO.name:'controlRecordCO.mobileEvt',controlRecordCO.progRef:'CTRL00MT'"
						dependency="mobile_evt_id_${_pageRef}:controlRecordCO.mobileEvt"/>
		       </div>
			</td>
			<td></td>
			<td  align="right">
				<ps:label 
					key="system_event_id_key" 
					id="lbl_mobile_evt_id_${_pageRef}"
					for="lookuptxt_mobile_evt_id_${_pageRef}" />
			</td>
			<td></td>
<%-- 			<td width="5%">
				<ps:textfield 
					id="mobile_evt_id_${_pageRef}"
					name="controlRecordCO.mobileEvt" 
					tabindex="8"
					mode="number"  
					maxlength ="8" />
			</td> --%>
			<td width="5%">		
	    		<psj:livesearch
					name="controlRecordCO.mobileEvt"
					id="mobile_evt_id_${_pageRef}" 
					mode="number" 
					maxlength ="8" 
					tabindex="2" 
					minValue="0" 
					resultList="EVT_ID:lookuptxt_mobile_evt_id_${_pageRef}"
					actionName="${pageContext.request.contextPath}/path/alert/controlrecord/systemEvtLookupAction_constructSysEvtLookup"
					dependencySrc=""
					dependency=""
					parameter=""
					searchElement="" >
				</psj:livesearch>
			</td>
			<td></td>
		 </tr>					
	</table>
</div>

<div id="communicationType_${_pageRef}" title="<ps:text name="email_configuration_key"/>">
	<table border="0" width="95%">
		<tr>
				<td width="10%"></td>
				<td width="15%"></td>
				<td width="15%"></td>
				<td width="20%"></td>	
				<td width="35%"></td>		
		</tr>
		<tr>
			<%--<td class="fldLabelView">
				<ps:label key="protocol_type_key" id="lbl_protocol_type_${_pageRef}"
					for="protocol_type_${_pageRef}" />
			</td>
			<td class="fldDataEdit center">
				<ps:select id="protocol_type_${_pageRef}"
				name="controlRecordCO.protocolType" list="protocolTypeDropDown"
				listKey="code" listValue="descValue" emptyOption="false"
				disabled="false" 
				parameter="controlRecordCO.protocolType:protocol_type_${_pageRef},controlRecordCO.progRef:'CTRL00MT',
				controlRecordCO.senderEmail:sle_sender_email_${_pageRef},controlRecordCO.ipAddress:sle_ip_${_pageRef},
				controlRecordCO.portNumber:sle_port_${_pageRef},controlRecordCO.userId:sle_user_${_pageRef},
				controlRecordCO.password:sle_pass_${_pageRef}"
				dependencySrc="${pageContext.request.contextPath}/path/alert/controlrecord/ControlRecordDepAction_dependencyByProtType"
				dependency="protocol_type_${_pageRef}:controlRecordCO.protocolType
				,sle_sender_email_${_pageRef}:controlRecordCO.senderEmail
				,sle_ip_${_pageRef}:controlRecordCO.ipAddress,sle_port_${_pageRef}:controlRecordCO.portNumber
				,sle_user_${_pageRef}:controlRecordCO.userId,sle_pass_${_pageRef}:controlRecordCO.password"
				/>
				
			</td>--%>
			<td class="fldLabelView">
				<ps:label key="email_config_type_key" id="lbl_email_config_type_${_pageRef}"
					for="email_config_type_${_pageRef}" />
			</td>
			<td class="fldDataEdit center">
				<ps:select id="email_config_type_${_pageRef}"
				name="controlRecordCO.emailConfigType" list="emailConfigTypeDropDown"
				listKey="code" listValue="descValue" emptyOption="false"
				disabled="false" 
				parameter="controlRecordCO.emailConfigType:email_config_type_${_pageRef},controlRecordCO.progRef:'CTRL00MT',
				controlRecordCO.senderEmail:sle_sender_email_${_pageRef},controlRecordCO.ipAddress:sle_ip_${_pageRef},
				controlRecordCO.portNumber:sle_port_${_pageRef},controlRecordCO.userId:sle_user_${_pageRef},
				controlRecordCO.password:sle_pass_${_pageRef}"
				dependencySrc="${pageContext.request.contextPath}/path/alert/controlrecord/ControlRecordDepAction_dependencyByEmailConfigType"
				dependency="email_config_type_${_pageRef}:controlRecordCO.emailConfigType
				,sle_sender_email_${_pageRef}:controlRecordCO.senderEmail
				,sle_ip_${_pageRef}:controlRecordCO.ipAddress,sle_port_${_pageRef}:controlRecordCO.portNumber
				,sle_user_${_pageRef}:controlRecordCO.userId,sle_pass_${_pageRef}:controlRecordCO.password"
				/>				
			</td>			
			
<%-- 			<td>
				<psj:a href="#" id="custom_email_btn_${_pageRef}" indicator="indicator" button="true"
							onclick="javascript:ctrl_configEmail()">
							<ps:text name="open_config_dialog"></ps:text></psj:a>
			</td>	 --%>		
	    </tr>
	    
	    <tr>
	    	<td  align="right">
			<ps:label key="sender_email_address_key" 
				id="lbl_sle_sender_email_${_pageRef}"
				for="sle_sender_email_${_pageRef}" />
				
		   </td>
		   <td>
				<ps:textfield id="sle_sender_email_${_pageRef}"
					name="controlRecordCO.senderEmail" tabindex="2"
					mode="character" maxlength ="30" style="width:100%" disabled="true"/>
		   </td>
		   <td></td>
	    </tr>
	    
	    <tr>      
	      	<td  align="right">
				<ps:label key="ip_address_key" 
					id="lbl_sle_ip_${_pageRef}"
					for="sle_ip_${_pageRef}" />
		   </td>
		   <td>
				<ps:textfield id="sle_ip_${_pageRef}"
					name="controlRecordCO.ipAddress" tabindex="2"
					mode="character" maxlength ="30" style="width:100%" disabled="true"/>
		   </td>
		   <td></td>
	    </tr>
	      <tr>
	       <td  align="right">
			<ps:label key="port_number_key" 
				id="lbl_sle_port_${_pageRef}"
				for="sle_port_${_pageRef}" />
		   </td>
		   <td>
				<ps:textfield id="sle_port_${_pageRef}"
					name="controlRecordCO.portNumber" tabindex="2"
					mode="character" maxlength ="30" style="width:100%;height:20px;" disabled="true"/>
		   </td>
		   <td></td>
	    </tr>
	     <tr>
	       <td  align="right">
			<ps:label key="user_id_key" 
				id="lbl_sle_user_${_pageRef}"
				for="sle_user_${_pageRef}" />
		   </td>
		   <td>
				<ps:textfield id="sle_user_${_pageRef}"
					name="controlRecordCO.userId" tabindex="2"
					mode="character" maxlength ="30" style="width:100%" disabled="true"/>
		   </td>
		   <td></td>
	    </tr>
	    
	    <tr>
		       <td  align="right">
					<ps:label key="password_key" 
						id="lbl_sle_pass_${_pageRef}"
						for="sle_pass_${_pageRef}" />
		  	   </td> 	 	     
			<td>
			<ps:password style="height:20px" id="sle_pass_${_pageRef}" name="controlRecordCO.password" value=""
	  		showPassword="true"	maxlength="30" tabindex="2" mode="character" disabled="true"/>
			</td>   
		   <td>
		   </td>
	    </tr>
	    <br/>
	    <tr>
	    	<td class="fldLabelView">
				<ps:label key="sms_config_type_key" id="lbl_custom_sms_btn_${_pageRef}"
					for="sms_config_type_${_pageRef}" />
			</td>
			
			<td class="fldDataEdit center">
					<ps:select id="sms_config_type_${_pageRef}"
						name="controlRecordCO.smsConfigType" 
						list="smsConfigTypeDropDown"
						listKey="code" 
						listValue="descValue" 
						emptyOption="false"
						disabled="false" 
						parameter="controlRecordCO.smsConfigType:sms_config_type_${_pageRef},controlRecordCO.progRef:'CTRL00MT'"
						dependencySrc="${pageContext.request.contextPath}/path/alert/controlrecord/ControlRecordDepAction_dependencyBySmsConfigType"
						dependency="sms_config_type_${_pageRef}:controlRecordCO.smsConfigType"/>
			</td>
			
<%-- 		  <td>
			<psj:a href="#" id="custom_sms_btn_${_pageRef}" indicator="indicator" button="true"
							onclick="javascript:ctrl_configSms()">
							<ps:text name="open_config_dialog"></ps:text>
			</psj:a>
		    </td> --%>
	    </tr>
	    
	    <br/>
<%-- 	     <tr>
	        <td class="fldLabelView">
				<ps:label key="omni_config_type_key" id="lbl_custom_sms_btn_${_pageRef}"
					for="custom_omni_btn_${_pageRef}" />
			</td>
	        <td >
			<psj:a href="#" id="custom_omni_btn_${_pageRef}" indicator="indicator" button="true"
							onclick="javascript:ctrl_configOmni()">
							<ps:text name="open_config_dialog"></ps:text></psj:a>
		   </td>
		  </tr> --%>
 </table>
 </div>
<%-- <tr></tr>
<tr>
  
	<td  colspan="20">
	 <fieldset  class="ui-widget-content ui-corner-all">
	 <legend >
		 <ps:label key="subscriptions_list_key" id="lbl_subscriptionList_${_pageRef}" />
	 </legend>
	<br>
	<table border="0" width="95%">
	<tr>
				<td width="22%"></td>
				<td width="10%" ></td>
				<td></td>				
	</tr>

	<tr>
	 <td>
		<div class="left">
					<ps:checkbox id="cbx_printlist_${_pageRef}"
						key="print_list_upon_approval_key"
						name="controlRecordCO.printFlag" tabindex="9"
						cssClass="ui-widget-content checkboxheight" 
						valOpt="1:0"
						dependencySrc="${pageContext.request.contextPath}/path/alert/controlrecord/ControlRecordDepAction_dependencyByBoxes"
					    parameter="controlRecordCO.checkBoxFlag:cbx_printlist_${_pageRef},controlRecordCO.id:'sle_rep_id',controlRecordCO.name:'controlRecordCO.accRepID',controlRecordCO.progRef:'CTRL00MT'"
						dependency="sle_rep_id_${_pageRef}:controlRecordCO.accRepID"
						/>
       </div>
	</td>
	<td></td>
	<td></td>
	</tr>
	<tr>
	<td>&nbsp;
		<ps:label key="report_id_of_the_list_to_print_for_account_subscribers_key"
			id="lbl_sle_rep_id_${_pageRef}"
			for="sle_rep_id_${_pageRef}" /> 
	</td>
	<td align ="left"><ps:textfield id="sle_rep_id_${_pageRef}"
			name="controlRecordCO.accRepID" tabindex="10"
			mode="number"  maxlength ="30" style="width:60px" />
	</td>
	<td></td>
	 </tr>
	 <tr><td colspan="3"></td></tr>
	 
 </table>
 </fieldset>
</td>
</tr>

<tr></tr>
<tr>
  
	<td  colspan="20">
	 <fieldset  class="ui-widget-content ui-corner-all">
	 <legend >
		 <ps:label key="subscribers_information_key" id="lbl_subscribersInformation_${_pageRef}" />
	 </legend>
	<br>
	<table border="0" width="95%">
	<tr>
		<td width="30%"></td>
				<td width="2%" ></td>
				<td width="20%"></td>
				<td width="4%"></td>			
				<td width="20%"></td>
				<td></td>
	</tr>

	<tr>
	 <td colspan="2">
		<div class="left">
					<ps:checkbox id="cbx_centralized_${_pageRef}"
						key="centralize_mobile_number_and_e-mail_with_core_banking_key"
						name="controlRecordCO.centralizeCore" tabindex="11"
						cssClass="ui-widget-content checkboxheight" valOpt="1:0"/>
       </div>
	</td>
	
	<td></td>	
	<td></td>
	<td></td>	
	<td></td>
	 </tr>
	 <tr><td colspan="6"></td></tr>
 </table>
 </fieldset>
</td>
</tr>
<tr>
  
	<td  colspan="20">
	 <fieldset  class="ui-widget-content ui-corner-all">
	 <legend >
		 <ps:label key="email_configuration_key" id="lbl_configuration_${_pageRef}" />
	 </legend>
	<br>
	<table border="0" width="95%">
		<tr>
				<td width="10%"></td>
				<td width="15%"></td>
				<td width="15%"></td>
				<td width="20%"></td>	
				<td width="35%"></td>		
		</tr>
		<tr>
			<td class="fldLabelView">
				<ps:label key="protocol_type_key" id="lbl_protocol_type_${_pageRef}"
					for="protocol_type_${_pageRef}" />
			</td>
			<td class="fldDataEdit center">
				<ps:select id="protocol_type_${_pageRef}"
				name="controlRecordCO.protocolType" list="protocolTypeDropDown"
				listKey="code" listValue="descValue" emptyOption="false"
				disabled="false" 
				parameter="controlRecordCO.protocolType:protocol_type_${_pageRef},controlRecordCO.progRef:'CTRL00MT',
				controlRecordCO.senderEmail:sle_sender_email_${_pageRef},controlRecordCO.ipAddress:sle_ip_${_pageRef},
				controlRecordCO.portNumber:sle_port_${_pageRef},controlRecordCO.userId:sle_user_${_pageRef},
				controlRecordCO.password:sle_pass_${_pageRef}"
				dependencySrc="${pageContext.request.contextPath}/path/alert/controlrecord/ControlRecordDepAction_dependencyByProtType"
				dependency="protocol_type_${_pageRef}:controlRecordCO.protocolType
				,sle_sender_email_${_pageRef}:controlRecordCO.senderEmail
				,sle_ip_${_pageRef}:controlRecordCO.ipAddress,sle_port_${_pageRef}:controlRecordCO.portNumber
				,sle_user_${_pageRef}:controlRecordCO.userId,sle_pass_${_pageRef}:controlRecordCO.password"
				/>
				
			</td>
			<td  align="right">
			<ps:label key="sender_email_address_key" 
				id="lbl_sle_sender_email_${_pageRef}"
				for="sle_sender_email_${_pageRef}" />
		   </td>
		   <td>
				<ps:textfield id="sle_sender_email_${_pageRef}"
					name="controlRecordCO.senderEmail" tabindex="2"
					mode="character" maxlength ="30" style="width:100%"/>
		   </td>
		   <td></td>
		   <tr></tr>
	    </tr>
	    <tr>
	        <td></td>
	        <td></td>
	      	<td  align="right">
			<ps:label key="ip_address_key" 
				id="lbl_sle_ip_${_pageRef}"
				for="sle_ip_${_pageRef}" />
		   </td>
		   <td>
				<ps:textfield id="sle_ip_${_pageRef}"
					name="controlRecordCO.ipAddress" tabindex="2"
					mode="character" maxlength ="30" style="width:100%"/>
		   </td>
		   <td></td>
		   <tr></tr>
	    </tr>
	     <tr>
	       <td></td>
	       <td></td>
	       <td  align="right">
			<ps:label key="port_number_key" 
				id="lbl_sle_port_${_pageRef}"
				for="sle_port_${_pageRef}" />
		   </td>
		   <td>
				<ps:textfield id="sle_port_${_pageRef}"
					name="controlRecordCO.portNumber" tabindex="2"
					mode="character" maxlength ="30" style="width:100%;height:20px;"/>
		   </td>
		   <td></td>
		   <tr></tr>
	    </tr>
	     <tr>
	       <td></td>
	       <td></td>
	       <td  align="right">
			<ps:label key="user_id_key" 
				id="lbl_sle_user_${_pageRef}"
				for="sle_user_${_pageRef}" />
		   </td>
		   <td>
				<ps:textfield id="sle_user_${_pageRef}"
					name="controlRecordCO.userId" tabindex="2"
					mode="character" maxlength ="30" style="width:100%"/>
		   </td>
		   <td></td>
		   <tr></tr>
	    </tr>
	    <tr>
	       <td></td>
	       <td></td>
		       <td  align="right">
					<ps:label key="password_key" 
						id="lbl_sle_pass_${_pageRef}"
						for="sle_pass_${_pageRef}" />
		  	   </td> 	 	     
			<td>
			<ps:password style="height:20px" id="sle_pass_${_pageRef}" name="controlRecordCO.password" value=""
	  		showPassword="true"	maxlength="30" tabindex="2" mode="character"/>
			</td>   
		   <td>
		   </td>
		   <tr></tr>
	    </tr>
 </table>
 </fieldset>
</td>
</tr> --%>

<br>


<ptt:toolBar id="controlRecToolBar_${_pageRef}" hideInAlert="true">
	<psj:submit id="CtrlRecUpdateBtn_${_pageRef}"
					progRef="CTRL00U" button="true" type="button"
					buttonIcon="ui-icon-disk" tabindex="12"
					onclick="updateCtrlRecord()"
					freezeOnSubmit="true">
					<ps:label for="CtrlRecUpdateBtn_${_pageRef}"
						key="Update_key" />
	</psj:submit>
</ptt:toolBar>

</ps:form>
</div>