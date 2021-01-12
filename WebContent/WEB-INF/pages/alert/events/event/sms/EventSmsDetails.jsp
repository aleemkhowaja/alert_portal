<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt"  uri="/path-toolbar-tags" %>

<ps:set name="eventQueryId_${_pageRef}" value="individualEventSC.queryId" />		
<ps:set name="ivcrud_${_pageRef}"    value="iv_crud"/>

<ps:hidden id="eventDynamicSmsMessageDetailsTemp_${_pageRef}" name="individualEventCO.eventDynamicSmsMessageDetailsTemp"></ps:hidden>	
<ps:hidden id="eventStaticSmsOtherLanguageHidden_${_pageRef}" name="individualEventCO.eventStaticSmsOtherLanguageHidden" value="DF"></ps:hidden>	

<ps:hidden id="eventStaticSmsParamMappingGridDataHidden_${_pageRef}" name="individualEventCO.eventStaticSmsQueryParamMappingGridDataHidden"></ps:hidden>
<ps:hidden id="eventStaticSmsQueryArgumentsHiddenId_${_pageRef}" name="individualEventCO.smsQueryParameterListJson" />
<ps:hidden id="eventStaticSmsQueryColumnsHiddenId_${_pageRef}" name="individualEventCO.smsQueryColumnListJson" />

<ps:hidden id="eventStaticSmsMessageDefaultSubjectHiddenId_${_pageRef}" name="individualEventCO.sms_EVT_COMM_MODEVO.DEFAULT_MESSAGE_SUBJECT" />
<ps:hidden id="eventStaticSmsMessageDefaultBodyHiddenId_${_pageRef}" name="individualEventCO.sms_EVT_COMM_MODEVO.DEFAULT_MESSAGE_BODY" />

<ps:hidden id="eventStaticSmsMessageARHiddenId_${_pageRef}" name="individualEventCO.eventStaticSmsMessageARHidden" />
<ps:hidden id="eventStaticSmsMessageENHiddenId_${_pageRef}" name="individualEventCO.eventStaticSmsMessageENHidden" />
<ps:hidden id="eventStaticSmsMessageFRHiddenId_${_pageRef}" name="individualEventCO.eventStaticSmsMessageFRHidden" />
<ps:hidden id="eventStaticSmsMessageFAHiddenId_${_pageRef}" name="individualEventCO.eventStaticSmsMessageFAHidden" />
<ps:hidden id="eventStaticSmsMessageRUHiddenId_${_pageRef}" name="individualEventCO.eventStaticSmsMessageRUHidden" />
<ps:hidden id="eventStaticSmsMessageTKHiddenId_${_pageRef}" name="individualEventCO.eventStaticSmsMessageTKHidden" />

<!--  Static Sms New Costom Tags-->
<%-- <ps:hidden id="eventStaticSmsNewCustomTagsHiddenId_${_pageRef}" name="individualEventCO.eventStaticSmsNewCustomTagsHidden" /> --%>

<!-- Report Attachment Hidden Fields -->
<ps:hidden id="eventStaticSmsReportAttachmentArgumentsHiddenId_${_pageRef}" name="individualEventCO.eventStaticSmsStaticReportAttachmentDataHidden" />
<ps:hidden id="eventStaticSmsQueryHiddenId_${_pageRef}" name="individualEventCO.SmsQueryId"></ps:hidden>

