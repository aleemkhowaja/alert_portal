/**
 * this method opens the status list
 * 
 * @return {TypeName}
 */
function individualSubscriberMaint_onStatusClick()
{
	var subID = $("#subscriberId_" + _pageRef).val();
	if (subID == "")
	{
		return;
	}
	var loadSrc = jQuery.contextPath+ "/path/alert/subscriber/individual/IndSubscriberStatusAction_search.action?+_pageRef="+ _pageRef;
	showStatus("individualSubscriberMainFormId_" + _pageRef, _pageRef, loadSrc,	{"subscriberID" : subID});
}


/**
 * insert/update Individual Subscriber
 * @returns
 */
function individualSubscriberMaint_save()
{
	var changes = $("#individualSubscriberMainFormId_" + _pageRef).hasChanges();
	if (changes == 'true' || changes == true)
	{
		parseNumbers();

		var chargeable = 0;
		var facebookSocialId = 0;
		var twitterSocialId = 0;
		var ivCrud = $("#iv_crud_" + _pageRef).val();
		var emails = "";
		var mobileNos = "";
		//check if duplicate emails
		var emailFlag  = individualSubscriberMaint_validateEmailIds();
		if(!emailFlag)
		{
			_showErrorMsg(duplicate_entry_of_email, info_msg_title, 300,100);
			return;
		}
		
		//check if duplicate mobile numbers
		var mobileNumbers = individualSubscriberMaint_validateMobileIds();
		if(!mobileNumbers)
		{
			_showErrorMsg(duplicate_entry_of_mobile, info_msg_title, 300,100);
			return;
		}
		_showProgressBar(true);
		//set all emails on hidden fields
		$("#subDetailsIndSubTab_"+_pageRef+" .accountEmails").each(function() 
		{
			if(emails == undefined || emails == "")
			{
				if($(this).val() != "" && $(this).val() != undefined)
				{
					emails = $(this).val();
				}
			} 
			else 
			{
				if($(this).val() != "" && $(this).val() != undefined)
				{
					emails = emails+"<<->>"+$(this).val();
				}
			}
		});
		
		//set all mobile on hidden fields
		$("#subDetailsIndSubTab_"+_pageRef+" .accountMobile").each(function() 
		{
			if(mobileNos == undefined || mobileNos == "")
			{
				if($(this).val() != "" && $(this).val() != undefined)
				{
					mobileNos = $(this).val();
				}
			}else 
			{
				if($(this).val() != "" && $(this).val() != undefined)
				{
					mobileNos = mobileNos+"<<->>"+$(this).val();
				}
			}
		});
		
		$("#emailIds_"+_pageRef).val(emails);
		$("#mobileNos_"+_pageRef).val(mobileNos);
		
		var eventsJsonStringUpdates  = $("#subscriptionsEvtGridTbl_Id_"+_pageRef).jqGrid('getAllRows');
		var packageJsonStringUpdates = $("#subscriptionsPckgGridTbl_Id_"+_pageRef).jqGrid('getAllRows');
		
		$("#subscriberEventsGridData_"+_pageRef).val(eventsJsonStringUpdates);
		$("#subscriberPackagesGridData_"+_pageRef).val(packageJsonStringUpdates);
		
		var formData = $("#individualSubscriberMainFormId_" + _pageRef).serializeForm();

		var url = jQuery.contextPath+'/path/alert/subscriber/individual/IndividualSubscriberMaintAction_save?iv_crud='+ ivCrud;
		$.ajax({
			url : url,
			type : "post",
			dataType : "json",
			data : formData,
				success : function(data)
				{
					if (data["_error"] == null || data["_error"] == "undefined") 
					{
						if(ivCrud == "F")
						{
							$("#individualSubscriberGridTbl_Id_" + _pageRef).trigger("reloadGrid");
							showHideSrchGrid('individualSubscriberGridTbl_Id_'+ _pageRef);
							$("#individualSubscriberMaintPage_id_" + _pageRef).html("");
						}
						else
						{
							individualSubscriberMaint_clearForm();
							$("#individualSubscriberGridTbl_Id_"+_pageRef).trigger("reloadGrid");
						}
						_showProgressBar(false);
						_showErrorMsg(record_saved_Successfully_key, info_msg_title, 300,100);
					}
					else
					{
						_showProgressBar(false);
					}
				}
				})
	}
	else
	{
		_showProgressBar(false);
		_showErrorMsg(changes_not_available_key, info_msg_title);
	}

}

/**
 * insert/update after validation
 * @param yesNo
 * @param arg
 * @returns
 */
