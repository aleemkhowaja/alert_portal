<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@include file="/WEB-INF/pages/alert/common/AlertAppTrans.jsp"%>
<%@taglib prefix="pt" uri="/path-toolbar-tags"%>
<%@taglib uri="/path-struts-tags" prefix="ps"%>

<style>
	.disable-link
	{
		text-decoration: none !important;
		color: black !important;
		cursor: default;
		pointer-events: none;
	}
			
	#mainTabs{
		overflow-x: hidden;
	}
			 
	.ui-autocomplete {
		max-height: 180px;
		overflow-y: auto;
		overflow-x: hidden;
	}
</style>

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/path/css/alert/style.css" />
<ps:set name="eventStatus_${_pageRef}"    value="individualEventCO.alrtEvtVO.STATUS"/>
<ps:set name="eventId_${_pageRef}"    value="individualEventCO.alrtEvtVO.EVT_ID"/>
<ps:set name="ivcrud_${_pageRef}" value="iv_crud" />
<ps:hidden id="enable_omni" name="enable_omni" />
<ps:form useHiddenProps="true" id="individualEventMainFormId_${_pageRef}" namespace="/path/alert/events/event" applyChangeTrack="true">
	<ps:hidden id='eventStatus_${_pageRef}' name='individualEventCO.alrtEvtVO.STATUS'  />
	<ps:hidden id="iv_crud_${_pageRef}" name="iv_crud" />
	<ps:hidden id="communicationType_${_pageRef}" name="communicationType" />
	<ps:hidden id="templateType_${_pageRef}" name="templateType" />
	<ps:hidden id="allRecFixedParamList_${_pageRef}" name="individualEventCO.fixedParamList" />
	<ps:hidden id="selectedBodyTextareaId_${_pageRef}" name="individualEventCO.selectedBodyTextarea"  />
	<ps:hidden id="selectedBodyTextareaLength_${_pageRef}" name="individualEventCO.selectedBodyTextareaLength"  />
	<ps:hidden id="alrtEvtVO_CREATED_BY_${_pageRef}" name="individualEventCO.alrtEvtVO.CREATED_BY"  />
	<ps:hidden id="alrtEvtVO_MODIFIED_BY_${_pageRef}" name="individualEventCO.alrtEvtVO.MODIFIED_BY"  />
	<ps:hidden id="alrtEvtVO_TOBE_SUSPENDED_BY_${_pageRef}" name="individualEventCO.alrtEvtVO.TOBE_SUSPENDED_BY" />
	<ps:hidden id="alrtEvtVO_TOBE_REACTIVATED_BY_${_pageRef}" name="individualEventCO.alrtEvtVO.TOBE_REACTIVATED_BY" />
	<ps:hidden id="alrtSubVO_DATE_UPDATED_${_pageRef}" name="individualEventCO.alrtEvtVO.DATE_UPDATED"  />
	
	<table cellpadding="0" cellspacing="1" width="100%" border="0">
		<tr>
			<td width="7%">
				<ps:label key="evt_id_key" id="lbl_eventId_${_pageRef}" for="eventId_${_pageRef}" />
			</td>
			<td width="14%" class="fldDataEdit right">
				<ps:textfield
					id="eventId_${_pageRef}" 
					name="individualEventCO.alrtEvtVO.EVT_ID"
					mode="number" 
					required="" 
					readonly="true" 
					tabindex="1"
					maxlength="16" />
			</td>
			<td width="30%"></td>
			<td width="30%"></td>
			<td width="1%" class="fldLabelView">
				<ps:label key="Status_key" id="lbl_status_${_pageRef}" for="status${_pageRef}" /> 
			</td>
			<td width="15%" class="fldDataEdit left">
				<ps:textfield
					id="status${_pageRef}" 
					name="individualEventCO.statusDesc"
					mode="text" 
					maxlength="100" 
					tabindex="-1" 
					readonly="true" />
			</td>
			<td width="5%" align="right">
				<psj:a 
					button="true"
					buttonIcon="ui-icon-triangle-2-s" 
					onclick="showEventStatus()">
					<ps:text name='status_key' />
				</psj:a>
			</td>
		</tr>
		<tr>
			<td width="7%">
				<ps:label key="desceng_key" id="lbl_desceng_${_pageRef}" for="desceng_${_pageRef}"/>
			</td>
			<td width="10%" colspan="2">
				<ps:textfield
					id="desceng_${_pageRef}"
					name="individualEventCO.alrtEvtVO.DESC_ENG" 
					mode="text"
					required="true" 
					tabindex="1" 
					maxlength="100" onchange="individualEventMaint_checkEventDescriptionUnique();" />
			</td>
		</tr>
		<tr>
			<td colspan="3"></td>
			<td width="10%" colspan="3" class="left">
					<ps:textfield
						id="briefDescAra_${_pageRef}"
						name="individualEventCO.alrtEvtVO.DESC_ARAB"
						required="false" 
						readonly="false" 
						tabindex="2" 
						maxlength="100"
						onlyArabic="true"  />
			</td>
			<td colspan="2" width="10%" nowrap="nowrap">
				<ps:label
					key="description_arab_jv_key" 
					id="lbl_brief_ara_eng_${_pageRef}"
					for="briefDescAra_${_pageRef}" />
			</td>
		</tr>
		</table>
		
		<div id="controldetails_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px;">
			<div id="controldetails_Inner_${_pageRef}" class="collapsibleContainer" title="<ps:text name='control_key'/>">
				<table cellpadding="1" cellspacing="1" border="0">
					<tr>
						<td>
							<ps:label key="evt_type_key" id="lbl_eventType_${_pageRef}" for="eventType_${_pageRef}" />
						</td>
						<td>
							<ps:select
								id="eventType_${_pageRef}"
							 	list="eventTypeList"  
							 	listKey="code" 
							 	listValue="descValue" 
							 	name="individualEventCO.alrtEvtVO.EVT_TYPE"
								tabindex="9"
								cssStyle="width: 100%;"
								onchange="showHideBatchGrid()"
								parameter="individualEventCO.alrtEvtVO.EVT_TYPE:eventType_${_pageRef}"
								dependencySrc="${pageContext.request.contextPath}/path/alert/events/event/IndividualEventMaintAction_applyDisplaySettingFields"
								dependency="eventType_${_pageRef}:individualEventCO.alrtEvtVO.EVT_TYPE"
							/>
						</td>
						<td></td>
						<td>
							<ps:label
								key="skip_subscription_key"
								id="lbl_skip_subscription_${_pageRef}"
								for="skipSubscription_${_pageRef}" /></td>			
						<td>
							<ps:checkbox id="skipSubscription_${_pageRef}"
								name="individualEventCO.alrtEvtVO.SKIP_SUBSCRIPTION_YN" tabindex="5"
								cssClass="ui-widget-content checkboxheight" 
								valOpt="Y:N"
								onchange="individualEventMaint_retrieveSourceOfContactsDropdown();"								
								/>
						</td>
					</tr>
					<tr>
						<td><ps:label
								key="src_contact_key" 
								id="lbl_source_of_contact_${_pageRef}"
								for="SOURCE_OF_CONTACT_${_pageRef}" /></td>			
						<td>
							<ps:select 
								list="sourceOfContact" 
								listKey="code"
								listValue="descValue" 
								name="individualEventCO.alrtEvtVO.SOURCE_OF_CONTACT"
								id="SOURCE_OF_CONTACT_${_pageRef}"
								tabindex="9"/>
						</td>
						<td></td>
						<td><ps:label
								key="bulk_events_key"
								id="lbl_bulk_events_${_pageRef}"
								for="bulkEvents_${_pageRef}" /></td>			
						<td>
							<ps:checkbox id="bulkEvents_${_pageRef}"
								name="individualEventCO.alrtEvtVO.BULK_YN" tabindex="5"
								cssClass="ui-widget-content checkboxheight" 
								valOpt="Y:N"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	<div id= "batchDiv_${_pageRef}">
		<!--Batch Details  -->
		<div id="batchdetails_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px;">
			<div id="batchdetails_Inner_${_pageRef}" class="collapsibleContainer collapsed" title="<ps:text name='Batch_key'/>">
				    <%@include file="batch/EventBatchDetails.jsp"%>
			</div>
		</div> 
	</div>   

