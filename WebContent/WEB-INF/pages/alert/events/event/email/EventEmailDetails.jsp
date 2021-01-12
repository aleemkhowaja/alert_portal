<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt"  uri="/path-toolbar-tags" %>

<ps:set name="Confirm_Delete_Change_Process_key" value="%{getEscText('Confirm_Delete_Change_Process_key')}" />
<ps:set name="Confirm_Delete_Change_Details_Process_key" value="%{getEscText('Confirm_Delete_Change_Details_Process_key')}" />
<ps:set name="entry_number_is_already_in_use" value="%{getEscText('entry_number_is_already_in_use')}" />

<ps:set name="eventQueryId_${_pageRef}" value="individualEventSC.queryId" />

<ps:hidden id="eventDynamicEmailMessageDetailsTemp_${_pageRef}" name="individualEventCO.eventDynamicEmailMessageDetailsTemp"></ps:hidden>
	
<ps:hidden id="eventStaticEmailOtherLanguageHidden_${_pageRef}" name="individualEventCO.eventStaticEmailOtherLanguageHidden" value="DF"></ps:hidden>				

<ps:hidden id="eventStaticEmailParamMappingGridDataHidden_${_pageRef}" name="individualEventCO.eventStaticEmailParamMappingGridDataHidden"></ps:hidden>

<ps:hidden id="eventStaticEmailQueryArgumentsHiddenId_${_pageRef}" name="individualEventCO.emailQueryParameterListJson" />

<ps:hidden id="eventStaticEmailQueryColumnsHiddenId_${_pageRef}" name="individualEventCO.emailQueryColumnListJson" />

<ps:hidden id="eventStaticEmailReportArgumentsHiddenId_${_pageRef}" name="individualEventCO.emailReportParameterListJson" />

<ps:hidden id="eventStaticEmailMessageDefaultSubjectHiddenId_${_pageRef}" name="individualEventCO.email_EVT_COMM_MODEVO.DEFAULT_MESSAGE_SUBJECT" />
<ps:hidden id="eventStaticEmailMessageDefaultBodyHiddenId_${_pageRef}" name="individualEventCO.email_EVT_COMM_MODEVO.DEFAULT_MESSAGE_BODY" />

<!-- Language Related Hidden Fields -->
<ps:hidden id="eventStaticEmailMessageARHiddenId_${_pageRef}" name="individualEventCO.eventStaticEmailMessageARHidden" />
<ps:hidden id="eventStaticEmailMessageENHiddenId_${_pageRef}" name="individualEventCO.eventStaticEmailMessageENHidden" />
<ps:hidden id="eventStaticEmailMessageFRHiddenId_${_pageRef}" name="individualEventCO.eventStaticEmailMessageFRHidden" />
<ps:hidden id="eventStaticEmailMessageFAHiddenId_${_pageRef}" name="individualEventCO.eventStaticEmailMessageFAHidden" />
<ps:hidden id="eventStaticEmailMessageRUHiddenId_${_pageRef}" name="individualEventCO.eventStaticEmailMessageRUHidden" />
<ps:hidden id="eventStaticEmailMessageTKHiddenId_${_pageRef}" name="individualEventCO.eventStaticEmailMessageTKHidden" />

<!-- New Custom Tags Hidden Field -->
<ps:hidden id="eventStaticEmailNewCustomTagsHiddenId_${_pageRef}" name="individualEventCO.eventStatiEmailNewCustomTagsHidden" />

<!-- Report Attachment Hidden Fields -->
<ps:hidden id="eventStaticEmailReportAttachmentCount_${_pageRef}" name="individualEventCO.emailEventStaticReportAttachCount"></ps:hidden>
<ps:hidden id="eventStaticEmailRemovedReportAttachmentIds_${_pageRef}" name="individualEventCO.eventEmailRemovedReportAttachmentIds"></ps:hidden>
<ps:hidden id="eventStaticEmailQueryHiddenId_${_pageRef}" name="individualEventCO.EmailQueryId"></ps:hidden>
<ps:hidden name="parametersDialogStatus" id="parametersDialogStatus_${_pageRef}"></ps:hidden>

<style>
	.disableDropDown{
    	background: #E1E1E1 !important;
        border: 1px solid #999999 !important;
        -webkit-box-shadow: inset 0 0 2px red;
        color: #3C3C3C !important;
    }
</style>