function continueUpdateAfterValidation(yesNo, arg)
{
	if (yesNo == true)
	{
		var suspend_all_subscriptions = 0;
		if ($("#suspend_all_subscriptions_" + _pageRef).prop('checked'))
		{
			suspend_all_subscriptions = 1;
		}
		else
		{
			suspend_all_subscriptions = 0;
		}
		var ivCrud = $("#iv_crud_" + _pageRef).val();
		var actionSrc = jQuery.contextPath+ "/path/alert/subscriber/individual/IndividualSubscriberMaintAction_continueUpdateAfterValidation?iv_crud="+ ivCrud;
		$.ajax({
			url : actionSrc,
			type : "post",
			dataType : "json",
			data : arg+"&criteria.suspendAllSubscriptions=" + suspend_all_subscriptions,
			success : function(data)
			{
				if (data["_error"] == "undefined" || data["_error"] == null)
				{
					showHideSrchGrid('individualSubscriberGridTbl_Id_'+ _pageRef);
					$("#individualSubscriberMaintPage_id_"+ _pageRef).html("");
					$("#individualSubscriberGridTbl_Id_"+ _pageRef).trigger("reloadGrid");
					_showErrorMsg(record_saved_Successfully_key, success_msg_title, 300,100);
				}
				_showProgressBar(false);
			}
		});
	}
}

/**
 * clear form
 * @returns
 */
function individualSubscriberMaint_clearForm() 
{
	var reloadUrl = jQuery.contextPath + "/path/alert/subscriber/individual/IndividualSubscriberMaintAction_initializeMain.action";
	var ivCrud = returnHtmlEltValue("iv_crud_" + _pageRef);
	var reloadParams = {};
	reloadParams["iv_crud"] = ivCrud;
	reloadParams["_pageRef"] = _pageRef;

	$.post(reloadUrl, reloadParams, function(param) {
		$("#individualSubscriberMaintPage_id_" + _pageRef).html(param);
	}, "html");

}


/**
 * Delete Subscriber Records
 * @returns
 */
function individualSubscriberMaint_processDelete()
{
	_showConfirmMsg(Confirm_Delete_Process_key, info_msg_title,individualSubscriberMaint_delete, {}, '', '', 300, 100);
}
/**
 * Delete Subscriber
 * @param yesNo
 * @returns
 */
function individualSubscriberMaint_delete(yesNo)
{
	_showProgressBar(true);
	var theForm = $("#individualSubscriberMainFormId_" + _pageRef).serializeForm();
	if (yesNo == true)
	{
		var actionSrc = jQuery.contextPath+ "/path/alert/subscriber/individual/IndividualSubscriberMaintAction_deleteIndSubscriber";
		$.ajax({
			url : actionSrc,
			type : "post",
			dataType : "json",
			data : theForm,
			success : function(data)
			{
				if (data["_error"] == null)
				{
					if (typeof data["_confirm"] != "undefined" && data["_confirm"] != null)
					{
						_showErrorMsg(Record_was_Deleted_Successfully_key,'Success')
						return;
					}
					if (typeof data["_error"] == "undefined" || data["_error"] == null)
					{
						_showErrorMsg(Record_was_Deleted_Successfully_key, info_msg_title, 300,100);
						showHideSrchGrid('individualSubscriberGridTbl_Id_'+ _pageRef);
						$("#individualSubscriberMainFormId_" + _pageRef).hide();
						if ($("#individualSubscriberGridTbl_Id_"+ _pageRef).html() != null	&& $("#individualSubscriberGridTbl_Id_"+ _pageRef).html() != "")
						{
							$("#individualSubscriberGridTbl_Id_"+ _pageRef).trigger("reloadGrid");
						}
					}
				}
				_showProgressBar(false);
			}
		});
	}
	else
	{
		_showProgressBar(false);
	}
}

/**
 * Conform Approve process
 * @returns
 */
function individualSubscriberMaint_processApprove()
{
	var subID = $("#subscriberId_" + _pageRef).val();
	if (subID != null && subID != "")
	{
		_showConfirmMsg(Confirm_Approve_Process_key, info_msg_title,individualSubscriberMaint_approve, {}, '', '', 300, 100);
	}
}


/**
 * approve Subscriber
 * @param yesNo
 * @param data
 * @returns
 */
