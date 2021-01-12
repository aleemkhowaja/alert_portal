<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt"  uri="/path-toolbar-tags" %>

<ps:set name="Confirm_Delete_Change_Process_key" value="%{getEscText('Confirm_Delete_Change_Process_key')}" />
<ps:set name="Confirm_Delete_Change_Details_Process_key" value="%{getEscText('Confirm_Delete_Change_Details_Process_key')}" />
<ps:set name="entry_number_is_already_in_use" value="%{getEscText('entry_number_is_already_in_use')}" />

<ps:set name="eventQueryId_${_pageRef}" value="individualEventSC.queryId" />

<ps:hidden id="eventDynamicBatchMessageDetailsTemp_${_pageRef}" name="individualEventCO.eventDynamicBatchMessageDetailsTemp"></ps:hidden>
	
<ps:hidden id="eventStaticBatchOtherLanguageHidden_${_pageRef}" name="individualEventCO.eventStaticBatchOtherLanguageHidden" value="DF"></ps:hidden>				

<ps:hidden id="eventStaticBatchParamMappingGridDataHidden_${_pageRef}" name="individualEventCO.eventStaticBatchParamMappingGridDataHidden"></ps:hidden>

<ps:hidden id="eventStaticBatchQueryArgumentsHiddenId_${_pageRef}" name="individualEventCO.batchQueryParameterListJson" />
<ps:hidden id="eventStaticBatchQueryColumnsHiddenId_${_pageRef}" name="individualEventCO.batchQueryColumnListJson" />

<ps:hidden id="eventStaticBatchReportArgumentsHiddenId_${_pageRef}" name="individualEventCO.batchReportParameterListJson" />
<ps:hidden id="queryOptionBatchType_${_pageRef}" name="individualEventCO.batchTypeQueryCol" />

<ps:hidden id="eventStaticBatchDefaultSubjectHiddenId_${_pageRef}" name="individualEventCO.batch_EVT_COMM_MODEVO.DEFAULT_MESSAGE_SUBJECT" />
<ps:hidden id="eventStaticBatchDefaultBodyHiddenId_${_pageRef}" name="individualEventCO.batch_EVT_COMM_MODEVO.DEFAULT_MESSAGE_BODY" />

<!-- Language Related Hidden Fields -->
<ps:hidden id="eventStaticBatchMessageARHiddenId_${_pageRef}" name="individualEventCO.eventStaticBatchMessageARHidden" />
<ps:hidden id="eventStaticBatchMessageENHiddenId_${_pageRef}" name="individualEventCO.eventStaticBatchMessageENHidden" />
<ps:hidden id="eventStaticBatchMessageFRHiddenId_${_pageRef}" name="individualEventCO.eventStaticBatchMessageFRHidden" />
<ps:hidden id="eventStaticBatchMessageFAHiddenId_${_pageRef}" name="individualEventCO.eventStaticBatchMessageFAHidden" />
<ps:hidden id="eventStaticBatchMessageRUHiddenId_${_pageRef}" name="individualEventCO.eventStaticBatchMessageRUHidden" />
<ps:hidden id="eventStaticBatchMessageTKHiddenId_${_pageRef}" name="individualEventCO.eventStaticBatchMessageTKHidden" />

<!-- New Custom Tags Hidden Field -->
<ps:hidden id="eventStaticBatchNewCustomTagsHiddenId_${_pageRef}" name="individualEventCO.eventStatiBatchNewCustomTagsHidden" />


<!-- Report Attachment Hidden Fields -->
<ps:hidden id="eventStaticBatchReportAttachmentDataHidden_${_pageRef}" name="individualEventCO.eventStaticBatchStaticReportAttachmentDataHidden" />

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
	});
	
	