<script type="text/javascript">
	$(document).ready(function(){
		$.struts2_jquery.require("TemplateEntriesMaint.js", null,
		jQuery.contextPath+ "/path/js/consolidation/templateentries/"); 
		$("#reportOptionDiv_id_"+_pageRef).hide();
	});
	
	
</script>
	<ps:set name="ivcrud_${_pageRef}"    value="iv_crud"/>
	<ps:hidden id="messageBodyOptionList_${_pageRef}" name="individualEventCO.email_EVT_COMM_MODEVO.TEMPLATE_TYPE"></ps:hidden>
	<table cellpadding="2" cellspacing="1" border="0" >
		<tr>
			<td width="10%"> </td>
			<td width="10%"> </td>
			<td width="10%"> </td>
			<td width="10%"> </td>
			<td width="10%"> </td>
			<td width="10%"> </td>
			<td width="10%"> </td>
			<td width="10%"> </td>
		</tr>
		<tr>
			<td nowrap="nowrap">
				<ps:label key="language_key" id="lbl_eventStaticEmailOtherLanguage_${_pageRef}" for="eventStaticEmailOtherLanguage_${_pageRef}" />
			</td>
			<td>
				<ps:select
					id="eventStaticEmailOtherLanguage_${_pageRef}"
			 		list="otherLanguageTypeList"  
			 		listKey="code" 
			 		listValue="descValue" 
			 		name="individualEventCO.email_EVT_OL_DATA_TRANSVO.LANG_CODE"
					tabindex="9"
					onchange="individualEventMaint_setStaticMessage('E','Email');"/>
			</td>
		</tr>
	</table>
	<fieldset>
		<legend><b><ps:text name='dynamic_tags_key'/></b></legend>
			<table cellpadding="2" cellspacing="1" border="0" >

			<tr>
				<td nowrap="nowrap"  width="12%"> 
					<ps:label key="query_id_key" id="lbl_eventStaticEmailQueryId_${_pageRef}" for="lookuptxt_eventStaticEmailQueryId_${_pageRef}" />
				</td>
				<td  width="10%">
					<psj:livesearch 
						name="individualEventCO.email_EVT_COMM_MODEVO.QUERY_ID"
						id="eventStaticEmailQueryId_${_pageRef}" 
						mode="number" 
						leadZeros="8" 
						tabindex="19"
						minValue="0" 
						resultList="QUERY_ID:lookuptxt_eventStaticEmailQueryId_${_pageRef}"
						actionName="${pageContext.request.contextPath}/path/alert/events/event/QueryLookupAction_constructQueryLookup"
						dependencySrc="${pageContext.request.contextPath}/path/alert/events/event/QueryLookupDependancyAction_dependencyByQueryId"							
						dependency="lookuptxt_eventStaticEmailQueryId_${_pageRef}:individualEventCO.irp_AD_HOC_QUERYCO.QUERY_ID,
										eventStaticEmailQueryHiddenId_${_pageRef}:individualEventCO.irp_AD_HOC_QUERYCO.QUERY_ID,
										
										eventStaticEmailQueryBriefDescEng_${_pageRef}:individualEventCO.irp_AD_HOC_QUERYCO.QUERY_NAME,
										eventStaticEmailQueryArgumentsHiddenId_${_pageRef}:individualEventCO.emailQueryParameterListJson,
										eventStaticEmailQueryColumnsHiddenId_${_pageRef}:individualEventCO.emailQueryColumnListJson"
							parameter="criteria.queryId:lookuptxt_eventStaticEmailQueryId_${_pageRef},
									   criteria.oldQueryId:eventStaticEmailQueryHiddenId_${_pageRef}"
							searchElement="QUERY_ID" 
							maxlength="8"  
							afterDepEvent="individualEvents_returnQueryColumnsByQueryId('Email')"
							beforeDepEvent="individualAlertTag_queryTagsValidation('Email');">
						</psj:livesearch>
					</td>
					<td width="51%"> 
						<ps:textfield
							id="eventStaticEmailQueryBriefDescEng_${_pageRef}" 
							name="individualEventCO.emailQueryBriefDescription"
							mode="string" 
							required="" 
							readonly="true" 
							tabindex="1"
							maxlength="100" /> 
					</td>
					<td> 
						<psj:a id="eventStaticEmailQueryParameterButton_${_pageRef}" name="eventStaticEmailQueryParameterButton"
							button="true" 
							buttonIcon="ui-icon-triangle-2-s"
							onclick="individualEventMaint_openQueryDialog('Email');">
							<ps:text name='parameters_key' />
						</psj:a>
					</td>
				</tr>
				<%-- <tr>
					<td nowrap="nowrap"  width="13%"> 
						<ps:label key="service_key" id="lbl_eventService_${_pageRef}" for="eventService_${_pageRef}" />
					</td>
					<td width="10%" colspan="2"> 
						<psj:a id="eventService_${_pageRef}" name="eventService"
							button="true" 
							buttonIcon="ui-icon-triangle-2-s"
							onclick="individualEventMaint_openQueryDialog('Email');">
							<ps:text name='service_key' />
						</psj:a>
					</td>
				</tr> --%>
				
			</table>
		</fieldset>
		<table cellpadding="2" cellspacing="1" border="0" >
		<tr>
			<td width="10%"> </td>
			<td width="10%"> </td>
			<td width="10%"> </td>
			<td width="10%"> </td>
			<td width="10%"> </td>
			<td width="10%"> </td>
			<td width="10%"> </td>
			<td width="10%"> </td>
		</tr>
		<tr>
			<td nowrap="nowrap">
				<ps:label key="email_subject" id="lbl_eventStaticEmailMessageSubjectEng_${_pageRef}" for="eventStaticEmailMmessageSubjectEng_${_pageRef}" />
			</td>
			<td colspan="7">
				<ps:textfield 
					id="eventStaticEmailMessageSubjectEng_${_pageRef}" 
					name="individualEventCO.email_EVT_OL_DATA_TRANSVO.MESSAGE_SUBJECT" 
					mode="text" 
					required="" 
					tabindex="6" 
					maxlength="200" 
					onclick="individualEventComm_getId(this);"
				/>
			</td>
		</tr>
		<tr>
			<td nowrap="nowrap">
				<ps:label key="reportid_key" id="lbl_eventDynamicEmailReportId_${_pageRef}" for="lookuptxt_eventDynamicEmailReportId_${_pageRef}" />
			</td>
			<td>
					<psj:livesearch name="individualEventCO.email_EVT_COMM_MODEVO.REPORT_ID"
							id="eventDynamicEmailReportId_${_pageRef}" mode="number" leadZeros="8" tabindex="19"
							minValue="0" 
							resultList="REPORT_ID:lookuptxt_eventDynamicEmailReportId_${_pageRef}, "
							actionName="${pageContext.request.contextPath}/pathdesktop/UsrReportsLookup_constructLookup"
							dependencySrc="${pageContext.request.contextPath}/path/alert/events/event/ReportLookupDependancyAction_dependencyByReportId"
							dependency="lookuptxt_eventDynamicEmailReportId_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_ID,
										eventDynamicEmailReportHiddenId_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_ID,
										eventDynamicEmailReportBriefDescEng_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_NAME,
										eventStaticEmailReportArgumentsHiddenId_${_pageRef}:individualEventCO.emailReportParameterListJson,
										messageBodyOptionList_${_pageRef}:individualEventCO.email_EVT_COMM_MODEVO.TEMPLATE_TYPE,
										eventStaticEmailMessageBodyEng_${_pageRef}:''"
							afterDepEvent="individualEventReport_validateReportAttachments('Report','Email',1)"
							parameter="criteria.reportId:lookuptxt_eventDynamicEmailReportId_${_pageRef}, criteria.lookupOf:'report'"
							searchElement="REPORT_ID" maxlength="8" >
					</psj:livesearch>
				</td>
				<td colspan="5"> 
					<ps:hidden id="eventDynamicEmailReportHiddenId_${_pageRef}" name="individualEventCO.email_EVT_COMM_MODEVO.REPORT_ID" />
					<ps:textfield
						id="eventDynamicEmailReportBriefDescEng_${_pageRef}" 
						name="individualEventCO.emailReportBriefDescription"
						mode="string" 
						required="" 
						readonly="true" 
						tabindex="1"
						maxlength="100"/> 
				</td>
				<td >
					<psj:a id="eventDynamicEmailReportParameterButton_${_pageRef}" name="eventStaticEmailReportParameterButton"
						button="true" 
						buttonIcon="ui-icon-triangle-2-s"
						onclick="individualEventMaint_openReportDialog('Email', 'Report')">
						<ps:text name='parameters_key' />
					</psj:a>
				</td>
				<td>
				</td>
			</tr>

			<tr>
				<td valign="top" nowrap="nowrap">
					<ps:label key="email_body_key" id="lbl_eventStaticEmailMessageBodyEng_${_pageRef}" for="eventStaticEmailMessageBodyEng_${_pageRef}" />
				</td>
				<td  valign="top" colspan="6">
					<ps:textarea
						id="eventStaticEmailMessageBodyEng_${_pageRef}" 
						name="individualEventCO.email_EVT_OL_DATA_TRANSVO.MESSAGE_BODY" 
						mode="text"
						required="" 
						rows="7.5" 
						tabindex="6" 
						maxlength="4000"
						onkeyup="individualEventMaint_setRemainingCharachter('Email', 4000);"
						onkeypress="individualEventMaint_setRemainingCharachter('Email', 4000);"
						cssStyle="height: 195px;white-space: pre-wrap;"
						onclick="individualEventComm_getId(this);"
						onkeydown="fixEventdetails_expressionShowHideData(this)"
					/>
				</td>
				<td style="vertical-align: top;">
					<div id="emailStaticQueryTagsDetails_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px;">
						<div id="emailStaticQueryTagsDetails_Inner_${_pageRef}" class="collapsibleContainer collapsed" title="<ps:text name='query_tags_key'/>">
						
							<psjg:grid 	
								id               		="eventEmailStaticQueryTagsGridId_${_pageRef}"
								dataType         		="json"
								pager            		="false"
								sortable         		="false"
								filter           		="false"
								gridModel        		="gridModel"
								rowNum           		="5"
								rowList          		="5,10,15,20"
								viewrecords      		="false"
								navigator       	 	="false"
								navigatorDelete 	    ="false"
								navigatorEdit    		="false"
								navigatorRefresh 		="false"
								navigatorAdd     		="false"
								navigatorSearch  		="false"
								editurl			 		=" " 
								editinline		 		="false" 
								navigatorSearchOptions	="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
								altRows          		="true"
								ondblclick       		="individualAlertTag_addTagsInTextArea('Query', 'Email')"
								autowidth				="false"
								height					="145" 
								width					="190">
													
								<psjg:gridColumn 
									search="true" 
									searchoptions="{sopt:['eq','ne','bw','bn','ew','en','cn','nc']}" 
									name="COLUMN_NAME" 
									sortable="true" 
									id="tagName" 
									title="%{getText('tag_name_key')}" 
									colType="text" 
									editable="true" />
							 </psjg:grid>
							</div>
						</div>
				</td >
			</tr>
			<tr>
			    <td></td>
				<td colspan="2"> <h5 style="margin-top: -9px;"><span id="EmailRemaining_${_pageRef}">4000 Characters Remaining</span></h5> </td>
			</tr>
			<ps:if test='%{#eventId_${_pageRef}!=null && #eventId_${_pageRef}!=""}'>
				<ps:iterator  value="individualEventCO.emailEventReportAttachmentCOs" status="row" >
					<tr id="indEventReportAttachmentRowEmail${_pageRef}_${row.index}">
						<td nowrap="nowrap"> 
							<ps:label key="attach_reportId_key"
							id="lbl_eventEmailStaticReportId_${row.index+1}_${_pageRef}"
							for="lookuptxt_eventEmailStaticReportAttachmentId_${row.index+1}_${_pageRef}" />
						</td>
						<td>
							<psj:livesearch name="individualEventCO.emailReportArray" value="${reportId}"
								id="eventEmailStaticReportAttachmentId_${row.index+1}_${_pageRef}" mode="number" leadZeros="8" tabindex="19"
								minValue="0" 
								resultList="REPORT_ID:lookuptxt_eventEmailStaticReportAttachmentId_${row.index+1}_${_pageRef}, "
								actionName="${pageContext.request.contextPath}/pathdesktop/UsrReportsLookup_constructLookup"
								dependencySrc="${pageContext.request.contextPath}/path/alert/events/event/ReportLookupDependancyAction_dependencyByReportId"
								dependency="lookuptxt_eventEmailStaticReportAttachmentId_${row.index+1}_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_ID,
											eventEmailStaticReportAttachmentBriefDescEng_${row.index+1}_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_NAME,
											eventStaticEmailReportAttachmentArgumentsHiddenId_${row.index+1}_${_pageRef}:individualEventCO.emailReportParameterListJson"
								parameter="criteria.reportId:lookuptxt_eventEmailStaticReportAttachmentId_${row.index+1}_${_pageRef}"
								searchElement="REPORT_ID" maxlength="8"
								afterDepEvent="individualEventReport_validateReportAttachments('ReportAttach','Email',${row.index+1})">
							</psj:livesearch>
						</td>
						<td colspan="5">
							<ps:textfield
								id="eventEmailStaticReportAttachmentBriefDescEng_${row.index+1}_${_pageRef}"
								name="reportDescription"
								mode="string" 
								required="" 
								readonly="true" 
								tabindex="1"
								maxlength="100"/> 
						</td>
						<td>
							<psj:a id="eventEmailStaticReportAttachmentParameterButton_${row.index+1}_${_pageRef}" name="eventStaticEmailReportParameterButton"
								button="true" 
								buttonIcon="ui-icon-triangle-2-s"
								onclick="individualEventReport_openReportAttachmentParameterDialog('Email',${row.index+1})">
								<ps:text name='parameters_key' />
							</psj:a>
							<ps:hidden	id="eventStaticEmailReportAttachmentArgumentsHiddenId_${row.index+1}_${_pageRef}"
									name="individualEventCO.emailReportAttachementParameterArray" /> 
						<!-- </td>
						<td> -->			
							<ps:if test='%{ ${row.index}==0}'>
								<psj:a
									id="addEmailReportAttachment_${_pageRef}_${row.index+1}" button="true"
									onclick="individualEventReport_addReportAttachmentsField('Email')" >
									<ps:text name='+'  />
								</psj:a>
							</ps:if>
							<ps:if test='%{ ${row.index}>0}'>
								<psj:a
									id="RemoveEmailReportAttachment_${_pageRef}_${row.index+1}" button="true"
									onclick="individualEventReport_removeReportAttachmentsField('Email', this, ${row.index+1})" >
									<ps:text name='-' />
								</psj:a>
							</ps:if>
						
							<ps:hidden	id="statusRAEmailHiddenId_${row.index+1}_${_pageRef}"
										name="reportAttachmentStatus" />
						</td>
					</tr>
				</ps:iterator>
			</ps:if>
			<ps:if test='%{individualEventCO.emailEventReportAttachmentCOs.size==0}'>
				<tr id="indEventReportAttachmentRowEmail${_pageRef}_1">
					<td nowrap="nowrap"> 
						<ps:label key="attach_reportId_key" id="lbl_eventEmailStaticReportId_1_${_pageRef}" for="lookuptxt_eventEmailStaticReportAttachmentId_${_pageRef}" />
					</td>
					<td>
						<psj:livesearch name="individualEventCO.emailReportArray"
							id="eventEmailStaticReportAttachmentId_1_${_pageRef}" mode="number" leadZeros="8" tabindex="19"
							minValue="0" 
							resultList="REPORT_ID:lookuptxt_eventEmailStaticReportAttachmentId_1_${_pageRef}, "
							actionName="${pageContext.request.contextPath}/pathdesktop/UsrReportsLookup_constructLookup"
							dependencySrc="${pageContext.request.contextPath}/path/alert/events/event/ReportLookupDependancyAction_dependencyByReportId"
							dependency="lookuptxt_eventEmailStaticReportAttachmentId_1_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_ID,
										eventEmailStaticReportAttachmentBriefDescEng_1_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_NAME,
										eventStaticEmailReportAttachmentArgumentsHiddenId_1_${_pageRef}:individualEventCO.emailReportParameterListJson"
							parameter="criteria.reportId:lookuptxt_eventEmailStaticReportAttachmentId_1_${_pageRef},criteria.lookupOf:'RA'"
							searchElement="REPORT_ID" maxlength="8"
							afterDepEvent="individualEventReport_validateReportAttachments('ReportAttach','Email',1)">
						</psj:livesearch>
					</td>
					<td colspan="5">
						<ps:textfield
							id="eventEmailStaticReportAttachmentBriefDescEng_1_${_pageRef}" 
							name="individualEventCO.emailReportAttachmentBriefDescription"
							mode="string" 
							required="" 
							readonly="true" 
							tabindex="1"
							maxlength="100"/> 
					</td>
					<td>
						<psj:a id="eventEmailStaticReportAttachmentParameterButton_1_${_pageRef}" name="eventStaticEmailReportParameterButton"
							button="true" 
							buttonIcon="ui-icon-triangle-2-s"
							onclick="individualEventReport_openReportAttachmentParameterDialog('Email',1)">
							<ps:text name='parameters_key' />
						</psj:a>
						 <ps:hidden	id="eventStaticEmailReportAttachmentArgumentsHiddenId_1_${_pageRef}"
									name="individualEventCO.emailReportAttachementParameterArray" />
					<!-- </td> -->
					<!-- <td> -->
						<psj:a
							id="addEmailReportAttachment_${_pageRef}_1" button="true"
							onclick="individualEventReport_addReportAttachmentsField('Email')">
							<ps:text name='+' />
						</psj:a>
					</td>
				</tr>		
			</ps:if>
	</table>
	
	<table cellpadding="1" cellspacing="1" border="0">