function individualSubscriberMaint_approve(yesNo, data)
{
	if (yesNo == true)
	{
		_showProgressBar(true);
		var theForm = $("#individualSubscriberMainFormId_" + _pageRef).serializeForm();
		var params = theForm;
		$.ajax({
			url : $.contextPath+ "/path/alert/subscriber/individual/IndividualSubscriberMaintAction_continueToApprove",
			type : "post",
			data : params,
			dataType : "json",
			success : function(data)
			{
				if (typeof data["_error"] == "undefined" || data["_error"] == null)
				{
					_showErrorMsg(record_was_Approved_Successfully_key, success_msg_title, 300,100);
					showHideSrchGrid('individualSubscriberGridTbl_Id_'+ _pageRef);
					$("#individualSubscriberGridTbl_Id_" + _pageRef).trigger("reloadGrid");
					$("#individualSubscriberMaintPage_id_" + _pageRef).html("");
				}
				_showProgressBar(false);
			}
		});
	}
}

function individualSubscriberMaint_openOtherLanguageDialogue() 
{
	var	openOtherLangDetailsPopup = $("<div id='openOtherLangDetailsPopup_"+_pageRef+"' class='path-common-sceen'></div>");
	openOtherLangDetailsPopup.css("padding","0");
	openOtherLangDetailsPopup.insertAfter($('body'));
	var subscriberId = $("#subscriberId_"+_pageRef).val();
	var _dialogOptions = {
		modal:true, 
		title:other_lang_dialog_title,
        autoOpen:false,
        show:'slide',
        width:returnMaxWidth(800),
        height:returnMaxHeight(350),
        position:'center', 
        closeOnEscape: true,
        //to hide the x button in the dialogue
        open: function(event, ui) {
    	   $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
        },
        buttons: [{
        	text:Ok_key,
        	click :function()
            {
                var theDialog = $(this);
                individualSubscriberMaint_OnOkLang(theDialog)	 
            }},
            {text:cancel_key,
            click :function()
            {
                var theDialog = $(this);
                individualSubscriberMaint_OnCancelLang(theDialog);
            }
        }]
    };
	
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var oldStatus = $("#individualSubStatus_"+_pageRef).val();
	
	mySrc = jQuery.contextPath+ "/path/alert/subscriber/individual/IndividualSubscriberMaintAction_returnIndividualSubscriberAllLanguageDialog.action?_pageRef="+_pageRef+"&iv_crud="+ivCrud+"&oldStatus="+oldStatus;
	$('#openOtherLangDetailsPopup_' + _pageRef).load(mySrc, {
		"criteria.subID" : subscriberId
	}, function() {
	});
	$('#openOtherLangDetailsPopup_' +_pageRef).dialog(_dialogOptions);
	$('#openOtherLangDetailsPopup_' + _pageRef).dialog('open');
}



/**
 * function call after clickin ok button of other language dialog 
 * @param theDialog
 * @returns
 */
function individualSubscriberMaint_OnOkLang(theDialog)
{
	//validate the grid
	if(!OtherLanguages_validateGrid())
	{
		return;
	}
	
	//get the data from the grid
	var rows = $("#otherSubscriberLanguagesGrid_Id_"+_pageRef).jqGrid('getChangedRowData');	
	$('#otherLanguagesJson_' + _pageRef).val(rows);
    var theform = document.getElementById("individualSubscriberMainFormId_"+_pageRef);
    $.data(theform, 'changeTrack', true);
    theDialog.dialog("destroy");
    theDialog.remove();
}

/**
 * Cancel Dialog of Other Language
 * @param theDialog
 * @returns
 */