<table cellpadding="1" cellspacing="1">
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
				<ps:label key="language_key" id="lbl_eventStaticSmsOtherLanguage_${_pageRef}" for="eventStaticSmsOtherLanguage_${_pageRef}" />
			</td>
			<td>
				<ps:select
					id="eventStaticSmsOtherLanguage_${_pageRef}"
			 		list="otherLanguageTypeList"  
			 		listKey="code" 
			 		listValue="descValue" 
			 		name="individualEventCO.sms_EVT_OL_DATA_TRANSVO.LANG_CODE"
					tabindex="9"
					cssStyle="width: 100%;"
					onchange="individualEventMaint_setStaticMessage('S','Sms');"
				 />
			</td>
		</tr>
		<tr>
			<td nowrap="nowrap"> 
				<ps:label key="query_id_key" id="lbl_eventStaticSmsQueryId_${_pageRef}" for="lookuptxt_eventStaticSmsQueryId_${_pageRef}" />
			</td>
			<td>
				<psj:livesearch 
					name="individualEventCO.sms_EVT_COMM_MODEVO.QUERY_ID"
					id="eventStaticSmsQueryId_${_pageRef}" 
					mode="number" 
					leadZeros="8" 
					tabindex="19"
					minValue="0" 
					resultList="QUERY_ID:lookuptxt_eventStaticSmsQueryId_${_pageRef}, "
					actionName="${pageContext.request.contextPath}/path/alert/events/event/QueryLookupAction_constructQueryLookup"
					dependencySrc="${pageContext.request.contextPath}/path/alert/events/event/QueryLookupDependancyAction_dependencyByQueryId"
					dependency="lookuptxt_eventStaticSmsQueryId_${_pageRef}:individualEventCO.irp_AD_HOC_QUERYCO.QUERY_ID,
								eventStaticSmsQueryHiddenId_${_pageRef}:individualEventCO.irp_AD_HOC_QUERYCO.QUERY_ID,
								eventStaticSmsQueryBriefDescEng_${_pageRef}:individualEventCO.irp_AD_HOC_QUERYCO.QUERY_NAME,
								eventStaticSmsQueryArgumentsHiddenId_${_pageRef}:individualEventCO.smsQueryParameterListJson,
								eventStaticSmsQueryColumnsHiddenId_${_pageRef}:individualEventCO.smsQueryColumnListJson"
					parameter="criteria.queryId:lookuptxt_eventStaticSmsQueryId_${_pageRef}"
					searchElement="QUERY_ID" 
					maxlength="8"  
					afterDepEvent="individualEvents_returnQueryColumnsByQueryId('Sms')"
					beforeDepEvent="individualAlertTag_queryTagsValidation('Sms')"
					>
				</psj:livesearch>
			</td>
			<td colspan="5"> 
				<ps:textfield
					id="eventStaticSmsQueryBriefDescEng_${_pageRef}" 
					name="individualEventCO.smsQueryBriefDescription"
					mode="string" 
					required="" 
					readonly="true" 
					tabindex="1"
					maxlength="100" /> 
			</td>
			<td> 
				<psj:a id="eventStaticSmsQueryParameterButton_${_pageRef}" name="eventStaticSmsQueryParameterButton"
					button="true" 
					buttonIcon="ui-icon-triangle-2-s"
					onclick="individualEventMaint_openQueryDialog('Sms');">
					<ps:text name='parameters_key' />
				</psj:a>
			</td>
		</tr>
		<tr>
			<td valign="top"  nowrap="nowrap">
				<ps:label key="sms_event_key" id="lbl_eventStaticSmsMessageBodyEng_${_pageRef}" for="eventStaticSmsMessageBodyEng_${_pageRef}" />
			</td>
			<td  valign="top" nowrap="nowrap" colspan="6">
				<ps:textarea
					id="eventStaticSmsMessageBodyEng_${_pageRef}" 
					name="individualEventCO.sms_EVT_OL_DATA_TRANSVO.MESSAGE_BODY" 
					mode="text"
					required="" 
					rows="7.5" 
					tabindex="6" 
					maxlength="4000"
					cssStyle="height: 195px;white-space: pre-wrap;" 
					onkeyup="individualEventMaint_setRemainingCharachter('Sms', 4000);"
					onclick="individualEventComm_getId(this);"
					onkeydown="fixEventdetails_expressionShowHideData(this)"
				/>
			</td>
			<td style="vertical-align: top;">
				<div id="smsStaticQueryTagsDetails_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px;">
					<div id="smsStaticQueryTagsDetails_Inner_${_pageRef}" class="collapsibleContainer collapsed" title="<ps:text name='query_tags_key'/>">
						<psjg:grid 	
							id               		="eventSmsStaticQueryTagsGridId_${_pageRef}"
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
							ondblclick       		="individualAlertTag_addTagsInTextArea('Query', 'Sms')"
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
		<td colspan="2"> <h5 style="margin-top: -9px;"><span id="SmsRemaining_${_pageRef}">160 Characters Remaining</span></h5> </td>
	</tr>
</table>
	
	<table>
		<tr>
			<td style="width: 10%;">
					<ps:label key="messagesubjecteng_key" id="lbl_eventStaticSmsMessageSubjectEng_${_pageRef}" for="eventStaticSmsMmessageSubjectEng_${_pageRef}" 
							  cssStyle="display:none" />
				</td>
				<td  style="width: 35%;">
					<ps:textfield 
						id="eventStaticSmsMessageSubjectEng_${_pageRef}" 
						name="individualEventCO.sms_EVT_OL_DATA_TRANSVO.MESSAGE_SUBJECT" 
						mode="text" 
						required="" 
						tabindex="6" 
						maxlength="200"
						cssStyle="display:none" />
				</td>
		</tr>
	</table>

		<script type="text/javascript">
			$("#eventSmsStaticCustomTagsGridId_"+_pageRef).subscribe("onRowSelTopic",function(rowObj)
			{
				individualEventMaint_disableCustomColumnCell('Sms');			
			});
	</script>