function reportQueryMaint_processSubmit()
{

	// var changes = $("#pfDistForm_" + _pageRef).hasChanges(true);
	if (_pageRef == 'RQ00MT' || _pageRef == 'RQ00MA')
	{
		var formChanged = $("#reportQueryMaintFormId_" + _pageRef).hasChanges(true);
		if (formChanged)
		{

			_showConfirmMsg(Confirm_Save_Process_key, Warning_key,
					reportQueryMaint_handleSaveProcess);
		}
	}
}

function reportQueryMaint_handleSaveProcess(confirm)
{
	if (confirm)
	{

		var reportQueryId = returnHtmlEltValue("lookuptxt_queryLkp_" + _pageRef);
		var jsonStringUpdates = $("#linkQryGridId_" + _pageRef).jqGrid(
				'getAllRows');
		$("#updateSnParameter_" + _pageRef).val(jsonStringUpdates);
		var form = $("#reportQueryMaintFormId_" + _pageRef).serializeForm();
		var actionUrl = jQuery.contextPath
				+ "/path/reportQuery/ReportQueryMaintAction_saveNew.action";
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
									+ "/path/reportQuery/ReportQueryMaintAction_clearStpForm.action";
							var ivCrud = returnHtmlEltValue("iv_crud_"
									+ _pageRef);
							var reloadParams = {};
							reloadParams["iv_crud"] = ivCrud;
							reloadParams["_pageRef"] = _pageRef;
							$.post(reloadUrl, reloadParams, function(param)
							{
								showHideSrchGrid('reportQueryListGridTbl_Id_'
										+ _pageRef);
								$("#reportQueryListMaintDiv_id_" + _pageRef)
										.html(param);
								// reload grid
								$("#reportQueryListGridTbl_Id_" + _pageRef)
										.trigger("reloadGrid");
								_showProgressBar(false);
								_showErrorMsg(record_saved_Successfully_key,
										info_msg_title, 300, 100);
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

function reportQueryMaint_processApprove()
{
	var args = {
			isReject : false,
			infoMessageDet : record_was_Approved_Successfully_key
	};
	_showConfirmMsg(Confirm_Approve_Process_key, "",
			"reportQueryMaint_handleApproveProcess", args,Ok_key,Cancel_key);
}

function reportQueryMaint_handleApproveProcess(confirm, args)
{
	if (confirm)
	{

		var actionUrl = jQuery.contextPath
				+ "/path/reportQuery/ReportQueryMaintAction_approve.action";
		var queryIdLkp = $("#lookuptxt_queryLkp_" + _pageRef).val()
		var repQuerId = $("#Code_" + _pageRef).val()
		var params = {};
		params["reportQueryCO.reportQueryVO.QUERY_ID"] = queryIdLkp;
		params["reportQueryCO.reportQueryVO.REP_QUER_ID"] = repQuerId;
		var dateUpdated = returnHtmlEltValue("DATE_UPDATED_" + _pageRef);
		params["reportQueryCO.reportQueryVO.DATE_UPDATED"] = dateUpdated;
		params["_pageRef"] = _pageRef;
		params["iv_crud"] = returnHtmlEltValue("iv_crud_" + _pageRef);
		_showProgressBar(true);
		$
				.ajax({
					url : actionUrl,
					type : "post",
					dataType : "json",
					data : params,
					success : function(param)
					{
						if (typeof param["_error"] == "undefined"
								|| param["_error"] == null)
						{
							// empty form
							reloadUrl = jQuery.contextPath
									+ "/path/reportQuery/ReportQueryMaintAction_clearStpForm.action";
							var ivCrud = returnHtmlEltValue("iv_crud_"
									+ _pageRef);
							var reloadParams = {};
							reloadParams["iv_crud"] = ivCrud;
							reloadParams["_pageRef"] = _pageRef;
							$.post(reloadUrl, reloadParams, function(param)
							{
								showHideSrchGrid('reportQueryListGridTbl_Id_'
										+ _pageRef);
								$("#reportQueryListMaintDiv_id_" + _pageRef)
										.html(param);
								// reload grid
								$("#reportQueryListGridTbl_Id_" + _pageRef)
										.trigger("reloadGrid");
								_showProgressBar(false);
								_showErrorMsg(
										record_was_Approved_Successfully_key,
										info_msg_title, 300, 100);
							}, "html");

						}
						else
						{
							_showProgressBar(false);
						}
					}
				});
	}
}

function reportQueryMaint_onDelClicked()
{
	_showConfirmMsg(Confirm_Delete_Process_key, Warning_key,
			stfTypeParamMaint_handleDeleteProcess);
}

function stfTypeParamMaint_handleDeleteProcess(confirm)
{
	if (confirm)
	{
		var reportQueryId = returnHtmlEltValue("lookuptxt_queryLkp_" + _pageRef);
		var jsonStringUpdates = $("#linkQryGridId_" + _pageRef).jqGrid(
				'getChangedRowData');
		$("#updateSnParameter_" + _pageRef).val(jsonStringUpdates);
		var form = $("#reportQueryMaintFormId_" + _pageRef).serializeForm();
		var actionUrl = jQuery.contextPath
				+ "/path/reportQuery/ReportQueryMaintAction_deleteReportQueryId.action";
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
									+ "/path/reportQuery/ReportQueryMaintAction_clearStpForm.action";
							var ivCrud = returnHtmlEltValue("iv_crud_"
									+ _pageRef);
							var reloadParams = {};
							reloadParams["iv_crud"] = ivCrud;
							reloadParams["_pageRef"] = _pageRef;
							$.post(reloadUrl, reloadParams, function(param)
							{
								showHideSrchGrid('reportQueryListGridTbl_Id_'
										+ _pageRef);
								$("#reportQueryListMaintDiv_id_" + _pageRef)
										.html(param);
								// reload grid
								$("#reportQueryListGridTbl_Id_" + _pageRef)
										.trigger("reloadGrid");
								_showProgressBar(false);
								_showErrorMsg(
										record_was_Deleted_Successfully_key,
										info_msg_title, 300, 100);
							}, "html");

						}
						else
						{
							_showProgressBar(false);
						}
					}
				});
	}
}

