/**
 * function to format running or inactive text foreground of Alert Engine node
 * 
 */
function engineControl_running_inactive_textFromatter(cellValue, options,
		rowObject)
{
	var status = '';
	switch (rowObject["STATUS"])
	{
		case 'R':
			status = running_val;
			break;
		case 'B':
			status = breaking_val;
			break;
		case 'S':
			status = stopped_val;
			break;
		case 'U':
			status = unable_to_get_status_val;
			break;
		default:
			status = rowObject["STATUS"];
			break;
	}
	return status;

}
/**
 * function to build Start Stop button of Alert Engine node
 * 
 */
function engineControl_start_stop_buttonFromatter(cellValue, options, rowObject)
{
	var value = '';
	switch (rowObject["STATUS"])
	{
		case 'S':
			value = '<button type="button" style="width:100px; background-color: #5cb85c; color: black;" onclick = "javascript:engine_confirmToStartStop(\''
					+ rowObject["IP"]
					+ '\',\''
					+ rowObject["STATUS"]
					+ '\');">' + start_val + '</button>';
			break;
		case 'R':
			value = '<button type="button" style="width:100px; background-color: #d9534f; color: white;" onclick = "javascript:engine_confirmToStartStop(\''
					+ rowObject["IP"]
					+ '\',\''
					+ rowObject["STATUS"]
					+ '\');">' + stop_val + '</button>';
			break;
		case 'B':
			value = "<div style='color: #777;'>-</div>";
			break;
		case 'U':
			value = "<div style='color: #777;'>-</div>";
			break;
		default:
			value = '<button type="button" style="width:100px;" disabled >'
					+ rowObject["STATUS"] + '</button>';
			break;
	}
	return value;

}

/**
 * function to make View Detail link, this link is use to open report in pop-up
 * window
 */
function engineRequest_action_buttonFromatter(cellValue, options, rowObject)
{
	return '<a href="#" style="text-decoration: underline;" onclick="javascript:engineRequest_showDetailReport(\''
			+ rowObject["alertEngineRequestVO"].REQUEST_ID
			+ '\',\''
			+ rowObject["alertEngineRequestVO"].EVENT_ID
			+ '\',\''
			+ rowObject["alertEngineMessageVO"].CIF_NO
			+ '\',\''
			+ rowObject["alertEngineMessageVO"].MSG_ID
			+ '\',\''
			+ rowObject["alertEngineRequestVO"].STATUS
			+ '\');" >'
			+ view_detail_val + '</a>';

}

/**
 * function to open 'Message Detail Report' in pop-up window
 * 
 */
function engineRequest_showDetailReport(request_id, event_id, cif_no, msg_id,
		status)
{

	var progRef = 'MD001';

	// prepare params
	// param sequence in report 1) request id, 2) message_id, 3) cif_number, 4)
	// event_id, 5) status
	var params = [];
	params.push(encodeURIComponent(request_id));
	params.push(encodeURIComponent(msg_id));
	params.push(encodeURIComponent(cif_no));
	params.push(encodeURIComponent(event_id));
	params.push(encodeURIComponent(status));

	// open report
	openPreviewAdvice(progRef, params.join('~#~'), 0, function()
	{
		// download report
		// openAdviceReportWithRef( progRef, params.join('~#~') );
	});

}

/**
 * function to make View Detail link, this link is use to open output message in
 * pop-up window in case of failure message
 */
