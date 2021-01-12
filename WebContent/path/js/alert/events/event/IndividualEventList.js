
/**
 * dbclick the record of grid and set data in form
 * @returns
 */
function individualEventList_onDbClickedEvent() 
{
	if(_pageRef == "EVT01MT")
	{
		 var changed = $("#individualEventMainFormId_" + _pageRef).hasChanges();
		 if (changed == 'true' || changed == true)
		 {
			 _showConfirmMsg(changes_made_confirm_msg, "","individualEventList_loadIndEventDataInForm", "yesNo", '', '', 300, 100);
		 }
		 else
		 {
			 individualEventList_loadIndEventDataInForm(true);
		 }
	}
	else{
		individualEventList_loadIndEventDataInForm(true);
	}
}

/**
 * load Data in form after dbclick on the record of grid
 * @param conform
 * @returns
 */
function individualEventList_loadIndEventDataInForm(conform)
{
	if(conform)
	{
		var $table = $("#individualEventGridTbl_Id_" + _pageRef);
		var selectedRowId = $table.jqGrid('getGridParam', 'selrow');
		var myObject = $table.jqGrid('getRowData', selectedRowId);
		var evtID = myObject["EVT_ID"];
		var ivCrud = $("#iv_crud_" + _pageRef).val();
		var params = {};
		params["individualEventSC.eventID"] = evtID;
		params["individualEventSC.ivCrud"] = ivCrud;
		params["iv_crud"] = ivCrud;
		params["_pageRef"] = _pageRef;
		var actionSrc = jQuery.contextPath+ "/path/alert/events/event/IndividualEventMaintAction_edit";
		
		_showProgressBar(true);
		$.post(actionSrc, params, function(param)
		{
			_showProgressBar(false);
			showHideSrchGrid('individualEventGridTbl_Id_'+ _pageRef);
			$("#individualEventMaintPage_id_" + _pageRef).html(param);
			var emailActive = $("#communicationModeEmail_"+_pageRef). prop("checked");
			var smsActive = $("#communicationModeSms_"+_pageRef). prop("checked");
		   
			individualEvents_activateCommunicationMode('communicationModeEmail', 'emaildetails', 'emaildetails_Inner');
			//set Form data
			individualEventList_setFormAndHiddenData('Email', 'Static');
			
			//set Email Query Columns
			individualEvents_returnQueryColumnsByQueryId('Email');
			
			//Set Email Remaining Charchters
			individualEventMaint_setRemainingCharachter('Email', 4000);
			
			
			individualEvents_activateCommunicationMode('communicationModeSms', 'smsdetails', 'smsdetails_Inner');
			
			//set Form data
			individualEventList_setFormAndHiddenData('Sms', 'Static');
			
			//set Sms Columns
			individualEvents_returnQueryColumnsByQueryId('Sms');
			
			//set remaining charachters
			individualEventMaint_setRemainingCharachter('Sms', 4000);
			
			//show the div of omni push notification communication while the omni is activated
			individualEvents_activateCommunicationMode('communicationModeOmniInbox', 'omniInboxdetails', 'omniInboxdetails_Inner');
			
			//set Omni inbox Form data
			individualEventList_setFormAndHiddenData('OmniInbox', 'Static');
			
			//set Omni inbox Columns
			individualEvents_returnQueryColumnsByQueryId('OmniInbox');
			
			//set Omni inbox remaining charachters
			individualEventMaint_setRemainingCharachter('OmniInbox', 4000);
			
			
			//show the div of internal alert communication while the internal alert is activated
			individualEvents_activateCommunicationMode('communicationModeImalInternalAlrt', 'imalInternalAlrtdetails', 'imalInternalAlrtdetails_Inner');
			
			//batch
			showHideBatchGrid();
			var evtType = $("#eventType_" + _pageRef).val();
			if (evtType == "B")
			{
				individualEvents_returnQueryColumnsByQueryId('Batch');
			}
			if (evtType == "F")
			{
				loadFixEventform('0');
				checkVisibilityProtocolType();
			}
			
			
			var status = $("#eventStatus_"+_pageRef).val();
			
			if(_pageRef != "EVT01MT" && _pageRef != "EVT01MA")
		    {
				//disable + and - button of Email while approve/suspand, reactive screen
				individualEventList_disableComponents('Email');
				
				//disable + and - button of Omni Inbox while approve/suspand, reactive screen
				individualEventList_disableComponents('OmniInbox');
		    }
			else if(_pageRef == "EVT01MT" && status != "A")
			{
				//disable + and - button of Email while approve/suspand, reactive screen
				individualEventList_disableComponents('Email');
				
				//disable + and - button of Omni Inbox while approve/suspand, reactive screen
				individualEventList_disableComponents('OmniInbox');
			}		
		});
	}
}