function individualSubscriberMaint_OnCancelLang(theDialog)
{
	var jsonAllRows = $("#otherSubscriberLanguagesGrid_Id_"+_pageRef).jqGrid('getAllRows');
	var jsonStringUpdates = $("#otherSubscriberLanguagesGrid_Id_"+_pageRef).jqGrid('getChangedRowData');
	var changed;
	if(JSON.parse(jsonAllRows).root.length > 0 && $('#otherLanguagesJson_' + _pageRef).val() != "")
	{
		if(JSON.parse(jsonAllRows).root.length == JSON.parse($('#otherLanguagesJson_' + _pageRef)[0].value).root.length)
		{
			var jsonSaved = $('#otherLanguagesSavedJson_' + _pageRef).val();
			var splitOtherLang = jsonSaved.split(',');
			
			loop1:
			for (var key in JSON.parse(jsonAllRows).root)
			{
		        var attrName = key;
		        var attrValue = JSON.parse(jsonAllRows).root[key];
		        for (var key1 in attrValue)
		        {
			        var attrName1 = key1;
			        var attrValue1 = attrValue[key1];
			        loop2:
		    		for(i=1;i<splitOtherLang.length;i++)
		    		{
				        if(attrName1 == "LANG_CODE"&& attrValue1 == splitOtherLang[i].split(':')[1])
			        	{
				        	changed = "0";
				        	continue loop1;
			        	}
				        else
				        {
				        	if(i != splitOtherLang.length -1)
			        		{
				        		continue loop2;
			        		}
				        	else
			        		{
				        		if(splitOtherLang.indexOf(attrValue1) == -1)
			        			{
				        			changed = "1";
				        			break loop1;
			        			}
			        		}
				        }	
		    		}
		        }
			}
		}
		else
		{
			changed = 1;
		}
	}
	
	if(jsonStringUpdates == null || jsonStringUpdates.length == 0||changed == "0"||typeof changed == "undefined")
	{
		theDialog.dialog("destroy");
        theDialog.remove();
	}	
	else
	{
		_showConfirmMsg('Values are not saved. Do you want to proceed?', confirm_msg_title, function(
				yesNo) {
			if (!yesNo) 
			{
				return;
			}
			else
			{
				theDialog.dialog("destroy");
	            theDialog.remove();
			}
		}, "yesNo");	
	}
}

/**
 * 
 * @returns
 */
function individualSubscriberMaint_addOtherLanguageHiddenData()
{
	var localJson = $('#otherLanguagesJson_' + _pageRef); //json from hidden field
	var jsonSaved = "";
	var count = 1;
	if(typeof localJson != "undefined" && localJson.val() != "")
	{
		jQuery('#otherSubscriberLanguagesGrid_Id_' + _pageRef).jqGrid('clearGridData');
		var allRows = localJson.val();
	    var allRowsArray = JSON.parse(allRows)["root"];

	    for (var i = 0; i < allRowsArray.length; i++) 
		{
	    	obj = allRowsArray[i];
	    	$("#otherSubscriberLanguagesGrid_Id_" + _pageRef).jqGrid('addRowData', i, obj);	
	    	if(typeof obj.otherLanguagesVO =="undefined")
    		{
	    		jsonSaved = jsonSaved + "," + count+":"+ obj["LANG_CODE"];
    		}
	    	else
    		{
	    		jsonSaved = jsonSaved + "," + count+":"+ obj.LANG_CODE;
    		}
	    	count++;
		}
	    $('#otherLanguagesSavedJson_' + _pageRef).val(jsonSaved);
	}
}

/**
 * This function checks if user selects a languages which is already chosen.
 **/ 
function individualSubscriberMaint_onLanguageChange() {
	
	var Tbl = $("#otherSubscriberLanguagesGrid_Id_" + _pageRef);
	var selRow = Tbl.jqGrid("getGridParam", 'selrow');
	var selLangCode = Tbl.jqGrid('getCell', selRow, 'LANG_CODE'); // selLangCode = selected language code
	var rows = Tbl.jqGrid('getDataIDs');
	var rowsLen = rows.length;
	
	//iterate over grid rows
	for (var i = 0; i < rowsLen; i++) 
	{
		var myObject = Tbl.jqGrid('getRowData', rows[i]);
		if (rows[i] != selRow) //exclude newly created row
		{
			var rowLanCode = myObject["LANG_CODE"];
			if (rowLanCode === selLangCode) //checking selected lanaguage code with language code in  current iteration
			{
				_showErrorMsg(same_language_key, error_msg_title, 300,100);
				//For Subscription Languages Grid
				Tbl.jqGrid('setCellValue', selRow, "LANG_CODE", "-1");
				Tbl.jqGrid('setCellValue', selRow, "BRIEF_NAME", "");
				Tbl.jqGrid('setCellValue', selRow, "MIDDLE_NAME", "");
				Tbl.jqGrid('setCellValue', selRow, "LONG_NAME", "");
				Tbl.jqGrid('setCellValue', selRow, "ADDRESS", "");
				return;
			}
		}
	}
}

/**
 * add email and mobile text fields
 * @param addFieldFor
 * @returns
 */
