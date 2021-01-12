	//this method checks if there are changes in the screen.
	function checkIfFormChanged()
	{
		if (document.getElementById("individualEventMainFormId_" + _pageRef) == "undefined"
				|| document.getElementById("individualEventMainFormId_"
						+ _pageRef) == null)
		{
			return false;
		}
		var changes = $("#individualEventMainFormId_" + _pageRef).hasChanges();
		if (changes)
		{
			return true;
		}
		return changes;
	}
	
	/**
	 * Check Event Description Unique
	 * @returns
	 */
	function individualEventMaint_checkEventDescriptionUnique() 
	{
	    var eventEnglishDescription = $("#desceng_"+ _pageRef).val();
	    var reloadParams = {};
		reloadParams["individualEventSC.eventEnglishDescription"] = eventEnglishDescription;
		//save /update
		var url = jQuery.contextPath+"/path/alert/events/event/IndividualEventMaintAction_checkEventDescriptionUnique";
			
		$.ajax({
			url : url,
			type : "post",
			dataType : "json",
			data : reloadParams,
			success : function(data) 
			{
				//individualEventMaint_focusOnEventDescription();
				var isDuplicate = data.isEventDescriptionExist;
				if(isDuplicate == "true")
				{
					_showErrorMsg(msg_duplicate_entry_Of_record_key, error_msg_title,300, 100,
						function()
						{
							individualEventMaint_focusOnEventDescription();
						});
				}
			}
		});
	}
	
	/**
	 * Focus on Event Description
	 * @returns
	 */
	function individualEventMaint_focusOnEventDescription()
	{
	       $("#desceng_"+_pageRef).val("");
	       $("#desceng_"+_pageRef).focus();
	}
	
	/**
	 * validate form before submit
	 * @returns
	 */
	function individualEventMaint_validateFormBeforeSubmit()
    {
		if($("#communicationModeEmail_"+_pageRef). prop("checked") == true)
		{
			var templateType = $("#messageBodyOptionList_"+_pageRef).val();
			if(templateType == 'S')
			{
				var defaultEmailQueryDefaultMessageSubject = $("#eventStaticEmailMessageDefaultSubjectHiddenId_"+_pageRef).val();
				var defautEmailEmailQueryDefaultMessageBody = $("#eventStaticEmailMessageDefaultBodyHiddenId_"+_pageRef).val();
				var language = $("#eventStaticEmailOtherLanguage_"+_pageRef).val();
				
				var emailQueryDefaultMessageSubject = $("#eventStaticEmailMessageSubjectEng_"+_pageRef).val();
				var emailQueryDefaultMessageBody = $("#eventStaticEmailMessageBodyEng_"+_pageRef).val();
				
				
				
				if((defaultEmailQueryDefaultMessageSubject == "-" || defaultEmailQueryDefaultMessageSubject == "" || defaultEmailQueryDefaultMessageSubject == undefined)
						|| (defautEmailEmailQueryDefaultMessageBody == "" || defautEmailEmailQueryDefaultMessageBody == undefined))
				{
					if(language != undefined && language != "DF")
					{
						$("#eventStaticEmailMessageSubjectEng_"+_pageRef).focus();
						_showErrorMsg(missing_email_query_default_subject_Body_key, error_msg_title, 300,100);
						return true;
					}
					else
					{
						if((emailQueryDefaultMessageSubject == "-" || emailQueryDefaultMessageSubject == "" || emailQueryDefaultMessageSubject == undefined)
								|| (emailQueryDefaultMessageBody == "" || emailQueryDefaultMessageBody == undefined))
						{
							$("#eventStaticEmailMessageSubjectEng_"+_pageRef).focus();
							_showErrorMsg(missing_email_query_default_subject_Body_key, error_msg_title, 300,100);
							return true;
						}
					}
				}
			}
			else
			{
				
				var emailDynamicDefaultMessageSubject = $("#eventStaticEmailMessageSubjectEng_"+_pageRef).val();
				if(emailDynamicDefaultMessageSubject == "" )
				{
					$("#eventStaticEmailMessageSubjectEng_"+_pageRef).focus();
					_showErrorMsg(missing_email_report_default_subject_key, error_msg_title, 300,100);
					
					return true;
				}
			}
		}
		
		if($("#communicationModeSms_"+_pageRef). prop("checked") == true)
	    {
			var defautEmailSmsQueryDefaultMessageBody = $("#eventStaticSmsMessageDefaultBodyHiddenId_"+_pageRef).val();
			var language = $("#eventStaticSmsOtherLanguage_"+_pageRef).val();
			
	//		var emailQueryDefaultMessageSubject = $("#eventStaticEmailMessageSubjectEng_"+_pageRef).val();
			var emailQueryDefaultMessageBody = $("#eventStaticSmsMessageBodyEng_"+_pageRef).val();
			
			
			
			if(defautEmailSmsQueryDefaultMessageBody == "" || defautEmailSmsQueryDefaultMessageBody == undefined)
			{
				if(language != undefined && language != "DF")
				{
					$("#eventStaticSmsMessageDefaultBodyHiddenId_"+_pageRef).focus();
					_showErrorMsg(missing_sms_query_default_Msg_key, error_msg_title, 300,100);
					return true;
				}
				else
				{
					if(emailQueryDefaultMessageBody == "" || emailQueryDefaultMessageBody == undefined)
					{
						$("#eventStaticSmsDefaultMessageBodyHiddenId_"+_pageRef).focus();
						_showErrorMsg(missing_sms_query_default_Msg_key, error_msg_title, 300,100);
						return true;
					}
				}
				
			}
	    }
		
		if($("#communicationModeOmniInbox_"+_pageRef). prop("checked") == true)
	    {
			var defaultOmniQueryDefaultMessageSubject = $("#eventStaticOmniInboxMessageDefaultSubjectHiddenId_"+_pageRef).val();
			var defautEmailOmniInboxQueryDefaultMessageBody = $("#eventStaticOmniInboxMessageDefaultBodyHiddenId_"+_pageRef).val();
			var language = $("#eventStaticOmniInboxOtherLanguage_"+_pageRef).val();
			
			var omniQueryDefaultMessageSubject = $("#eventStaticOmniInboxMessageSubjectEng_"+_pageRef).val();
			var omniQueryDefaultMessageBody = $("#eventStaticOmniInboxMessageBodyEng_"+_pageRef).val();
			
			
			
			if(( defaultOmniQueryDefaultMessageSubject == "" || typeof defaultOmniQueryDefaultMessageSubject == "undefined")
					|| (defautEmailOmniInboxQueryDefaultMessageBody == "" || typeof defautEmailOmniInboxQueryDefaultMessageBody == "undefined"))
			{
				if(typeof language != "undefined" && language != "DF")
				{
					$("#eventStaticOmniInboxMessageSubjectEng_"+_pageRef).focus();
					_showErrorMsg(missing_omni_query_default_subject_Body_key, error_msg_title, 300,100);
					return true;
				}
				else
				{
					if((omniQueryDefaultMessageSubject == "" || omniQueryDefaultMessageSubject == undefined)
							|| (omniQueryDefaultMessageBody == "" || omniQueryDefaultMessageBody == undefined))
					{
						$("#eventStaticOmniInboxMessageSubjectEng_"+_pageRef).focus();
						_showErrorMsg(missing_omni_query_default_subject_Body_key, error_msg_title, 300,100);
						return true;
					}
				}
			}
			
//			
//			
//			if(defautEmailOmniInboxQueryDefaultMessageBody == "" || defautEmailOmniInboxQueryDefaultMessageBody == undefined)
//			{
//				if(language != undefined && language != "DF")
//				{
//					$("#eventStaticOmniInboxMessageBodyEng_"+_pageRef).focus();
//					_showErrorMsg(missing_omniInbox_query_default_Msg_key, error_msg_title, 300,100);
//					return true;
//				}
//				else
//				{
//					if(emailQueryDefaultMessageBody == "" || emailQueryDefaultMessageBody == undefined)
//					{
//						$("#eventStaticOmniInboxMessageBodyEng_"+_pageRef).focus();
//						_showErrorMsg(missing_omniInbox_query_default_Msg_key, error_msg_title, 300,100);
//						return true;
//					}
//				}
//			}
	    }
		
		return false;
    }
	
	/**
	 * 
	 * @returns
	 */
	function individualEventMaint_validateSmsLength(communicationType)
	{
		 var selectedBodyTextareaId = $("#selectedBodyTextareaId_"+_pageRef).val();
		 var id = $("#eventStatic"+communicationType+"MessageBodyEng_"+_pageRef);
		 var text_length = id.val().length;
		   if(selectedBodyTextareaId == "eventStatic"+communicationType+"MessageBodyEng_"+_pageRef)
		   {
			   if(text_length > 160)
		   		{
		    		return true
		    	}
		    }
	}
	/**
	 * conform message for Query tags of email, Sms and Omni
	 * @returns
	 */
	function individualEventMaint_submit()
	{
		//validate the default subject and bofy from email/sms/omni
		var requiredFieldMissig = individualEventMaint_validateFormBeforeSubmit();
		if(requiredFieldMissig)
        {
        	return;
        }
		
		/**
		 * validate internal Alert Requesred fields
		 */
		if(!internalAlerts_validate()) return;
		
		//check if sms contains charachters more than 160
		/*var smsValidation = individualEventMaint_validateSmsLength("Sms");
		if(smsValidation)
        {
			_showErrorMsg(sms_should_be_less_than_160_charachters_key, error_msg_title, 300,100);
        	return;
        }*/
		
		var emailQueryId = $("#lookuptxt_eventStaticEmailQueryId_"+_pageRef).val();
		var smsQueryId = $("#lookuptxt_eventStaticSmsQueryId_"+_pageRef).val();
		var omniQueryId = $("#lookuptxt_eventStaticOmniInboxQueryId_"+_pageRef).val();
		
		
	    var emailLang = $("#eventStaticEmailOtherLanguage_"+_pageRef).val();
	    var smsLang = $("#eventStaticSmsOtherLanguage_"+_pageRef).val();
	    var omniInboxLang = $("#eventStaticOmniInboxOtherLanguage_"+_pageRef).val();
		
		var emailHiddenData = $('[id*=eventStaticEmailMessage]');
		var smsHiddenData = $('[id*=eventStaticSmsMessage]');
		var omniInboxHiddenData = $('[id*=eventStaticOmniInboxMessage]');
		
		var isEmailActivate = $("#communicationModeEmail_"+_pageRef).prop("checked");
		var isSmsActivate = $("#communicationModeSms_"+_pageRef).prop("checked");
		var isOmniActivate = $("#communicationModeOmniInbox_"+_pageRef).prop("checked");

		var reportId = $("#lookuptxt_eventDynamicEmailReportId_"+_pageRef).val();
		
		var message = "";
		
		if(reportId == "" && emailQueryId != "" && typeof emailQueryId != "undefined" && isEmailActivate)
		{
			var queryTagUsed = false;
			for(var i=0; i<emailHiddenData.length; i++)
			{
				var emailData = $("#"+emailHiddenData[i].id).val();
				var emailHiddenDetails = emailData.split("<-->");
				if(emailHiddenDetails.length > 1)
				{
					if(emailLang != emailHiddenDetails[1])
					{
						if(typeof emailData != "undefined" && emailData.indexOf("<QUERY.") > -1)
						{
							queryTagUsed = true;
							break;
						}
					}
				}
				else
				{
					if(typeof emailData != "undefined" && emailData.indexOf("<QUERY.") > -1)
					{
						queryTagUsed = true;
						break;
					}
				}
			}
			
			if(!queryTagUsed)
			{
				message = "E";
			}
		}
		
		if(smsQueryId != ""  && typeof smsQueryId != "undefined" && isSmsActivate)
		{
			queryTagUsed = false;
			
			for(var i=0; i<smsHiddenData.length; i++)
			{
				var smsData = $("#"+smsHiddenData[i].id).val();
				var smsHiddenDetails = smsData.split("<-->");
				if(smsHiddenDetails.length > 1)
				{
					if(smsLang != smsHiddenDetails[1])
					{
						if(typeof smsData != "undefined" && smsData.indexOf("<QUERY.") > -1)
						{
							queryTagUsed = true;
							break;
						}
					}
				}
				else
				{
					if(typeof smsData != "undefined" && smsData.indexOf("<QUERY.") > -1)
					{
						queryTagUsed = true;
						break;
					}
				}
			}
			
			if(!queryTagUsed)
			{
				message+="S";
			}
		}
		
		if(omniQueryId != ""  && typeof omniQueryId != "undefined" && isOmniActivate)
		{
			
			queryTagUsed = false;
			for(var i=0; i<omniInboxHiddenData.length; i++)
			{
				var omniInboxData = $("#"+omniInboxHiddenData[i].id).val();
				
				var omniInboxHiddenDetails = omniInboxData.split("<-->");
				if(omniInboxHiddenDetails.length > 1)
				{
					if(omniInboxLang != omniInboxHiddenDetails[1])
					{
						if(typeof omniInboxData != "undefined" && omniInboxData.indexOf("<QUERY.") > -1)
						{
							queryTagUsed = true;
							break;
						}
					}
				}
				else
				{
					if(typeof omniInboxData != "undefined" && omniInboxData.indexOf("<QUERY.") > -1)
					{
						queryTagUsed = true;
						break;
					}
				}
			}
			
			if(!queryTagUsed)
			{
				message+="O";
			}
		}
		
		var fullMessage = "";
		if(message != "")
		{
			if(message == "E")
			{
				_showConfirmMsg(email_key+" "+query_tags_not_used_conform_key, confirm_msg_title,individualEventMaint_save, {}, '', '', 300, 100);
			} else if(message == "S")
			{
				_showConfirmMsg(SMS_key+" "+query_tags_not_used_conform_key, confirm_msg_title,individualEventMaint_save, {}, '', '', 300, 100);
			} else if(message == "O")
			{
				_showConfirmMsg(omni_inbox_key+" "+query_tags_not_used_conform_key, confirm_msg_title,individualEventMaint_save, {}, '', '', 300, 100);
			} else if(message == "ES")
			{
				_showConfirmMsg(email_key+" "+SMS_key+" "+query_tags_not_used_conform_key, confirm_msg_title,individualEventMaint_save, {}, '', '', 300, 100);
			} else if(message == "EO")
			{
				_showConfirmMsg(email_key+" "+omni_inbox_key+" "+query_tags_not_used_conform_key, confirm_msg_title,individualEventMaint_save, {}, '', '', 300, 100);
			}
			else if(message == "SO")
			{
				_showConfirmMsg(SMS_key+" "+omni_inbox_key+" "+query_tags_not_used_conform_key, confirm_msg_title,individualEventMaint_save, {}, '', '', 300, 100);
			}
			else if(message == "ESO")
			{
				_showConfirmMsg(email_key+" "+SMS_key+" "+omni_inbox_key+" "+query_tags_not_used_conform_key, confirm_msg_title,individualEventMaint_save, {}, '', '', 300, 100);
			}
				
		}
		else
		{
			individualEventMaint_save(true);
		}
	}
	
	/**
	 * Save Event Record
	 * @returns
	 */
	function individualEventMaint_save(conform)
	{
		if(conform)
		{
			var evtType = $("#eventType_" + _pageRef).val();
			//clear all query details whenever the tags hasn't used
			individualEventMaint_clearQueryDeatils();
	        if (evtType =='F')
	        {
	        	var gridId = "fixedParam_";
	        	//var validateProperty = "alrtSubVO.DEFAULT_BRIEF_NAME";
	        	var columNames = ["PARAM_VALUE", "OPERATOR_TYPE"];

	        	//check if rows Empty
	        	var isEmpty = common_validateGridEmptyRowByProperties(gridId, columNames);
	        	if(isEmpty)
	        	{
	        		_showErrorMsg(fill_fixed_event_param_empty_row_key, error_msg_title, 300,100);
	        		return;
	        	}

	        	
	        	var fixedParam = $("#fixedParam_" + _pageRef);
	      	  	var distAllRecList1 = fixedParam.jqGrid('getAllRows');
	      	  	$("#allRecFixedParamList_" + _pageRef).val(distAllRecList1);
	        }
	        
			var changes = $("#individualEventMainFormId_"+_pageRef).hasChanges();
			if (changes == 'true' || changes == true)
			{
				var url = jQuery.contextPath + "/path/alert/events/event/IndividualEventMaintAction_save";
				process_individualEventMaint(url);
			}
		}
	}
	
	/**
	 * clear query details if Tags Not used
	 * @returns
	 */
	function individualEventMaint_clearQueryDeatils()
	{
		
		var emailQueryId = $("#lookuptxt_eventStaticEmailQueryId_"+_pageRef).val();
		var smsQueryId = $("#lookuptxt_eventStaticSmsQueryId_"+_pageRef).val();
		var omniQueryId = $("#lookuptxt_eventStaticOmniInboxQueryId_"+_pageRef).val();
		
		
		var emailHiddenData = $('[id*=eventStaticEmailMessage]');
		var smsHiddenData = $('[id*=eventStaticSmsMessage]');
		var omniInboxHiddenData = $('[id*=eventStaticOmniInboxMessage]');
		
		var isEmailActivate = $("#communicationModeEmail_"+_pageRef). prop("checked");
		var isSmsActivate = $("#communicationModeSms_"+_pageRef). prop("checked");
		var isOmniActivate = $("#communicationModeOmniInbox_"+_pageRef). prop("checked");
		
		var reportId = $("#lookuptxt_eventDynamicEmailReportId_"+_pageRef).val();
		
		if(reportId == "" && emailQueryId != "" && typeof emailQueryId != "undefined" && isEmailActivate)
		{
			
			var queryTagUsed = false;
			for(var i=0; i<emailHiddenData.length; i++)
			{
				var emailData = $("#"+emailHiddenData[i].id).val();
				if(typeof emailData != "undefined" && emailData.indexOf("<QUERY.") > -1)
				{
					queryTagUsed = true;
					break;
				}
			}
			
			if(!queryTagUsed)
			{
				$("#lookuptxt_eventStaticEmailQueryId_"+_pageRef).val("");
				$("#eventStaticEmailQueryBriefDescEng_"+_pageRef).val("");
				$("#eventStaticEmailQueryArgumentsHiddenId_"+_pageRef).val("");
				$('#eventEmailStaticQueryTagsGridId_' +_pageRef).jqGrid('clearGridData');
			}
		}
		
		if(smsQueryId != ""  && typeof smsQueryId != "undefined" && isSmsActivate)
		{
			
			queryTagUsed = false;
			for(var i=0; i<smsHiddenData.length; i++)
			{
				var smsData = $("#"+smsHiddenData[i].id).val();
				if(typeof smsData != "undefined" && smsData.indexOf("<QUERY.") > -1)
				{
					queryTagUsed = true;
					break;
				}
			}
			
			if(!queryTagUsed)
			{
				$("#lookuptxt_eventStaticSmsQueryId_"+_pageRef).val("");
				$("#eventStaticSmsQueryBriefDescEng_"+_pageRef).val("");
				$("#eventStaticSmsQueryArgumentsHiddenId_"+_pageRef).val("");
				$('#eventSmsStaticQueryTagsGridId_' +_pageRef).jqGrid('clearGridData');
			}
		}
		
		if(omniQueryId != ""  && typeof omniQueryId != "undefined" && isOmniActivate)
		{
			queryTagUsed = false;
			for(var i=0; i<omniInboxHiddenData.length; i++)
			{
				var omniInboxData = $("#"+omniInboxHiddenData[i].id).val();
				if(typeof omniInboxData != "undefined" && omniInboxData.indexOf("<QUERY.") > -1)
				{
					queryTagUsed = true;
					break;
				}
			}
			
			if(!queryTagUsed)
			{
				$("#lookuptxt_eventStaticOmniInboxQueryId_"+_pageRef).val("");
				$("#eventStaticOmniInboxQueryBriefDescEng_"+_pageRef).val("");
				$("#eventStaticOmniInboxQueryArgumentsHiddenId_"+_pageRef).val("");
				$('#eventOmniInboxStaticQueryTagsGridId_' +_pageRef).jqGrid('clearGridData');
			}
		}
	}
	
	/**
	 * Update After approve
	 * @returns
	 */
	function updateAfterApprove_individualEventMaint()
	{
		var requiredFieldMissig = individualEventMaint_validateFormBeforeSubmit();
		var evtType = $("#eventType_" + _pageRef).val();
        if(requiredFieldMissig)
        {
        	return;
        }
        
        if (evtType =='F')
        {
        	var fixedParam = $("#fixedParam_" + _pageRef);
      	  	var distAllRecList1 = fixedParam.jqGrid('getRowData');
      	  	$("#allRecFixedParamList_" + _pageRef).val(replaceTypeValue(distAllRecList1));
        }
        
		var changes = $("#individualEventMainFormId_"+_pageRef).hasChanges();
		if (changes == 'true' || changes == true)
		{
			var actionUrl = jQuery.contextPath+ "/path/alert/events/event/IndividualEventMaintAction_save";
			process_individualEventMaint(actionUrl, "MA");
		}
	}
	
	/**
	 * approve event event
	 * @returns
	 */
	function individualEventMaint_approve()
	{
		var actionUrl = jQuery.contextPath+ "/path/alert/events/event/IndividualEventMaintAction_approve";
		process_individualEventMaint(actionUrl, "P");
	}
	
	/**
	 * to suspend
	 * @returns
	 */
	function individualEventMaint_toSuspend()
	{
		var actionUrl = jQuery.contextPath+ "/path/alert/events/event/IndividualEventMaintAction_toSuspend";
		process_individualEventMaint(actionUrl, "S");
	}
	
	/**
	 * approve suspend
	 * @returns
	 */
	function individualEventMaint_approveSuspend()
	{
		var actionUrl = jQuery.contextPath+ "/path/alert/events/event/IndividualEventMaintAction_suspend";
		process_individualEventMaint(actionUrl, "SP");
	}
	
	/**
	 * to reactive
	 * @returns
	 */
	function individualEventMaint_toReactivate()
	{
		var actionUrl = jQuery.contextPath+ "/path/alert/events/event/IndividualEventMaintAction_toReactivate";
		process_individualEventMaint(actionUrl, "RA");
	}
	
	/**
	 * Approve Reactive
	 * @returns
	 */
	function individualEventMaint_approveReactivate()
	{
		var actionUrl = jQuery.contextPath+ "/path/alert/events/event/IndividualEventMaintAction_reactivate";
		process_individualEventMaint(actionUrl, "RP");
	}
	
	function individualEventMaint_reject(fromScreen)
	{
		var actionUrl = jQuery.contextPath+ "/path/alert/events/event/IndividualEventMaintAction_reject";
		process_individualEventMaint(actionUrl, fromScreen);
	}
	
	/**
	 * process to save/approve/update after approve
	 * @param url
	 * @param status
	 * @returns
	 */
	function process_individualEventMaint(url, status)
	{
		if(url == undefined)
		{
			return;
		}
		//adjust email static messages details in all languages
		individualEventMaint_setAllLangMessageDetails("Email");
		//adjust sms static messages details in all languages
		individualEventMaint_setAllLangMessageDetails("Sms");
		//adjust omni Inbox static messages details in all languages
		individualEventMaint_setAllLangMessageDetails("OmniInbox");
		
		/**
		 * if fixed events is not availble in secondary db (core db)
		 * then the record related to fixed events will be insert
		 */
		var evtType = $("#eventType_" + _pageRef).val();
        if (evtType =='F')
        {
        	var gridId = "fixedParam_";
        	//var validateProperty = "alrtSubVO.DEFAULT_BRIEF_NAME";
        	var columNames = ["PARAM_VALUE", "OPERATOR_TYPE"];

        	//check if rows Empty
        	var isEmpty = common_validateGridEmptyRowByProperties(gridId, columNames);
        	if(!isEmpty)
        	{
        		var fixedParam = $("#fixedParam_" + _pageRef);
          	  	var distAllRecList1 = fixedParam.jqGrid('getAllRows');
          	  	$("#allRecFixedParamList_" + _pageRef).val(distAllRecList1);
        	}
        	
        }
        
		
		var formData = $("#individualEventMainFormId_" + _pageRef).serializeForm();
		_showProgressBar(true);
		$.ajax({
			url : url,
			type : "post",
			dataType : "json",
			data : formData,
			success : function(data)
			{
				if (data["_error"] == null || data["_error"] == "undefined") 
				{
					var ivcrud = $("#iv_crud_"+_pageRef).val();
					
					if(status != "P" && status != "S" && status != "SP" && status != "RA" && status != "RP" && status != "RS" && status != "RRA" && ivcrud != "F")
					{
						individualEventMaint_clearForm();
						$("#individualEventGridTbl_Id_" + _pageRef).trigger("reloadGrid");
					}
					
					var resultMessage = "";
					resultMessage = record_saved_Successfully_key;
					if(status == "P")
					{
						resultMessage = record_was_Approved_Successfully_key;
					}
					else if(status == "S")
					{
						resultMessage = record_was_Suspended_Successfully_key;
					}
					else if(status == "SP")
					{
						resultMessage = suspended_record_approved_successfully_key;
					}
					else if(status == "RA")
					{
						resultMessage = record_reactivated_successfully_key;
					}
					else if(status == "RP")
					{
						resultMessage = reactivated_record_approved_successfully_key;
					}
					else if(status == "RS")
					{
						resultMessage = suspended_record_rejected_successfully_key;
					}
					else if(status == "RRA")
					{
						resultMessage = reactivated_record_rejected_successfully_key;
					}
					_showErrorMsg(resultMessage, info_msg_title, 300,100);
					_showProgressBar(false);
					
					if(status == "P" || status == "S" || status == "SP" || status == "RA" || status == "RP" || status == "RS" || status == "RRA" || ivcrud == 'F')
					{
						showHideSrchGrid('individualEventGridTbl_Id_'+ _pageRef);
						$("#individualEventGridTbl_Id_" + _pageRef).trigger("reloadGrid");
						$("#individualEventMaintPage_id_" + _pageRef).html("");
					}
				}
				else
				{
					_showProgressBar(false);
				}
			}
		});
	}

	function individualEventMaint_setAllLangMessageDetails(componentId)
	{
		var englishMessage = $("#eventStatic"+componentId+"MessageENHiddenId_"+_pageRef).val();
		var arabicMessage = $("#eventStatic"+componentId+"MessageARHiddenId_"+_pageRef).val();
		var frenchMessage = $("#eventStatic"+componentId+"MessageFRHiddenId_"+_pageRef).val();
		var persionMessage = $("#eventStatic"+componentId+"MessageFAHiddenId_"+_pageRef).val();
		var russianMessage = $("#eventStatic"+componentId+"MessageRUHiddenId_"+_pageRef).val();
		var turkishMessage = $("#eventStatic"+componentId+"MessageTKHiddenId_"+_pageRef).val();
		
		$("#eventDynamic"+componentId+"MessageDetailsTemp_"+_pageRef).val(englishMessage+"<---->"+arabicMessage+"<---->"+frenchMessage+"<---->"+russianMessage+"<---->"+turkishMessage+"<---->"+persionMessage);
		
		// set new Custom Tags in Hidden fields
		var table = $("#eventEmailStaticCustomTagsGridId_" + _pageRef);
		var newCustomnTags = table.jqGrid('getChangedRowData');
		$("#eventStaticEmailNewCustomTagsHiddenId_"+_pageRef).val(newCustomnTags);
		
	}
	
	/**
	 * Conform Delete Record
	 * @returns
	 */
	function individualEventMaint_conformDelete()
	{
		_showConfirmMsg(Confirm_Delete_Process_key, info_msg_title,individualEventMaint_delete, {}, '', '', 300, 100);
	}
	
	/**
	 * Delete Event Record
	 * @param conform
	 * @returns
	 */
	function individualEventMaint_delete(conform)
	{
		if (confirm) 
		{
			_showProgressBar(true);
			var form = $("#individualEventMainFormId_" + _pageRef).serializeForm();
			var actionUrl = jQuery.contextPath+ "/path/alert/events/event/IndividualEventMaintAction_delete";
			$.ajax({
				url : actionUrl,
				type : "post",
				dataType : "json",
				data : form,
				success : function(data) 
				{
					if (data["_error"] == null || data["_error"] == "undefined") 
					{
						$("#individualEventGridTbl_Id_"+_pageRef).trigger("reloadGrid");
						individualEventMaint_clearForm();
						_showProgressBar(false);
						_showErrorMsg(Record_was_Deleted_Successfully_key, info_msg_title,300, 100);
					} else 
					{
						_showProgressBar(false);
					}
				}
			});
		}
	}

	/**
	 * Clear Event Form
	 * @returns
	 */
	function individualEventMaint_clearForm() 
	{
		_showProgressBar(true);
		var reloadUrl = jQuery.contextPath + "/path/alert/events/event/IndividualEventMaintAction_clear";
		var ivCrud = returnHtmlEltValue("iv_crud_" + _pageRef);
		var reloadParams = {};
		reloadParams["iv_crud"] = ivCrud;
		reloadParams["_pageRef"] = _pageRef;

		$.post(reloadUrl, reloadParams, function(param) {
			$("#individualEventMaintPage_id_" + _pageRef).html(param);
			_showProgressBar(false);
		}, "html");

	}

	/**
	 * Change Event Status Process
	 * @returns
	 */
	function individualEventMaint_changeStatusProcess() 
	{
		var iv_crud = $("#iv_crud_"+ _pageRef).val();
	    var Confirm_Message;
	    var Success_Message;
		if(iv_crud == 'P')
		{
			Confirm_Message = Confirm_Approve_Process_key;
			Success_Message = record_was_Approved_Successfully_key;
		} 
		else if(iv_crud == 'UP')
		{
			Confirm_Message = Confirm_Reactivate_Process_key;
			Success_Message = record_was_Updated_Successfully_key;
		}
		else if(iv_crud == 'S')
		{
			Confirm_Message = Confirm_Suspend_Process_key;
			Success_Message = record_was_Suspended_Successfully_key;
		}
		else if(iv_crud == 'RA')
		{
			Confirm_Message = Confirm_Reactivate_Process_key;
			Success_Message = record_reactivated_successfully_key;
		}
		
		$("#saveRecord_" + _pageRef).val(1);
		_showConfirmMsg(Confirm_Message, info_msg_title,
				individualEventMaint_updateStatusProcess, 
				{
					isReject : false,
					infoMessageDet : Success_Message
				}, '', '', 300, 100);
	    }
	
	/**
	 * Change in Event Record in diffrent Status i.e Active, Approve, Suspand, Reactive, Update After Approve
	 * @param confirm
	 * @param args
	 * @returns
	 */
	function individualEventMaint_updateStatusProcess(confirm, args) 
	{
		if (confirm) 
		{
			_showProgressBar(true);
			var form = $("#groupDefinitionFormId_" + _pageRef).serializeForm();
			var actionUrl = jQuery.contextPath+"//path/alert/events/event/IndividualEventMaintAction_updateStatusProcess";
			$.ajax({
				url : actionUrl,
				type : "post",
				dataType : "json",
				data : form,

				success : function(data) {
					if (data["_error"] == null || data["_error"] == "undefined") {
						$("#individualEventGridTbl_Id_" + _pageRef).trigger("reloadGrid");
						individualEventMaint_clearForm();
						_showProgressBar(false);
						
						if (args.isReject == 0) {
							_showErrorMsg(args.infoMessageDet,info_msg_title, 300, 100);
						} else {
							_showErrorMsg(record_rejected_Successfully_key,info_msg_title, 300, 100);
						}

					} else {
						_showProgressBar(false);
					}

				}
			});
		}
	}

	
	
