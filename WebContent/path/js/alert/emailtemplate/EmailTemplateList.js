function emailTemplateList_onDbClickedEvent()
{
	var $table = $("#emailTemplateListGridTbl_Id_" + _pageRef);
	var selectedRowId = $table.jqGrid('getGridParam', 'selrow');
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var myObject = $table.jqGrid('getRowData', selectedRowId);
	var actionSrc = jQuery.contextPath
			+ '/path/emailTemplate/EmailTemplateMaintAction_retrieveSelectedTemplateId.action';
	params = {};
	params["_pageRef"] = _pageRef;
	params["iv_crud"] = ivCrud;
	params["tempId"] = myObject["emailTemplateVO.TEMPLATE_ID"];
	params["tempIdOldStatus"] = myObject["emailTemplateVO.STATUS"];

	$.post(actionSrc, params, function(param)
	{
		_showProgressBar(false);

		if (param.indexOf("<script type=") != -1)
		{
			$("#emailTemplateListMaintDiv_id_" + _pageRef).show();
			$("#emailTemplateListMaintDiv_id_" + _pageRef).html(param);
			showHideSrchGrid('emailTemplateListGridTbl_Id_' + _pageRef);
		}
		else
		{
			var response = jQuery.parseJSON(param);
			_showErrorMsg(response["_error"], response["_msgTitle"], 300, 100);
		}
	}, "html");
}

