<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt"  uri="/path-toolbar-tags" %>

<ps:set name="eventQueryId_${_pageRef}" value="individualEventSC.queryId" />		
<ps:set name="ivcrud_${_pageRef}"    value="iv_crud"/>

<ps:hidden id="eventDynamicOmniInboxMessageDetailsTemp_${_pageRef}" name="individualEventCO.eventDynamicOmniInboxMessageDetailsTemp"></ps:hidden>	
<ps:hidden id="eventStaticOmniInboxOtherLanguageHidden_${_pageRef}" name="individualEventCO.eventStaticOmniInboxOtherLanguageHidden" value="DF"></ps:hidden>	

<ps:hidden id="eventStaticOmniInboxParamMappingGridDataHidden_${_pageRef}" name="individualEventCO.eventStaticOmniInboxQueryParamMappingGridDataHidden"></ps:hidden>
<ps:hidden id="eventStaticOmniInboxQueryArgumentsHiddenId_${_pageRef}" name="individualEventCO.omniInboxQueryParameterListJson" />
<ps:hidden id="eventStaticOmniInboxQueryColumnsHiddenId_${_pageRef}" name="individualEventCO.omniInboxQueryColumnListJson" />

<ps:hidden id="eventStaticOmniInboxMessageDefaultSubjectHiddenId_${_pageRef}" name="individualEventCO.omniInbox_EVT_COMM_MODEVO.DEFAULT_MESSAGE_SUBJECT" />
<ps:hidden id="eventStaticOmniInboxMessageDefaultBodyHiddenId_${_pageRef}" name="individualEventCO.omniInbox_EVT_COMM_MODEVO.DEFAULT_MESSAGE_BODY" />

<ps:hidden id="eventStaticOmniInboxMessageARHiddenId_${_pageRef}" name="individualEventCO.eventStaticOmniInboxMessageARHidden" />
<ps:hidden id="eventStaticOmniInboxMessageENHiddenId_${_pageRef}" name="individualEventCO.eventStaticOmniInboxMessageENHidden" />
<ps:hidden id="eventStaticOmniInboxMessageFRHiddenId_${_pageRef}" name="individualEventCO.eventStaticOmniInboxMessageFRHidden" />
<ps:hidden id="eventStaticOmniInboxMessageFAHiddenId_${_pageRef}" name="individualEventCO.eventStaticOmniInboxMessageFAHidden" />
<ps:hidden id="eventStaticOmniInboxMessageRUHiddenId_${_pageRef}" name="individualEventCO.eventStaticOmniInboxMessageRUHidden" />
<ps:hidden id="eventStaticOmniInboxMessageTKHiddenId_${_pageRef}" name="individualEventCO.eventStaticOmniInboxMessageTKHidden" />

<!--  Static OmniInbox New Costom Tags-->
<%-- <ps:hidden id="eventStaticOmniInboxNewCustomTagsHiddenId_${_pageRef}" name="individualEventCO.eventStaticOmniInboxNewCustomTagsHidden" /> --%>

<!-- Report Attachment Hidden Fields -->
<ps:hidden id="eventStaticOmniInboxReportAttachmentCount_${_pageRef}" name="individualEventCO.omniInboxEventStaticReportAttachCount"></ps:hidden>
<ps:hidden id="eventStaticOmniInboxRemovedReportAttachmentIds_${_pageRef}" name="individualEventCO.eventOmniRemovedReportAttachmentIds"></ps:hidden>

<ps:hidden id="eventStaticOmniInboxQueryHiddenId_${_pageRef}" name="individualEventCO.omniInboxQueryId"></ps:hidden>