<%-- 		<ps:if test='%{#eventId_${_pageRef}!=null && #eventId_${_pageRef}!=""}'>
			<ps:iterator  value="individualEventCO.emailEventReportAttachmentCOs" status="row" >
				<tr id="indEventReportAttachmentRowEmail${_pageRef}_${row.index}">
					<td nowrap="nowrap"> 
						<ps:label key="attach_reportId_key"
						id="lbl_eventEmailStaticReportId_${row.index+1}_${_pageRef}"
						for="lookuptxt_eventEmailStaticReportAttachmentId_${row.index+1}_${_pageRef}" />
				</td>
					<td>
						<psj:livesearch name="individualEventCO.emailReportArray" value="${reportId}"
							id="eventEmailStaticReportAttachmentId_${row.index+1}_${_pageRef}" mode="number" leadZeros="8" tabindex="19"
							minValue="0" 
							resultList="REPORT_ID:lookuptxt_eventEmailStaticReportAttachmentId_${row.index+1}_${_pageRef}, "
							actionName="${pageContext.request.contextPath}/pathdesktop/UsrReportsLookup_constructLookup"
							dependencySrc="${pageContext.request.contextPath}/path/alert/events/event/ReportLookupDependancyAction_dependencyByReportId"
							dependency="lookuptxt_eventEmailStaticReportAttachmentId_${row.index+1}_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_ID,
										eventEmailStaticReportAttachmentBriefDescEng_${row.index+1}_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_NAME,
										eventStaticEmailReportAttachmentArgumentsHiddenId_${row.index+1}_${_pageRef}:individualEventCO.emailReportParameterListJson"
							parameter="criteria.reportId:lookuptxt_eventEmailStaticReportAttachmentId_${row.index+1}_${_pageRef}"
							searchElement="REPORT_ID" maxlength="8"
							afterDepEvent="individualEventReport_validateReportAttachments('ReportAttach','Email',${row.index+1})">
						</psj:livesearch>
					</td>
					<td>
						<ps:textfield
							id="eventEmailStaticReportAttachmentBriefDescEng_${row.index+1}_${_pageRef}"
							name="reportDescription"
							mode="string" 
							required="" 
							readonly="true" 
							tabindex="1"
							maxlength="100"/> 
					</td>
					<td>
						<psj:a id="eventEmailStaticReportAttachmentParameterButton_${row.index+1}_${_pageRef}" name="eventStaticEmailReportParameterButton"
							button="true" 
							buttonIcon="ui-icon-triangle-2-s"
							onclick="individualEventReport_openReportAttachmentParameterDialog('Email',${row.index+1})">
							<ps:text name='parameters_key' />
						</psj:a>
						 <ps:hidden	id="eventStaticEmailReportAttachmentArgumentsHiddenId_${row.index+1}_${_pageRef}"
									name="individualEventCO.emailReportAttachementParameterArray" /> 
									
						<ps:if test='%{ ${row.index}==0}'>
							<psj:a
								id="addEmailReportAttachment_${_pageRef}_${row.index+1}" button="true"
								onclick="individualEventReport_addReportAttachmentsField('Email')" >
								<ps:text name='+'  />
							</psj:a>
						</ps:if>
						<ps:if test='%{ ${row.index}>0}'>
							<psj:a
								id="RemoveEmailReportAttachment_${_pageRef}_${row.index+1}" button="true"
								onclick="individualEventReport_removeReportAttachmentsField('Email', this, ${row.index+1})" >
								<ps:text name='-' />
							</psj:a>
						</ps:if>
						
						
						<ps:hidden	id="statusRAEmailHiddenId_${row.index+1}_${_pageRef}"
									name="reportAttachmentStatus" />
					</td>
				</tr>
			</ps:iterator>
		</ps:if> --%>
		<%-- <ps:if test='%{individualEventCO.emailEventReportAttachmentCOs.size==0}'>
			<tr id="indEventReportAttachmentRowEmail${_pageRef}_1">
			<td nowrap="nowrap"> 
				<ps:label key="attach_reportId_key" id="lbl_eventEmailStaticReportId_1_${_pageRef}" for="lookuptxt_eventEmailStaticReportAttachmentId_${_pageRef}" />
			</td>
			<td>
				<psj:livesearch name="individualEventCO.emailReportArray"
					id="eventEmailStaticReportAttachmentId_1_${_pageRef}" mode="number" leadZeros="8" tabindex="19"
					minValue="0" 
					resultList="REPORT_ID:lookuptxt_eventEmailStaticReportAttachmentId_1_${_pageRef}, "
					actionName="${pageContext.request.contextPath}/pathdesktop/UsrReportsLookup_constructLookup"
					dependencySrc="${pageContext.request.contextPath}/path/alert/events/event/ReportLookupDependancyAction_dependencyByReportId"
					dependency="lookuptxt_eventEmailStaticReportAttachmentId_1_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_ID,
								eventEmailStaticReportAttachmentBriefDescEng_1_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_NAME,
								eventStaticEmailReportAttachmentArgumentsHiddenId_1_${_pageRef}:individualEventCO.emailReportParameterListJson"
					parameter="criteria.reportId:lookuptxt_eventEmailStaticReportAttachmentId_1_${_pageRef},criteria.lookupOf:'RA'"
					searchElement="REPORT_ID" maxlength="8"
					afterDepEvent="individualEventReport_validateReportAttachments('ReportAttach','Email',1)">
				</psj:livesearch>
			</td>
			<td>
				<ps:textfield
					id="eventEmailStaticReportAttachmentBriefDescEng_1_${_pageRef}" 
					name="individualEventCO.emailReportAttachmentBriefDescription"
					mode="string" 
					required="" 
					readonly="true" 
					tabindex="1"
					maxlength="100"/> 
			</td>
			<td>
				<psj:a id="eventEmailStaticReportAttachmentParameterButton_1_${_pageRef}" name="eventStaticEmailReportParameterButton"
					button="true" 
					buttonIcon="ui-icon-triangle-2-s"
					onclick="individualEventReport_openReportAttachmentParameterDialog('Email',1)">
					<ps:text name='parameters_key' />
				</psj:a>
				 <ps:hidden	id="eventStaticEmailReportAttachmentArgumentsHiddenId_1_${_pageRef}"
							name="individualEventCO.emailReportAttachementParameterArray" /> 
				<psj:a
					id="addEmailReportAttachment_${_pageRef}_1" button="true"
					onclick="individualEventReport_addReportAttachmentsField('Email')">
					<ps:text name='+' />
				</psj:a>
			</td>
		</tr>		
		</ps:if> --%>
	</table>
	
	<script type="text/javascript">
		$("#eventEmailStaticCustomTagsGridId_"+_pageRef).subscribe("onRowSelTopic",function(rowObj)
		{
			individualEventMaint_disableCustomColumnCell('Email');			
		});

		
		$.subscribe('setEmailGridLayout', function(event, data) {
			indEvent_setLayout("eventEmailStaticCustomTagsGridId");
			indEvent_setLayout("eventEmailStaticDefaultTagsGridId");
			indEvent_setLayout("eventEmailStaticQueryTagsGridId");
			 
		});
		
		function indEvent_setLayout(id)
	    {
			 $("#gbox_"+id+"_"+_pageRef).removeAttr("style");
			 //$(".ui-jqgrid-btable").removeAttr("style");
			 $("#"+id+"_"+_pageRef+"_pager").removeAttr("style");
			 $("#gview_"+id+"_"+_pageRef).find('.ui-jqgrid-hdiv').removeAttr("style");
			 $("#gview_"+id+"_"+_pageRef).removeAttr("style");
			 $("#gview_"+id+"_"+_pageRef).find('.ui-jqgrid-bdiv').css('width', '');
	    }

		</script>