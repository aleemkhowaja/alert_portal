<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp" %>

<style>
	.ui-autocomplete {
		max-height: 180px;
		overflow-y: auto;
		overflow-x: hidden;
	}
</style>
<html>
<body>
	<ps:hidden  id="selectedTxtArea_${_pageRef}"/>
	
	<ps:hidden name="updates" id="updatesEventQueryParam_${_pageRef}"></ps:hidden>
	<ps:hidden name="communicationType" id="communicationType_${_pageRef}"></ps:hidden>
	<ps:set name="eventQueryId_${_pageRef}" value="individualEventSC.queryId" />
		
	<ps:set name="filterExprssion_${_pageRef}" value="templateEntriesCO.fcsExclTmpltEntryDtlVOWithBlob.LINE_DESCRIPTION" />
	<ps:hidden id="eventStaticReportAttachmentArgumentsHiddenId_${_pageRef}" name="individualEventCO.eventStaticEmailStaticReportAttachmentDataHidden" />
	
	<ps:url id="urlQueryArgumentsGrid" escapeAmp="false" action="IndividualEventGridAction_returnEventsQueryArgumentsForGrid" namespace="/path/alert/events/event">
   		<ps:param name="_pageRef" value="_pageRef"></ps:param>
   		<ps:param name="individualEventSC.queryId" value="eventQueryId_${_pageRef}"></ps:param>
	</ps:url>
	
	<div class="collapsibleContainer" title="<ps:text name='parameters_key'/>">
		<table  width="100%" border ="0">
			<tr>
				<td>
					<div style="height: 200px ;overflow: auto;">
						<psjg:grid 	
							id               		="eventArgumentGridId_${_pageRef}"
							dataType         		="json"
							pager            		="false"
							sortable         		="false"
							filter           		="false"
							gridModel        		="gridModel"
							rowNum           		="5"
							rowList         		="5,10,15,20"
							viewrecords      		="false"
							navigator        		="false"
							navigatorDelete  		="false"
							navigatorEdit    		="false"
							navigatorRefresh 		="false"
							navigatorAdd     		="false"
							navigatorSearch  		="false"
							editurl			 		=" " 
							editinline		 		='%{_pageRef == "EVT01MT" || _pageRef == "EVT01MA"}' 
						    navigatorSearchOptions	="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
						    altRows          		="true"
						    autowidth        		="false"
							width    				="570"
							height					="120"
							onSelectRowTopics		="onRowSelTopic"
							onEditInlineBeforeTopics="onEditRowTopics"
							onGridCompleteTopics	="onGridCompleteGrid"
							>
						    
							<psjg:gridColumn 
								name="ARG_NAME" 
								sortable="true" 
								index="ARG_NAME" 
								id="ARG_NAME" 
								title="%{getText('arg_name_key')}" 
								colType="text" 
								width="100"/>
								
							<psjg:gridColumn 
								name="MAPPING_TAG_NAME" 
								sortable="true" 
								index="MAPPING_TAG_NAME" 
								id="MAPPING_TAG_NAME" 
								title="%{getText('mapping_tag_key')}"
								editable='%{_pageRef == "EVT01MT" || _pageRef == "EVT01MA"}' 
								colType="select" 
								edittype="select" 
								afterDepEvent=""
								editoptions="{ value:function() {return individualEventMaint_loadTagsCombo('${pageContext.request.contextPath}/path/alert/events/event/IndividualEventMaintAction_fillMappingtCustomDefaultTagTagsDropDown.action?individualEventSC.isCustomYN=N','alrtTagsCOList', 'TAG_NAME', 'TAG_NAME');}
									, dataEvents: [{ type: 'change', fn: function(e) {individualEventMaint_enableAndDisableStaticValueColumn();}}]}"
									
								width="150"/>
								
						   <psjg:gridColumn 
								name		="MAPPING_VALUE_HIDDEN" 
								index		="MAPPING_VALUE_HIDDEN" 
								id			="MAPPING_VALUE_HIDDEN" 
								title		="%{getText('mapping_value_key')}" 
								colType		="text" 
								width		="80"
								hidden		="true"
								/>
									
							<psjg:gridColumn 
								name="MAPPING_VALUE" 
								sortable="true"
								index="MAPPING_VALUE" 
								id="MAPPING_VALUE" 
								title="%{getText('mapping_value_key')}" 
								colType="text" 
								editable='%{_pageRef == "EVT01MT" || _pageRef == "EVT01MA"}'
								
								width="80"
								editoptions="{maxlength: '255'}"
						  />
								
								
							<psjg:gridColumn 
								name="ID" 
								sortable="true"
								index="ID" 
								id="ID" 
								title="%{getText('ID_key')}" 
								colType="text" 
								hidden="true" />
								
							<psjg:gridColumn 
								name="ATTACH_REPORT_ID" 
								sortable="true"
								index="ATTACH_REPORT_ID" 
								id="ATTACH_REPORT_ID" 
								title="%{getText('ATTACH_REPORT_ID_key')}" 
								colType="text" 
								hidden="true" />
						</psjg:grid>
					</div>
				</td>
			</tr>
		</table>
	</div>
	
	<script type="text/javascript">
		
		$("#eventArgumentGridId_"+_pageRef).subscribe("onRowSelTopic",function(rowObj)
		{
			individualEventMaint_enableAndDisableStaticValueColumn();			
		});

		$("#eventArgumentGridId_"+_pageRef).subscribe("onEditRowTopics",function(rowObj)
		{
			//add customn/query/fixed events tags
			individualEvents_addCustomnAndFixedTags();
			
			//enable and desable value column
			individualEventMaint_enableAndDisableStaticValueColumn();
		});
		
		$("#eventArgumentGridId_"+_pageRef).subscribe("onGridCompleteGrid",function(rowObj)
		{
			individualAlertTag_fillMappingTagInHiddenField();
		});
</script>
</body>
</html>

