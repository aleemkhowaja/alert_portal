function emailTemplateMaint_processSubmit()
{
	// var changes = $("#pfDistForm_" + _pageRef).hasChanges(true);
	if (_pageRef == 'ET00MT' || _pageRef == 'ET00MA')
	{
		var formChanged = $("#emailTemplateMaintFormId_" + _pageRef).hasChanges(true);
		if (formChanged)
		{

			_showConfirmMsg(Confirm_Save_Process_key, Warning_key,
					emailTemplateMaint_handleSaveProcess);
		}
	}
}

function emailTemplateMaint_handleSaveProcess(confirm)
{
	if (confirm)
	{
		var fileName = document.getElementById("uploadTemplateFile_" + _pageRef).value;
		var tempId = $("#emailTempId_" + _pageRef);
		if((fileName == "" || fileName == undefined)&& (tempId == null || tempId == "" || tempId == undefined))
		{
			_showErrorMsg(Please_choose_file_key, info_msg_title,250, 100);
			return;
		}
		var actionUrl = jQuery.contextPath
				+ "/path/emailTemplate/EmailTemplateMaintAction_saveNew.action";
			
		var options = {
				url : actionUrl,
				type : 'post',
				dataType : "json", 
				success : function(param, status, xhr) 
				{
					if (typeof param["_error"] == "undefined" || param["_error"] == null)
					{
						// empty form
						reloadUrl = jQuery.contextPath
								+ "/path/emailTemplate/EmailTemplateMaintAction_clearStpForm.action";
						var ivCrud = returnHtmlEltValue("iv_crud_"+ _pageRef);
						var reloadParams = {};
						reloadParams["iv_crud"] = ivCrud;
						reloadParams["_pageRef"] = _pageRef;
						$.post(reloadUrl, reloadParams, function(param)
						{
							showHideSrchGrid('emailTemplateListGridTbl_Id_'+ _pageRef);
							$("#emailTemplateListMaintDiv_id_" + _pageRef).html(param);
							// reload grid
							$("#emailTemplateListGridTbl_Id_" + _pageRef).trigger("reloadGrid");
							_showProgressBar(false);
							_showErrorMsg(record_saved_Successfully_key,info_msg_title, 300, 100);
						}, "html");

					}
					else
					{
						_showProgressBar(false);
					}
				}
			}
		_showProgressBar(true);
		$("#emailTemplateMaintFormId_" + _pageRef).ajaxSubmit(options);
	}
	else
	{
		_showProgressBar(false);

	}
}

function emailTemplateMaint_onDelClicked()
{
	_showConfirmMsg(Confirm_Delete_Process_key, Warning_key,
			emailTemplateMaint_handleDeleteProcess);
}

function emailTemplateMaint_handleDeleteProcess(confirm)
{
	if (confirm)
	{
		var tempId = $("#emailTempId_" + _pageRef);
		var form = $("#emailTemplateMaintFormId_" + _pageRef).serializeForm();
		var actionUrl = jQuery.contextPath
				+ "/path/emailTemplate/EmailTemplateMaintAction_deleteEmailTemplateId.action";
		var params = {};
		_showProgressBar(true);
		$
			.ajax({
				url : actionUrl,
				type : "post",
				dataType : "json",
				data : form,
				success : function(param)
				{
					if (typeof param["_error"] == "undefined"
							|| param["_error"] == null)
					{
						// empty form
						reloadUrl = jQuery.contextPath
								+ "/path/emailTemplate/EmailTemplateMaintAction_clearStpForm.action";
						var ivCrud = returnHtmlEltValue("iv_crud_"+ _pageRef);
						var reloadParams = {};
						reloadParams["iv_crud"] = ivCrud;
						reloadParams["_pageRef"] = _pageRef;
						$.post(reloadUrl, reloadParams, function(param)
						{
							showHideSrchGrid('emailTemplateListGridTbl_Id_'+ _pageRef);
							$("#emailTemplateListMaintDiv_id_" + _pageRef).html(param);
							// reload grid
							$("#emailTemplateListGridTbl_Id_" + _pageRef).trigger("reloadGrid");
							_showProgressBar(false);
							_showErrorMsg(record_was_Deleted_Successfully_key,info_msg_title, 300, 100);
						}, "html");

					}
					else
					{
						_showProgressBar(false);
					}
				}
			});
	}
	else
	{
		_showProgressBar(false);

	}
}

