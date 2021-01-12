<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp" %>


<html>
<body>

	<div class="collapsibleContainer" title="<ps:text name='report_attachment_key'/>">
		<ps:url id="urlEventReportAttachmentGrid" escapeAmp="false" action="IndividualEventListAction_returnIndividualEventReportAttachmentForGrid" namespace="/path/alert/events/event">
			<ps:param name="_pageRef" value="_pageRef"></ps:param>
			<ps:param name="individualEventSC.isCustomYN" value="'Y'"></ps:param>
		</ps:url>
		<table  width="100%" border ="0">
			<tr>
				<td>
					<div style="height: 200px ;overflow: auto;">
						<psjg:grid 	
							id               ="eventStaticReportAttachmentGridId_${_pageRef}"
							href             ="%{urlEventReportAttachmentGrid}"
							dataType         ="json"
							pager            ="false"
							sortable         ="true"
							filter           ="true"
							gridModel        ="gridModel"
							rowNum           ="5"
							rowList          ="5,10,15,20"
							viewrecords      ="false"
							navigator        ="true"
							navigatorDelete  ="false"
							navigatorEdit    ="false"
							navigatorRefresh ="true"
							navigatorAdd     ="true"
							navigatorSearch  ="false"
							editurl=" " 
							editinline="true" 
						    navigatorSearchOptions="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
						    altRows  ="true"
						    autowidth="false"
							width="600"
							addfunc="individualEvents_addNewReportAttachmentRow()"
							onSelectRowTopics="onRowSelTopic">
						    
						    <psjg:gridColumn 
						    	colType="liveSearch" 
						    	id="eventReportAttachmentId_${_pageRef}"
								name="reportId" 
								title="%{getText('report_key')}" 
								editable="true" 
								sortable="true" 
								search="true"
								autoSearch="true"
								dataAction="${pageContext.request.contextPath}/pathdesktop/UsrReportsLookup_constructLookup"
								paramList="criteria.reportId:REPORT_ID_lookuptxt"
								resultList="REPORT_ID:reportId_lookuptxt"
								
								dependencySrc="${pageContext.request.contextPath}/path/alert/events/event/ReportLookupDependancyAction_dependencyByReportId"
								params="criteria.reportId:reportId_lookuptxt"
								
								dependency="reportId_lookuptxt:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_ID,
											individualEventCO.emailReportParameterListJson:reportAttachmentParameter" />
																		
							<psjg:gridColumn 
						    	colType="custom" 
						    	id="eventReportarameterLinkId_${_pageRef}"
								name="eventReportParameterLink" 
								title="%{getText('parameters_key')}" 
								sortable="false" 
								search="false"
								mode="text"	    
								editable="false" 
								formatter="individualEventMaintt_openReportAttachmentParamtersDailog" />
							
								
							<psjg:gridColumn 
									name="reportAttachmentParameter" 
									colType="text" 
									hidden="true"
									sortable="true" 
									id="reportAttachmentParameter" 
									title="%{getText('parameter_key')}" />
									
							<psjg:gridColumn 
									name="reportAttachmentParameterMappings" 
									colType="text" 
									hidden="true"
									sortable="true" 
									id="reportAttachmentParameterMappings" 
									title="%{getText('parameter_key')}" />
									
						</psjg:grid>
					</div>
				</td>
			</tr>
		</table>
	</div>
	
	<script type="text/javascript">
		$("#eventReportAttachmentGridId_"+_pageRef).subscribe("onRowSelTopic",function(rowObj)
		{
			individualEventMaint_enableAndDisableStaticValueColumn();			
		});
</script>
</body>
</html>