</script>
	
	<ps:set name="ivcrud_${_pageRef}"    value="iv_crud"/>
		<table cellpadding="2" cellspacing="1" border="0" >
		 	<tr>
				<td nowrap="nowrap"  style="width: 12%;"> 
					<ps:label key="Query_key" id="lbl_eventStaticBatchQueryId_${_pageRef}" for="lookuptxt_eventStaticBatchQueryId_${_pageRef}" />
				</td>
				<td style="width:6%;">
					<psj:livesearch 
						name="individualEventCO.alrtEvtVO.REPORT_ID"
						id="eventStaticBatchQueryId_${_pageRef}" 
						mode="number" 
						leadZeros="8" 
						tabindex="19"
						minValue="0" 
						resultList="QUERY_ID:lookuptxt_eventStaticBatchQueryId_${_pageRef}, "
						actionName="${pageContext.request.contextPath}/path/alert/events/event/QueryLookupAction_constructQueryLookup"
						dependencySrc="${pageContext.request.contextPath}/path/alert/events/event/QueryLookupDependancyAction_dependencyByQueryId"
						dependency="lookuptxt_eventStaticBatchQueryId_${_pageRef}:individualEventCO.irp_AD_HOC_QUERYCO.QUERY_ID,
									eventStaticBatchQueryHiddenId_${_pageRef}:individualEventCO.irp_AD_HOC_QUERYCO.QUERY_ID,
									eventStaticBatchQueryBriefDescEng_${_pageRef}:individualEventCO.irp_AD_HOC_QUERYCO.QUERY_NAME,
									eventStaticBatchQueryArgumentsHiddenId_${_pageRef}:individualEventCO.batchQueryParameterListJson,
									eventStaticBatchQueryColumnsHiddenId_${_pageRef}:individualEventCO.batchQueryColumnListJson"
									
						parameter="criteria.queryId:lookuptxt_eventStaticBatchQueryId_${_pageRef}"
						searchElement="individualEventCO.alrtEvtVO.REPORT_ID" 
						maxlength="8"  
						afterDepEvent="individualEvents_returnQueryColumnsByQueryId('Batch')">
					</psj:livesearch>
				</td>
 				<td style="width: 23.5%;text-align: left;"> 
					<ps:textfield
						id="eventStaticBatchQueryBriefDescEng_${_pageRef}" 
						name="individualEventCO.batchQueryBriefDescription"
						mode="string" 
						required="" 
						readonly="true" 
						tabindex="1"
						maxlength="100" /> 
				</td>
				<td> 
					<psj:a id="eventStaticBatchQueryParameterButton_${_pageRef}" name="eventStaticBatchQueryParameterButton"
						button="true" 
						buttonIcon="ui-icon-triangle-2-s"
						onclick="individualEventMaint_openQueryDialog('Batch');">
						<ps:text name='parameters_key' />
					</psj:a>
				</td>
			</tr>
			<tr id="trBatchTypeOption_${_pageRef}">
				<td nowrap="nowrap" style="width: 12%;">
					<ps:label key="mapping_subscriber_id"  id="lbl_subscriberType_option_${_pageRef}"  for="subscriberType_option_${_pageRef}" />
				 </td>			
				 <td style="width: 10%;">
				 	<ps:select
				 		list="subscriberTypeOptionList"  
				 		listKey="code" 
				 		listValue="descValue" 
				 		name="individualEventCO.alrtEvtVO.EVENT_BATCH_TYPE"
						id="subscriberType_option_${_pageRef}"
						tabindex="9"
						onchange="" />
				</td>
				<td style="width: 10%;">
				 	<ps:select
				 		list="batchTypeQueryOptionList"  
				 		listKey="code" 
				 		listValue="descValue" 
				 		name="individualEventCO.alrtEvtVO.BATCH_TYPE_QUERY_COL"
						id="batchType_option_${_pageRef}"
						tabindex="10"
						onchange="" />
				</td>
			</tr>
		</table>
		<div id="eventBatchStaticQueryTagsDivId_${_pageRef}" hidden="true">
			<table cellpadding="2" cellspacing="1" border="0">
				<tr>
					<td style="vertical-align: top;">
					</td >
					<td style="vertical-align: top;">
						<div id="batchStaticQueryTagsDetails_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px;">
							<psjg:grid 	
								id               		="eventBatchStaticQueryTagsGridId_${_pageRef}"
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
								ondblclick       		="individualAlertTag_addTagsInTextArea('Query', 'Batch')"
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
					</td>
				</tr>
		</table>
	</div>
	
	<script type="text/javascript">
		$("#eventBatchStaticCustomTagsGridId_"+_pageRef).subscribe("onRowSelTopic",function(rowObj)
		{
			individualEventMaint_disableCustomColumnCell('Batch');			
		});

		
		$.subscribe('setBatchGridLayout', function(event, data) {
			//	$("#gbox_individualSubscriberGridTbl_Id_"+_pageRef).removeAttr("style");
			//	$("#individualSubscriberGridTbl_Id_"+_pageRef).removeAttr("style");
			//	$(".ui-jqgrid-btable").removeAttr("style");
			
			indEvent_setLayout("eventBatchStaticCustomTagsGridId");
			indEvent_setLayout("eventBatchStaticDefaultTagsGridId");
			indEvent_setLayout("eventBatchStaticQueryTagsGridId");
			 
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
	</script>