function emailTemplateMaint_onApproveClicked()
{
	_showConfirmMsg(Confirm_Approve_Process_key, Warning_key,
			emailTemplateMaint_handleApproveProcess);
}

function emailTemplateMaint_handleApproveProcess(confirm)
{
	if (confirm)
	{
		var tempId = $("#emailTempId_" + _pageRef);
		var form = $("#emailTemplateMaintFormId_" + _pageRef).serializeForm();
		var actionUrl = jQuery.contextPath
				+ "/path/emailTemplate/EmailTemplateMaintAction_approveEmailTemplateId.action";
		var params = {};
		_showProgressBar(true);
		$
			.ajax({
				url : actionUrl,
				type : "post",
				dataType : "json",
				data : form,
				success : function(param)
				{
					if (typeof param["_error"] == "undefined"
							|| param["_error"] == null)
					{
						// empty form
						reloadUrl = jQuery.contextPath
								+ "/path/emailTemplate/EmailTemplateMaintAction_clearStpForm.action";
						var ivCrud = returnHtmlEltValue("iv_crud_"+ _pageRef);
						var reloadParams = {};
						reloadParams["iv_crud"] = ivCrud;
						reloadParams["_pageRef"] = _pageRef;
						$.post(reloadUrl, reloadParams, function(param)
						{
							showHideSrchGrid('emailTemplateListGridTbl_Id_'+ _pageRef);
							$("#emailTemplateListMaintDiv_id_" + _pageRef).html(param);
							// reload grid
							$("#emailTemplateListGridTbl_Id_" + _pageRef).trigger("reloadGrid");
							_showProgressBar(false);
							_showErrorMsg(record_was_Approved_Successfully_key,info_msg_title, 300, 100);
						}, "html");

					}
					else
					{
						_showProgressBar(false);
					}
				}
			});
	}
	else
	{
		_showProgressBar(false);

	}
}

function emailTemplateList_onAddClicked()
{
	// empty form
	if ($("#emailTemplateMaintFormId_" + _pageRef).hasChanges())
	{
		_showConfirmMsg(Confirm_Proceed_key, proceed_msg_title, function(
				confirmcChoice, theArgs)
		{
			if (confirmcChoice)
			{
				emailTemplate_clearStpForm();
			}
		}, {}, "yes", "no", 300, 100);
	}
	else
	{
		emailTemplate_clearStpForm();
	}
}

function emailTemplate_clearStpForm()
{
	var url = jQuery.contextPath
			+ "/path/emailTemplate/EmailTemplateMaintAction_clearStpForm.action";
	var params = {};
	params["_pageRef"] = _pageRef;
	var ivCrud = returnHtmlEltValue("iv_crud_" + _pageRef);
	params["iv_crud"] = ivCrud;
	$.post(url, params, function(param)
	{
		$("#emailTemplateListMaintDiv_id_" + _pageRef).html(param);
	}, "html");
}

function emailTemplateMaint_uploadTemplateFile() 
{
	var fileName = document.getElementById("uploadTemplateFile_" + _pageRef).value;
	var ext = fileName.substring(fileName.lastIndexOf(".")+1,fileName.length);
	ext = ext.toUpperCase();
	if(ext != "HTML")
	{
		_showErrorMsg(msg_file_type_not_allowed_key);
		$("#uploadTemplateFile_" + _pageRef).val("");
	}
}

function emailtemplate_onStatusClicked()
{
	var emailTemplate = $("#emailTempId_" + _pageRef).val();
	if (emailTemplate == "")
	{
		return;
	}
	var loadSrc = jQuery.contextPath
			+ "/path/emailTemplate/EmailTemplateStatusAction_search.action?emailTemplate="
			+ emailTemplate + "&_pageRef=" + _pageRef;
	var theFormId = "emailTemplateMaintFormId_" + _pageRef;
	showStatus(theFormId, _pageRef, loadSrc, {});
}