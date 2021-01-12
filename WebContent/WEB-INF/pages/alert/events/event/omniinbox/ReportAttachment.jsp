<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt"  uri="/path-toolbar-tags" %>

	<tr id="indEventReportAttachmentRowOmniInbox${_pageRef}_${individualEventCO.omniInboxEventStaticReportAttachCount}"
		class="indEventOmniInboxReportAttachClass">
		<td nowrap="nowrap"><ps:label key="attach_reportId_key"
				id="lbl_eventOmniInboxStaticReportId_${individualEventCO.omniInboxEventStaticReportAttachCount}_${_pageRef}"
				for="lookuptxt_eventOmniInboxStaticReportAttachmentId_${_pageRef}" /></td>
		<td><psj:livesearch
				name="individualEventCO.omniReportArray"
				id="eventOmniInboxStaticReportAttachmentId_${individualEventCO.omniInboxEventStaticReportAttachCount}_${_pageRef}" mode="number"
				leadZeros="8" tabindex="19" minValue="0"
				resultList="REPORT_ID:lookuptxt_eventOmniInboxStaticReportAttachmentId_${individualEventCO.omniInboxEventStaticReportAttachCount}_${_pageRef}, "
				actionName="${pageContext.request.contextPath}/pathdesktop/UsrReportsLookup_constructLookup"
				dependencySrc="${pageContext.request.contextPath}/path/alert/events/event/ReportLookupDependancyAction_dependencyByReportId"
				dependency="lookuptxt_eventOmniInboxStaticReportAttachmentId_${individualEventCO.omniInboxEventStaticReportAttachCount}_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_ID,
										eventOmniInboxStaticReportAttachmentBriefDescEng_${individualEventCO.omniInboxEventStaticReportAttachCount}_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_NAME,
										eventStaticOmniInboxReportAttachmentArgumentsHiddenId_${individualEventCO.omniInboxEventStaticReportAttachCount}_${_pageRef}:individualEventCO.omniInboxReportParameterListJson"
				parameter="criteria.reportId:lookuptxt_eventOmniInboxStaticReportAttachmentId_${individualEventCO.omniInboxEventStaticReportAttachCount}_${_pageRef},
				criteria.lookupOf:'RA'"
				searchElement="REPORT_ID" maxlength="8"
				afterDepEvent="individualEventReport_validateReportAttachments('ReportAttach','OmniInbox',${individualEventCO.omniInboxEventStaticReportAttachCount})">
			</psj:livesearch></td>
		<td colspan="5"><ps:textfield
				id="eventOmniInboxStaticReportAttachmentBriefDescEng_${individualEventCO.omniInboxEventStaticReportAttachCount}_${_pageRef}"
				name="individualEventCO.omniInboxReportAttachmentBriefDescription"
				mode="string" required="" readonly="true" tabindex="1"
				maxlength="100" /></td>
		<td><psj:a
				id="eventOmniInboxStaticReportAttachmentParameterButton_${individualEventCO.omniInboxEventStaticReportAttachCount}_${_pageRef}"
				name="eventStaticOmniInboxReportParameterButton" button="true"
				buttonIcon="ui-icon-triangle-2-s"
				onclick="individualEventReport_openReportAttachmentParameterDialog('OmniInbox',${individualEventCO.omniInboxEventStaticReportAttachCount})">
				<ps:text name='parameters_key' />
			</psj:a> <ps:hidden
				id="eventStaticOmniInboxReportAttachmentArgumentsHiddenId_${individualEventCO.omniInboxEventStaticReportAttachCount}_${_pageRef}"
				name="individualEventCO.omniReportAttachementParameterArray" /> 
				<psj:a
				id="RemoveOmniInboxReportAttachment_${_pageRef}_${individualEventCO.omniInboxEventStaticReportAttachCount}" button="true"
				onclick="individualEventReport_removeReportAttachmentsField('OmniInbox', this, ${individualEventCO.omniInboxEventStaticReportAttachCount})">
				<ps:text name='-' />
			</psj:a>
			<ps:hidden	id="statusRAOmniInboxHiddenId_${individualEventCO.omniInboxEventStaticReportAttachCount}_${_pageRef}"
									name="individualEventReportAttachmentCO.reportAttachmentStatus" />
		</td>
	</tr>