function engineRequest_output_buttonFromatter(cellValue, options, rowObject)
{
	// Check "cellValue" should not be null or undefined
	var linkValue = '';
	if (typeof cellValue != "undefined")
	{
		// remove single and double quote, this cause the issue to pass
		// parameter to function
		linkValue = cellValue.replace(/'/g, '');
		linkValue = linkValue.replace(/"/g, '');
	}
	else
	{
		// set empty value in case of null or undefined, this variable value
		// show into grid
		cellValue = '';
	}
	switch (rowObject["alertEngineRequestVO"].STATUS)
	{
		// in case when message 'Fail' or 'Skiped'
		case 'F':
		case 'X':
			// make sure that pop-up window should have text message
			// ,don't show pop-up window with empty text
			// this case occur when OUTPUT_MSG column in null or empty
			if (linkValue != '')
			{
				return '<a href="#" style="text-decoration: underline;" onclick="javascript:engineRequest_showOutputMessage(\''
						+ rowObject["alertEngineRequestVO"].REQUEST_ID
						+ '\',\''
						+ rowObject["alertEngineMessageVO"].MSG_ID
						+ '\',\''
						+ options.rowId
						+ '\');" >'
						+ view_detail_val
						+ '</a>'
						+'<p style="display:none" id="error_message_' + options.rowId +'">'+ linkValue+'</p>';
						 
			}
			else
			{
				return '';
			}
			break;

		default:
			return cellValue;
			break;
	}

}
/**
 * function to show output message details in pop-up window
 * 
 */
function engineRequest_showOutputMessage(request_id, msg_id, row_id)
{
	var msg_title = ''
	if (msg_id !== null && msg_id !== '')
	{
		msg_title = message_id_val + ' : ' + msg_id
	}
	else
	{
		msg_title = request_id_val + ' : ' + request_id
	}
	
	var error_message = $("#error_message_" + row_id).text();
	_showErrorMsg(error_message, msg_title, 600, 300);	
}

/**
 * function to confirm user action to stop or start Alert Engine node
 * 
 */
function engine_confirmToStartStop(ip, status)
{

	if (ip == null || status == null)
	{
		return;
	}

	var node_info = {
		_IP : ip,
		_STATUS : status
	}

	switch (status)
	{
		case 'R':
			_showConfirmMsg(confirm_msg_to_stop_control_node_val,
					confirm_msg_title, "engine_start_stop_confirm", node_info);
			break;
		case 'S':
			_showConfirmMsg(confirm_msg_to_start_control_node_val,
					confirm_msg_title, "engine_start_stop_confirm", node_info);
			break;
		default:
			break;
	}

}

/**
 * function to confirm user action to stop or start Alert Engine node
 * 
 */
function engine_start_stop_confirm(yesNo, node_info)
{
	if (yesNo)
	{
		engine_start_stop_node(node_info);
	}
}

/**
 * function to call Alert Engine node service to stop or stop engine
 * 
 */
function engine_start_stop_node(node_info)
{
	_showProgressBar(true);
	var url = jQuery.contextPath
			+ "/path/alert/enginecontrol/EngineControlMaintAction_startStopEngineNode";
	var params = {
		"engineControlCO.IP" : node_info._IP,
		"engineControlCO.STATUS" : node_info._STATUS
	};
	$.post(url, params, function(response)
	{
		var message = '';
		switch (response.engineControlCO.response)
		{
			case response_status_start_val:
				message = engine_service_start_val;
				break;
			case response_status_stop_val:
				message = engine_service_stop_val
				break;
			default:
				message = response.engineControlCO.response;
				break;
		}

		_showErrorMsg(message, info_msg_title, 300, 100);
		reload_engineNodeGrid();
		_showProgressBar(false);
	});
}
/**
 * function to reload Alert Engine node status grid after start or stop action
 * 
 */
function reload_engineNodeGrid()
{
	$("#engineNodeGrid_Id_" + _pageRef).trigger("reloadGrid");
}

/**
 * function to set monitor collapsible pane status, it's in collapse or expend
 * state
 * 
 */
function monitor_expend_load_default_grid()
{
	switch (monitor_expend_val)
	{
		case '0':
			engineControl_onClickedRetrieveData()
			monitor_expend_val = '1'
			break;
		case '1':
			monitor_expend_val = '0'
			break;
		default:
			monitor_expend_val = '0'
			break;
	}

}
/**
 * 
 * function to handle Retrieve click it load grid data on user's specified
 * criteria
 */
function engineControl_onClickedRetrieveData()
{
	var startDate = $("#engineControl_start_date_" + _pageRef).val();
	var endDate = $("#engineControl_end_date_" + _pageRef).val();
	var cifNumber = $("#lookuptxt_cifNumber_" + _pageRef).val();
	var eventID = $("#lookuptxt_event_id_" + _pageRef).val();
	var subId = $("#lookuptxt_sub_id_" + _pageRef).val();
	var userId = $("#lookuptxt_user_id_" + _pageRef).val();
	var channelEndUserId = $("#lookuptxt_channel_end_user_id_" + _pageRef).val();
	var message_status = $("#message_status_" + _pageRef).val();


	var params = {};
	params["engineControlCO.startDate"] = startDate;
	params["engineControlCO.endDate"] = endDate;
	params["engineControlCO.cifNumber"] = cifNumber;
	params["engineControlCO.STATUS"] = message_status;
	params["engineControlCO.eventID"] = eventID;
	params["engineControlCO.subId"] = subId;
	params["engineControlCO.userId"] = userId;
	params["engineControlCO.channelEndUserId"] = channelEndUserId;

	_showProgressBar(true);
	$("#alertEngineRequestGrid_Id_" + _pageRef)
			.jqGrid(
					'setGridParam',
					{
						url : jQuery.contextPath
								+ "/path/alert/enginecontrol/EngineControlListAction_returnAlertEngineRequestDataForGrid",
						datatype : 'json',
						postData : params,
						page : 1
					}).trigger("reloadGrid");

	_showProgressBar(false);
}

/**
 * function to format Message Status foreground
 * 
 */

function alert_engine_grid_loaded()
{
	var table = $("#alertEngineRequestGrid_Id_" + _pageRef)
	var rows = table.jqGrid('getDataIDs');
	for (var a = 0; a < rows.length; a++)
	{
		var statusCode = table.jqGrid('getCell', rows[a],
				'alertEngineRequestVO.STATUS')
		table.jqGrid('setCell', rows[a], 'statusDesc', '', {
			color : getMessageStatusColorCode(statusCode)
		});
	}
}
/**
 * function to return Message Status foreground color code
 * 
 */
function getMessageStatusColorCode(statusCode)
{
	var color = '#000'

	switch (statusCode)
	{
		case "A":
			color = '#28B463'
			break;
		case "F":
			color = '#C70039'
			break;
		case "S":
			color = '#196F3D'
			break;
		case "X":
			color = '#D35400'
			break;
		case "N":
			color = '#2E86C1'
			break;
		default:
			color = '#000';
			break;
	}

	return color;
}

/**
 * function to format Engine Node foreground
 * 
 */
function alert_engine_node_loaded()
{
	var table = $("#engineNodeGrid_Id_" + _pageRef)
	var rows = table.jqGrid('getDataIDs');

	for (var a = 0; a < rows.length; a++)
	{
		var statusCode = table.jqGrid('getCell', rows[a], 'statusDesc')
		table.jqGrid('setCell', rows[a], 'Engine_STATUS', '', {
			color : getEngineStatusColorCode(statusCode)
		});
	}
}
/**
 * function to return Engine Status foreground color code
 * 
 */
function getEngineStatusColorCode(statusCode)
{
	var color = '#black'

	switch (statusCode)
	{
		case "R":
			color = '#5cb85c';
			break;
		case "B":
			color = '#777';
			break;
		case "S":
			color = '#d9534f';
			break;
		case "U":
			color = '#777';
			break;
		default:
			color = '#black';
			break;
	}

	return color;
}
