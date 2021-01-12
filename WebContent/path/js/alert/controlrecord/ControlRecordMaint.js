/**
 * Update Control Record
 * @param args
 * @returns
 */
function updateCtrlRecord(args) 
{
	var changes = $("#userSelectionFormId_" + _pageRef).hasChanges(true);
	if (changes == 'true' || changes == true) 
	{
		// parseNumbers();
		var theForm = $("#userSelectionFormId_" + _pageRef).serializeForm();
		_showProgressBar(true);
		var actionSrc = jQuery.contextPath
				+ "/path/alert/controlrecord/ControlRecordMaintAction_updateCtrlRecord";
		$.ajax({
			url : actionSrc,
			type : "post",
			dataType : "json",
			data : theForm,
			success : function(data) {
				if (typeof data["_error"] == "undefined"
						|| data["_error"] == null) 
				{
					var actionSrc = jQuery.contextPath + "/path/alert/controlrecord/ControlRecordMaintAction_initialize?_pageRef=" + _pageRef;
					$.post(
					   actionSrc,
					   {},
					   function(param)
					   {
						   $("#controlRecordMaintPage_id_"+ _pageRef).html(param);
					   }, "html");
					_showErrorMsg(record_saved_Successfully_key, info_msg_title, 300,100);
					_showProgressBar(false);
					return;
				}
				_showProgressBar(false);
			}
		// _showProgressBar(false);
		});
	}
}


/**
 * @returns
 */
function ctrl_configEmail(){
	var mailConfig = [];
	var smsConfig = ['',''];
	var mappingFieldsUrl = jQuery.contextPath+"/path/alert/controlrecord/ControlRecordMaintAction_fillEmailExpressionVariables";
	pws_loadPwsModal(1,mailDialogTitleKey,{}, mappingFieldsUrl,null,null,mappingFieldsUrl);
}


/**
 * @returns
 */
function ctrl_configSms()
{

	var smsConfigType = $("#sms_config_type_"+_pageRef).val();
	var mappingId = 0;
	
	if(typeof smsConfigType != "undefined" && smsConfigType != null)
	{
		if(smsConfigType == "0")
		{
			mappingId = 2;
		}
		else
		{
			mappingId = 5;
		}
	}
	
	var smsConfig = ['',''];
	var mappingFieldsUrl = jQuery.contextPath+"/path/alert/controlrecord/ControlRecordMaintAction_fillSmsExpressionVariables";
	pws_loadPwsModal(mappingId,smsDialogTitleKey,{}, mappingFieldsUrl,null,null,mappingFieldsUrl);
}


/**
 * @returns
 */
function ctrl_configOmni(){
	
	var omniConfig = [];
	pws_loadPwsModal(omniMappingID,omniDialogTitleKey,omniConfig);
	
}