function individualSubscriberMaint_addEmailAndMobileDynamicField(addFieldFor)
{
	var dateNeeded = (new Date()).getTime();
	var addRowId;
	if(addFieldFor == "email")
	{
		
		//validate Email
		var listEmailIds = $('[id*=subscriberEmail_'+_pageRef+']');
		//set max email fields
		if(listEmailIds.length == 5)
		{
			$("#addEmailButton_"+_pageRef).addClass('disable-link');
		}
		else if(listEmailIds.length >= 6)
		{
			$("#addEmailButton_"+_pageRef).addClass('disable-link');
			return;
		}
		
		var emailId = listEmailIds[listEmailIds.length-1].id
		if($("#"+emailId).val() == "" || typeof $("#"+emailId).val() == "undefined")
		{
			_showErrorMsg(fill_empty_email_key, error_msg_title, 300,100);
			return;
		}
		
		var emailCounter = parseInt($("#emailFieldsCount_"+_pageRef).val() == "" ? 1 : $("#emailFieldsCount_"+_pageRef).val());
		var newEmailCounter = emailCounter+1;
		$("#emailFieldsCount_"+_pageRef).val(newEmailCounter);
		var newTextField = "<tr id='lastEmailRow_"+dateNeeded+_pageRef+"'><td></td>"+
		   "<td colspan='3'>"+
			   "<div style='margin-bottom: 3px'>"+
					"<input type='text' autocomplete='off' size='70' " +
					"class='accountEmails path-theme-cust-input ui-state-focus ui-corner-all path-text-size' maxlength='250' value='' tabindex='11'" +
					" id='"+dateNeeded+"subscriberEmail_"+_pageRef+"' initialvalue='' prevvalue='' onblur='validateEmail(this)'>"+
				"</div>"+
			"</td>"+
		    "<td>"+
			"<a id='deleteEmailButton_"+dateNeeded+_pageRef+"' onclick='individualSubscriberMaint_removeEmailDynamicField("+dateNeeded+");' class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' " +
				"role='button'><span class='ui-button-text'> - </span>" +
			"</a> </td> "+
		"<tr>";
		var listEmailId = $('[id^=lastEmailRow_]');
		addRowId = listEmailId[listEmailId.length-1].id;
		
	}
	else if(addFieldFor == "mobile")
	{
		
		//validate Mobile
		
		var listMobileIds = $('[id*=tell_'+_pageRef+']');
		
		//set max mobile fields
		if(listMobileIds.length == 16)
		{
			$("#addMobileButton_"+_pageRef).addClass('disable-link');
		}
		else if(listMobileIds.length >= 17)
		{
			$("#addMobileButton_"+_pageRef).addClass('disable-link');
			return;
		}
		
		var mobileId = listMobileIds[listMobileIds.length-1].id
		
		if($("#"+mobileId).val() == "" || typeof $("#"+mobileId).val() == "undefined")
		{
			_showErrorMsg(fill_empty_mobile_no_key, error_msg_title, 300,100);
			return;
		}
		
		var mobileCounter = parseInt($("#mobileNoFieldsCount_"+_pageRef).val() == "" ? 1 : $("#mobileNoFieldsCount_"+_pageRef).val());
		var newMobileCounter = mobileCounter+1;
		$("#mobileNoFieldsCount_"+_pageRef).val(newMobileCounter);
		var newTextField = "<tr id='lastMobileRow_"+dateNeeded+_pageRef+"'><td></td>"+
		   "<td colspan='3'>"+
			   "<div style='margin-bottom: 3px'>"+
					"<input type='text' autocomplete='off' size='70' " +
					"class='accountMobile path-theme-cust-input ui-state-focus ui-corner-all path-text-size' maxlength='23' value='' tabindex='11'" +
					" id='"+dateNeeded+"tell_"+_pageRef+"' initialvalue='' prevvalue='' onblur='validateMobile(this)'>"+
				"</div>"+
			"</td>"+
		    "<td>"+
			"<a id='deleteMobileButton_"+dateNeeded+_pageRef+"' onclick='individualSubscriberMaint_removeMobileDynamicField("+dateNeeded+");' class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' " +
				"role='button'><span class='ui-button-text'> - </span>" +
			"</a> </td> "+
		"<tr>";
			
		var listMobileId = $('[id^=lastMobileRow_]');
		addRowId = listMobileId[listMobileId.length-1].id;
		
	}
	individualSubscriberMaint_addDynamicField(addRowId, newTextField)
}
/**
 * this function is used for to add dynamic row
 * @returns
 */
function individualSubscriberMaint_addDynamicField(addFieldRowId, newTextField)
{
	$("#"+addFieldRowId).after(newTextField);
	//change Form
	individualSubscriberMaint_formChanged();
}

/**
 * this function is used for to remove email dynamic row
 * @returns
 */
