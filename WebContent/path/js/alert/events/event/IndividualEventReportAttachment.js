/**
 * Add report Attachment row
 * @param commuincationType
 * @returns
 */
function individualEventReport_addReportAttachmentsField(commuincationType)
{
	var oldReportAttachmentCount =  parseInt($("#eventStatic"+commuincationType+"ReportAttachmentCount_"+_pageRef).val());
	var newReportAttachmentCount = parseInt(oldReportAttachmentCount)+1;
	
	var params ={};
	params["_pageRef"] = _pageRef;
	if(commuincationType == "Email")
	{
		params["individualEventCO.emailEventStaticReportAttachCount"] = newReportAttachmentCount;
	}
	else if(commuincationType == "OmniInbox")
	{
		params["individualEventCO.omniInboxEventStaticReportAttachCount"] = newReportAttachmentCount;
	}
	
	params["individualEventSC.commType"] = commuincationType;
	var actionSrc = jQuery.contextPath+ "/path/alert/events/event/IndividualEventMaintAction_returnReportAttachmentRow";
	_showProgressBar(true);
	$.post(actionSrc, params, function(param)
	{
		_showProgressBar(false);
		
		//retrieve last report attachment tr id for inserting new row
		var reportAttachRowsId = $('[id^=indEventReportAttachmentRow'+commuincationType+_pageRef+']');
		var rowCount = 0;
		var rowId = reportAttachRowsId[reportAttachRowsId.length-1].id;
		
		//retrieve last report attachment lookup id
		var reportAttachlookupIds = $('[id^=lookuptxt_event'+commuincationType+'StaticReportAttachmentId]');
		var reportAttachlookupId = reportAttachlookupIds[reportAttachlookupIds.length-1].id;
		
		var previousReportAttachmentId = $("#"+reportAttachlookupId).val();
		if(previousReportAttachmentId == "" || previousReportAttachmentId == undefined)
		{
			_showErrorMsg(fill_empty_report_attachment_key, error_msg_title, 300,100);
		}
		else
		{
			$("#"+rowId).after(param);
			$("#eventStatic"+commuincationType+"ReportAttachmentCount_"+_pageRef).val(newReportAttachmentCount);
		}
	});
}

/**
 * remove Report Attachment Row
 * @param communicationType
 * @param newReportAttachmentCount
 * @returns
 */
function individualEventReport_removeReportAttachmentsField(communicationType, id,  newReportAttachmentCount)
{
	//set removed Report Attachment Ids in hidden Fields
	var eventId = $("#eventId_"+_pageRef).val();
	if(eventId != "" && eventId != undefined)
	{
		var selectedReportAttachmentId = $("#lookuptxt_event"+communicationType+"StaticReportAttachmentId_"+newReportAttachmentCount+"_"+_pageRef).val();
		var ids = $("#eventStatic"+communicationType+"RemovedReportAttachmentIds_"+_pageRef).val();
		if(ids == "")
		{
			$("#eventStatic"+communicationType+"RemovedReportAttachmentIds_"+_pageRef).val(selectedReportAttachmentId);
		}
		else
		{
			$("#eventStatic"+communicationType+"RemovedReportAttachmentIds_"+_pageRef).val(ids+","+selectedReportAttachmentId);
		}
	}
	
	//Remove Row
	$(id).closest ('tr').remove ();
	
	//change form
	individualEventReport_changeForm();
}

/**
 * open Report Dialog
 * @param communicationType
 * @returns
 */
function individualEventReport_openReportAttachmentDialog(communicationType,selectedRow)
{
	var eventReportId = eventReportId = $("#lookuptxt_event"+communicationType+"StaticReportAttachmentId_"+selectedRow+"_"+_pageRef).val();
	if(eventReportId != undefined && eventReportId != "")
	{
		var eventId = $("#eventId_"+_pageRef).val();
		if(eventId != "" && eventId != undefined)
		{
			//return attached report mapping parameters
			individualEventMaint_returnAttachReportMappingArguments(communicationType, eventId, selectedRow);
		}
		individualEventMaint_openReportAttachmentParameterDialog(communicationType, selectedRow);
	}
	else
	{
		_showErrorMsg(select_report_key, error_msg_title, 300,100);
	}
}

/**
 * Open Report Attachment Mapping Arguments dialog
 * @param communicationType
 * @param selectedRow
 * @returns
 */
function individualEventReport_openReportAttachmentParameterDialog(communicationType, selectedRow)
{
	var reportAttachId = $("#lookuptxt_event"+communicationType+"StaticReportAttachmentId_"+selectedRow+"_"+_pageRef).val();
	if(reportAttachId == undefined || reportAttachId == "")
	{
		_showErrorMsg(select_report_key, error_msg_title, 300,100);
		return;
	}
	var eventId = $("#eventId_"+_pageRef).val();
	var reportAttachStatus = $("#statusRA"+communicationType+"HiddenId_"+selectedRow+"_"+_pageRef).val();
	var	openEventFilterPopup = $("<div id='open"+communicationType+"ParameterPopup_"+_pageRef+"' class='path-common-sceen'></div>");
	openEventFilterPopup.css("padding","0");
	openEventFilterPopup.insertAfter($('body'));
	var _dialogOptions = {
		modal:true, 
		title:"Report Attachment Parameters",
	    autoOpen:false,
	    show:'slide',
	    width:returnMaxWidth(600),
	    height:returnMaxHeight(285),
	    position:'center', 
	    closeOnEscape: true,
	    //to hide the x button in the dialogue
	    open: function(event, ui) {
	  	   $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
	    },
	    buttons: {
		       OK:function()
		    {
		    	   var theDialog = $(this);
		    	   individualEventReport_okReportAttachmentParameterDialog(theDialog, communicationType,selectedRow)	 
			},
			Cancel: function()
			{
				var theDialog = $(this);
				individualEventReport_cancelReportAttachmentParameterDialog(theDialog);
			}
	    },
	    position:'center', 
	};
	var ivCrud = $("#iv_crud_" + _pageRef).val();

	mySrc = jQuery.contextPath+ "/path/alert/events/event/IndividualEventMaintAction_returnIndividualEventQueryParamDialog.action?_pageRef="+_pageRef+"&iv_crud="+ivCrud;
	$('#open'+communicationType+'ParameterPopup_' + _pageRef).load(mySrc, {
	}, function() {
		
		if(eventId != "" && eventId != undefined && reportAttachStatus == "O")
		{
			individualEventMaint_returnReportQueryMappingArguments(communicationType, eventId, selectedRow, 'RA');
		}
		else
		{
			individualEvents_loadParmaterGrid(communicationType, "", "RAD", selectedRow);
		}
	//	individualEvents_loadParmaterGrid(communicationType, "", "RAD", selectedRow);
		
	});
	$('#open'+communicationType+'ParameterPopup_' +_pageRef).dialog(_dialogOptions);
	$('#open'+communicationType+'ParameterPopup_' + _pageRef).dialog('open');
}