<div id= "fixEventDiv_${_pageRef}">
	<!--fixEvent Details  -->
	<div id="fixEventdetails_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px;">
		<div id="fixEventdetails_Inner_${_pageRef}" class="collapsibleContainer collapsed" title="<ps:text name='fixed_event_details_key'/>">
			<%@include file="fixedparam/FixedParamDetails.jsp"%>
				
		</div>
	</div> 
</div>

<table width="100%">
	<tr>
		<td width="90%" style="vertical-align: top;" >
			<div id="communicationModeDetails_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px">
				<div id="communicationModeDetails_Inner_${_pageRef}" class="collapsibleContainer" title="<ps:text name='communication_mode_key'/>" >
					<div style="height: 320px;overflow-y: auto;">
						<!--------------------------------------------------------------------->
						<!------------------------------ Email -------------------------------->
						<!--------------------------------------------------------------------->
						<div>
							<label class="switch_activate">
								<ps:checkbox 
									id="communicationModeEmail_${_pageRef}"
									key="email_activate_key"
									name="individualEventCO.emailActivate" 
									tabindex="12"
									valOpt="1:0"
									cssClass="ui-widget-content checkboxheight communicationModes"
									onclick="individualEvents_activateCommunicationMode('communicationModeEmail', 'emaildetails', 'emaildetails_Inner');"
									>
								 </ps:checkbox>
							</label>
						</div>
						<!--Emails Details  -->
						<div id="emaildetails_${_pageRef}" class="connectedSortable ui-helper-reset div-disable" style="margin-bottom: 5px; margin-top: 3px;">
							<div id="emaildetails_Inner_${_pageRef}" class="collapsibleContainer collapsed" title="<ps:text name='email_key'/>">
								    <%@include file="email/EventEmailDetails.jsp"%>
							</div>
						</div>
						
						<!--------------------------------------------------------------------->
						<!------------------------------ Sms ---------------------------------->
						<!--------------------------------------------------------------------->
						<div  style="margin-bottom: 3px;">
							<label class="switch_activate">
								<ps:checkbox 
									id="communicationModeSms_${_pageRef}"
									key="sms_activate_key"
									name="individualEventCO.smsActivate" 
									tabindex="12"
									valOpt="1:0"
									cssClass="ui-widget-content checkboxheight communicationModes"
									onclick="individualEvents_activateCommunicationMode('communicationModeSms', 'smsdetails', 'smsdetails_Inner');"
									>
								 </ps:checkbox>
							</label>
						</div>
			
						 <!--SMS  Details  -->
						<div id="smsdetails_${_pageRef}" class="connectedSortable ui-helper-reset div-disable" style="margin-bottom: 5px; margin-top: 3px;">
							<div id="smsdetails_Inner_${_pageRef}" class="collapsibleContainer collapsed" title="<ps:text name='sms_event_key'/>" >
									<%@include file="sms/EventSmsDetails.jsp"%>
							</div>
						</div>
						
						<!--------------------------------------------------------------------->
						<!------------------------- Omni Inbox -------------------------------->
						<!--------------------------------------------------------------------->
						<div  style="margin-bottom: 3px;">
							<label class="switch_activate">
								<ps:checkbox 
									id="communicationModeOmniInbox_${_pageRef}"
									key="omni_push_notification_activate_key"
									name="individualEventCO.omniInboxActivate" 
									tabindex="12"
									valOpt="1:0"
									cssClass="ui-widget-content checkboxheight communicationModes"
									onclick="individualEvents_activateCommunicationMode('communicationModeOmniInbox', 'omniInboxdetails', 'omniInboxdetails_Inner');"
									>
								 </ps:checkbox>
							</label>
						</div>
						<!--OMNI Inbox  Details  -->
						<div id="omniInboxdetails_${_pageRef}" class="connectedSortable ui-helper-reset div-disable"  style="margin-bottom: 5px; margin-top: 3px;">
							<div id="omniInboxdetails_Inner_${_pageRef}" class="collapsibleContainer collapsed" title="<ps:text name='omni_push_notification_key'/>">
									<%@include file="omniinbox/EventOmniInboxDetails.jsp"%>
							</div>
						</div>	
						
						<!--------------------------------------------------------------------->
						<!------------------------- IMAL Internal Alerts ---------------------->
						<!--------------------------------------------------------------------->
						<div  style="margin-bottom: 3px;">
							<label class="switch_activate">
								<ps:checkbox 
									id="communicationModeImalInternalAlrt_${_pageRef}"
									key="internal_alrt_activate_key"
									name="individualEventCO.imalInternalAlrtActivate" 
									tabindex="12"
									valOpt="1:0"
									cssClass="ui-widget-content checkboxheight communicationModes"
									onclick="individualEvents_activateCommunicationMode('communicationModeImalInternalAlrt', 'imalInternalAlrtdetails', 'imalInternalAlrtdetails_Inner');"
									>
								 </ps:checkbox>
							</label>
						</div>	
						
						<!--IMAL Internal Alerts Details  -->
						<div id="imalInternalAlrtdetails_${_pageRef}" class="connectedSortable ui-helper-reset div-disable"  style="margin-bottom: 5px; margin-top: 3px;">
							<div id="imalInternalAlrtdetails_Inner_${_pageRef}" class="collapsibleContainer collapsed" title="<ps:text name='imal_internal_alrt_notification_key'/>">
									<%@include file="imalInternalAlerts/InternalAlrtDetails.jsp"%>
							</div>
						</div>
						
						
					</div>
				</div>
			</div>
		</td>
		<td width="10%" style="vertical-align: top;" height="60%">
			<div id="tagsdetails_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px">
				<div id="tagsdetails_Inner_${_pageRef}" class="collapsibleContainer" title="<ps:text name='tags_key'/>" >
					<div style="height: 320px;overflow-y: auto;">
						<%@include file="communicationTags/CommunicationTags.jsp"%>
					</div>
				</div>
			</div>
		</td>
	</tr>