/**
 * 
 * @returns
 */
function individualEventList_reportStaticSectionHideShow()
{
	var sectionVal = $('#messageBodyOptionList_'+_pageRef).val();
	if(sectionVal != undefined && sectionVal == "D")
	{
		 $("#reportOptionDiv_id_"+_pageRef).show();
		 $("#staticOptionDiv_id_"+_pageRef).hide();
	}
	else  if(sectionVal != undefined && sectionVal == "S")
	{
		 $("#staticOptionDiv_id_"+_pageRef).show();
		 $("#reportOptionDiv_id_"+_pageRef).hide();
	}
}

/**
 * 
 * @param componentId
 * @param templateType
 * @returns
 */
function individualEventList_setFormAndHiddenData(componentId, templateType)
{
	
	var defaultMessageSubject =  $("#event"+templateType+componentId+"MessageDefaultSubjectHiddenId_"+_pageRef).val();
	var defaultMessageBody =  $("#event"+templateType+componentId+"MessageDefaultBodyHiddenId_"+_pageRef).val();
	
	if(defaultMessageSubject != undefined && defaultMessageSubject != "")
	{
		$("#event"+templateType+componentId+"MessageSubjectEng_"+_pageRef).val(defaultMessageSubject);
	}
	
	if(defaultMessageBody != undefined && defaultMessageBody != "")
	{
		$("#event"+templateType+componentId+"MessageBodyEng_"+_pageRef).val(defaultMessageBody);
	}
}


/**
 * New Button Clicked
 * @returns
 */
function individualEventList_NewClicked()
{
	individualEventMaint_clearForm();
	$("#individualSubscriberGridTbl_Id_" + _pageRef).trigger("reloadGrid");
}

function individualEventList_disableComponents(communicationType)
{
	
	var removeButtonReportAttach = $('[id^=Remove'+communicationType+'ReportAttachment_'+_pageRef+']');
	var addButtonReportAttach = $('[id^=add'+communicationType+'ReportAttachment_'+_pageRef+']');
	
	/**
	 * disable - buttons of report Attachments
	 */
	for(var i=0; i<removeButtonReportAttach.length; i++)
	{
		var rowId = removeButtonReportAttach[i].id;
		$("#"+rowId).addClass('disable-link');
	}
	
	/**
	 * disable + buttons of report Attachments
	 */
	for(var i=0; i<addButtonReportAttach.length; i++)
	{
		var rowId = addButtonReportAttach[i].id;
		$("#"+rowId).addClass('disable-link');
	}
	
	
}

/**
 * Set Layout
 * @param id
 * @returns
 */
function indEvent_setLayout(id)
{
	 $("#gbox_"+id+"_"+_pageRef).removeAttr("style");
	 //$(".ui-jqgrid-btable").removeAttr("style");
	 $("#"+id+"_"+_pageRef+"_pager").removeAttr("style");
	 $("#gview_"+id+"_"+_pageRef).find('.ui-jqgrid-hdiv').removeAttr("style");
	 $("#gview_"+id+"_"+_pageRef).removeAttr("style");
	 $("#gview_"+id+"_"+_pageRef).find('.ui-jqgrid-bdiv').css('width', '');
}