/**
 * while click ok button of Report Attachment parameter dialog
 * @param dialogId
 * @param communicationType
 * @param templateType
 * @returns
 */
function individualEventReport_okReportAttachmentParameterDialog(dialogId, communicationType, selectedRow)
{
	var rows = $("#eventArgumentGridId_"+_pageRef).jqGrid('getAllRows');
	
	$("#eventStatic"+communicationType+"ReportAttachmentArgumentsHiddenId_"+selectedRow+"_"+_pageRef).val(rows);
	$("#statusRA"+communicationType+"HiddenId_"+selectedRow+"_"+_pageRef).val("N");
	//change form
	individualEventReport_changeForm();
	dialogId.dialog("destroy");
	dialogId.remove();
}

/**
 * while click cancel button of Report Attachment parameter dialog
 * @param dialogId
 * @returns
 */
function individualEventReport_cancelReportAttachmentParameterDialog(dialogId)
{
	dialogId.dialog("destroy");
	dialogId.remove();
}

/**
 * validate Report Attachment to check select Unique reports
 * @param communicationType
 * @param selectedRow
 * @returns
 */
function individualEventReport_validateReportAttachments(fromReport , communicationType,selectedRow)
{
	var reportAttachmentCount = $("#eventStatic"+communicationType+"ReportAttachmentCount_"+_pageRef).val();
	var reportId = $("#lookuptxt_eventDynamic"+communicationType+"ReportId_"+_pageRef).val();
	var selectedReportAttachmentId = "";
	
	//validate report attachment id with report body 
	if(fromReport == "ReportAttach")
	{
		selectedReportAttachmentId = $("#lookuptxt_event"+communicationType+"StaticReportAttachmentId_"+selectedRow+"_"+_pageRef).val();
		if(reportId != "" && reportId == selectedReportAttachmentId)
		{
			$("#lookuptxt_event"+communicationType+"StaticReportAttachmentId_"+(selectedRow)+"_"+_pageRef).val("");
			$("#event"+communicationType+"StaticReportAttachmentBriefDescEng_"+(selectedRow)+"_"+_pageRef).val("");
			$("#eventStatic"+communicationType+"ReportAttachmentArgumentsHiddenId_"+(selectedRow)+"_"+_pageRef).val("");
			_showErrorMsg(duplicate_entry_report_key, error_msg_title, 300,100);
			return;
		}
	}
	
	//validate report attachments and its self as well as body report id
	if(reportAttachmentCount != undefined && reportAttachmentCount >= 1)
	{
		for(var i=1; i<=reportAttachmentCount; i++)
		{
			var previousReportAttachmentId = $("#lookuptxt_event"+communicationType+"StaticReportAttachmentId_"+(i)+"_"+_pageRef).val();
			//validate report attachments and its self
			if(reportAttachmentCount > 1 && fromReport == "ReportAttach") 
			{
				if(selectedRow != i)
				{
					if(previousReportAttachmentId != undefined && previousReportAttachmentId == selectedReportAttachmentId)
					{
						$("#lookuptxt_event"+communicationType+"StaticReportAttachmentId_"+(selectedRow)+"_"+_pageRef).val("");
						$("#event"+communicationType+"StaticReportAttachmentBriefDescEng_"+(selectedRow)+"_"+_pageRef).val("");
						$("#eventStatic"+communicationType+"ReportAttachmentArgumentsHiddenId_"+(selectedRow)+"_"+_pageRef).val("");
						_showErrorMsg(duplicate_entry_report_key, error_msg_title, 300,100);
						break;
					}
				}
			}
			//validate body report id with report attachment
			else if(reportId != "" && reportId != undefined && fromReport == "Report") 
			{
				if(reportId == previousReportAttachmentId)
				{
					$("#lookuptxt_eventDynamic"+communicationType+"ReportId_"+_pageRef).val("");
					$("#eventDynamic"+communicationType+"ReportBriefDescEng_"+_pageRef).val("");
					$("#eventStatic"+communicationType+"ArgumentsHiddenId_"+_pageRef).val("");
					_showErrorMsg(duplicate_entry_report_key, error_msg_title, 300,100);
					break;
				}
			}
			
		}
	}
}

/**
 * 
 * @returns
 */
function individualEventReport_changeForm()
{
	var theform = document.getElementById("individualEventMainFormId_"+ _pageRef);
	$.data(theform, 'changeTrack', true);
}