function individualSubscriberMaint_removeEmailDynamicField(rowCount)
{
	var totalEmailFieldsByClass =$("#subDetailsIndSubTab_"+_pageRef+" .accountEmails").length;
	var counter = parseInt($("#emailFieldsCount_"+_pageRef).val());
	if(rowCount == counter)
	{
		counter = counter-1;
		$("#emailFieldsCount_"+_pageRef).val(counter)
	}
	if(totalEmailFieldsByClass == 2 )
	{
		$("#mobileNoFieldsCount_"+_pageRef).val(1)
	}
	var rowId = "lastEmailRow_"+rowCount+_pageRef;
	$("#"+rowId).remove();
	
	//enable add(+) button while remove last email field
	var listEmailIds = $('[id*=subscriberEmail_'+_pageRef+']');
	if(listEmailIds.length <= 5)
	{
		$("#addEmailButton_"+_pageRef).removeClass('disable-link');
	}
	
	//change Form
	individualSubscriberMaint_formChanged();
}

/**
 * this function is used for to remove mobile dynamic row
 * @returns
 */
function individualSubscriberMaint_removeMobileDynamicField(rowCount)
{
	var totalMobileFieldsByClass = $("#subDetailsIndSubTab_"+_pageRef+" .accountMobile").length;
	
	var counter = parseInt($("#mobileNoFieldsCount_"+_pageRef).val());
	if(rowCount == counter )
	{
		counter = counter-1;
		$("#mobileNoFieldsCount_"+_pageRef).val(counter)
	}
	else if(totalMobileFieldsByClass == 2 )
	{
		$("#mobileNoFieldsCount_"+_pageRef).val(1)
	}
	var rowId = "lastMobileRow_"+rowCount+_pageRef;
	$("#"+rowId).remove();
	
	//enable add(+) button while remove last mobile field
	var listMobileIds = $('[id*=tell_'+_pageRef+']');
	if(listMobileIds.length <= 16)
	{
		$("#addMobileButton_"+_pageRef).removeClass('disable-link');
	}
	
	//change Form
	individualSubscriberMaint_formChanged();
}

//check duplicate email Ids
function individualSubscriberMaint_validateEmailIds()
{
	var emailIds = $('[id*=subscriberEmail_'+_pageRef+']');
	
	//var emailIds = $(".accountEmails");
	var flag;
	for(var i = 0; i < emailIds.length; i++)
	{
		flag = true;
		for(var j = i+1; j < emailIds.length; j++)
		{
			if( $("#"+emailIds[i].id).val() != undefined && $("#"+emailIds[i].id).val() != "" 
				&& $("#"+emailIds[j].id).val() != undefined && $("#"+emailIds[j].id).val() != "" )
			{
				if($(emailIds[i]).val() == $(emailIds[j]).val())
			    {
					flag = false;
					return flag;
			    }
			}
		}
	}
	return flag;
}

//check duplicate email Ids
function individualSubscriberMaint_validateMobileIds()
{
//	var mobileNumbers = $(".accountMobile");
	var mobileNumbers = $("[id*=tell_"+_pageRef+"]");
	var flag;
	for(var i = 0; i < mobileNumbers.length; i++)
	{
		flag = true;
		for(var j = i+1; j < mobileNumbers.length; j++)
		{
			if($("#"+mobileNumbers[i].id).val() != undefined && $("#"+mobileNumbers[i].id).val() != "" 
				&& $("#"+mobileNumbers[j].id).val() != undefined && $("#"+mobileNumbers[j].id).val() != "")
			{
				if($(mobileNumbers[i]).val() == $(mobileNumbers[j]).val())
			    {
					flag = false;
					return flag;
			    }
			}
		}
	}
	return  flag;
}

/**
 * Form Changed
 * @returns
 */
function individualSubscriberMaint_formChanged()
{
	var theform = document.getElementById("individualSubscriberMainFormId_"+_pageRef);
    $.data(theform, 'changeTrack', true);
}


function individualSubscriberMaint_returnAllCifAcounts()
{
	var cifCode = $("#cifNumberHidden_"+_pageRef).val();
	if(cifCode != "" && cifCode != undefined)
	{
		var ivCrud = $("#iv_crud_" + _pageRef).val();
		var actionSrc = jQuery.contextPath+ "/path/alert/subscriber/individual/IndividualSubscriberMaintAction_returnAccountsByCifCode";
		_showProgressBar(true);
		$.post(actionSrc, {
			"criteria.cif" : cifCode,
			"criteria.ivCrud" : ivCrud,
			"iv_crud" : ivCrud,
			"_pageRef" : _pageRef
		},
		function(param)
		{
			_showProgressBar(false);
			$("#cifAccountsMultiselectArray_"+_pageRef).val(param.individualSubscriberCO.cifAccountsMultiselectArray);
		});
	}
	else
	{
		$("#cifAccountsMultiselectArray_"+_pageRef).val("");
		$("#cifAccount_"+_pageRef).val("");
	}
}