</table>
	


<%-- <div  style="margin-bottom: 3px;">
	<label class="switch_activate">
		<ps:checkbox 
			id="communicationModeSms_${_pageRef}"
			key="sms_activate_key"
			name="individualEventCO.smsActivate" 
			tabindex="12"
			valOpt="1:0"
			cssClass="ui-widget-content checkboxheight communicationModes"
			onclick="individualEvents_activateCommunicationMode('communicationModeSms', 'smsdetails', 'smsdetails_Inner');"
			>
		 </ps:checkbox>
	</label>
</div>

 <!--SMS  Details  -->
<div id="smsdetails_${_pageRef}" class="connectedSortable ui-helper-reset div-disable" style="margin-bottom: 5px; margin-top: 3px;">
	<div id="smsdetails_Inner_${_pageRef}" class="collapsibleContainer collapsed" title="<ps:text name='sms_event_key'/>" >
			<%@include file="sms/EventSmsDetails.jsp"%>
	</div>
</div>

<div  style="margin-bottom: 3px;">
	<label class="switch_activate">
		<ps:checkbox 
			id="communicationModeOmniInbox_${_pageRef}"
			key="omniInbox_activate_key"
			name="individualEventCO.omniInboxActivate" 
			tabindex="12"
			valOpt="1:0"
			cssClass="ui-widget-content checkboxheight communicationModes"
			onclick="individualEvents_activateCommunicationMode('communicationModeOmniInbox', 'omniInboxdetails', 'omniInboxdetails_Inner');"
			>
		 </ps:checkbox>
	</label>