function showEventStatus()
{
	var evtId = $("#eventId_" + _pageRef).val();
	if (evtId == "")
	{
		return;
	}

	var loadSrc = jQuery.contextPath
			+ "/path/alert/events/event/EventStatusAction_search.action?_pageRef="
			
			+ _pageRef;

	showStatus("individualEventMainFormId_" + _pageRef, _pageRef, loadSrc, {
		"eventID" : evtId
	});
}

function indEventMaint_otherLangDialogue() 
{
	var	openOtherLangDetailsPopup = $("<div id='openOtherLangDetailsPopup_"+_pageRef+"' class='path-common-sceen'></div>");
	openOtherLangDetailsPopup.css("padding","0");
	openOtherLangDetailsPopup.insertAfter($('body'));
	
	var _dialogOptions = {modal:true, 
			title:other_lang_msg_subjects,
            autoOpen:false,
            show:'slide',
            width:returnMaxWidth(405),
            height:returnMaxHeight(350),
            position:'center', 
            closeOnEscape: false,
            //to hide the x button in the dialogue
            open: function(event, ui) {
                $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
            },
            buttons:{
                OK:function(){
                	    var theDialog = $(this);
                        onOkLang(theDialog)	 
                        },
                Cancel: function(){
                	     var theDialog = $(this);
                		 onCancelLang(theDialog);
		               	 }
		                       
		               },
		         position:'center', 
		        };
	
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var oldStatus = $("#STATUS_"+_pageRef).val();
	
	mySrc = jQuery.contextPath
			+ "/path/otherLanguages/OtherLanguagesAction_loadPopup.action?_pageRef="+_pageRef+"&iv_crud="+ivCrud+"&oldStatus="+oldStatus;
	$('#openOtherLangDetailsPopup_' + _pageRef).load(mySrc/*, {
		"reportQueryCO.querySyntax" : param.reportQueryCO.querySyntax
	}*/, function() {
	});
	$('#openOtherLangDetailsPopup_' +_pageRef).dialog(_dialogOptions);
	$('#openOtherLangDetailsPopup_' + _pageRef).dialog('open');
}