function individualSubscriberMaint_isChargeable()
{
	var isChargeable = $("#chargeable_box_"+_pageRef).val();
	if ($("#chargeable_box_"+_pageRef).is(":checked"))
	{
		$("#nbFreeMsgs_"+_pageRef).removeAttr("readonly");
	}
	else
	{
		$("#nbFreeMsgs_"+_pageRef).val("");
		$("#nbFreeMsgs_"+_pageRef).attr("readonly", "true");
	}

}


function individualSubscriberMaint_packAndEvntselect(obj, data)
{
  var grid = obj.originalEvent.grid;  
  var sel_id = grid.jqGrid('getGridParam', 'selrow');  
  var selectedRowObject = grid.jqGrid('getRowData', sel_id);
  var status = selectedRowObject["alrtSubEvtTmpVO.SUB_EVT_STATUS"];
  var eventType = selectedRowObject["alrtSubEvtTmpVO.EVT_TYPE"];
  if(status != "P")
  {
	  $(grid).jqGrid("setCellReadOnly",sel_id,"eventAccountNumber",true);
      $(grid).jqGrid("setCellReadOnly",sel_id,"packageAccountNumber",true);
  }
  else
  {
	  if(eventType != "F")
	  {
		  $(grid).jqGrid("setCellReadOnly",sel_id,"eventAccountNumber",true);
	      $(grid).jqGrid("setCellReadOnly",sel_id,"packageAccountNumber",true);
	  }
  }
}
	
function individualSubscriberMaint_gridLayoutSetting(id)
{
	 $("#gbox_"+id+"_"+_pageRef).removeAttr("style");
	 //$(".ui-jqgrid-btable").removeAttr("style");
	 $("#"+id+"_"+_pageRef+"_pager").removeAttr("style");
	 $("#gview_"+id+"_"+_pageRef).find('.ui-jqgrid-hdiv').removeAttr("style");
	 $("#gview_"+id+"_"+_pageRef).removeAttr("style");
	 $("#gview_"+id+"_"+_pageRef).find('.ui-jqgrid-bdiv').css('width', '');
	 $("#gview_"+id+"_"+_pageRef).find('.ui-jqgrid-bdiv').css('overflow-x','hidden');
}


function subscriptionsEvtGridLoaded()
{
	var table = $("#subscriptionsEvtGridTbl_Id_" + _pageRef);
	var rows = table.jqGrid('getDataIDs');
	for (var a = 0; a < rows.length; a++)
	{
		var rel_type = table.jqGrid('getCell', rows[a],'alrtSubEvtTmpVO.REL_TYPE')
		var evt_type = table.jqGrid('getCell', rows[a],'alrtSubEvtTmpVO.EVT_TYPE')
						
		if(rel_type == 'SE' && evt_type == 'F' && _pageRef == 'IND00MA'){			
			table.jqGrid('setCellReadOnly', rows[a],"eventAccountNumber", "false");			
		}else {			
			table.jqGrid('setCellReadOnly', rows[a],"eventAccountNumber", "true");
		}
	}
}

$.subscribe('individualSubscriberMaint_disableRows', function(event, data) {
	var grid = event.originalEvent.grid;  
	var sel_id = grid.jqGrid('getGridParam', 'selrow'); 
	 
	var $table = $("subscriberEvtGridTbl_Id_" + _pageRef);
	var selectedRowObject = grid.jqGrid('getRowData', sel_id);
	var status = selectedRowObject["alrtSubEvtTmpVO.SUB_EVT_STATUS"];
	  
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var status = $("#status_" + _pageRef).val();
	if (((status == "A" && ivCrud == "P") && _pageRef =="IND00P"))
	{
			$table.jqGrid('setSelection', rowId, false);
	}
});

/**
 * Invalid email
 * @returns
 */
function validateEmail(evt)
{
	var emailAddress =  $("#"+evt.id).val();
	if(emailAddress != "" && typeof emailAddress != "undefined"){
		var pattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
	    if(!pattern.test(emailAddress)){
	    	_showErrorMsg(invalid_email_key, error_msg_title, 300,100);
	    	$("#"+evt.id).val("");
	    }
	}
}
/**
 * Invalid Mobile
 * @returns
 */