function reportQuery_onStatusClicked()
{
	var repQueryId = $("#Code_" + _pageRef).val();
	if (repQueryId == "")
	{
		return;
	}
	var loadSrc = jQuery.contextPath
			+ "/path/reportQuery/ReportQueryStatusAction_search.action?repQueryID="
			+ repQueryId + "&_pageRef=" + _pageRef;
	var theFormId = "reportQueryMaintFormId_" + _pageRef;
	showStatus(theFormId, _pageRef, loadSrc, {});
}

function reportQueryList_onAddClicked()
{
	// empty form
	if ($("#reportQueryMaintFormId_" + _pageRef).hasChanges())
	{
		_showConfirmMsg(Confirm_Proceed_key, proceed_msg_title, function(
				confirmcChoice, theArgs)
		{
			if (confirmcChoice)
			{
				reportQuery_clearStpForm();
			}
		}, {}, "yes", "no", 300, 100);
	}
	else
	{
		reportQuery_clearStpForm();
	}

}

function reportQuery_clearStpForm()
{
	var url = jQuery.contextPath
			+ "/path/reportQuery/ReportQueryMaintAction_clearStpForm.action";
	var params = {};
	params["_pageRef"] = _pageRef;
	var ivCrud = returnHtmlEltValue("iv_crud_" + _pageRef);
	params["iv_crud"] = ivCrud;
	$.post(url, params, function(param)
	{
		$("#reportQueryListMaintDiv_id_" + _pageRef).html(param);
	}, "html");
}

function reloadLinkQryGrid()
{
	var queryIdLkp = $("#lookuptxt_queryLkp_" + _pageRef).val();
	var repQuerId = $("#Code_" + _pageRef).val()
	url = jQuery.contextPath
			+ "/path/reportQuery/QueryDesignerAction_loadLinkQryGrid.action?queryIdLkp="
			+ queryIdLkp;
	$("#linkQryGridId_" + _pageRef).jqGrid('setGridParam', {
		url : url
	}).trigger("reloadGrid");
}

function reportquery_ChangedQryMapParam()
{
	var detailsGridId = $("#linkQryGridId_" + _pageRef);
	var selRow = detailsGridId.jqGrid("getGridParam", 'selrow');
	var subscType = $("#subscription_type_" + _pageRef).val();
	if (subscType == "A")
	{
		$("#" + selRow + "_reportQueryArgVO\\.MAPPING_ARG option[value='I']")
				.each(function()
				{
					$(this).remove();
				});
	}
	else if (subscType == "C")
	{
		$("#" + selRow + "_reportQueryArgVO\\.MAPPING_ARG option[value='B']")
				.each(function()
				{
					$(this).remove();
				});
		$("#" + selRow + "_reportQueryArgVO\\.MAPPING_ARG option[value='D']")
				.each(function()
				{
					$(this).remove();
				});
		$("#" + selRow + "_reportQueryArgVO\\.MAPPING_ARG option[value='I']")
				.each(function()
				{
					$(this).remove();
				});
		$("#" + selRow + "_reportQueryArgVO\\.MAPPING_ARG option[value='U']")
				.each(function()
				{
					$(this).remove();
				});
	}
	else
	{
		$("#" + selRow + "_reportQueryArgVO\\.MAPPING_ARG option[value='B']")
				.each(function()
				{
					$(this).remove();
				});
		$("#" + selRow + "_reportQueryArgVO\\.MAPPING_ARG option[value='D']")
				.each(function()
				{
					$(this).remove();
				});
		$("#" + selRow + "_reportQueryArgVO\\.MAPPING_ARG option[value='N']")
				.each(function()
				{
					$(this).remove();
				});
		$("#" + selRow + "_reportQueryArgVO\\.MAPPING_ARG option[value='U']")
				.each(function()
				{
					$(this).remove();
				});
	}
}

function reportQueryMaint_onDetailsClicked()
{
	var queryIdLkp = $("#lookuptxt_queryLkp_" + _pageRef).val();

	url = jQuery.contextPath
			+ "/path/reportQuery/QueryDesignerAction_retSqlSytaxQuery.action?queryIdLkp="
			+ queryIdLkp;
	$
			.post(
					url,
					function(param)
					{
						mySrc = jQuery.contextPath
								+ "/path/reportQuery/ReportQueryMaintAction_openDetails.action";
						$('#openDetailsPopup_' + _pageRef)
								.load(
										mySrc,
										{
											"reportQueryCO.querySyntax" : param.reportQueryCO.querySyntax
										}, function()
										{
										});
						$('#openDetailsPopup_' + _pageRef).dialog('open');
					});
}