<table cellpadding="2" cellspacing="1">
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
			<ps:label key="language_key" id="lbl_eventStaticOmniInboxOtherLanguage_${_pageRef}" for="eventStaticOmniInboxOtherLanguage_${_pageRef}" />
		</td>
		<td>
			<ps:select
				id="eventStaticOmniInboxOtherLanguage_${_pageRef}"
		 		list="otherLanguageTypeList"  
		 		listKey="code" 
		 		listValue="descValue" 
		 		name="individualEventCO.omniInbox_EVT_OL_DATA_TRANSVO.LANG_CODE"
				tabindex="9"
				cssStyle="width: 100%;"
				onchange="individualEventMaint_setStaticMessage('OI','OmniInbox');" />
		</td>
	</tr>
	<tr>	
		<td nowrap="nowrap"> 
			<ps:label key="query_id_key" id="lbl_eventStaticOmniInboxQueryId_${_pageRef}" for="lookuptxt_eventStaticOmniInboxQueryId_${_pageRef}" />
				</td>
				<td>
					<psj:livesearch 
						name="individualEventCO.omniInbox_EVT_COMM_MODEVO.QUERY_ID"
						id="eventStaticOmniInboxQueryId_${_pageRef}" 
						mode="number" 
						leadZeros="8" 
						tabindex="19"
						minValue="0" 
						resultList="QUERY_ID:lookuptxt_eventStaticOmniInboxQueryId_${_pageRef}, "
						actionName="${pageContext.request.contextPath}/path/alert/events/event/QueryLookupAction_constructQueryLookup"
						dependencySrc="${pageContext.request.contextPath}/path/alert/events/event/QueryLookupDependancyAction_dependencyByQueryId"
						dependency="lookuptxt_eventStaticOmniInboxQueryId_${_pageRef}:individualEventCO.irp_AD_HOC_QUERYCO.QUERY_ID,
									eventStaticOmniInboxQueryHiddenId_${_pageRef}:individualEventCO.irp_AD_HOC_QUERYCO.QUERY_ID,
									eventStaticOmniInboxQueryBriefDescEng_${_pageRef}:individualEventCO.irp_AD_HOC_QUERYCO.QUERY_NAME,
									eventStaticOmniInboxQueryArgumentsHiddenId_${_pageRef}:individualEventCO.omniInboxQueryParameterListJson,
									eventStaticOmniInboxQueryColumnsHiddenId_${_pageRef}:individualEventCO.omniInboxQueryColumnListJson"
									
						parameter="criteria.queryId:lookuptxt_eventStaticOmniInboxQueryId_${_pageRef}"
						searchElement="QUERY_ID" 
						maxlength="8"  
						afterDepEvent="individualEvents_returnQueryColumnsByQueryId('OmniInbox')"
						beforeDepEvent="individualAlertTag_queryTagsValidation('OmniInbox');">
					</psj:livesearch>
				</td>
 				<td colspan="5"> 
					<ps:textfield
						id="eventStaticOmniInboxQueryBriefDescEng_${_pageRef}" 
						name="individualEventCO.omniInboxQueryBriefDescription"
						mode="string" 
						required="" 
						readonly="true" 
						tabindex="1"
						maxlength="100" /> 
				</td>
				<td> 
					<psj:a id="eventStaticOmniInboxQueryParameterButton_${_pageRef}" name="eventStaticOmniInboxQueryParameterButton"
						button="true" 
						buttonIcon="ui-icon-triangle-2-s"
						onclick="individualEventMaint_openQueryDialog('OmniInbox');">
						<ps:text name='parameters_key' />
					</psj:a>
				</td>
			</tr>
			<tr>
				<td  nowrap="nowrap">
					<ps:label key="subject_key" id="lbl_eventStaticOmniInboxMessageSubjectEng_${_pageRef}" for="eventStaticOmniInboxMmessageSubjectEng_${_pageRef}" />
				</td>
				<td  colspan="7">
					<ps:textfield 
						id="eventStaticOmniInboxMessageSubjectEng_${_pageRef}" 
						name="individualEventCO.omniInbox_EVT_OL_DATA_TRANSVO.MESSAGE_SUBJECT" 
						mode="text" 
						required="" 
						tabindex="6" 
						maxlength="200"
						onclick="individualEventComm_getId(this);"
					/>
				</td>
			</tr>
			<tr>
				<td valign="top"   nowrap="nowrap">
					<ps:label key="body_key" id="lbl_eventStaticOmniInboxMessageBodyEng_${_pageRef}" for="eventStaticOmniInboxMessageBodyEng_${_pageRef}" />
				</td>
				<td  valign="top" colspan="6">
					<ps:textarea
						id="eventStaticOmniInboxMessageBodyEng_${_pageRef}" 
						name="individualEventCO.omniInbox_EVT_OL_DATA_TRANSVO.MESSAGE_BODY" 
						mode="text"
						required="" 
						rows="7.5" 
						tabindex="6" 
						maxlength="4000"
						cssStyle="height: 195px;white-space: pre-wrap;"
						onkeyup="individualEventMaint_setRemainingCharachter('OmniInbox', 4000);"
						onkeypress="individualEventMaint_setRemainingCharachter('OmniInbox', 4000);"
						onclick="individualEventComm_getId(this);"
						onkeydown="fixEventdetails_expressionShowHideData(this)"
					/>
				</td>
				<td style="vertical-align: top;">
					<div id="omniInboxStaticQueryTagsDetails_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px;">
						<div id="omniInboxStaticQueryTagsDetails_Inner_${_pageRef}" class="collapsibleContainer collapsed" title="<ps:text name='query_tags_key'/>">
						
							<psjg:grid 	
								id               		="eventOmniInboxStaticQueryTagsGridId_${_pageRef}"
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
								ondblclick       		="individualAlertTag_addTagsInTextArea('Query', 'OmniInbox')"
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
				</td>
			</tr>
			<tr>
			    <td></td>
				<td colspan="2"> <h5 style="margin-top: -9px;"><span id="OmniInboxRemaining_${_pageRef}">4000 Characters Remaining</span></h5> </td>
			</tr>
