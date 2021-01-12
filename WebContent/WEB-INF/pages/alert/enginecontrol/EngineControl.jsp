<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@include file="/WEB-INF/pages/alert/common/AlertAppTrans.jsp"%>
<%@taglib prefix="pt" uri="/path-toolbar-tags"%>
<%@ page import="com.path.alert.bo.base.AlertConstant"%>
<jsp:include page="/WEB-INF/pages/common/login/InfoBar.jsp" />
<div id="enginecontrolPage_id_${_pageRef}" style="width: 100%;">

	<ps:url id="engineNodeGrid_url" escapeAmp="false"
		action="EngineControlListAction_returnEngineNodeDataForGrid"
		namespace="/path/alert/enginecontrol">
	</ps:url>

	<ps:set name="confirm_msg_to_start_control_node_key"
		value="%{getText('confirm_msg_to_start_control_node_key')}" />
	<ps:set name="confirm_msg_to_stop_control_node_key"
		value="%{getText('confirm_msg_to_stop_control_node_key')}" />

	<ps:set name="engine_service_stop_key"
		value="%{getText('engine_service_stop_key')}" />
	<ps:set name="engine_service_start_key"
		value="%{getText('engine_service_start_key')}" />
	<ps:set name="message_id_key" value="%{getText('message_id_key')}" />
	<ps:set name="request_id_key" value="%{getText('request_id_key')}" />
	<ps:set name="view_detail_key" value="%{getText('view_detail_key')}" />
	<ps:set name="running_key" value="%{getText('running_key')}" />
	<ps:set name="breaking_key" value="%{getText('breaking_key')}" />
	<ps:set name="stopped_key" value="%{getText('stopped_key')}" />

	<ps:set name="start_key" value="%{getText('start_key')}" />
	<ps:set name="stop_key" value="%{getText('Stop_key')}" />
	<ps:set name="unable_to_get_status_key"
		value="%{getText('unable_to_get_status_key')}" />

	<ps:set name="monitor_expend_key" value="1" />

	<script type="text/javascript">
		$.struts2_jquery.require("EngineControl.js", null, jQuery.contextPath
				+ "/path/js/alert/enginecontrol/");
		var confirm_msg_to_start_control_node_val = "${confirm_msg_to_start_control_node_key}";
		var confirm_msg_to_stop_control_node_val = "${confirm_msg_to_stop_control_node_key}";
		var engine_service_stop_val = "${engine_service_stop_key}";
		var engine_service_start_val = "${engine_service_start_key}";
		var message_id_val = "${message_id_key}";
		var request_id_val = "${request_id_key}";
		var view_detail_val = "${view_detail_key}";
		var running_val = "${running_key}";
		var breaking_val = "${breaking_key}";
		var stopped_val = "${stopped_key}";
		var unable_to_get_status_val = "${unable_to_get_status_key}";
		var start_val = "${start_key}";
		var stop_val = "${stop_key}";
		var monitor_expend_val = "${monitor_expend_key}";
		var response_status_start_val = "${AlertConstant.RESPONSE_STATUS_START}"
		var response_status_stop_val = "${AlertConstant.RESPONSE_STATUS_STOP}"
	</script>

	<table border='0' width='99%' id="main-content">
		<tr>
			<td>
				<div id="control_${_pageRef}" title="<ps:text name="RA_CTRL"/>"
					style="margin-bottom: 5px;">
					<psjg:grid id="engineNodeGrid_Id_${_pageRef}" caption=" "
						href="%{engineNodeGrid_url}" dataType="json" loadonce="false"
						hiddengrid="false" pager="false" sortable="false" filter="false"
						gridModel="gridModel" rowNum="5" rowList="5,10,15,20"
						viewrecords="true" navigator="true" navigatorDelete="false"
						navigatorEdit="false" navigatorRefresh="false"
						navigatorAdd="false" navigatorSearch="false"
						navigatorSearchOptions="" altRows="false" shrinkToFit="true"
						autowidth="fasle" height="80" sortorder="" sortname=""
						onCompleteTopics="onCompleteGrid">

						<psjg:gridColumn id="Engine_IP_${_pageRef}" colType="text"
							name="IP" index="IP" title="%{getText('ip_key')}"
							sortable="false" />

						<psjg:gridColumn id="Engine_STATUS_${_pageRef}" colType="custom"
							name="Engine_STATUS" index="STATUS"
							title="%{getText('Status_key')}" align="center" sortable="false"
							formatter="engineControl_running_inactive_textFromatter" />

						<psjg:gridColumn id="Engine_ACTION_${_pageRef}" colType="custom"
							name="Engine_ACTION" index="ACTION"
							title="%{getText('reporting.action')}" align="center"
							sortable="false"
							formatter="engineControl_start_stop_buttonFromatter" />

						<psjg:gridColumn id="Engine_STATUS_Code_${_pageRef}"
							colType="text" name="statusDesc" index="statusDesc"
							title="%{getText('status_code_key')}" hidden="true" />

					</psjg:grid>
				</div>
			</td>
		</tr>
		<tr>
			<td><div id="monitor_${_pageRef}"
					title="<ps:text name="Monitoring_key"/>"
					style="margin-bottom: 0px; margin-top: 0px;">

					<table border="0" style="margin-bottom: 0px;">
						<tr>
							<td width="80px"></td>
							<td width="135px"></td>
							<td width="70px"></td>
							<td width="135px"></td>
							<td width="65px"></td>
							<td width="135px"></td>
							<td width="65px"></td>
							<td width="135px"></td>
							<td width="65px"></td>

						</tr>
						<tr height="25px">
							<td style='padding-left: 5px'><ps:label key="RA_FR_DATE"
									id="lbl_start_time_id_${_pageRef}"
									for="engineControl_start_date_${_pageRef}" /></td>
							<td><psj:datepicker
									id="engineControl_start_date_${_pageRef}"
									name="engineControlCO.startDate"
									timepickerTimeOnlyTitle="false" timepickerOnly="false"
									timepicker="true" timepickerShowSecond="true"
									timepickerFormat="hh:mm:ss" buttonImageOnly="true" firstDay="1"
									timepickerShowHour="true" tabindex="2"
									timepickerMinuteText="true" timepickerTimeText="true"
									timepickerShowMinute="true" timepickerHourText="true"
									timepickerSecondText="true" required="false" readonly="false"
									disabled=""
									parameter="engineControlCO.startDate:engineControl_start_date_${_pageRef}
										,engineControlCO.endDate:engineControl_end_date_${_pageRef}"
									dependency="engineControl_start_date_${_pageRef}:engineControlCO.startDate"
									dependencySrc="${pageContext.request.contextPath}/path/alert/enginecontrol/EngineControlMaintAction_returnDependencyByStartTime" /></td>
							<td style='padding-left: 5px' ><ps:label key="RA_TO_DATE"
									id="lbl_alert_end_date_id_${_pageRef}"
									for="engineControl_end_date_${_pageRef}" /></td>
							<td><psj:datepicker id="engineControl_end_date_${_pageRef}"
									name="engineControlCO.endDate" timepickerTimeOnlyTitle="false"
									timepickerOnly="false" timepicker="true"
									timepickerShowSecond="true" timepickerFormat="hh:mm:ss"
									buttonImageOnly="true" firstDay="1" timepickerShowHour="true"
									tabindex="3" timepickerMinuteText="true"
									timepickerTimeText="true" timepickerShowMinute="true"
									timepickerHourText="true" timepickerSecondText="true"
									required="false" readonly="false" disabled=""
									parameter="engineControlCO.startDate:engineControl_start_date_${_pageRef}
										,engineControlCO.endDate:engineControl_end_date_${_pageRef}"
									dependency="engineControl_end_date_${_pageRef}:engineControlCO.endDate"
									dependencySrc="${pageContext.request.contextPath}/path/alert/enginecontrol/EngineControlMaintAction_returnDependencyByStartTime" /></td>
							
						   <td style='padding-left: 5px'><ps:label key="event_id_key"
									id="lbl_event_id_${_pageRef}"
									for="lookuptxt_event_id_${_pageRef}" /></td>
							<td><psj:livesearch id="event_id_${_pageRef}"
									name="engineControlCO.eventID" mode="number" maxlength="16"
									leadZeros="8" tabindex="4" minValue="0"
									resultList="EVT_ID:lookuptxt_event_id_${_pageRef}"
									actionName="${pageContext.request.contextPath}/path/alert/controlrecord/systemEvtLookupAction_constructSysEvtLookup"
									paramList="criteria.eventType:all" dependencySrc=""
									dependency="" parameter="" searchElement="">
								</psj:livesearch></td>
							<ps:set name="isOmniInstal_${_pageRef}"    value="engineControlCO.omniAdminInstalledYN"/>
							<ps:if test='%{#isOmniInstal_${_pageRef} == "N"}'>
							
								<td style='padding-left: 5px'><ps:label key="cif_number_key"
									id="lbl_cifNumber_${_pageRef}"
									for="lookuptxt_cifNumber_${_pageRef}" /></td>
								<td><psj:livesearch id="cifNumber_${_pageRef}"
									name="individualSubscriberCO.alrtSubVO.CIF_NO" mode="number"
									maxlength="8" leadZeros="8" tabindex="5" minValue="0"
									resultList="cifVO.CIF_NO:lookuptxt_cifNumber_${_pageRef}"
									actionName="${pageContext.request.contextPath}/path/alert/subscriber/individual/IndividualSubscriberCIFLookupAction_constructCifQueryLookup"
									parameter="cif:lookuptxt_cifNumber_${_pageRef},
												individualSubscriberCO.alrtSubVO.CIF_NO:lookuptxt_cifNumber_${_pageRef},
												pageRef:'EC00P'"
									dependencySrc="${pageContext.request.contextPath}/path/alert/subscriber/individual/IndividualSubscriberDepAction_dependencyByCifNumber"
									dependency="lookuptxt_cifNumber_${_pageRef}:individualSubscriberCO.alrtSubVO.CIF_NO"
									searchElement="CIF_NO"  >
								</psj:livesearch></td>
							</ps:if>
							<td></td>
						</tr>

						<tr height="25px">
							<td style='padding-left: 5px'><ps:label key="sub_id_key" id="lbl_sub_id_${_pageRef}"
									for="lookuptxt_sub_id_${_pageRef}" /></td>
							<td><psj:livesearch id="sub_id_${_pageRef}" 
								    name="engineControlCO.subId" mode="number"
								    tabindex="6"
									resultList="alertSubVo.ID:lookuptxt_sub_id_${_pageRef}"
									actionName="${pageContext.request.contextPath}/path/alert/enginecontrol/alertSubscriberLookupAction_constructSubIdLookup"
									searchElement="SUB_ID">
								</psj:livesearch></td>

							<td style='padding-left: 5px'><ps:label key="user_id_key"
									id="lbl_user_id_${_pageRef}"
									for="lookuptxt_user_id_${_pageRef}" /></td>
							<td><psj:livesearch id="user_id_${_pageRef}" 
									name="engineControlCO.userId" mode="text"
									tabindex="7"
									resultList="alertSubVo.USR_ID:lookuptxt_user_id_${_pageRef}"
									actionName="${pageContext.request.contextPath}/path/alert/enginecontrol/alertUserLookupAction_constructUserLookup"
									searchElement="USR_ID">
								</psj:livesearch></td>

							<td style='padding-left: 5px'><ps:label key="channel_end_user_key"
									id="lbl_channel_end_user_id_${_pageRef}"
									for="lookuptxt_channel_end_user_id_${_pageRef}" /></td>
							<td><psj:livesearch id="channel_end_user_id_${_pageRef}" 
									name="engineControlCO.channelEndUserId" mode="text"
									tabindex="8"
									resultList="alertSubVo.CHANNEL_END_USR_ID:lookuptxt_channel_end_user_id_${_pageRef}"
									actionName="${pageContext.request.contextPath}/path/alert/enginecontrol/channelEndUserIdLookupAction_constructChannelEndUserIdLookup"
									searchElement="CHANNEL_END_USER_ID">
								</psj:livesearch></td>
							
							<td style='padding-left: 5px'><ps:label key="status_key"
									id="lbl_status_id_${_pageRef}"
									for="lookuptxt_event_status_${_pageRef}" /></td>
							<td><ps:select id="message_status_${_pageRef}"
									 name="engineControlCO.STATUS"
									tabindex="9" list="messageStatusList" listKey="code"
									listValue="descValue">
								</ps:select></td>
							
							
							<td align="right"><psj:submit
									id="engine_control_load_main_record_Btn_${_pageRef}"
									button="true" onclick="engineControl_onClickedRetrieveData()"
									type="button" tabindex="10" freezeOnSubmit="true">
									<ps:label for="CtrlRecUpdateBtn_${_pageRef}" key="Retrieve_key" />
								</psj:submit>
							</td>
						</tr>
					</table>

					<psjg:grid id="alertEngineRequestGrid_Id_${_pageRef}" href=""
						dataType="json" caption="Request Data" loadonce="false"
						tabindex="11" hiddengrid="false" pager="true" sortable="false"
						filter="false" gridModel="gridModel" rowNum="10"
						rowList="10,15,20" viewrecords="true" navigator="true"
						navigatorDelete="false" navigatorEdit="false"
						navigatorRefresh="false" navigatorAdd="false"
						navigatorSearch="false" navigatorSearchOptions="" altRows="true"
						shrinkToFit="true" autowidth="true" height="220" sortorder=""
						sortname="" onCompleteTopics="onCompleteGrid">

						<psjg:gridColumn id="Request_ID_${_pageRef}" colType="number"
							name="alertEngineRequestVO.REQUEST_ID"
							index="alertEngineRequestVO.REQUEST_ID" width="5"
							title="%{getText('request_id_key')}" sortable="false" />

						<psjg:gridColumn id="Event_ID_${_pageRef}" colType="number"
							name="alertEngineRequestVO.EVENT_ID"
							index="alertEngineRequestVO.EVENT_ID" width="5"
							title="%{getText('event_id_key')}" sortable="false" />


						<psjg:gridColumn id="MSG_ID_${_pageRef}" colType="number"
							name="alertEngineMessageVO.MSG_ID"
							index="alertEngineMessageVO.MSG_ID" width="5"
							title="%{getText('message_id_key')}" sortable="false" />

						<psjg:gridColumn id="CIF_NO_${_pageRef}" colType="number"
							name="alertEngineMessageVO.CIF_NO"
							index="alertEngineMessageVO.CIF_NO" width="5"
							title="%{getText('cif_number_key')}" sortable="false" hidden='%{#isOmniInstal_${_pageRef} == "Y"}' />

						<psjg:gridColumn id="SUB_NO_${_pageRef}" colType="number"
							name="subId" index="subId" width="5"
							title="%{getText('sub_id_key')}" sortable="false" />

						<psjg:gridColumn id="USER_ID_${_pageRef}" colType="text"
							name="userId" index="userId" width="5"
							title="%{getText('user_id_key')}" sortable="false" />

						<psjg:gridColumn id="CAHNNEL_END_USER_ID_${_pageRef}" colType="text"
							name="channelEndUserId" index="channelEndUserId" width="5"
							title="%{getText('channel_end_user_key')}" sortable="false" />


						<psjg:gridColumn id="Received_Time_${_pageRef}" colType="date"
							formatoptions="{srcformat:'Y-m-d H:i:s.u',newformat:'d/m/Y h:i.s A'}"
							name="alertEngineRequestVO.RECEIVED_TIME"
							index="alertEngineRequestVO.RECEIVED_TIME" width="10"
							title="%{getText('received_time_key')}" sortable="false" />

						<psjg:gridColumn id="Starting_Time_${_pageRef}" colType="date"
							formatoptions="{srcformat:'Y-m-d H:i:s.u',newformat:'d/m/Y h:i.s A'}"
							name="alertEngineRequestVO.STARTING_TIME"
							index="alertEngineRequestVO.STARTING_TIME" width="10"
							title="%{getText('start_time_key')}" sortable="false" />

						<psjg:gridColumn id="Ending_Time_${_pageRef}" colType="date"
							formatoptions="{srcformat:'Y-m-d H:i:s.u',newformat:'d/m/Y h:i.s A'}"
							name="alertEngineRequestVO.ENDING_TIME"
							index="alertEngineRequestVO.ENDING_TIME" width="10"
							title="%{getText('End_Time_Key')}" sortable="false" />

						<psjg:gridColumn id="Status_Desc_${_pageRef}" colType="text"
							name="statusDesc" index="statusDesc" width="7"
							title="%{getText('Status_key')}" align="center" sortable="false" />

						<psjg:gridColumn id="Output_Message_${_pageRef}" colType="text"
							name="alertEngineRequestVO.OUTPUT_MSG"
							index="alertEngineRequestVO.OUTPUT_MSG" width="15"
							title="%{getText('output_message_key')}"
							formatter="engineRequest_output_buttonFromatter" sortable="false" />

						<psjg:gridColumn id="EngineRequest_ACTION_${_pageRef}"
							colType="custom" name="EngineRequest_ACTION" index="" width="5"
							title="%{getText('reporting.action')}" align="center"
							formatter="engineRequest_action_buttonFromatter" sortable="false" />

						<psjg:gridColumn id="Status_Code_${_pageRef}" colType="text"
							name="alertEngineRequestVO.STATUS"
							index="alertEngineRequestVO.STATUS" width="7"
							title="%{getText('status_code_key')}" sortable="false"
							hidden="true" />
					</psjg:grid>

				</div></td>
		</tr>
	</table>



	<script type="text/javascript">
		$(function() {
			$("#control_" + _pageRef).collapsiblePanel();
			$("#monitor_" + _pageRef).collapsiblePanel();

			$("#gview_engineNodeGrid_Id_${_pageRef} div.ui-jqgrid-titlebar")
					.hide();
			$(
					"#gview_alertEngineRequestGrid_Id_${_pageRef} div.ui-jqgrid-titlebar")
					.hide();

			$("#monitor_" + _pageRef + " .collapsibleContainerTitle").bind(
					'click', monitor_expend_load_default_grid);
			engineControl_onClickedRetrieveData();
		});

		$("#alertEngineRequestGrid_Id_" + _pageRef).subscribe("onCompleteGrid",
				function(rowObj) {
					alert_engine_grid_loaded();
				});
		$("#engineNodeGrid_Id_" + _pageRef).subscribe("onCompleteGrid",
				function(rowObj) {
					alert_engine_node_loaded();
				});
	</script>
</div>