</div>
<!--OMNI Inbox  Details  -->
<div id="omniInboxdetails_${_pageRef}" class="connectedSortable ui-helper-reset div-disable"  style="margin-bottom: 5px; margin-top: 3px;">
	<div id="omniInboxdetails_Inner_${_pageRef}" class="collapsibleContainer collapsed" title="<ps:text name='omni_inbox_key'/>">
			<%@include file="omniinbox/EventOmniInboxDetails.jsp"%>
	</div>
</div>	
<br /> --%>
 
	<pt:toolBar id="individualEventToolBar_${_pageRef}" hideInAlert="true">
		<ps:if test='%{#ivcrud_${_pageRef}=="R"}'>
			<ps:if test='%{#eventStatus_${_pageRef}==null || #eventStatus_${_pageRef}=="A"}'>
				<psj:submit button="true" buttonIcon="ui-icon-disk" id="IndividualEventUpdateBtn_${_pageRef}" tabindex="12">
					<ps:label key="btn.save" for="IndividualEventUpdateBtn_${_pageRef}" />
				</psj:submit>
			</ps:if>	
			<%-- <ps:if test='%{#eventStatus_${_pageRef}=="A"}'>
				<psj:submit button="true" buttonIcon="ui-icon-trash"
					id="IndividualEventDeleteBtn_${_pageRef}" tabindex="12" type="button"
					onclick="individualEventMaint_conformDelete()">
					<ps:label key="Delete_key" for="IndividualEventDeleteBtn_${_pageRef}" />
				</psj:submit>
			</ps:if> --%>
		</ps:if>
		
		<ps:if test='%{#ivcrud_${_pageRef}=="P"}'>
			<psj:submit button="true" type="button"
				onclick="individualEventMaint_approve()"
				id="event_approve_btn_${_pageRef}">
				<ps:label key="Approve_key" for="event_approve_btn_${_pageRef}" />
			</psj:submit>
		</ps:if>
		
		<ps:if test='%{#ivcrud_${_pageRef}=="F"}'>
		    <psj:submit button="true" buttonIcon="ui-icon-disk" id="IndividualEventUpdateBtn_${_pageRef}" tabindex="12">
				<ps:label key="btn.save" for="IndividualEventUpdateBtn_${_pageRef}" />
			</psj:submit>
		</ps:if>
		
		<ps:if test='%{#ivcrud_${_pageRef}=="SP"}'>
		<psj:submit id="event_toSuspend_${_pageRef}" button="true" type="button" onclick="individualEventMaint_toSuspend()"
			buttonIcon="ui-icon ui-icon-clock" freezeOnSubmit="true">
			<ps:label key="toSuspend_key" for="event_toSuspend_${_pageRef}" />
		</psj:submit>
		</ps:if>
		
		<ps:if test='%{#ivcrud_${_pageRef}=="S"}'>
		<psj:submit id="event_suspend_${_pageRef}" button="true" type="button" onclick="individualEventMaint_approveSuspend()"
			freezeOnSubmit="true" buttonIcon="ui-icon ui-icon-clock">
			<ps:label key="approve_suspend_key" for="event_suspend_${_pageRef}" />
		</psj:submit>
		<psj:submit id="reject_suspend_${_pageRef}" button="true" type="button" onclick="individualEventMaint_reject('RS')"
			freezeOnSubmit="true"
			buttonIcon="ui-icon ui-icon-clock">
			<ps:label key="reject_suspend_key" for="reject_suspend_${_pageRef}" />
		</psj:submit>
		</ps:if>
		
		<ps:if test='%{#ivcrud_${_pageRef}=="RA"}'>
		<psj:submit id="event_toReactivate_${_pageRef}" button="true" type="button" onclick="individualEventMaint_toReactivate()"
			buttonIcon="ui-icon ui-icon-arrowreturnthick-1-w" freezeOnSubmit="true">
			<ps:label key="toReactivate_key" for="event_toReactivate_${_pageRef}" />
		</psj:submit>
		</ps:if>
		
		<ps:if test='%{#ivcrud_${_pageRef}=="A"}'>
		<psj:submit id="event_reactivate_${_pageRef}" button="true" type="button" onclick="individualEventMaint_approveReactivate()"
			buttonIcon="ui-icon ui-icon-arrowreturnthick-1-w" freezeOnSubmit="true">
			<ps:label key="approve_reactivate_key" for="event_reactivate_${_pageRef}" />
		</psj:submit>
		<psj:submit id="reject_reactivate_${_pageRef}" button="true" type="button" onclick="individualEventMaint_reject('RRA')"
			freezeOnSubmit="true" buttonIcon="ui-icon ui-icon-clock">
			<ps:label key="reject_reactivate_key" for="reject_reactivate_${_pageRef}" />
		</psj:submit>
		</ps:if>
	</pt:toolBar>
	
	<div class="clearfix">
      <psj:dialog
            id="openCustomExpressionPopup_${_pageRef}" 
            href=""
            autoOpen="false"
            dataType="html"
            modal="true" 
            title="%{getText('Formula')}"
            width="450"
            height="300" />    
	</div>
	<ps:hidden name="individualEventCO.alrtEvtVO.ALRT_EVT_EXPR" id="updateCustomExpression_${_pageRef}"></ps:hidden>

</ps:form>


<script type="text/javascript">

	var other_lang_msg_subjects = "${other_lang_msg_subjects_key}";
	$.struts2_jquery.require("IndividualEventMaint.js,IndividualAlertTags.js,AlertFixedParam.js,IndividualEventReportAttachment.js,IndividualEventCommMode.js,InternalAlerts.js"
			, null, jQuery.contextPath+ "/path/js/alert/events/event/");
	$.struts2_jquery.require("common.js", null, jQuery.contextPath + "/path/js/alert/common/");
	
	$(document).ready(function() 
	{
		 $("#individualEventMainFormId_"+_pageRef+" .collapsibleContainer").collapsiblePanel();	
		 $(".communicationModeEmail").remove();
		 $('<span class="communicationModeEmail slider_activate round_activate"></span>').insertAfter(".communicationModes");
		 $("#individualEventMainFormId_"+_pageRef).processAfterValid("individualEventMaint_submit",{});
		 $("#batchDiv_"+_pageRef).hide();
		 $("#fixEventDiv_"+_pageRef).hide();
	}); 
</script>