function indEventMaint_otherLangBodyDialogue() 
{
	var	openOtherLangDetailsPopup = $("<div id='openOtherLangBodyDetailsPopup_"+_pageRef+"' class='path-common-sceen'></div>");
	openOtherLangDetailsPopup.css("padding","0");
	openOtherLangDetailsPopup.insertAfter($('body'));
	
	var _dialogOptions = {modal:true, 
			title:other_lang_msg_subjects,
			autoOpen:false,
			show:'slide',
			width:returnMaxWidth(1010),
			height:returnMaxHeight(350),
			position:'center', 
			closeOnEscape: false,
			//to hide the x button in the dialogue
			open: function(event, ui) {
				$(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
			},
			buttons:{
				OK:function(){
					var theDialog = $(this);
					onOkBodyLang(theDialog)	 
				},
				Cancel: function(){
					var theDialog = $(this);
					onCancelBodyLang(theDialog);
				}
				
			},
			position:'center', 
	};
	
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var oldStatus = $("#STATUS_"+_pageRef).val();
	
	mySrc = jQuery.contextPath
	+ "/path/otherLanguages/OtherLanguagesAction_loadBodyPopup.action?_pageRef="+_pageRef+"&iv_crud="+ivCrud+"&oldStatus="+oldStatus;
	$('#openOtherLangBodyDetailsPopup_' + _pageRef).load(mySrc, {
		"individualEventSC.alrtEvtVO.EVT_TYPE" : $("#event_type_" + _pageRef).val(),
		"individualEventSC.alrtEvtVO.FIXED_EVENT_ID" : $("#fixedEventTypeId_" + _pageRef).val()
	}, function() {
	});
	$('#openOtherLangBodyDetailsPopup_' +_pageRef).dialog(_dialogOptions);
	$('#openOtherLangBodyDetailsPopup_' + _pageRef).dialog('open');
}

function onOkLang(theDialog)
{
	//validate the grid
	if(!OtherLanguages_validateGrid())
	{
		return;
	}
	//get the data from the grid
	var rows = $("#otherLanguagesGrid_Id_"+_pageRef).jqGrid('getAllRows');	
	
	$('#otherLanguagesJson_' + _pageRef).val(rows);
    var theform = document.getElementById("individualEventMainFormId_"+_pageRef);
    $.data(theform, 'changeTrack', true);
    theDialog.dialog("destroy");
    theDialog.remove();
}

function onOkBodyLang(theDialog)
{
	//validate the grid
	if(!OtherLanguagesBody_validateGrid())
	{
		return;
	}
	//get the data from the grid
	var rows = $("#otherLanguagesBodyGrid_Id_"+_pageRef).jqGrid('getAllRows');	
	
	$('#otherLanguagesBodyJson_' + _pageRef).val(rows);
    var theform = document.getElementById("individualEventMainFormId_"+_pageRef);
    $.data(theform, 'changeTrack', true);
    theDialog.dialog("destroy");
    theDialog.remove();
}

function onCancelLang(theDialog)
{
	var jsonAllRows = $("#otherLanguagesGrid_Id_"+_pageRef).jqGrid('getAllRows');
	var jsonStringUpdates = $("#otherLanguagesGrid_Id_"+_pageRef).jqGrid('getChangedRowData');
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
				        if(attrName1 == "otherLanguagesVO.LANG_CODE"&& attrValue1 == splitOtherLang[i].split(':')[1])
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

function onCancelBodyLang(theDialog)
{
	var jsonAllRows = $("#otherLanguagesBodyGrid_Id_"+_pageRef).jqGrid('getAllRows');
	var jsonStringUpdates = $("#otherLanguagesBodyGrid_Id_"+_pageRef).jqGrid('getChangedRowData');
	var changed;
	if(JSON.parse(jsonAllRows).root.length > 0 && $('#otherLanguagesBodyJson_' + _pageRef).val() != "")
	{
		if(JSON.parse(jsonAllRows).root.length == JSON.parse($('#otherLanguagesBodyJson_' + _pageRef)[0].value).root.length)
		{
			var jsonSaved = $('#otherLanguagesBodySavedJson_' + _pageRef).val();
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
				        if(attrName1 == "otherLanguagesVO.LANG_CODE"&& attrValue1 == splitOtherLang[i].split(':')[1])
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

function addJsonCustomDetails()
{
	var localJson = $('#otherLanguagesJson_' + _pageRef); //json from hidden field
	var jsonSaved = "";
	var count = 1;
	if(typeof localJson != "undefined" && localJson.val() != "")
	{
		var AllRows = localJson.val();
	    var AllRowsArray = JSON.parse(AllRows)["root"];

	    for (var i = 0; i < AllRowsArray.length; i++) 
		{
	    	obj = AllRowsArray[i];
	    	$("#otherLanguagesGrid_Id_" + _pageRef).jqGrid('addRowData', i, obj);	
	    	if(typeof obj.otherLanguagesVO =="undefined")
    		{
	    		jsonSaved = jsonSaved + "," + count+":"+ obj["otherLanguagesVO.LANG_CODE"];
    		}
	    	else
    		{
	    		jsonSaved = jsonSaved + "," + count+":"+ obj.otherLanguagesVO.LANG_CODE;
    		}
	    	count++;
		}
	    $('#otherLanguagesSavedJson_' + _pageRef).val(jsonSaved);
	}
}

function addJsonBodyCustomDetails()
{
	var localJson = $('#otherLanguagesBodyJson_' + _pageRef); //json from hidden field
	var jsonSaved = "";
	var count = 1;
	if(typeof localJson != "undefined" && localJson.val() != "")
	{
		var AllRows = localJson.val();
	    var AllRowsArray = JSON.parse(AllRows)["root"];

	    for (var i = 0; i < AllRowsArray.length; i++) 
		{
	    	obj = AllRowsArray[i];
	    	$("#otherLanguagesBodyGrid_Id_" + _pageRef).jqGrid('addRowData', i, obj);	
	    	if(typeof obj.otherLanguagesVO =="undefined")
    		{
	    		jsonSaved = jsonSaved + "," + count+":"+ obj["otherLanguagesVO.LANG_CODE"];
    		}
	    	else
    		{
	    		jsonSaved = jsonSaved + "," + count+":"+ obj.otherLanguagesVO.LANG_CODE;
    		}
	    	count++;
		}
	    $('#otherLanguagesBodySavedJson_' + _pageRef).val(jsonSaved);
	}
}

function alertTagsBodySelected() 
{
	var table = $("#alrtTags2_" + _pageRef);
	var selectedRowId = table.jqGrid('getGridParam', 'selrow');
	var id = table.jqGrid('getCell', selectedRowId, 'TAG_ID');

	var desc = table.jqGrid('getCell', selectedRowId, 'TAG_NAME');
	
	var otherLangBodyGridId = $("#otherLanguagesBodyGrid_Id_" + _pageRef);
	var selRow = otherLangBodyGridId.jqGrid("getGridParam", 'selrow');
	
	otherLangBodyGridId.jqGrid('setCellValue',selRow,'otherLanguagesVO.DESCRIPTION',otherLangBodyGridId.jqGrid ('getCell', selRow, 'otherLanguagesVO.DESCRIPTION') + desc);
}

function replaceTypeValue(rows){
	var fixedevtId = $("#fixedEventTypeId_" + _pageRef).val();
	if(rows!=undefined && rows!=null && (fixedevtId==1 || fixedevtId==8)){
		for(var i=0;i<rows.length;i++){
			if(rows[i].FIXED_CODE==1){				
				rows[i].FROM_VALUE = rows[i].FROM_VALUE3;
			}
		}
	}
	var rowdata = JSON.stringify(rows);
	if(rowdata != "")
	{
		//add root for json string
		rowdata  = "{"+ "\"root\":"+rowdata +"}";
	}
	return rowdata;
}

function checkVisibilityProtocolType()
{
	var mode = '';
	var jsonMode = $("#selEventMode_" + _pageRef).val();
	for (var i = 0; i < JSON.parse(jsonMode).root.length; i++)
	{
        var attrValue = JSON.parse(jsonMode).root[i];
        if(attrValue.VALUE_DESC.includes("Email"))
    	{
        	mode = 'E'; 
    	}
	}
	if(mode == 'E')
	{	
		var url = jQuery.contextPath
		+ "/path/alert/events/event/IndividualEventMaintAction_checkVisibilityProtocolType.action";
		var params = {};
		$.post(url, params, function(param) 
		{
			if (JSON.parse(param).alrtProtocolType == "SMTP") 
			{
				document.getElementById("emailTempTable_" + _pageRef).style.display = "inline";
			} 
			else 
			{
				document.getElementById("emailTempTable_" + _pageRef).style.display = "none";
			}
		}, "html");	
	}
	else
	{
		$("#lookuptxt_emailTempId_"+_pageRef).val(null);
		$("#emailTempDesc_"+_pageRef).val(null);
		document.getElementById("emailTempTable_" + _pageRef).style.display = "none";
		return;
	}
}

/**
 * open Report Dialog
 * @param communicationType
 * @returns
 */
function individualEventMaint_openReportDialog(communicationType)
{
	
	var eventReportId = $("#lookuptxt_eventDynamicEmailReportId_"+_pageRef).val();

	if(eventReportId != undefined && eventReportId != "")
	{
		individualEventMaint_openParameterDialog(communicationType, 'Report','');
		$("#parametersDialogStatus_"+_pageRef).val("Report");
	}
	else
	{
		_showErrorMsg(select_report_key, error_msg_title, 300,100);
	}
}

/**
 * return Attach report mapping parameters
 * @param communicationType
 * @returns
 */
function individualEventMaint_returnAttachReportMappingArguments(communicationType, eventId)
{
	var attchReportId = $("#lookuptxt_event"+communicationType+"StaticReportAttachmentId_"+_pageRef).val();
	if(communicationType == "Sms")
	{
		communicationType = "S";
	}
	else
		if(communicationType == "Email")
		{
			communicationType = "E";
		}
	else
		if(communicationType == "OmniInbox")
		{
			communicationType = "OI";
		}
	var url = jQuery.contextPath + "/path/alert/events/event/IndividualEventMaintAction_returnAttachReportMappingArguments";
	var reloadParams = {};
	reloadParams["individualEventSC.reportId"] = attchReportId;
	reloadParams["individualEventSC.emailCommunicationType"] = communicationType;
	reloadParams["individualEventSC.eventID"] = eventId;
	$.ajax({
		url : url,
		type : "post",
		dataType : "json",
		data : reloadParams,
		success : function(data)
		{
			
			if(communicationType == "S" && data.individualEventCO.eventStaticSmsStaticReportAttachmentDataHidden != undefined && 
					data.individualEventCO.eventStaticSmsStaticReportAttachmentDataHidden != "" )
			{
				$("#eventStaticSmsReportAttachmentArgumentsHiddenId_"+_pageRef).val(data.individualEventCO.eventStaticSmsStaticReportAttachmentDataHidden);
			}
			else
				if(communicationType == "E" && data.individualEventCO.eventStaticEmailStaticReportAttachmentDataHidden != undefined && 
						data.individualEventCO.eventStaticEmailStaticReportAttachmentDataHidden != "")
				{
					$("#eventStaticEmailReportAttachmentArgumentsHiddenId_"+_pageRef).val(data.individualEventCO.eventStaticEmailStaticReportAttachmentDataHidden);
				}
			else
				if(communicationType == "OI" && data.individualEventCO.eventStaticOmniInboxStaticReportAttachmentDataHidden != undefined && 
						data.individualEventCO.eventStaticOmniInboxStaticReportAttachmentDataHidden != "")
				{
					$("#eventStaticOmniInboxReportAttachmentArgumentsHiddenId_"+_pageRef).val(data.individualEventCO.eventStaticOmniInboxStaticReportAttachmentDataHidden);
				}
		}
	});
}

/**
 * open Query Dialog
 * @param communicationType
 * @returns
 */
function individualEventMaint_openQueryDialog(communicationType)
{
	var eventQueryId = $("#lookuptxt_eventStatic"+communicationType+"QueryId_"+_pageRef).val();
	if(eventQueryId != undefined && eventQueryId != "")
	{
		individualEventMaint_openParameterDialog(communicationType, 'Query','');
		$("#parametersDialogStatus_"+_pageRef).val("Query");
	}
	else
	{
		_showErrorMsg(select_query_key, error_msg_title, 300,100);
	}
}

/**
 * Open Dialog
 * @param communicationType
 * @param templateType
 * @returns
 */
function individualEventMaint_openParameterDialog(communicationType, templateType, fromScreen) 
{
	var eventId = $("#eventId_"+_pageRef).val();
	var	openEventFilterPopup = $("<div id='open"+templateType+communicationType+"ParameterPopup_"+_pageRef+"' class='path-common-sceen'></div>");
	openEventFilterPopup.css("padding","0");
	openEventFilterPopup.insertAfter($('body'));
	var _dialogOptions = {
		modal:true, 
		title:"Parameters",
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
			       individualEventMaint_okParameterDialog(theDialog, communicationType, templateType, fromScreen)	 
			},
			Cancel: function()
			{
				var theDialog = $(this);
			    individualEventMaint_cancelParameterDialog(theDialog);
			}
	    },
	    position:'center', 
	};
	var ivCrud = $("#iv_crud_" + _pageRef).val();

	mySrc = jQuery.contextPath+ "/path/alert/events/event/IndividualEventMaintAction_returnIndividualEventQueryParamDialog.action?_pageRef="+_pageRef+"&iv_crud="+ivCrud;
	$('#open'+templateType+communicationType+'ParameterPopup_' + _pageRef).load(mySrc, {}, function() {
	
	var mappingArguments = $('#eventStatic'+communicationType+templateType+"ArgumentsHiddenId_" + _pageRef).val();
		
	if(eventId != "" && eventId != undefined && mappingArguments == "")
	{
		individualEventMaint_returnReportQueryMappingArguments(communicationType, eventId, '', templateType);
	}
	else
	{
		individualEvents_loadParmaterGrid(communicationType, templateType, fromScreen,'');
	}
	$("#communicationType_"+_pageRef).val(communicationType);
		
	});
	$('#open'+templateType+communicationType+'ParameterPopup_' +_pageRef).dialog(_dialogOptions);
	$('#open'+templateType+communicationType+'ParameterPopup_' + _pageRef).dialog('open');
	
}

/**
 * while click ok button of parameter dialog
 * @param dialogId
 * @param communicationType
 * @param templateType
 * @returns
 */
function individualEventMaint_okParameterDialog(dialogId, communicationType, templateType, fromScreen)
{
	//check this dialog has opened from Report Attachment Dialog
	if(fromScreen != undefined && fromScreen == "RAD")
	{
		var rows = $("#eventArgumentGridId_"+_pageRef).jqGrid('getAllRows');
		var $table = $("#eventStaticReportAttachmentGridId_" + _pageRef);
		var selectedRowId = $table.jqGrid('getGridParam', 'selrow');
		$table.jqGrid('setCellValue',selectedRowId,'reportAttachmentParameterMappings',rows);
	}
	//this will execute while click ok button from parameter dialog opened from form query and report parameters
	else
	{
		var rows = $("#eventArgumentGridId_"+_pageRef).jqGrid('getAllRows');
		$('#eventStatic'+communicationType+templateType+"ArgumentsHiddenId_" + _pageRef).val(rows);		
	}
	var theform = document.getElementById("individualEventMainFormId_"+ _pageRef);
	$.data(theform, 'changeTrack', true);
	dialogId.dialog("destroy");
	dialogId.remove();
}

/**
 * while click cancel button of parameter dialog
 * @param dialogId
 * @returns
 */
function individualEventMaint_cancelParameterDialog(dialogId)
{
	dialogId.dialog("destroy");
	dialogId.remove();
}

/**
 * return Attach report mapping parameters
 * @param communicationType
 * @returns
 */
function individualEventMaint_returnReportQueryMappingArguments(communicationType, eventId, selectedRow, lookupOf)
{
	
	if(lookupOf == "RA")
	{
		reportId = $("#lookuptxt_event"+communicationType+"StaticReportAttachmentId_"+selectedRow+"_"+_pageRef).val();
	}
	else if(lookupOf == "Query")
	{
		reportId = $("#lookuptxt_eventStatic"+communicationType+"QueryId_"+_pageRef).val();
	}
	else
	{
		reportId = $("#lookuptxt_eventDynamic"+communicationType+"ReportId_"+_pageRef).val();
	}
	
	var commType = "";
	if(communicationType == "Sms")
	{
		commType = "S";
	}
	else
		if(communicationType == "Email")
		{
			commType = "E";
		}
	else
		if(communicationType == "OmniInbox")
		{
			commType = "OI";
		}
	var url = jQuery.contextPath + "/path/alert/events/event/IndividualEventMaintAction_returnAttachReportMappingArguments";
	var reloadParams = {};
	reloadParams["individualEventSC.reportId"] = reportId;
	reloadParams["individualEventSC.emailCommunicationType"] = commType;
	reloadParams["individualEventSC.eventID"] = eventId;
	reloadParams["individualEventSC.lookupOf"] = lookupOf;
	$.ajax({
		url : url,
		type : "post",
		dataType : "json",
		data : reloadParams,
		success : function(data)
		{
			if(lookupOf == "RA")
			{
				if(data.individualEventCO.eventStaticEmailStaticReportAttachmentDataHidden != undefined && 
						data.individualEventCO.eventStaticEmailStaticReportAttachmentDataHidden != "")
				{
					$("#eventStatic"+communicationType+"ReportAttachmentArgumentsHiddenId_"+selectedRow+"_"+_pageRef).val(data.individualEventCO.eventStaticEmailStaticReportAttachmentDataHidden);
				}
				else
					if(data.individualEventCO.eventStaticOmniInboxStaticReportAttachmentDataHidden != undefined && 
							data.individualEventCO.eventStaticOmniInboxStaticReportAttachmentDataHidden != "")
					{
						$("#eventStatic"+communicationType+"ReportAttachmentArgumentsHiddenId_"+selectedRow+"_"+_pageRef).val(data.individualEventCO.eventStaticOmniInboxStaticReportAttachmentDataHidden);
					   
					}
				individualEvents_loadParmaterGrid(communicationType, "", "RAD", selectedRow);
				
			}
			else if(lookupOf == "Query")
			{
				var queryMappingArguments = "";
				if(communicationType == "Email")
				{
					if(data.individualEventCO.emailQueryParameterListJson != undefined && 
							data.individualEventCO.emailQueryParameterListJson != "")
					{
						queryMappingArguments = data.individualEventCO.emailQueryParameterListJson;
					}
				}
				else
					if(communicationType == "Sms")
					{
						if(data.individualEventCO.smsQueryParameterListJson != undefined && 
								data.individualEventCO.smsQueryParameterListJson != "")
						{
							queryMappingArguments = data.individualEventCO.smsQueryParameterListJson;
						}
					}
				else
					if(communicationType == "OmniInbox")
					{
						if(data.individualEventCO.omniInboxQueryParameterListJson != undefined && 
								data.individualEventCO.omniInboxQueryParameterListJson != "")
						{
							queryMappingArguments = data.individualEventCO.omniInboxQueryParameterListJson;
						}
					}
					$("#eventStatic"+communicationType+"QueryArgumentsHiddenId_"+_pageRef).val(queryMappingArguments);
					individualEvents_loadParmaterGrid(communicationType, lookupOf, '','');
			}
			else
			{
				var reportMappingArguments = "";
				if(communicationType == "Email")
				{
					if(data.individualEventCO.emailReportParameterListJson != undefined && 
							data.individualEventCO.emailReportParameterListJson != "")
					{
						reportMappingArguments = data.individualEventCO.emailReportParameterListJson;
					}
				}
				$("#eventStatic"+communicationType+"ReportArgumentsHiddenId_"+_pageRef).val(reportMappingArguments);
				individualEvents_loadParmaterGrid(communicationType, lookupOf, '','');
			}
		}
	});
}

/**
 * 
 * @param communicationType
 * @param templateType
 * @returns
 */
function individualEvents_loadParmaterGrid(communicationType, templateType, fromScreen,selectedRow)
{
	//eventStaticEmailReportArgumentsHiddenId
	var queryParamtersJson = "";
	var attachedReportId = "";
	/**
	 * if condition will be executed while open param dialog from report attachment Grid
	 */
	if(fromScreen != "" && fromScreen == "RAD")
	{
		queryParamtersJson = $("#eventStatic"+communicationType+"ReportAttachmentArgumentsHiddenId_"+selectedRow+"_"+_pageRef).val();
		//lookuptxt_eventEmailStaticReportAttachmentId_1
		attachedReportId = $("#lookuptxt_event"+communicationType+"StaticReportAttachmentId_"+selectedRow+"_"+_pageRef).val();
	}
	/**
	 * this else will be executed while open param dialog from form parameter button of query and report
	 */
	else
	{
		queryParamtersJson = $("#eventStatic"+communicationType+templateType+"ArgumentsHiddenId_"+_pageRef).val();
	}
	var jsonSaved = "";
	var count = 1;
	
	if(typeof queryParamtersJson != "undefined" && queryParamtersJson != "")
	{
		jQuery('#eventArgumentGridId_' +_pageRef).jqGrid('clearGridData');
		var allRows = queryParamtersJson;
	    var allRowsArray = JSON.parse(allRows)["root"];
	    for (var i = 0; i < allRowsArray.length; i++) 
		{
	    	var data = {};
	    	var rowId = "new_"+(new Date()).getTime()+i;
	    	obj = allRowsArray[i];
	    	data['ARG_NAME'] =  obj.ARG_NAME;
	    	if(obj.MAPPING_TAG_NAME != undefined )
	    	{
	    		if(obj.MAPPING_TAG_NAME == "0")
	    		{
	    			obj.MAPPING_TAG_NAME = ""
	    		}
	    		data['MAPPING_TAG_NAME'] =  obj.MAPPING_TAG_NAME;
	    	}
	    	
	    	if(obj.MAPPING_VALUE != undefined)
	    	{
	    		if(obj.MAPPING_VALUE == "0")
	    		{
	    			obj.MAPPING_VALUE = ""
	    		}
	    		data['MAPPING_VALUE'] =  obj.MAPPING_VALUE;
	    	}
	    	
	    	if(obj.ID != undefined)
	    	{
	    		data['ID'] =  obj.ID;
	    	}
	    	else
	    	{
	    		data['ID'] = "";
	    	}
	    	
	    	if(attachedReportId != undefined)
	    	{
	    		data['ATTACH_REPORT_ID'] =  attachedReportId;
	    	}
	    	else
	    	{
	    		data['ATTACH_REPORT_ID'] = "";
	    	}
	    	
	    	$("#eventArgumentGridId_" + _pageRef).jqGrid('addRowData', rowId, data);	
		}
	}
}

/**
 * 
 * @returns
 */
function individualEvent_changeEventType()
{
	var evtType = $("#event_type_" + _pageRef).val();
	
	if(evtType == "D")
	{
		$(".eventFixed").hide();
		$(".eventDynamic").show();
	}
	else if(evtType == "F")
	{
		$(".eventDynamic").hide();
		$(".eventFixed").show();
	}
}

/**
 * 
 * @returns
 */
function reportStaticSectionHideShow()
{
	var sectionVal = $('#messageBodyOptionList_'+_pageRef).val();
	if(sectionVal != undefined && sectionVal == "D")
	{
		 $("#reportOptionDiv_id_"+_pageRef).show();
		 $("#staticOptionDiv_id_"+_pageRef).hide();
		 individualEvent_clearStaticAndDynamicFields();
	}
	else  if(sectionVal != undefined && sectionVal == "S")
	{
		 $("#staticOptionDiv_id_"+_pageRef).show();
		 $("#reportOptionDiv_id_"+_pageRef).hide();
		 individualEvent_clearStaticAndDynamicFields();
	}
}

/**
 * 
 * @returns
 */
function individualEvent_clearStaticAndDynamicFields()
{
	$("#eventQueryId_"+_pageRef).val("");
	$("#eventDynamicEmailMessageDetailsTemp_"+_pageRef).val("");
	$("#eventStaticEmailParamMappingGridDataHidden_"+_pageRef).val("");
	$("#eventStaticEmailParamMappingGridDataHidden_"+_pageRef).val("");
	$("#eventStaticEmailQueryArgumentsHiddenId_"+_pageRef).val("");
	$("#eventStaticEmailQueryColumnsHiddenId_"+_pageRef).val("");
	$("#eventStaticEmailReportArgumentsHiddenId_"+_pageRef).val("");
	$("#eventStaticEmailMessageDefaultSubjectHiddenId_"+_pageRef).val("");
	$("#eventStaticEmailMessageDefaultBodyHiddenId_"+_pageRef).val("");
	$("#eventStaticEmailMessageARHiddenId_"+_pageRef).val("");
	$("#eventStaticEmailMessageENHiddenId_"+_pageRef).val("");
	$("#eventStaticEmailMessageFRHiddenId_"+_pageRef).val("");
	$("#eventStaticEmailMessageFAHiddenId_"+_pageRef).val("");
	$("#eventStaticEmailMessageRUHiddenId_"+_pageRef).val("");
	$("#eventStaticEmailMessageTKHiddenId_"+_pageRef).val("");
	
	$("#eventDynamicEmailMessageSubjectEng_"+_pageRef).val("");
	$("#lookuptxt_eventDynamicEmailReportId_"+_pageRef).val("");
	//$("#eventStaticSmsMessageSubjectEng_"+_pageRef).val("");
	$("#eventDynamicEmailReportBriefDescEng_"+_pageRef).val("");
	$("#eventStaticEmailOtherLanguage_"+_pageRef).val("");
	$("#eventStaticEmailMessageSubjectEng_"+_pageRef).val("");
	$("#lookuptxt_eventStaticEmailQueryId_"+_pageRef).val("");
	$("#eventStaticEmailQueryBriefDescEng_"+_pageRef).val("");
	$("#eventStaticEmailMessageBodyEng_"+_pageRef).val("");
	
	$("#eventEmailStaticQueryTagsGridId_"+ _pageRef).trigger("reloadGrid");
}

/**
 * 
 * @returns
 */
function reLoad()
{
	var queryId = $("#eventQueryHiddenId_"+_pageRef).val();
	
	var url = jQuery.contextPath+ '/path/alert/events/event/IndividualEventGridAction_loadEventsQueryArgumentGrid?_pageRef='+_pageRef+'&individualEventSC.queryId='+queryId;
	$("#eventQueryArgumentGridId_"+ _pageRef).jqGrid('setGridParam', { url: url });
	$("#eventQueryArgumentGridId_"+ _pageRef).trigger("reloadGrid");
}

/**
 * 
 * @returns
 */
function getComboDetails()
{
    return loadCombo(jQuery.contextPath+'/path/alert/events/event/IndividualEventMaintAction_fillMappingtCustomDefaultTagTagsDropDown.action',
			'alrtTagsCOList',
			'tagName',
			'tagName');
}

/**
 * 
 * @param checkBoxId
 * @param mainCollapsibleDivId
 * @param innerCollapsibleDivId
 * @returns
 */
function individualEvents_activateCommunicationMode(checkBoxId, mainCollapsibleDivId, innerCollapsibleDivId)
{
	if($("#"+checkBoxId+"_"+_pageRef). prop("checked") == true)
	{
		$("#"+innerCollapsibleDivId+"_"+_pageRef+" .collapsibleContainerContent").css("display","block");
		$("#"+mainCollapsibleDivId+"_"+_pageRef).removeClass("div-disable");
	}
    else if($("#"+checkBoxId+"_"+_pageRef). prop("checked") == false)
    {
    	$("#"+innerCollapsibleDivId+"_"+_pageRef+" .collapsibleContainerContent").css("display","none");
    	$("#"+mainCollapsibleDivId+"_"+_pageRef).addClass("div-disable");
    }
}

/**
 * 
 * @param componentId
 * @returns
 */
function individualEventMaint_getPreviousLang(componentId)
{
	var languageCode = $("#eventStatic"+componentId+"OtherLanguage_"+_pageRef).val();
	$("#eventStatic"+componentId+"OtherLanguageHidden_"+_pageRef).val(languageCode);
}

/**
 * 
 * @param communicationType
 * @param componentId
 * @returns
 */
function individualEventMaint_setStaticMessage(communicationType, componentId)
{
	var languageCode = $("#eventStatic"+componentId+"OtherLanguage_"+_pageRef).val();
	
	/**
	 * set Subject and Body fields behavior
	 * according to language
	 */
	individualEvents_setFieldsBehavior(languageCode, componentId);
	
	
	var messageSubject = $("#eventStatic"+componentId+"MessageSubjectEng_"+_pageRef).val();
	var messageBody = $("#eventStatic"+componentId+"MessageBodyEng_"+_pageRef).val();
	var languageHiddenCode = $("#eventStatic"+componentId+"OtherLanguageHidden_"+_pageRef).val();
	
	$("#eventStatic"+componentId+"OtherLanguageHidden_"+_pageRef).val(languageCode);
	messageSubject = messageSubject == undefined  || messageSubject == "" ? "-" : messageSubject;
	var messageData = "";
	if(messageSubject != "")
	{
		messageBody = messageBody != undefined && messageBody != "" ? messageBody : "-";
		messageData = communicationType+"<-->"+languageHiddenCode+"<-->"+messageSubject+"<-->"+messageBody;
	}
	var isDefault = false;
	if(languageHiddenCode == "DF")
	{
		$("#eventStatic"+componentId+"MessageDefaultSubjectHiddenId_"+_pageRef).val(messageSubject == undefined ? "" : messageSubject);
		$("#eventStatic"+componentId+"MessageDefaultBodyHiddenId_"+_pageRef).val(messageBody == undefined ? "" : messageBody);
		individualEvents_clearStaticMessage(componentId);
	} else
		if(languageCode == "DF")
		{
			var oldMessageSubject = $("#eventStatic"+componentId+"MessageDefaultSubjectHiddenId_"+_pageRef).val();
			var oldMessageBody = $("#eventStatic"+componentId+"MessageDefaultBodyHiddenId_"+_pageRef).val();
			
			$("#eventStatic"+componentId+"MessageSubjectEng_"+_pageRef).val(oldMessageSubject == undefined || oldMessageSubject == "-"  ? "" : oldMessageSubject);
			$("#eventStatic"+componentId+"MessageBodyEng_"+_pageRef).val(oldMessageBody == undefined || oldMessageBody == "-" ? "" : oldMessageBody);
			isDefault = true;
		}

	/*if(languageHiddenCode != "DF" && languageCode != "DF")
	{*/
		var oldLanguageData = $("#eventStatic"+componentId+"Message"+languageCode+"HiddenId_"+_pageRef).val();
		
		$("#eventStatic"+componentId+"Message"+languageHiddenCode+"HiddenId_"+_pageRef).val(messageData);
		
		if(oldLanguageData != undefined && oldLanguageData != "")
		{
			var data = oldLanguageData.split("<-->");
			$("#eventStatic"+componentId+"MessageSubjectEng_"+_pageRef).val(data[2] == "-" || data[2] == undefined ? "" : data[2]);
			$("#eventStatic"+componentId+"MessageBodyEng_"+_pageRef).val(data[3] == "-" || data[3] == undefined ? "" : data[3]);
			isDefault = true;
		}
		
		if(isDefault == false)
		{
			$("#eventStatic"+componentId+"MessageSubjectEng_"+_pageRef).val("");
			$("#eventStatic"+componentId+"MessageBodyEng_"+_pageRef).val("");
		}
		
		
	//}
	//eventStaticEmailMessageARHiddenId_
}

/**
 * set subject and body field behavior according to language selected from dropdown
 * @param languageCode
 * @param componentId
 * @returns
 */
function individualEvents_setFieldsBehavior(languageCode, componentId)
{
	/**
	 * Change input behavior according to language
	 */
	if(languageCode == 'AR')
	{
		/**
		 * bind on keydown event for arabic and alignment right to left
		 */
		$("#eventStatic"+componentId+"MessageSubjectEng_"+_pageRef ).css("direction","rtl");
		$("#eventStatic"+componentId+"MessageBodyEng_"+_pageRef ).css("direction","rtl");
		
		$("#eventStatic"+componentId+"MessageSubjectEng_"+_pageRef ).bind('keydown',function(event){arabicCharOnly(event)});
		$("#eventStatic"+componentId+"MessageBodyEng_"+_pageRef ).bind('keydown',function(event){arabicCharOnly(event)});
		
		
	}
	else
	{
		/**
		 * reset the alignement
		 * un bind the keydown event from subject and body field
		 */
		$("#eventStatic"+componentId+"MessageSubjectEng_"+_pageRef ).css("direction","");
		$("#eventStatic"+componentId+"MessageBodyEng_"+_pageRef ).css("direction","");
		
		$("#eventStatic"+componentId+"MessageSubjectEng_"+_pageRef ).unbind("keydown");
		$("#eventStatic"+componentId+"MessageBodyEng_"+_pageRef ).unbind("keydown");
		
		/**
		 * bind show expression function with body text area
		 */
		$("#eventStatic"+componentId+"MessageBodyEng_"+_pageRef ).bind('keydown',function(event){fixEventdetails_expressionShowHideData(event)});
		
	}
}



/**
 * 
 * @param componentId
 * @param languageCode
 * @param data
 * @returns
 */
function individualEvents_setStaticMessageData(componentId, languageCode, data)
{
	if(data != undefined && data != "")
	{
		var previousMessageData = data.split(",");
		for(var i=0; i<previousMessageData.length; i++)
		{
			for(var j=0; j<previousMessageData[i].length; j++)
			{
				var staticMessage = previousMessageData[j].split(":");
				if(languageCode == staticMessage[1])
				{
					$("#eventStatic"+componentId+"OtherLanguage_"+_pageRef).val(staticMessage[1]);
					$("#eventStatic"+componentId+"MessageSubjectEng_"+_pageRef).val(staticMessage[2]);
					$("#eventStatic"+componentId+"MessageBodyEng_"+_pageRef).val(staticMessage[3] == "-" || staticMessage[3] == undefined ? "" : staticMessage[3]);
					return false;
					break;
				}
			}
		}
	}
}

/**
 * 
 * @param componentId
 * @returns
 */
function individualEvents_clearStaticMessage(componentId)
{
	//$("#eventStatic"+componentId+"OtherLanguage_"+_pageRef).val("");
	$("#eventStatic"+componentId+"MessageSubjectEng_"+_pageRef).val("");
	$("#eventStatic"+componentId+"MessageBodyEng_"+_pageRef).val("");
}

/**
 * parse query Columns from hidden json
 * @returns
 */
function individualEvents_returnQueryColumnsByQueryId(communicationType)
{
	$('#event'+communicationType+'StaticQueryTagsGridId_'+_pageRef).jqGrid('clearGridData');
	var queryColumnsJson = $("#eventStatic"+communicationType+"QueryColumnsHiddenId_"+_pageRef).val();
	var jsonSaved = "";
	var count = 1;
	
	if(typeof queryColumnsJson != "undefined" && queryColumnsJson != "")
	{
		$('#trBatchTypeOption_'+_pageRef).show();
		$('#eventBatchStaticQueryTagsDivId_'+_pageRef).show();
		$('#event'+communicationType+'StaticQueryTagsGridId_'+_pageRef).jqGrid('clearGridData');
		var allRows = queryColumnsJson;
	    var allRowsArray = JSON.parse(allRows)["root"];
	    if(communicationType == "Batch")
    	{
    		$("#batchType_option_"+_pageRef).empty();
    	}
	    for (var i = 0; i < allRowsArray.length; i++) 
		{
	    	var data = {};
	    	var rowId = "new_"+(new Date()).getTime()+i;
	    	obj = allRowsArray[i];
	    	data['COLUMN_NAME'] =  obj.FIELD_ALIAS;
	    	$('#event'+communicationType+'StaticQueryTagsGridId_'+_pageRef).jqGrid('addRowData', rowId, data);	
	    	if(communicationType == "Batch")
	    	{
	    		$('#batchType_option_'+_pageRef).append($('<option>'+data['COLUMN_NAME']+'</option>').val(data['COLUMN_NAME']));
	    	}
		}
	    if(communicationType == "Batch" && ($('#queryOptionBatchType_'+_pageRef).val() != null || $('#queryOptionBatchType_'+_pageRef).val() != ""))
	    {
	    	$('#batchType_option_'+_pageRef).val($('#queryOptionBatchType_'+_pageRef).val());
	    }
	}
	else
	{
		if(communicationType == "Batch" && typeof $('#eventStaticBatchQueryId_'+_pageRef).val() == "undefined")
		{
    		$('#trBatchTypeOption_'+_pageRef).hide();
//    		$('#eventBatchStaticQueryTagsDivId_'+_pageRef).hide();
		}
	}	
}

/**
 * enable and disable static value cell
 * @returns
 */
function individualEventMaint_enableAndDisableStaticValueColumn()
{
	var $table = $("#eventArgumentGridId_" + _pageRef);
	var selectedRowId = $table.jqGrid('getGridParam', 'selrow');
	var myObject = $table.jqGrid('getRowData', selectedRowId);
	var mappingTagName = myObject["MAPPING_TAG_NAME"];
	
	var checkDisable = $("#_recReadOnly_"+_pageRef).val();
	if(checkDisable == "true")
	{
		$table.jqGrid("setCellReadOnly",selectedRowId,"MAPPING_VALUE",true);
		$table.jqGrid("setCellReadOnly",selectedRowId,"MAPPING_TAG_NAME",true);
	}
	else
	{
		if(mappingTagName != "" && mappingTagName != undefined)
		{
			 if(mappingTagName == '' || mappingTagName == 'Select Tag' || mappingTagName == '0')
			 {
			  	$table.jqGrid("setCellReadOnly",selectedRowId,"MAPPING_VALUE",false);
			 }
			 else
			 {
			  	$table.jqGrid("setCellReadOnly",selectedRowId,"MAPPING_VALUE",true);
			  	$table.jqGrid('setCellValue',selectedRowId,'MAPPING_VALUE',"");
			 }
		}
	}
	
	/**
	 * While selecting any row of parameter Mapping gird  
	 * in Query, Report mapping dialog
	 * The record related to the 
	 * QUERY.tagName , CUSTOM.tagName , BATCH.tagName has removed from select
	 * so we have add every item in hidden column and while selecting row
	 * after populating the select the hidden field record will be set in select
	 */
	if(mappingTagName != "" && mappingTagName != undefined )
	{
		if(mappingTagName != '' && mappingTagName != 'Select Tag' && mappingTagName != '0')
		 {
			$table.jqGrid('setCellValue',selectedRowId,'MAPPING_VALUE_HIDDEN',mappingTagName);
		 }
	}
}

/**
 * 
 * @param zUrl
 * @param zList
 * @param zId
 * @param zValue
 * @returns
 */
function individualEventMaint_loadTagsCombo(zUrl, zList, zId, zValue) {
	var reloadParams = {};
	var list = {};
	if(typeof $("#openQueryBatchParameterPopup_"+ _pageRef).val() == "undefined")
	{
		reloadParams["individualEventSC.eventType"] = "Others";
	}	
	else
	{
		reloadParams["individualEventSC.eventType"] = "B";
	}	
	$.ajax( {
		url : zUrl,
		async : false,
		dataType : 'json',
		data : reloadParams,
		success : function(data) {
			 data = JSON.parse(JSON.stringify(data[zList]));
             for(var i=0; i<data.length; i++)
              {
                    var key = data[i][zId];
                    if(typeof key == "undefined") //no id for select box
                    	key = "";
                    var value = data[i][zValue]
                    list[key] = value;
              }
             list[0] = ""
		}
	});
	return list;
}

/**
 * Add New Row in Customn Grid
 * @returns
 */
function individualEvents_addNewCustomTagRow(communicationType)
{
	var isEmpty = individualEvents_validateCustomnTags(communicationType);
	if(isEmpty != true)
	{
		$("#event"+communicationType+"StaticCustomTagsGridId_" + _pageRef).jqGrid('addInlineRow',{'IS_NEW':'N'});
	}
	else
	{
		_showErrorMsg(fill_empty_tag_key, error_msg_title, 300,100);
		return true;
	}
}

/**
 * validate custom tags
 * @param communicationType
 * @returns
 */
function individualEvents_validateCustomnTags(communicationType)
{
	var tagName = $("#event"+communicationType+"StaticCustomTagsGridId_" + _pageRef).jqGrid('getCol','TAG_NAME');
    for (var i=0; i<tagName.length; i++)
    {
    	if(tagName[i] == "" || tagName[i] == undefined)
    	{
    		return true
    		break;
    	}
    }
}

/**
 * Delete New Row in Customn Grid
 * @returns
 */
function individualEvents_deleteNewCustomTagRow(communicationType)
{
	var table = $("#event"+communicationType+"StaticCustomTagsGridId_" + _pageRef);
	var selectedRowId = table.jqGrid('getGridParam', 'selrow');
	var tagName = table.jqGrid('getCell', selectedRowId, 'TAG_NAME');
	individualEvents_deleteCustomTagsfromBody(tagName);
	
	$("#event"+communicationType+"StaticCustomTagsGridId_" + _pageRef).jqGrid('deleteGridRow');
}

/**
 * remove Tags from all communications mode body
 * @param communicationType
 * @returns
 */
function individualEvents_deleteCustomTagsfromBody(customTag)
{
	var emailHiddenData = $('[id*=eventStaticEmailMessage]');
	var smsHiddenData = $('[id*=eventStaticSmsMessage]');
	var omniInboxHiddenData = $('[id*=eventStaticOmniInboxMessage]');
	
	var isEmailActivate = $("#communicationModeEmail_"+_pageRef). prop("checked");
	var isSmsActivate = $("#communicationModeSms_"+_pageRef). prop("checked");
	var isOmniActivate = $("#communicationModeOmniInbox_"+_pageRef). prop("checked");
	
	//remove email custom tags from body while a tag has deleted
	if(isEmailActivate)
	{
		for(var i=0; i<emailHiddenData.length; i++)
		{
			var emailData = $("#"+emailHiddenData[i].id).val();
			if(typeof emailData != "undefined" && emailData.indexOf("<CUSTOM."+customTag+">") > -1)
			{
				emailData = emailData.replace(new RegExp('<CUSTOM.'+customTag+'>', 'g'), "");
				$("#"+emailHiddenData[i].id).val(emailData);
			}
		}
	}
	
	//remove sms custom tags from body while a tag has deleted
	if(isSmsActivate)
	{
		
		for(var i=0; i<smsHiddenData.length; i++)
		{
			var smsData = $("#"+smsHiddenData[i].id).val();
			if(typeof smsData != "undefined" && smsData.indexOf("<CUSTOM."+customTag+">") > -1)
			{
				smsData = smsData.replace(new RegExp('<CUSTOM.'+customTag+'>', 'g'), "");
				$("#"+smsHiddenData[i].id).val(smsData);
			}
		}
	}
	
	//remove omni inbox custom tags from body while a tag has deleted
	if(isOmniActivate)
	{
		for(var i=0; i<omniInboxHiddenData.length; i++)
		{
			var omniInboxData = $("#"+omniInboxHiddenData[i].id).val();
			if(typeof omniInboxData != "undefined" && omniInboxData.indexOf("<CUSTOM."+customTag+">") > -1)
			{
				omniInboxData = omniInboxData.replace(new RegExp('<CUSTOM.'+customTag+'>', 'g'), "");
				$("#"+omniInboxHiddenData[i].id).val(omniInboxData);
			}
		}
	}
}


/**
 * 
 * @returns
 */
function showHideBatchGrid()
{
	var evtType = $("#eventType_" + _pageRef).val();
	var eventId = $("#eventId_" + _pageRef).val();
	if (evtType == "B")
	{
		//reset fix event
		$("#fixedEventTypeId_"+_pageRef).val("");
		$("#updateCustomExpression_"+_pageRef).val("");
		
//		$("#briefdesceng_"+_pageRef).val("");
//		$("#expressionId_"+_pageRef).val("");
		//clear fixedParam grid
		$("#fixedParam_"+_pageRef).jqGrid('clearGridData');
		
		$("#batchDiv_"+_pageRef).show();
		$("#fixEventDiv_"+_pageRef).hide();
		$('#trBatchTypeOption_'+_pageRef).hide();
//		$('#eventBatchStaticQueryTagsDivId_'+_pageRef).hide();
		$("#batchDiv_"+_pageRef+" .collapsibleContainerContent").css("display","block");
		$("#batchDiv_"+_pageRef).removeClass("div-disable");
	}
	else if(evtType == "F")
	{
		//reset batch
		$("#lookuptxt_eventStaticBatchQueryId_"+_pageRef).val("");
		$("#eventStaticBatchQueryBriefDescEng_"+_pageRef).val("");
		$("#subscriberType_option_"+_pageRef).val("A");
		$("#eventStaticBatchQueryArgumentsHiddenId_"+_pageRef).val("");
		$("#eventStaticBatchQueryColumnsHiddenId_"+_pageRef).val("");
		//empty batch type option dropdown list
		$("#batchType_option_"+_pageRef).empty();
		//clear tag name grid
		$("#fixedEventTagsGridId_"+_pageRef).jqGrid('clearGridData');
		
		$("#batchDiv_"+_pageRef).hide();
		$("#fixEventDiv_"+_pageRef).show();
		$("#fixEventDiv_"+_pageRef+" .collapsibleContainerContent").css("display","block");
		$("#fixEventDiv_"+_pageRef).removeClass("div-disable");
		
	}
	else
	{
		//reset batch
		$("#lookuptxt_eventStaticBatchQueryId_"+_pageRef).val("");
		$("#eventStaticBatchQueryBriefDescEng_"+_pageRef).val("");
		$("#subscriberType_option_"+_pageRef).val("A");
		$("#eventStaticBatchQueryArgumentsHiddenId_"+_pageRef).val("");
		$("#eventStaticBatchQueryColumnsHiddenId_"+_pageRef).val("");
		//empty batch type option dropdown list
		$("#batchType_option_"+_pageRef).empty();
		//clear tag name grid
		$("#eventBatchStaticQueryTagsGridId_"+_pageRef).jqGrid('clearGridData');
		
		//reset fix event
		$("#fixedEventTypeId_"+_pageRef).val("");
		$("#updateCustomExpression_"+_pageRef).val("");
		//clear fixedParam grid
		$("#fixedParam_"+_pageRef).jqGrid('clearGridData');
		$("#eventEmailStaticFixedEvtTagsGridId_"+_pageRef).jqGrid('clearGridData');
		
		$("#batchDiv_"+_pageRef).hide();
		$("#fixEventDiv_"+_pageRef).hide();
	}	
	
	if(eventId == "" || eventId == null)
	{
		//reload source of contact dropdown according to event type
		individualEventMaint_retrieveSourceOfContactsDropdown();
	}
	
}

/**
 * 
 * @param communicationType
 * @param numOfChar
 * @returns
 */
function individualEventMaint_setRemainingCharachter(communicationType, numOfChar)
{
	var id = $("#eventStatic"+communicationType+"MessageBodyEng_"+_pageRef);
	var $remaining = $('#'+communicationType+'Remaining_'+_pageRef);
	var text_length = id.val().length;
    var text_remaining = numOfChar - text_length;
    if(text_remaining < 0)
    {
    	text_remaining = 0;
    }
    $remaining.text(text_remaining + ' Characters Remaining');
}

/**
 * 
 * @param lookupOf
 * @returns
 */
function individualEvents_validateReportsId(lookupOf)
{
	var attachReportId = $("#lookuptxt_eventEmailStaticReportAttachmentId_"+_pageRef).val();
	var reportId = $("#lookuptxt_eventDynamicEmailReportId_"+_pageRef).val();
	
	if(attachReportId != "" && reportId != "")
	{
		if(attachReportId == reportId)
		{
			if(lookupOf == "Report")
			{
				$("#lookuptxt_eventDynamicEmailReportId_"+_pageRef).val("");
				$("#eventDynamicEmailReportBriefDescEng_"+_pageRef).val("");
				$("#eventDynamicEmailReportHiddenId_"+_pageRef).val("");
			}
			else
			{
				$("#lookuptxt_eventEmailStaticReportAttachmentId_"+_pageRef).val("");
				$("#eveventEmailStaticReportAttachmentBriefDescEng_"+_pageRef).val("");
			}
			_showErrorMsg(duplicate_entry_report_report_key, error_msg_title, 300,100);
		}
		
	}
	
	if(lookupOf == "Report")
	{
		jQuery('#eventEmailStaticQueryTagsGridId_' +_pageRef).jqGrid('clearGridData');
	}
}

/**
 * add Custom and fixed tags
 * @returns
 */
function individualEvents_addCustomnAndFixedTags()
{
	var Tbl = $("#eventArgumentGridId_" + _pageRef);
    var selRowId= Tbl.jqGrid('getGridParam','selrow');
    var tagsDropdown = $("#"+selRowId+"_MAPPING_TAG_NAME");
    
    //retrive tags from custom grid
	var tagName = $("#eventEmailStaticCustomTagsGridId_" + _pageRef).jqGrid('getCol','TAG_NAME');
	if(tagName != null && typeof tagName != "undefined")
	{
		for(var i=0; i<tagName.length; i++)
		{
			tagsDropdown.append($("<option />").val("CUSTOM."+tagName[i]).text("CUSTOM."+tagName[i]));
		}
	}
	
	//retrieve tags from fixed event tags grid
	var eventFixedTags = $("#eventEmailStaticFixedEvtTagsGridId_" + _pageRef).jqGrid('getCol','TAG_NAME');
	if(eventFixedTags != null && typeof eventFixedTags != "undefined")
	{
		for(var i=0; i<eventFixedTags.length; i++)
		{
			tagsDropdown.append($("<option />").val(eventFixedTags[i]).text(eventFixedTags[i]));
		}
	}
	
	var templateType = $("#messageBodyOptionList_"+_pageRef).val();
	var communicationType = $("#communicationType_"+_pageRef).val();
	var parameterDialogStatus = $("#parametersDialogStatus_"+_pageRef).val();
	if(templateType == "D" && communicationType == "Email" && parameterDialogStatus == "Report")
	{
		//retrieve tags from query tags grid
		var queryTags = $("#eventEmailStaticQueryTagsGridId_"+_pageRef).jqGrid('getCol','COLUMN_NAME');
		if(queryTags != null && typeof queryTags != "undefined")
		{
			for(var i=0; i<queryTags.length; i++)
			{
				tagsDropdown.append($("<option />").val("QUERY."+queryTags[i]).text("QUERY."+queryTags[i]));
			}
		}
	}
	
	/**
	 * Added Batch Tags inside query and report parameters mapping dialog
	 * Added by Aleem
	 * Requested by Patricia
	 * TP ID: 841912
	 */
	var batchTags = $("#eventBatchStaticQueryTagsGridId_"+_pageRef).jqGrid('getCol','COLUMN_NAME');
	if(batchTags != null && typeof batchTags != "undefined")
	{
		for(var i=0; i<batchTags.length; i++)
		{
			tagsDropdown.append($("<option />").val("BATCH."+batchTags[i]).text("BATCH."+batchTags[i]));
		}
	}
	
	/**
	 * While selecting any row of parameter Mapping gird  
	 * in Query, Report mapping dialog
	 * The record related to the 
	 * QUERY.tagName , CUSTOM.tagName , BATCH.tagName has removed from select
	 * so we have add every item in hidden column and while selecting row
	 * after populating the select the hidden field record will be set in select
	 */
	var tbl = $("#eventArgumentGridId_" + _pageRef);
    var selRowId= tbl.jqGrid('getGridParam','selrow');
    var mappingvaluehiddden = tbl.jqGrid('getCell', selRowId, 'MAPPING_VALUE_HIDDEN');
    tagsDropdown.val(mappingvaluehiddden);
	
	
}


/**
 * retrieve Source of Contact Dropdown
 * @returns
 */
function individualEventMaint_retrieveSourceOfContactsDropdown()
{
	var sourceOfContactDropDown = $("#SOURCE_OF_CONTACT_"+_pageRef);
	var evtType = $("#eventType_" + _pageRef).val();
	
	sourceOfContactDropDown.empty();
	var skipSubscription = document.getElementById("skipSubscription_"+_pageRef);
	//var skipSubscription = $('#skipSubscription_'+_pageRef).attr('checked');
	if(!skipSubscription.checked)
	{
		skipSubscription = "";
	}
	var reloadParams={};
	reloadParams['individualEventCO.alrtEvtVO.SKIP_SUBSCRIPTION_YN'] = skipSubscription;
	if(evtType == 'B' || evtType == 'F')
	{
		reloadParams['individualEventCO.alrtEvtVO.EVT_TYPE'] = evtType;
		if(evtType == 'F')
		{
			var fixedEventId = $("#fixedEventTypeId_"+_pageRef).val();
			if(fixedEventId != "" && typeof fixedEventId != "undefined")
			{
				reloadParams['individualEventCO.fixedEventId'] = fixedEventId;
			}
		}
	}
	
	var url = jQuery.contextPath+"/path/alert/events/event/IndividualEventMaintAction_fillSourceOfContact";
	$.ajax({
		url : url,
		async : false,
		dataType : 'json',
		data : reloadParams,
		success : function(data) 
		{
			for(var i=0; i<data.sourceOfContact.length; i++)
			{
				sourceOfContactDropDown.append($("<option />").val(data.sourceOfContact[i].code).text(data.sourceOfContact[i].descValue));
				//tagsDropdown.append($("<option />").val(data.sourceOfContact[i].code).text(data.sourceOfContact[i].descValue);
			}
		}
	});
}