<!-- 	</table>
	
	<table cellpadding="1" cellspacing="1" border="0"> -->
		<ps:if test='%{#eventId_${_pageRef}!=null && #eventId_${_pageRef}!=""}'>
			<ps:iterator  value="individualEventCO.omniEventReportAttachmentCOs" status="row" >
				<tr id="indEventReportAttachmentRowOmniInbox${_pageRef}_${row.index}">
					<td  nowrap="nowrap"> 
						<ps:label key="attach_reportId_key"
						id="lbl_eventOmniInboxStaticReportId_${row.index+1}_${_pageRef}"
						for="lookuptxt_eventOmniInboxStaticReportAttachmentId_${row.index+1}_${_pageRef}" />
				</td>
					<td>
						<psj:livesearch name="individualEventCO.omniReportArray" value="${reportId}"
							id="eventOmniInboxStaticReportAttachmentId_${row.index+1}_${_pageRef}" mode="number" leadZeros="8" tabindex="19"
							minValue="0" 
							resultList="REPORT_ID:lookuptxt_eventOmniInboxStaticReportAttachmentId_${row.index+1}_${_pageRef}, "
							actionName="${pageContext.request.contextPath}/pathdesktop/UsrReportsLookup_constructLookup"
							dependencySrc="${pageContext.request.contextPath}/path/alert/events/event/ReportLookupDependancyAction_dependencyByReportId"
							dependency="lookuptxt_eventOmniInboxStaticReportAttachmentId_${row.index+1}_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_ID,
										eveventOmniInboxStaticReportAttachmentBriefDescEng_${row.index+1}_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_NAME,
										eventStaticOmniInboxReportAttachmentArgumentsHiddenId_${row.index+1}_${_pageRef}:individualEventCO.omniInboxReportParameterListJson"
							parameter="criteria.reportId:lookuptxt_eventOmniInboxStaticReportAttachmentId_${row.index+1}_${_pageRef}"
							searchElement="REPORT_ID" maxlength="8"
							afterDepEvent="individualEventReport_validateReportAttachments('ReportAttach','OmniInbox',${row.index+1})">
						</psj:livesearch>
					</td>
					<td colspan="5">
						<ps:textfield
							id="eventOmniInboxStaticReportAttachmentBriefDescEng_${row.index+1}_${_pageRef}" 
							name="reportDescription"
							mode="string" 
							required="" 
							readonly="true" 
							tabindex="1"
							maxlength="100"/> 
					</td>
					<td>
						<psj:a 
							id="eventOmniInboxStaticReportAttachmentParameterButton_${row.index+1}_${_pageRef}" 
							name="eventStaticOmniInboxReportParameterButton"
							button="true" 
							buttonIcon="ui-icon-triangle-2-s" 
							onclick="individualEventReport_openReportAttachmentParameterDialog('OmniInbox',${row.index+1})" >
							<ps:text name='parameters_key' />
						</psj:a>
						 <ps:hidden	id="eventStaticOmniInboxReportAttachmentArgumentsHiddenId_${row.index+1}_${_pageRef}"
									name="individualEventCO.omniReportAttachementParameterArray" /> 
									
						<ps:if test='%{ ${row.index}==0}'>
							<psj:a
								id="addOmniInboxReportAttachment_${_pageRef}_${row.index+1}" button="true"
								onclick="individualEventReport_addReportAttachmentsField('OmniInbox')">
								<ps:text name='+' />
							</psj:a>
						</ps:if>
						<ps:if test='%{${row.index}>0}'>
							<psj:a
								id="RemoveOmniInboxReportAttachment_${_pageRef}_${row.index+1}" 
								button="true"
								onclick="individualEventReport_removeReportAttachmentsField('OmniInbox', this, ${row.index+1})" >
								<ps:text name='-' />
							</psj:a>
						</ps:if>
						
						
						<ps:hidden	id="statusRAOmniInboxHiddenId_${row.index+1}_${_pageRef}"
									name="reportAttachmentStatus" />
					</td>
				</tr>
			</ps:iterator>
		</ps:if>
		<%-- <ps:if test='%{individualEventCO.omniEventReportAttachmentCOs.size==0}'>
			<tr id="indEventReportAttachmentRowOmniInbox${_pageRef}_1">
			<td nowrap="nowrap""> 
				<ps:label key="attach_reportId_key" id="lbl_eventOmniInboxStaticReportId_1_${_pageRef}" for="lookuptxt_eventOmniInboxStaticReportAttachmentId_${_pageRef}" />
			</td>
			<td>
				
				<psj:livesearch name="individualEventCO.omniReportArray"
					id="eventOmniInboxStaticReportAttachmentId_1_${_pageRef}" mode="number" leadZeros="8" tabindex="19"
					minValue="0" 
					resultList="REPORT_ID:lookuptxt_eventOmniInboxStaticReportAttachmentId_1_${_pageRef}, "
					actionName="${pageContext.request.contextPath}/pathdesktop/UsrReportsLookup_constructLookup"
					dependencySrc="${pageContext.request.contextPath}/path/alert/events/event/ReportLookupDependancyAction_dependencyByReportId"
					dependency="lookuptxt_eventOmniInboxStaticReportAttachmentId_1_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_ID,
								eventOmniInboxStaticReportAttachmentBriefDescEng_1_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_NAME,
								eventStaticOmniInboxReportAttachmentArgumentsHiddenId_1_${_pageRef}:individualEventCO.omniInboxReportParameterListJson"
					parameter="criteria.reportId:lookuptxt_eventOmniInboxStaticReportAttachmentId_1_${_pageRef},criteria.lookupOf:'RA'"
					searchElement="REPORT_ID" maxlength="8"
					afterDepEvent="individualEventReport_validateReportAttachments('ReportAttach','OmniInbox',1)">
				</psj:livesearch>
			</td>
			<td colspan="5">
				<ps:textfield
					id="eventOmniInboxStaticReportAttachmentBriefDescEng_1_${_pageRef}" 
					name="individualEventCO.omniInboxReportAttachmentBriefDescription"
					mode="string" 
					required="" 
					readonly="true" 
					tabindex="1"
					maxlength="100"/> 
			</td>
			<td >
				<psj:a id="eventOmniInboxStaticReportAttachmentParameterButton_1_${_pageRef}" name="eventStaticOmniInboxReportParameterButton"
					button="true" 
					buttonIcon="ui-icon-triangle-2-s"
					onclick="individualEventReport_openReportAttachmentParameterDialog('OmniInbox',1)">
					<ps:text name='parameters_key' />
				</psj:a>
				 <ps:hidden	id="eventStaticOmniInboxReportAttachmentArgumentsHiddenId_1_${_pageRef}"
							name="individualEventCO.omniReportAttachementParameterArray" /> 
				<psj:a
					id="addOmniInboxReportAttachment_${_pageRef}_1" button="true"
					onclick="individualEventReport_addReportAttachmentsField('OmniInbox')">
					<ps:text name='+' />
				</psj:a>
			</td>
		</tr>		
		</ps:if> --%>
	</table>

	
	<script type="text/javascript">
		$("#eventOmniInboxStaticCustomTagsGridId_"+_pageRef).subscribe("onRowSelTopic",function(rowObj)
		{
			individualEventMaint_disableCustomColumnCell('OmniInbox');			
		});
	</script>