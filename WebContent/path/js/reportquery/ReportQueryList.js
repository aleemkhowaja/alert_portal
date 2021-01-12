function reportQueryList_onDbClickedEvent()
{

	var $table = $("#reportQueryListGridTbl_Id_" + _pageRef);
	var selectedRowId = $table.jqGrid('getGridParam', 'selrow');
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var myObject = $table.jqGrid('getRowData', selectedRowId);
	var actionSrc = jQuery.contextPath
			+ '/path/reportQuery/ReportQueryMaintAction_retrieveSelectedQueryId.action';
	params = {};
	params["_pageRef"] = _pageRef;
	params["iv_crud"] = ivCrud;
	params["queryId"] = myObject["reportQueryVO.QUERY_ID"];
	params["repQueryId"] = myObject["reportQueryVO.REP_QUER_ID"];
	params["queryIdOldStatus"] = myObject["reportQueryVO.STATUS"];

	$.post(actionSrc, params, function(param)
	{
		_showProgressBar(false);

		if (param.indexOf("<script type=") != -1)
		{
			$("#reportQueryListMaintDiv_id_" + _pageRef).show();
			$("#reportQueryListMaintDiv_id_" + _pageRef).html(param);
			showHideSrchGrid('reportQueryListGridTbl_Id_' + _pageRef);
		}
		else
		{
			var response = jQuery.parseJSON(param);
			_showErrorMsg(response["_error"], response["_msgTitle"], 300, 100);
		}
	}, "html");

}
