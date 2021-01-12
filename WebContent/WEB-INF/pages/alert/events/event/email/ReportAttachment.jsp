<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt"  uri="/path-toolbar-tags" %>

	<tr id="indEventReportAttachmentRowEmail${_pageRef}_${individualEventCO.emailEventStaticReportAttachCount}"
		class="indEventEmailReportAttachClass">
		<td nowrap="nowrap">
			<ps:label key="attach_reportId_key"
				id="lbl_eventEmailStaticReportId_${individualEventCO.emailEventStaticReportAttachCount}_${_pageRef}"
				for="lookuptxt_eventEmailStaticReportAttachmentId_${_pageRef}" /></td>
		<td><psj:livesearch
				name="individualEventCO.emailReportArray"
				id="eventEmailStaticReportAttachmentId_${individualEventCO.emailEventStaticReportAttachCount}_${_pageRef}" mode="number"
				leadZeros="8" tabindex="19" minValue="0"
				resultList="REPORT_ID:lookuptxt_eventEmailStaticReportAttachmentId_${individualEventCO.emailEventStaticReportAttachCount}_${_pageRef}, "
				actionName="${pageContext.request.contextPath}/pathdesktop/UsrReportsLookup_constructLookup"
				dependencySrc="${pageContext.request.contextPath}/path/alert/events/event/ReportLookupDependancyAction_dependencyByReportId"
				dependency="lookuptxt_eventEmailStaticReportAttachmentId_${individualEventCO.emailEventStaticReportAttachCount}_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_ID,
										eventEmailStaticReportAttachmentBriefDescEng_${individualEventCO.emailEventStaticReportAttachCount}_${_pageRef}:individualEventCO.irp_AD_HOC_REPORTCO.REPORT_NAME,
										eventStaticEmailReportAttachmentArgumentsHiddenId_${individualEventCO.emailEventStaticReportAttachCount}_${_pageRef}:individualEventCO.emailReportParameterListJson"
				parameter="criteria.reportId:lookuptxt_eventEmailStaticReportAttachmentId_${individualEventCO.emailEventStaticReportAttachCount}_${_pageRef},
				criteria.lookupOf:'RA'"
				searchElement="REPORT_ID" maxlength="8"
				afterDepEvent="individualEventReport_validateReportAttachments('ReportAttach','Email',${individualEventCO.emailEventStaticReportAttachCount})">
			</psj:livesearch></td>
		<td colspan="5"><ps:textfield
				id="eventEmailStaticReportAttachmentBriefDescEng_${individualEventCO.emailEventStaticReportAttachCount}_${_pageRef}"
				name="individualEventCO.emailReportAttachmentBriefDescription"
				mode="string" required="" readonly="true" tabindex="1"
				maxlength="100" /></td>
		<td><psj:a
				id="eventEmailStaticReportAttachmentParameterButton_${individualEventCO.emailEventStaticReportAttachCount}_${_pageRef}"
				name="eventStaticEmailReportParameterButton" button="true"
				buttonIcon="ui-icon-triangle-2-s"
				onclick="individualEventReport_openReportAttachmentParameterDialog('Email',${individualEventCO.emailEventStaticReportAttachCount})">
				<ps:text name='parameters_key' />
			</psj:a> <ps:hidden
				id="eventStaticEmailReportAttachmentArgumentsHiddenId_${individualEventCO.emailEventStaticReportAttachCount}_${_pageRef}"
				name="individualEventCO.emailReportAttachementParameterArray" /> 
				<psj:a
				id="RemoveReportAttachment_${_pageRef}_${individualEventCO.emailEventStaticReportAttachCount}" button="true"
				onclick="individualEventReport_removeReportAttachmentsField('Email', this, ${individualEventCO.emailEventStaticReportAttachCount})">
				<ps:text name='-' />
			</psj:a>
			<ps:hidden	id="statusRAEmailHiddenId_${individualEventCO.emailEventStaticReportAttachCount}_${_pageRef}"
									name="individualEventReportAttachmentCO.reportAttachmentStatus" />
		</td>
	</tr>