function validateMobile(evt)
{
	var mobile =  $("#"+evt.id).val();
	if(mobile != "" && typeof mobile != "undefined")
	{
		//var pattern = /^[-+]?[0-9]?[-]?[ ]+$/;
		var pattern = /^(?=.*[0-9])[- +()0-9]+$/;
	    if(!pattern.test(mobile)){
	    	_showErrorMsg(invalid_mobile_no_key, error_msg_title, 300,100);
	    	$("#"+evt.id).val("");
	    }
	}
}

//LBedrane 11/01/2019 
function notifyUserChanges()
{
    var briefname = $("#briefNameEng_"+_pageRef).val();
    var middleNameEng = $("#middleNameEng_"+_pageRef).val();
    var longName = $("#longNameEng_"+_pageRef).val();
    var address = $("#address_"+_pageRef).val();
    
	if(briefname != "" || middleNameEng != "" || longName != "" || address != "")
	{
		_showConfirmMsg(
				confirm_change_user_details_key,
				info_msg_title,
				   function(confirmcChoice, theArgs)
				   {
				    if (confirmcChoice)
				    {
				    	individualSubscriberMaint_UserChanges(confirmcChoice);
				    }
				   }, {}, yes_confirm, no_confirm, 300, 100);
	}
	else
	{
		individualSubscriberMaint_UserChanges(true);
	}
	
	
}
//LBedrane 11/01/2019 
function individualSubscriberMaint_UserChanges(confirm){
	if (confirm) 
	{	
		var actionUrl =jQuery.contextPath+ "/path/alert/subscriber/individual/IndividualSubscriberDepAction_dependencyByCifNumber";
		var CifNo       = $("#lookuptxt_cifNumber_" + _pageRef).val();
		var form  = {};
		form["cif"] = CifNo;
		$.ajax({
			url 		: actionUrl,
			type 		: "post",
			dataType 	: "json",
			data 		: form,
			success : function(data) 
			{
				if (data["_error"] == null || data["_error"] == "undefined") 
				{
					var shortNameEng = data.individualSubscriberCO.cifVO.SHORT_NAME_ENG;
					var longNameEng = data.individualSubscriberCO.cifVO.LONG_NAME_ENG;
					var address = data.individualSubscriberCO.cifVO.ADDRESS1_ENG;
					var cifType = data.individualSubscriberCO.cifType;
					
					$("#briefNameEng_"+_pageRef).val(shortNameEng); 
					$("#longNameEng_"+_pageRef).val(longNameEng);
					$("#address_"+_pageRef).val(address);
					$("#cifType_"+_pageRef).val(cifType);
					
				//	_showErrorMsg(details_updated_successfully_key,info_msg_title, 300, 100);
				} else {
					_showProgressBar(false);
				}
			}
		});
	}
}

function notifyImalUserChanges(data){
	
	if (data["_error"] == null || data["_error"] == "undefined") {
		var shortNameEng = data.individualSubscriberCO.usrVO.FIRST_NAME;
		var longNameEng = data.individualSubscriberCO.usrVO.LAST_NAME;
		var usrName = (shortNameEng||"") + ' ' + (longNameEng||"");
		
		$("#usrName_"+_pageRef).val(usrName);
	}
	
	_showConfirmMsg(
			confirm_change_user_details_key,
			info_msg_title,
			   function(confirmcChoice, theArgs)
			   {
			    if (confirmcChoice)
			    {
			    	individualSubscriberMaint_ImalUserChanges(confirmcChoice);
			    }
			   }, {}, yes_confirm, no_confirm, 300, 100);
}

function individualSubscriberMaint_ImalUserChanges(confirm){
	if (confirm) 
	{	
		var actionUrl =jQuery.contextPath+ "/path/alert/subscriber/individual/IndividualSubscriberDepAction_dependencyByUserID";
		var userID       = $("#lookuptxt_userId_" + _pageRef).val();
		var form  = {};
		form["userID"] = userID;
		$.ajax({
			url 		: actionUrl,
			type 		: "post",
			dataType 	: "json",
			data 		: form,
			success : function(data) {
				if (data["_error"] == null || data["_error"] == "undefined") {
					var shortNameEng = data.individualSubscriberCO.usrVO.FIRST_NAME;
					var longNameEng = data.individualSubscriberCO.usrVO.LAST_NAME;
					var usrName = (shortNameEng||"") + ' ' + (longNameEng||"");
					
					$("#briefNameEng_"+_pageRef).val(shortNameEng); 
					$("#longNameEng_"+_pageRef).val(longNameEng);
					$("#usrName_"+_pageRef).val(usrName);
				} else {
					_showProgressBar(false);
				}
			}
		});
	}
}