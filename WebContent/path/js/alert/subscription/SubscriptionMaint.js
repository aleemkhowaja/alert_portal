function ifSubscriptionFormChanged()
{
	var formChanged = false;
	$("#subscriptionMaintForm_" + _pageRef).each(function(i)
	{
		formChanged = $(this).hasChanges();
		if (formChanged)
		{
			return true;
		}
	});
	return formChanged;
}

function viewStatusDetails()
{
	var title = subscription_audit_details_key;
	var subEvtGrid = returnsGridSelected();
	var selectedRows = subEvtGrid.jqGrid('getGridParam', 'selarrrow');
	var openFavScreenDiv = $("<div id='showStatus_id' />");
	var openFavScreenIFramDiv = $(openFavScreenDiv);
	$('body').append(openFavScreenIFramDiv);
	// var $table = subEvtGrid;
	var selectedRowId = subEvtGrid.jqGrid('getGridParam', 'selrow');
	var myObject = subEvtGrid.jqGrid('getRowData', selectedRows[0]);
	var selected_line = myObject["alrtSubEvtTmpVO.REL_ID"];
	var status = myObject["alrtSubEvtTmpVO.SUB_EVT_STATUS"];
	var type = myObject["alrtSubEvtTmpVO.REL_TYPE"];
	if (status == "C")
	{
		_showErrorMsg(no_det_for_populated_sub_key, information_key);
		return;
	}

	if (selectedRows.length == 0)
	{
		_showErrorMsg(please_select_a_sub_key, missing_info_key);
		return;
	}

	var actionSource = jQuery.contextPath
			+ "/path/alert/subscription/SubscriptionMaintAction_viewStatusDetails";

	var params = {};

	params["subscriptionSC.type"] = type;
	params["subscriptionSC.lineNumber"] = selected_line;
	params["_pageRef"] = _pageRef;
	_showProgressBar(true);

	var openItemDivElement = $("#showStatus_id")

	openItemDivElement.dialog({
		modal : true,
		title : title,
		autoOpen : false,
		position : 'center',
		width : returnMaxWidth(590),
		height : returnMaxHeight(350),
		close : function()
		{
			$("#showStatus_id").dialog("destroy");
			$("#showStatus_id").remove();
		},
		open : function()
		{
		}

	});

	$(openItemDivElement).load(actionSource, params, function()
	{
		$(openItemDivElement).dialog("open");
		_showProgressBar(false);
	});

}

function viewSubscriptionDetails()
{
	var title = subscription_details_key;
	var table;

	var subscriptionType = $("#subscription_type_" + _pageRef).val();

	if (subscriptionType == "SE")
	{

		table = $("#subscriptionsEvtGridTbl_Id_" + _pageRef);

	}
	else if (subscriptionType == "SP")
	{

		table = $("#subscriptionsPckgGridTbl_Id_" + _pageRef);

	}
	else if (subscriptionType == "EG")
	{

		table = $("#groupsEvtGridTbl_Id_" + _pageRef);

	}
	else if (subscriptionType == "GP")
	{

		table = $("#groupPckgGridTbl_Id_" + _pageRef);

	}

	var selectedRows = table.jqGrid('getGridParam', 'selarrrow');
	var myObject = table.jqGrid('getRowData', selectedRows[0]);
	var selected_line = myObject["alrtSubEvtTmpVO.REL_ID"];
	var subID = myObject["alrtSubEvtTmpVO.SUB_ID"];
	var evtID = myObject["alrtSubEvtTmpVO.REL_ID"];
	var selected_type = myObject["alrtSubEvtTmpVO.REL_TYPE"];
	var status = myObject["alrtSubEvtTmpVO.SUB_EVT_STATUS"];
	if (status == "T")
	{
		_showErrorMsg(no_det_available_to_be_del_key, information_key);
		return;
	}

	if (status == "C")
	{
		_showErrorMsg(no_det_for_populated_sub_key, information_key);
		return;
	}

	if (selectedRows.length == 0)
	{
		_showErrorMsg(please_select_a_sub_key, missing_info_key);
		return;
	}
	var openScreenDiv = $("<div id='viewSubscriptionDetails_id' />");
	var openScreenIFramDiv = $(openScreenDiv);
	$('body').append(openScreenIFramDiv);
	var params = {};
	var actionSource = jQuery.contextPath
			+ "/path/alert/subscription/SelectSubscriptionDetailsGridAction_viewSubscriptionDetails";

	params["subscriptionSC.type"] = selected_type;
	params["subscriptionSC.lineNumber"] = selected_line;
	params["subscriptionSC.SUB_ID"] = subID;
	params["subscriptionSC.EVT_ID"] = evtID;
	params["_pageRef"] = _pageRef;
	_showProgressBar(true);
	var dialogOptions = {
		modal : true,
		autoOpen : false,
		show : 'slide',
		position : 'center',
		dialogClass : 'no-close',
		closeOnEscape : false,
		title : title,
		'height' : returnMaxHeight(400),
		'width' : returnMaxWidth(950),
		buttons : [ {
			text : "close",
			click : function()
			{
				$(this).dialog("destroy").appendTo(
						"#subscriptionMaintForm_" + _pageRef).remove();
			}
		} ]
	};

	$("#viewSubscriptionDetails_id").load(actionSource, params, function()
	{
		_showProgressBar(false);

	});

	$("#viewSubscriptionDetails_id").dialog(dialogOptions);
	$("#viewSubscriptionDetails_id").dialog("open");
	setTimeout(resizeGrids, 220);

}

function LoadFixedEvtsParams(selectedRowId)
{
	var title = fixed_event_parameter_key;
	var $table = $("#subscriptionDetailsGridTbl_Id_" + _pageRef);
	var myObject = $table.jqGrid('getRowData', selectedRowId);
	var evt_id = myObject["alrtSubEvtVO.EVT_ID"];
	var rowId = myObject["alrtSubEvtVO.ID"];

	var openScreenDiv = $("<div id='viewEventsParams_id' />");
	var openScreenIFramDiv = $(openScreenDiv);
	$('body').append(openScreenIFramDiv);
	var params = {};
	var actionSource = jQuery.contextPath
			+ "/path/alert/subscription/SelectFixedEventsParamGridAction_viewEventsParams";

	params["subscriptionSC.evt_id"] = evt_id;
	params["subscriptionSC.lineNumber"] = rowId;
	params["_pageRef"] = _pageRef;
	params["subscriptionSC.crud"] = $("#iv_crud_" + _pageRef).val();

	_showProgressBar(true);
	var dialogOptions = {
		modal : true,
		autoOpen : false,
		show : 'slide',
		position : 'center',
		dialogClass : 'no-close',
		closeOnEscape : false,
		title : title,
		'height' : returnMaxHeight(320),
		'width' : returnMaxWidth(650),
		buttons : [ {
			text : "Update",
			click : function()
			{
				updateSubDetailsParams();

				$(this).dialog("close");

				$(this).dialog("destroy");
				$(this).remove();
			}
		}, {
			text : "Cancel",
			click : function()
			{
				// $(this).dialog("destroy").appendTo(
				// "#subscriptionMaintForm_" + _pageRef).remove();
				$(this).dialog("close");

				$(this).dialog("destroy");
				$(this).remove();
			}
		} ]
	};

	$("#viewEventsParams_id").load(actionSource, params, function()
	{

		// makeReadonlyContents("fixedEventsParamForm_" + _pageRef, true);
		_showProgressBar(false);
	});

	$("#viewEventsParams_id").dialog(dialogOptions);
	$("#viewEventsParams_id").dialog("open");
	setTimeout(resizeGrids, 220);
	
	//hide dialog update button in approve screen
	if($("#iv_crud_" + _pageRef).val()=='P'){
		$(".ui-dialog-buttonset").children().eq(1).hide();
	}

}

function OnFixedEvtsParamGridLoad()
{

	var $table = $("#fixedEvtsParamGridTbl_Id_" + _pageRef);
	var rowIds = $table.jqGrid('getDataIDs');
	for (i = 0; i < rowIds.length; i++)
	{
		var myObject = $table.jqGrid('getRowData', rowIds[i]);
		if (myObject["fixedFlag"] == "N")
		{
			$table.jqGrid('setCellReadOnly', rowIds[i],
					"alrtSubscriptionParamVO.FIXED_OPERATOR", "false");
		}
		else
		{
			$table.jqGrid('setCellReadOnly', rowIds[i],
					"alrtSubscriptionParamVO.FIXED_OPERATOR", "true");
		}
		if (myObject["fixedFlag"] == "S" || myObject["fixedFlag"] == "B")
		{
			$table.jqGrid('setCellReadOnly', rowIds[i],
					"alrtSubscriptionParamVO.FROM_VALUE", "true");
			$table.jqGrid('setCellReadOnly', rowIds[i],
					"alrtSubscriptionParamVO.TO_VALUE", "true");

		}
		else
		{
			$table.jqGrid('setCellReadOnly', rowIds[i],
					"alrtSubscriptionParamVO.FROM_VALUE", "false");
			$table.jqGrid('setCellReadOnly', rowIds[i],
					"alrtSubscriptionParamVO.TO_VALUE", "false");
		}
	}

	manageFromToFields('', null);
}

function onFixedOperatorChanged(fixedOperator)
{
	var gridId = $("#fixedEvtsParamGridTbl_Id_" + _pageRef);
	var selectedRowId = gridId.jqGrid('getGridParam', 'selrow');
	manageFromToFields(fixedOperator.value, selectedRowId);
}
/**
 * 
 * @param fixedOperator
 * @param selectedRowId
 * @returns
 */
function manageFromToFields(fixedOperator, selectedRowId)
{
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var flag = false;
	var gridId = $("#fixedEvtsParamGridTbl_Id_" + _pageRef);
	if (fixedOperator == "3")
	{

		gridId.jqGrid('showCol', "alrtSubscriptionParamVO.TO_VALUE");
		gridId.jqGrid('setCellReadOnly', selectedRowId,
				"alrtSubscriptionParamVO.TO_VALUE", "false");
	}
	else
	{
		var rowIds = gridId.jqGrid('getDataIDs');
		for (i = 0; i < rowIds.length; i++)
		{
			var myObject = gridId.jqGrid('getRowData', rowIds[i]);
			if (myObject["alrtSubscriptionParamVO.FIXED_OPERATOR"] == "3")
			{
				flag = true;
			}

		}

		if (flag == false)
		{
			gridId.jqGrid('hideCol', "alrtSubscriptionParamVO.TO_VALUE");
			if (ivCrud == 'P')
			{
				gridId
						.jqGrid('hideCol',
								"alrtSubscriptionParamVO.OLD_TO_VALUE");
			}
		}
		else
		{
			gridId.jqGrid('showCol', "alrtSubscriptionParamVO.TO_VALUE");

			gridId.jqGrid('setCellReadOnly', selectedRowId,
					"alrtSubscriptionParamVO.TO_VALUE", "true");

			if (ivCrud == 'P')
			{
				gridId
						.jqGrid('showCol',
								"alrtSubscriptionParamVO.OLD_TO_VALUE");
			}
		}
	}

	if (ivCrud == 'P')
	{
		gridId.jqGrid('showCol', "alrtSubscriptionParamVO.OLD_FIXED_OPERATOR");
		gridId.jqGrid('showCol', "alrtSubscriptionParamVO.OLD_FROM_VALUE");
		// gridId.jqGrid('showCol', "alrtSubscriptionParamVO.OLD_TO_VALUE");

	}

}

function subscriptionDetails_BtnFormatter(cellValue, options, rowObject)
{
	var name = Parameters_key;
	var evt_type = rowObject["alrtEvtVO"]["EVT_TYPE"];
	if (rowObject != undefined && rowObject["alrtEvtVO"] != undefined
			&& rowObject["alrtEvtVO"]["EVT_TYPE"] != undefined
			&& evt_type == "F")
	{

		return '<table style="border-width:0" width="100%" ><tr style="border-width:0" width="100%"><td style="border-width:0" width="33%"><b><a href = "#" onclick = "javascript:LoadFixedEvtsParams('
				+ options.rowId + ');">' + name + '</a></b></td></tr></table>';
	}
	else
	{

		return '';
	}

}

function subscriptionDetails_unformatSaleBtn(cellValue, options)
{
	return "";
}

function putfixedEvtsParamGridProtectedFields(rowObject)
{

	var table = $("#fixedEvtsParamGridTbl_Id_" + _pageRef);
	var status = $("#status_" + _pageRef).val();
	var selectedRowId = rowObject.originalEvent.id;
	var fixedOperator = table.jqGrid('getCell', selectedRowId,
			"alrtSubscriptionParamVO.FIXED_OPERATOR");
	manageFromToFields(fixedOperator, selectedRowId);
}

function loadComboAlrt()
{
	var url = jQuery.contextPath
			+ "/path/alert/subscription/SelectFixedEventsParamGridAction_loadFromValueDropDown";

	var fixedEventId = $("#fixedEvtId_" + _pageRef).val();
	url = url + '?fixedEventId=' + fixedEventId;
	return loadCombo(url, 'fromValueList', 'code', 'descValue');
}

// on Row Select
function dynamicGridSelectRowFunc(selectedRowInd, gridType)
{

	var gridId, columnName, variableName;
	if (gridType == 'S')
	{
		/** subscriber Grid */
		gridId = "#subscriberGridTbl_Id_";
		columnName = "alrtSubVO.ID";
		variableName = "SUB_ID";
	}
	else if (gridType == 'E')
	{
		/** event Grid */
		gridId = "#eventsGridTbl_Id_";
		columnName = "alrtEvtVO.EVT_ID";
		variableName = "EVT_ID";
	}
	else if (gridType == 'G')
	{
		/** group Grid */
		gridId = "#groupsGridTbl_Id_";
		columnName = "alrtGrpVO.GRP_ID";
		variableName = "GRP_ID";
	}
	else
	{
		/** package Grid */
		gridId = "#packagesGridTbl_Id_";
		columnName = "alrtPkgVO.PKG_ID";
		variableName = "PKG_ID";
	}
	var $table = $(gridId + _pageRef);
	var rowId = selectedRowInd.originalEvent.id;
	var myObject = $table.jqGrid('getRowData', rowId);
	var selSerialNo2 = ($("#selSerialNo_" + gridType + "_" + _pageRef).val() != "") ? eval("("
			+ $("#selSerialNo_" + gridType + "_" + _pageRef).val() + ")")
			: new Object();

	var varId = myObject[columnName] + "";
	if (selectedRowInd.originalEvent.status)
	{

		selSerialNo2["varId_" + varId] = "{\"" + variableName + "\":\""
				+ myObject[columnName] + "\"}";
	}
	else
	{
		selSerialNo2["varId_" + varId] = undefined;
		$("#all_rows_" + gridType + "_" + _pageRef).val("0");
	}

	$("#selSerialNo_" + gridType + "_" + _pageRef).val(
			JSON.stringify(selSerialNo2));

}

function dynamicGridSelectAllFunc(selectedRowInd, gridType)
{
	var params = {};
	params["subscriptionSC.gridType"] = gridType;
	var gridId, columnName, variableName;
	if (gridType == 'S')
	{
		/** subscriber Grid */
		gridId = "#subscriberGridTbl_Id_";
		columnName = "alrtSubVO.ID";
		variableName = "SUB_ID";
	}
	else if (gridType == 'E')
	{
		/** event Grid */
		gridId = "#eventsGridTbl_Id_";
		columnName = "alrtEvtVO.EVT_ID";
		variableName = "EVT_ID";
	}
	else if (gridType == 'G')
	{
		/** group Grid */
		gridId = "#groupsGridTbl_Id_";
		columnName = "alrtGrpVO.GRP_ID";
		variableName = "GRP_ID";
	}
	else
	{
		/** package Grid */
		gridId = "#packagesGridTbl_Id_";
		columnName = "alrtPkgVO.PKG_ID";
		variableName = "PKG_ID";
	}

	var $table = $(gridId + _pageRef);
	if (selectedRowInd.originalEvent.status)
	{
		var totalRow = $table.jqGrid('getGridParam', 'records');
		var rowNum = $table.jqGrid('getGridParam', 'rowNum');

		if (totalRow > rowNum)
		{
			var gridUrl = jQuery.contextPath
					+ "/path/alert/subscription/SubscriptionListAction_returnAllSelectedRow";

			$.ajax({
				url : gridUrl,
				type : "post",
				dataType : "json",
				data : params,
				success : function(data)
				{
					$("#selSerialNo_" + gridType + "_" + _pageRef).val(
							data.allSelectedRow2);
					$("#all_rows_" + gridType + "_" + _pageRef).val("1");
				}
			});
		}
		else
		{
			for (i = 0; i < selectedRowInd.originalEvent.ids.length; i++)
			{
				dynamicGridOnePageRowsFunc(selectedRowInd.originalEvent.ids[i],
						selectedRowInd.originalEvent.status, gridType);
			}
			$("#all_rows_" + gridType + "_" + _pageRef).val("0");
		}
	}
	else
	{
		$("#selSerialNo_" + gridType + "_" + _pageRef).val("");
		$("#all_rows_" + gridType + "_" + _pageRef).val("0");
	}

}

// if only record in one page
function dynamicGridOnePageRowsFunc(selectedRowId, status, gridType)
{
	var gridId, columnName, variableName;
	if (gridType == 'S')
	{
		/** subscriber Grid */
		gridId = "#subscriberGridTbl_Id_";
		columnName = "alrtSubVO.ID";
		variableName = "SUB_ID";
	}
	else if (gridType == 'E')
	{
		/** event Grid */
		gridId = "#eventsGridTbl_Id_";
		columnName = "alrtEvtVO.EVT_ID";
		variableName = "EVT_ID";
	}
	else if (gridType == 'G')
	{
		/** group Grid */
		gridId = "#groupsGridTbl_Id_";
		columnName = "alrtGrpVO.GRP_ID";
		variableName = "GRP_ID";
	}
	else
	{
		/** package Grid */
		gridId = "#packagesGridTbl_Id_";
		columnName = "alrtPkgVO.PKG_ID";
		variableName = "PKG_ID";
	}
	var $table = $(gridId + _pageRef);
	var myObject = $table.jqGrid('getRowData', selectedRowId);
	var selSerialNo2 = ($("#selSerialNo_" + gridType + "_" + _pageRef).val() != "") ? eval("("
			+ $("#selSerialNo_" + gridType + "_" + _pageRef).val() + ")")
			: new Object();

	var varId = myObject[columnName] + "";
	if (status)
	{
		selSerialNo2["varId_" + varId] = "{\"" + variableName + "\":\""
				+ myObject[columnName] + "\"}";
	}
	else
	{
		selSerialNo2["varId_" + varId] = undefined;
		$("#all_rows_" + gridType + "_" + _pageRef).val("0");
	}

	$("#selSerialNo_" + gridType + "_" + _pageRef).val(
			JSON.stringify(selSerialNo2));

}

function onAfterBatchDetailScreenLoad(selectedRowId, gridType)
{
	var gridId, columnName, variableName;
	if (gridType == 'S')
	{
		/** subscriber Grid */
		gridId = "#subscriberGridTbl_Id_";
		columnName = "alrtSubVO.ID";
		variableName = "SUB_ID";
	}
	else if (gridType == 'E')
	{
		/** event Grid */
		gridId = "#eventsGridTbl_Id_";
		columnName = "alrtEvtVO.EVT_ID";
		variableName = "EVT_ID";
	}
	else if (gridType == 'G')
	{
		/** group Grid */
		gridId = "#groupsGridTbl_Id_";
		columnName = "alrtGrpVO.GRP_ID";
		variableName = "GRP_ID";
	}
	else
	{
		/** package Grid */
		gridId = "#packagesGridTbl_Id_";
		columnName = "alrtPkgVO.PKG_ID";
		variableName = "PKG_ID";
	}
	var $table = $(gridId + _pageRef);
	var rows = $table.jqGrid('getDataIDs');
	var rowsLen = rows.length;
	var rowNum = $table.jqGrid('getGridParam', 'rowNum');
	selSerialNo2 = ($("#selSerialNo_" + gridType + "_" + _pageRef).val() != "") ? eval("("
			+ $("#selSerialNo_" + gridType + "_" + _pageRef).val() + ")")
			: new Object();
	if (!$.isEmptyObject(selSerialNo2))
	{
		for (var j = 1; j <= rowNum; j++)
		{
			var myObject = $table.jqGrid('getRowData', j);
			var varId = myObject[columnName];
			if (selSerialNo2["varId_" + varId] != undefined)
			{
				$table.jqGrid('setSelection', j, true);

			}
		}
	}
	else
	{
		for (var j = 1; j <= rowNum; j++)
		{
			var myObject = $table.jqGrid('getRowData', j);
			var varId = myObject[columnName];
			if (selSerialNo2["varId_" + varId] != undefined)
			{
				$table.jqGrid('setSelection', j, false);
			}

		}
	}

}

function populateSubscription()
{

	
	
	var subscriptionType = $("#subscription_type_" + _pageRef).val();
	
	
	if (subscriptionType == "SE")
	{
		/**
		 * Added condition if all rows selected then 
		 * set on in flag for bulk insert for subscribers
		 */
		if ($('#cb_subscriberGridTbl_Id_SBT00SEMT').is(":checked"))
		{
			$("#all_rows_S_"+_pageRef).val("1");
		}
		else
		{
			$("#all_rows_S_"+_pageRef).val("0");
		}
		
		/**
		 * Added condition if all rows selected then 
		 * set on in flag for bulk insert for events
		 */
		if ($('#cb_eventsGridTbl_Id_SBT00SEMT').is(":checked"))
		{
			$("#all_rows_E_"+_pageRef).val("1");
		}
		else
		{
			$("#all_rows_E_"+_pageRef).val("0");
		}
	}
	
	var selectedRows, alrtSubGrd, alrtEvtPckgGrd, gridTypeSG, gridTypeEP;

	if (subscriptionType == "SE" || subscriptionType == "SP")
	{
		selectedRows = $("#subscriberGridTbl_Id_" + _pageRef).jqGrid('getGridParam', 'selarrrow');
		alrtSubGrd = $("#subscriberGridTbl_Id_" + _pageRef);
		gridTypeSG = "S";
	}
	else
	{
		selectedRows = $("#groupsGridTbl_Id_" + _pageRef).jqGrid('getGridParam', 'selarrrow');
		alrtSubGrd = $("#groupsGridTbl_Id_" + _pageRef);
		gridTypeSG = "G";
	}

	var rowSelected = "";
	if (selectedRows.length <= 0)
	{
		_showErrorMsg(no_sub_grps_sel_for_population);
		return;
	}
	else
	{
		for (var i = 0; i < selectedRows.length; i++)
		{
			var gridData = alrtSubGrd.jqGrid("getRowData", selectedRows[i]);
			rowSelected += JSON.stringify(gridData) + ",";
		}
		jsonStringSubGrp = "{\"root\":[" + rowSelected + "]}";
	}

	var selectedRowsEP
	if (subscriptionType == "EG" || subscriptionType == "SE")
	{
		selectedRowsEP = $("#eventsGridTbl_Id_" + _pageRef).jqGrid('getGridParam', 'selarrrow');
		alrtEvtPckgGrd = $("#eventsGridTbl_Id_" + _pageRef);
		gridTypeEP = "E";
	}
	else
	{
		selectedRowsEP = $("#packagesGridTbl_Id_" + _pageRef).jqGrid('getGridParam', 'selarrrow');
		alrtEvtPckgGrd = $("#packagesGridTbl_Id_" + _pageRef);
		gridTypeEP = "P";
	}

	var rowSelectedEP = "";
	if (selectedRowsEP.length <= 0)
	{
		_showErrorMsg(no_evt_pkg_sel_for_population);
		return;
	}
	else
	{
		for (var i = 0; i < selectedRowsEP.length; i++)
		{
			var gridData = alrtEvtPckgGrd.jqGrid("getRowData", selectedRowsEP[i]);
			rowSelectedEP += JSON.stringify(gridData) + ",";
		}
		jsonStringEvtPckg = "{\"root\":[" + rowSelectedEP + "]}";
	}

	var selSerialNoSG = $("#selSerialNo_" + gridTypeSG + "_" + _pageRef).val();
	var selSerialNoEP = $("#selSerialNo_" + gridTypeEP + "_" + _pageRef).val();
	var allRowsSG = $("#all_rows_" + gridTypeSG + "_" + _pageRef).val();
	var allRowsEP = $("#all_rows_" + gridTypeEP + "_" + _pageRef).val();
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var actionSrc = jQuery.contextPath+ "/path/alert/subscription/SubscriptionMaintAction_populateSubscription?iv_crud="+ ivCrud;
	var theForm = $("#subscriptionMaintForm_" + _pageRef).serializeForm();
	_showProgressBar(true);
	$.ajax({
		url : actionSrc,
		type : "post",
		dataType : "json",
		data : theForm + "&selSerialNoSG=" + selSerialNoSG
			+ "&selSerialNoEP=" + selSerialNoEP + "&allRowsSG="
			+ allRowsSG + "&allRowsEP=" + allRowsEP
			+ "&subscriptionCO.gridTypeSG=" + gridTypeSG
			+ "&subscriptionCO.gridTypeEP=" + gridTypeEP
			+ "&_pageRef=" + _pageRef,

		success : function(data)
		{
			if (data["_error"] == null)
			{
				$("#populatedYN_" + _pageRef).val("1");

				var theform = document.getElementById("subscriptionMaintForm_"+ _pageRef);
				$.data(theform, 'changeTrack', true);
				/*
				 * var enableDelete = 0;
				 * 
				 * 
				 * 
				 * var alrtSubGrd = returnsGridSelected();
				 * 
				 * var rowIds = alrtSubGrd.jqGrid('getDataIDs'); var
				 * myObject;
				 * 
				 * for(i= 0 ;i< rowIds.length;i++){ myObject =
				 * alrtSubGrd.jqGrid('getRowData', rowIds[i]);
				 * if(myObject["alrtSubEvtTmpVO.SUB_EVT_STATUS"] != 'C' ){
				 * enableDelete = 1; break; } }
				 * 
				 * if(enableDelete == 1){
				 * makeElementReadonly("subscriptionMaint_delete_selected_"+_pageRef,false); }
				 * else{
				 * makeElementReadonly("subscriptionMaint_delete_selected_"+_pageRef,true); }
				 */
				// var myObject = details.jqGrid('getRowData',
				// rowIds[0]);
				var params = {};
				var url = jQuery.contextPath
						+ "/path/alert/subscription/SubscriptionMaintAction_afterPopulateVisibility?subscriptionCO.row="
						+ data.subscriptionCO.row;
				$.ajax({
					url : url,
					type : "post",
					dataType : "json",
					data : params,
					success : function(data)
					{
						if (data["_error"] == null)
						{
							applyAdditionalDynamicDisplay(data["additionalScreenParams"]);
							 $("#subscriptionMaint_save_populated_" + _pageRef).attr('disabled' , false);
							// reloadDetGridsOnSuccess(subscriptionType);
							var reloadParams = {
								"subscriptionSC.retreiveCrud" : 'N'
							};
							var alrtSubGrd;
							if (subscriptionType == "SE")
							{
								alrtSubGrd = $("#subscriptionsEvtGridTbl_Id_"+ _pageRef);
							}
							else if (subscriptionType == "SP")
							{
								alrtSubGrd = $("#subscriptionsPckgGridTbl_Id_"+ _pageRef);
							}
							else if (subscriptionType == "EG")
							{
								alrtSubGrd = $("#groupsEvtGridTbl_Id_"+ _pageRef);
							}
							else if (subscriptionType == "GP")
							{
								alrtSubGrd = $("#groupPckgGridTbl_Id_"+ _pageRef);
							}
							alrtSubGrd.jqGrid('setGridParam', {
								postData : reloadParams,
								loadComplete : function(obj)
								{
								}
							}).trigger("reloadGrid");
						}
					}
				});
			}
			_showProgressBar(false);
		}
	});
}

function deleteSubscription()
{

	var alrtSubGrd = returnsGridSelected();

	var selectedRows = alrtSubGrd.jqGrid('getGridParam', 'selarrrow');
	var subscriptionType = $("#subscription_type_" + _pageRef).val();

	var enableDelete = 0;

	// var alrtSubGrd = returnsGridSelected();

	var rowIds = alrtSubGrd.jqGrid('getDataIDs');
	var myObject;

	for (i = 0; i < rowIds.length; i++)
	{
		myObject = alrtSubGrd.jqGrid('getRowData', rowIds[i]);
		if (myObject["alrtSubEvtTmpVO.SUB_EVT_STATUS"] != 'C')
		{
			enableDelete = 1;
			break;
		}
	}

	if (selectedRows.length > 0 && enableDelete == 1)
	{

		var arg = {
			subscriptionType : subscriptionType
		};
		_showConfirmMsg(are_you_sure_to_dlt_subs, "",
				"continueDeleteValidation", arg, yes_key, no_key);
	}
	else
	{
		if (selectedRows.length == 0)
		{
			_showErrorMsg(no_sub_sel_for_delt);
			return;
		}
	}
}

function continueDeleteValidation(yesNo, arg)
{
	if (yesNo == true)
	{
		var populatedYN = $("#populatedYN_" + _pageRef).val();
		var allrowsSelected = $(
				"#all_rows_" + arg.subscriptionType + "_" + _pageRef).val();
		var selSerialNo = $(
				"#selSerialNo_" + arg.subscriptionType + "_" + _pageRef).val();
		var params = {};

		params["subscriptionCO.selSerialNoDet"] = selSerialNo;
		params["subscriptionCO.allRowsDet"] = allrowsSelected;
		params["_pageRef"] = _pageRef;
		params["subscriptionCO.populatedYN"] = populatedYN;
		params["subscriptionCO.subscriptionType"] = arg.subscriptionType;
		var url = jQuery.contextPath
				+ "/path/alert/subscription/SubscriptionMaintAction_deleteSubscription";
		$.ajax({
			url : url,
			type : "post",
			dataType : "json",
			data : params,
			success : function(data)
			{
				if (data["_error"] == null)
				{
					_showErrorMsg(
							Record_was_Deleted_Successfully_key,
							success_msg_title);
					reloadDetGridsOnSuccess(arg.subscriptionType);
				}
				var subscriptionType = $("#subscription_type_" + _pageRef).val();
				reloadDetGridsOnSuccess(subscriptionType);
			}
		});
	}
}
function updateSubDetailsParams()
{
	var table = $("#fixedEvtsParamGridTbl_Id_" + _pageRef);
	var paramAllRecList = table.jqGrid('getChangedRowData');
	// var _changedRows = table.jqGrid('getChangedRowData');
	if (paramAllRecList != "")
	{
		var details = $("#subscriptionDetailsGridTbl_Id_" + _pageRef);
		// var myObject = details.jqGrid('getRowData', 0);
		var rowIds = details.jqGrid('getDataIDs');
		var myObject = details.jqGrid('getRowData', rowIds[0]);
		var params = {};

		params["subscriptionCO.paramAllRecList"] = paramAllRecList;
		params["subscriptionCO.alrtSubEvtTmpVO.SUB_ID"] = myObject["alrtSubEvtVO.SUB_ID"];
		params["subscriptionCO.alrtSubEvtTmpVO.EVT_ID"] = myObject["alrtSubEvtVO.EVT_ID"];
		params["subscriptionCO.alrtSubEvtTmpVO.ID"] = myObject["alrtSubEvtVO.ID"];
		params["_pageRef"] = _pageRef;
		var url = jQuery.contextPath
				+ "/path/alert/subscription/SubscriptionMaintAction_updateSubDetailsParams";
		$
				.ajax({
					url : url,
					type : "post",
					dataType : "json",
					data : params,
					success : function(data)
					{
						if (data["_error"] == null)
						{
							var subscriptionType = $(
									"#subscription_type_" + _pageRef).val();
							reloadDetGridsOnSuccess(subscriptionType);
							var theform = document
									.getElementById("subscriptionMaintForm_"
											+ _pageRef);
							$.data(theform, 'changeTrack', true);

						}

					}
				});
	}
}
// on Row Select
function dynamicGridSelectRowFuncDet(selectedRowInd, gridType)
{

	var gridId, columnName, columnName2, columnName3, columnName1, variableName;
	variableName = "SUB_ID-EVT_ID";
	if (gridType == 'SE')
	{
		/** subscriber Grid */
		gridId = "#subscriptionsEvtGridTbl_Id_";
		columnName1 = "alrtSubEvtTmpVO.SUB_ID";
		columnName2 = "alrtSubEvtTmpVO.EVT_ID";
		columnName3 = "alrtSubEvtTmpVO.ID";
	}
	else if (gridType == 'SP')
	{
		/** event Grid */
		gridId = "#subscriptionsPckgGridTbl_Id_";
		columnName1 = "alrtSubEvtTmpVO.SUB_ID";
		columnName2 = "alrtSubEvtTmpVO.EVT_ID";
		columnName3 = "alrtSubEvtTmpVO.REL_ID";
		// variableName = "SUB_ID-PKG_ID";
	}
	else if (gridType == 'EG')
	{
		/** group Grid */
		gridId = "#groupsEvtGridTbl_Id_";
		columnName1 = "alrtSubEvtTmpVO.SUB_ID";
		columnName2 = "alrtSubEvtTmpVO.EVT_ID";
		columnName3 = "alrtSubEvtTmpVO.REL_ID";
		// variableName = "EVT_ID-GRP_ID";
	}
	else if(gridType == 'TS')
	{
		gridId = "#subscriptionsPckgGridTbl_Id_";
		columnName1 = "alrtSubEvtTmpVO.SUB_ID";
		columnName2 = "alrtSubEvtTmpVO.EVT_ID";
		columnName3 = "alrtSubEvtTmpVO.REL_ID";
	}
	else
	{
		/** package Grid */
		gridId = "#groupPckgGridTbl_Id_";
		columnName1 = "alrtSubEvtTmpVO.SUB_ID";
		columnName2 = "alrtSubEvtTmpVO.EVT_ID";
		columnName3 = "alrtSubEvtTmpVO.REL_ID";
		// variableName = "GRP_ID-PKG_ID";
	}
	var $table = $(gridId + _pageRef);
	var rowId = selectedRowInd.originalEvent.id;
	var myObject = $table.jqGrid('getRowData', rowId);
	var selSerialNo2 = ($("#selSerialNo_" + gridType + "_" + _pageRef).val() != "") ? eval("("
			+ $("#selSerialNo_" + gridType + "_" + _pageRef).val() + ")")
			: new Object();

	var varId = myObject[columnName1] + "-" + myObject[columnName2] + "";
	if (selectedRowInd.originalEvent.status)
	{

		selSerialNo2["varId_" + varId] = "{\"" + variableName + "\":\""
				+ myObject[columnName1] + "~" + myObject[columnName2] + "~"
				+ myObject[columnName3] + "\"}";
	}
	else
	{
		selSerialNo2["varId_" + varId] = undefined;
		$("#all_rows_" + gridType + "_" + _pageRef).val("0");
	}

	$("#selSerialNo_" + gridType + "_" + _pageRef).val(
			JSON.stringify(selSerialNo2));

}

function dynamicGridSelectAllFuncDet(selectedRowInd, gridType)
{
	var params = {};
	params["subscriptionSC.gridType"] = gridType;
	params["subscriptionSC.crud"] = $("#iv_crud_" + _pageRef).val();
	var gridId, columnName1, columnName2, columnName3, variableName;

	variableName = "SUB_ID-EVT_ID";
	if (gridType == 'SE')
	{
		/** subscriber Grid */
		gridId = "#subscriptionsEvtGridTbl_Id_";
		columnName1 = "alrtSubEvtTmpVO.SUB_ID";
		columnName2 = "alrtSubEvtTmpVO.EVT_ID";
		columnName3 = "alrtSubEvtTmpVO.REL_ID";

	}
	else if (gridType == 'SP')
	{
		/** event Grid */
		gridId = "#subscriptionsPckgGridTbl_Id_";
		columnName1 = "alrtSubEvtTmpVO.SUB_ID";
		columnName2 = "alrtSubEvtTmpVO.EVT_ID";
		columnName3 = "alrtSubEvtTmpVO.REL_ID";
		// variableName = "SUB_ID-PKG_ID";
	}
	else if (gridType == 'EG')
	{
		/** group Grid */
		gridId = "#groupsEvtGridTbl_Id_";
		columnName1 = "alrtSubEvtTmpVO.SUB_ID";
		columnName2 = "alrtSubEvtTmpVO.EVT_ID";
		columnName3 = "alrtSubEvtTmpVO.REL_ID";
		// variableName = "EVT_ID-GRP_ID";
	}
	else if(gridType == 'TS')
	{
		gridId = "#subscriptionsPckgGridTbl_Id_";
		columnName1 = "alrtSubEvtTmpVO.SUB_ID";
		columnName2 = "alrtSubEvtTmpVO.EVT_ID";
		columnName3 = "alrtSubEvtTmpVO.REL_ID";
	}
	else
	{
		/** package Grid */
		gridId = "#groupPckgGridTbl_Id_";
		columnName1 = "alrtSubEvtTmpVO.SUB_ID";
		columnName2 = "alrtSubEvtTmpVO.EVT_ID";
		columnName3 = "alrtSubEvtTmpVO.REL_ID";
		// variableName = "GRP_ID-PKG_ID";
	}

	var $table = $(gridId + _pageRef);
	if (selectedRowInd.originalEvent.status)
	{
		var totalRow = $table.jqGrid('getGridParam', 'records');
		var rowNum = $table.jqGrid('getGridParam', 'rowNum');

		if (totalRow > rowNum)
		{
			var gridUrl = jQuery.contextPath
					+ "/path/alert/subscription/SubscriptionListAction_returnAllSelectedRowDet";

			$.ajax({
				url : gridUrl,
				type : "post",
				dataType : "json",
				data : params,
				success : function(data)
				{
					$("#selSerialNo_" + gridType + "_" + _pageRef).val(
							data.allSelectedRow2);
					$("#all_rows_" + gridType + "_" + _pageRef).val("1");
				}
			});
		}
		else
		{
			for (i = 0; i < selectedRowInd.originalEvent.ids.length; i++)
			{
				dynamicGridOnePageRowsFuncDet(
						selectedRowInd.originalEvent.ids[i],
						selectedRowInd.originalEvent.status, gridType);
			}
			$("#all_rows_" + gridType + "_" + _pageRef).val("0");
		}
	}
	else
	{
		$("#selSerialNo_" + gridType + "_" + _pageRef).val("");
		$("#all_rows_" + gridType + "_" + _pageRef).val("0");
	}

}

// if only record in one page
function dynamicGridOnePageRowsFuncDet(selectedRowId, status, gridType)
{
	var gridId, columnName1, columnName2, columnName3, variableName;
	variableName = "SUB_ID-EVT_ID";
	if (gridType == 'SE')
	{
		/** subscriber EVT Grid */
		gridId = "#subscriptionsEvtGridTbl_Id_";
		columnName1 = "alrtSubEvtTmpVO.SUB_ID";
		columnName2 = "alrtSubEvtTmpVO.EVT_ID";
		columnName3 = "alrtSubEvtTmpVO.REL_ID";

	}
	else if (gridType == 'SP')
	{
		/** event Grid */
		gridId = "#subscriptionsPckgGridTbl_Id_";
		columnName1 = "alrtSubEvtTmpVO.SUB_ID";
		columnName2 = "alrtSubEvtTmpVO.EVT_ID";
		columnName3 = "alrtSubEvtTmpVO.REL_ID";
		// variableName = "SUB_ID-PKG_ID";
	}
	else if (gridType == 'EG')
	{
		/** group Grid */
		gridId = "#groupsEvtGridTbl_Id_";
		columnName1 = "alrtSubEvtTmpVO.SUB_ID";
		columnName2 = "alrtSubEvtTmpVO.EVT_ID";
		columnName3 = "alrtSubEvtTmpVO.REL_ID";
		// variableName = "EVT_ID-GRP_ID";
	}
	else
	{
		/** package Grid */
		gridId = "#groupPckgGridTbl_Id_";
		columnName1 = "alrtSubEvtTmpVO.SUB_ID";
		columnName2 = "alrtSubEvtTmpVO.EVT_ID";
		columnName3 = "alrtSubEvtTmpVO.REL_ID";
		// variableName = "GRP_ID-PKG_ID";
	}
	var $table = $(gridId + _pageRef);
	var myObject = $table.jqGrid('getRowData', selectedRowId);
	var selSerialNo2 = ($("#selSerialNo_" + gridType + "_" + _pageRef).val() != "") ? eval("("
			+ $("#selSerialNo_" + gridType + "_" + _pageRef).val() + ")")
			: new Object();

	var varId = myObject[columnName1] + "-" + myObject[columnName2] + "";
	if (status)
	{
		selSerialNo2["varId_" + varId] = "{\"" + variableName + "\":\""
				+ myObject[columnName1] + "~" + myObject[columnName2] + "~"
				+ myObject[columnName3] + "\"}";
	}
	else
	{
		selSerialNo2["varId_" + varId] = undefined;
		$("#all_rows_" + gridType + "_" + _pageRef).val("0");
	}

	$("#selSerialNo_" + gridType + "_" + _pageRef).val(
			JSON.stringify(selSerialNo2));

}

function onAfterBatchDetailScreenLoadDet(selectedRowId, gridType)
{
	var gridId, columnName1, columnName2, columnName3, variableName;
	variableName = "SUB_ID-EVT_ID";
	if (gridType == 'SE')
	{
		/**
		 * show select all check box on grid only for maintenance and approve screen
		 */
		if(_pageRef != "SBT00SEMT" && _pageRef != "SBT00SEP")
		{
			$("#cb_subscriptionsEvtGridTbl_Id_"+_pageRef).attr("style","visibility:hidden");
		}
		
		/** subscriber evt Grid */
		gridId = "#subscriptionsEvtGridTbl_Id_";
		columnName1 = "alrtSubEvtTmpVO.SUB_ID";
		columnName2 = "alrtSubEvtTmpVO.EVT_ID";
		columnName3 = "alrtSubEvtTmpVO.REL_ID";
	}
	else if (gridType == 'SP')
	{
		$("#cb_subscriptionsPckgGridTbl_Id_"+_pageRef).attr("style","visibility:hidden");
		/** event Grid */
		gridId = "#subscriptionsPckgGridTbl_Id_";
		columnName1 = "alrtSubEvtTmpVO.SUB_ID";
		columnName2 = "alrtSubEvtTmpVO.EVT_ID";
		columnName3 = "alrtSubEvtTmpVO.REL_ID";
		// variableName = "SUB_ID-PKG_ID";
	}
	else if (gridType == 'EG')
	{
		$("#cb_groupsEvtGridTbl_Id_"+_pageRef).attr("style","visibility:hidden");
		/** group Grid */
		gridId = "#groupsEvtGridTbl_Id_";
		columnName1 = "alrtSubEvtTmpVO.SUB_ID";
		columnName2 = "alrtSubEvtTmpVO.EVT_ID";
		columnName3 = "alrtSubEvtTmpVO.REL_ID";
		// variableName = "EVT_ID-GRP_ID";
	}
	else
	{
		$("#cb_groupPckgGridTbl_Id_"+_pageRef).attr("style","visibility:hidden");
		/** package Grid */
		gridId = "#groupPckgGridTbl_Id_";
		columnName1 = "alrtSubEvtTmpVO.SUB_ID";
		columnName2 = "alrtSubEvtTmpVO.EVT_ID";
		columnName3 = "alrtSubEvtTmpVO.REL_ID";
		// variableName = "GRP_ID-PKG_ID";
	}
	var $table = $(gridId + _pageRef);
	var rows = $table.jqGrid('getDataIDs');
	var rowsLen = rows.length;
	var rowNum = $table.jqGrid('getGridParam', 'rowNum');
	selSerialNo2 = ($("#selSerialNo_" + gridType + "_" + _pageRef).val() != "") ? eval("("
			+ $("#selSerialNo_" + gridType + "_" + _pageRef).val() + ")")
			: new Object();

	if (!$.isEmptyObject(selSerialNo2))
	{
		for (var j = 1; j <= rowNum; j++)
		{
			var myObject = $table.jqGrid('getRowData', j);
			var varId = myObject[columnName1] + "-" + myObject[columnName2]
					+ "";
			if (selSerialNo2["varId_" + varId] != undefined)
			{
				$table.jqGrid('setSelection', j, true);

			}
			
			if(gridType=='SE' || gridType=='EG'){
			reloadUrl = jQuery.contextPath + "/path/alert/subscription/SubscriptionMaintAction_checkEventModeFlags.action";
			var ivCrud = returnHtmlEltValue("iv_crud_"+ _pageRef);
			var reloadParams = {};
			if(JSON.stringify(myObject) != '{}')
			{
				reloadParams["subscriptionCO.alrtSubEvtTmpVO.EVT_ID"] = myObject["alrtSubEvtTmpVO.EVT_ID"];
				reloadParams["subscriptionCO.alrtSubEvtTmpVO.SUB_ID"] = myObject["alrtSubEvtTmpVO.SUB_ID"];
				reloadParams["subscriptionCO.alrtSubEvtTmpVO.ID"] = myObject["alrtSubEvtTmpVO.ID"];
				reloadParams["subscriptionCO.alrtSubEvtTmpVO.REL_ID"] = myObject["alrtSubEvtTmpVO.REL_ID"];
				reloadParams["subscriptionCO.alrtSubEvtTmpVO.REL_TYPE"] = myObject["alrtSubEvtTmpVO.REL_TYPE"];
				reloadParams["updates"] = j;
				
				$.post(reloadUrl,reloadParams,function(param) 
						{
						param = JSON.parse(param);
						$table.jqGrid('setCellValue',param.updates,'alrtSubEvtVO.EMAIL_YN',param.subscriptionCO.alrtSubEvtVO.EMAIL_YN);
						$table.jqGrid('setCellValue',param.updates,'alrtSubEvtVO.FILE_YN',param.subscriptionCO.alrtSubEvtVO.FILE_YN);
						$table.jqGrid('setCellValue',param.updates,'alrtSubEvtVO.FACEBOOK_PRIVATE_WALL_YN',param.subscriptionCO.alrtSubEvtVO.FACEBOOK_PRIVATE_WALL_YN);
						$table.jqGrid('setCellValue',param.updates,'alrtSubEvtVO.INBOX_YN',param.subscriptionCO.alrtSubEvtVO.INBOX_YN);
						$table.jqGrid('setCellValue',param.updates,'alrtSubEvtVO.MOBILE_PUSH_NOTIFICATION_YN',param.subscriptionCO.alrtSubEvtVO.MOBILE_PUSH_NOTIFICATION_YN);
						$table.jqGrid('setCellValue',param.updates,'alrtSubEvtVO.SMS_YN',param.subscriptionCO.alrtSubEvtVO.SMS_YN);
						$table.jqGrid('setCellValue',param.updates,'alrtSubEvtVO.TWITTER_DIRECT_MESSAGE_YN',param.subscriptionCO.alrtSubEvtVO.TWITTER_DIRECT_MESSAGE_YN);
						$table.jqGrid('setCellValue',param.updates,'alrtSubEvtVO.SRC_CONTACT_TYPE',param.subscriptionCO.alrtSubEvtVO.SRC_CONTACT_TYPE);
						}, "html");
			}
			}
		}
	}
	else
	{
		for (var j = 1; j <= rowNum; j++)
		{
			var myObject = $table.jqGrid('getRowData', j);
			var varId = myObject[columnName1] + "-" + myObject[columnName2]
					+ "";
			if (selSerialNo2["varId_" + varId] != undefined)
			{
				$table.jqGrid('setSelection', j, false);
			}
			
			if(gridType=='SE' || gridType=='EG'){
			reloadUrl = jQuery.contextPath + "/path/alert/subscription/SubscriptionMaintAction_checkEventModeFlags.action";
			var ivCrud = returnHtmlEltValue("iv_crud_"+ _pageRef);
			var reloadParams = {};
			if(JSON.stringify(myObject) != '{}')
			{
				reloadParams["subscriptionCO.alrtSubEvtTmpVO.EVT_ID"] = myObject["alrtSubEvtTmpVO.EVT_ID"];
				reloadParams["subscriptionCO.alrtSubEvtTmpVO.SUB_ID"] = myObject["alrtSubEvtTmpVO.SUB_ID"];
				reloadParams["subscriptionCO.alrtSubEvtTmpVO.ID"] = myObject["alrtSubEvtTmpVO.ID"];
				reloadParams["subscriptionCO.alrtSubEvtTmpVO.REL_ID"] = myObject["alrtSubEvtTmpVO.REL_ID"];
				reloadParams["subscriptionCO.alrtSubEvtTmpVO.REL_TYPE"] = myObject["alrtSubEvtTmpVO.REL_TYPE"];
				reloadParams["updates"] = j;
				
				$.post(reloadUrl,reloadParams,function(param) 
						{
						param = JSON.parse(param);
						$table.jqGrid('setCellValue',param.updates,'alrtSubEvtVO.EMAIL_YN',param.subscriptionCO.alrtSubEvtVO.EMAIL_YN);
						$table.jqGrid('setCellValue',param.updates,'alrtSubEvtVO.FILE_YN',param.subscriptionCO.alrtSubEvtVO.FILE_YN);
						$table.jqGrid('setCellValue',param.updates,'alrtSubEvtVO.FACEBOOK_PRIVATE_WALL_YN',param.subscriptionCO.alrtSubEvtVO.FACEBOOK_PRIVATE_WALL_YN);
						$table.jqGrid('setCellValue',param.updates,'alrtSubEvtVO.INBOX_YN',param.subscriptionCO.alrtSubEvtVO.INBOX_YN);
						$table.jqGrid('setCellValue',param.updates,'alrtSubEvtVO.MOBILE_PUSH_NOTIFICATION_YN',param.subscriptionCO.alrtSubEvtVO.MOBILE_PUSH_NOTIFICATION_YN);
						$table.jqGrid('setCellValue',param.updates,'alrtSubEvtVO.SMS_YN',param.subscriptionCO.alrtSubEvtVO.SMS_YN);
						$table.jqGrid('setCellValue',param.updates,'alrtSubEvtVO.TWITTER_DIRECT_MESSAGE_YN',param.subscriptionCO.alrtSubEvtVO.TWITTER_DIRECT_MESSAGE_YN);
						$table.jqGrid('setCellValue',param.updates,'alrtSubEvtVO.SRC_CONTACT_TYPE',param.subscriptionCO.alrtSubEvtVO.SRC_CONTACT_TYPE);
						if(ivCrud == "P" || ivCrud == "D")
						{
							$table.jqGrid("setCellReadOnly",param.updates, 'alrtSubEvtVO.EMAIL_YN', "true");
							$table.jqGrid("setCellReadOnly",param.updates, 'alrtSubEvtVO.FILE_YN', "true");
							$table.jqGrid("setCellReadOnly",param.updates, 'alrtSubEvtVO.FACEBOOK_PRIVATE_WALL_YN', "true");
							$table.jqGrid("setCellReadOnly",param.updates, 'alrtSubEvtVO.INBOX_YN', "true");
							$table.jqGrid("setCellReadOnly",param.updates, 'alrtSubEvtVO.MOBILE_PUSH_NOTIFICATION_YN', "true");
							$table.jqGrid("setCellReadOnly",param.updates, 'alrtSubEvtVO.SMS_YN', "true");
							$table.jqGrid("setCellReadOnly",param.updates, 'alrtSubEvtVO.TWITTER_DIRECT_MESSAGE_YN', "true");
							$table.jqGrid("setCellReadOnly",param.updates, 'alrtSubEvtVO.SRC_CONTACT_TYPE', "true");
						}
						}, "html");
			}
			}
		}
	}

}
function reloadDetGridsOnSuccess(subscriptionType)
{
	if (subscriptionType == "SE")
	{
		var isSelectAll = $("#selectAllSubEvtGridFlag_"+_pageRef).val();
		if(isSelectAll == 1)
		{
			$("#subscriptionsEvtGridTbl_Id_"+_pageRef).jqGrid("clearGridData");
			$("#cb_subscriptionsEvtGridTbl_Id_"+_pageRef).prop("checked",false);
			
			if(_pageRef == "SBT00SEMT")
			{
				$("#selSerialNo_S_" + _pageRef).val("");
				$("#all_rows_S_" + _pageRef).val("");
				$("#selSerialNo_E_" + _pageRef).val("");
				$("#all_rows_E_" + _pageRef).val("");
				$("#selectAllSubEvtGridFlag_"+_pageRef).val("");
				
				//SubscriptionMaint_selectRecordForAllSelectedRecords("subscriberGridTbl_Id");
				//SubscriptionMaint_selectRecordForAllSelectedRecords("eventsGridTbl_Id");
				$("#cb_subscriberGridTbl_Id_"+_pageRef).prop("checked",false);
				$("#cb_eventsGridTbl_Id_"+_pageRef).prop("checked",false);
				$("#subscriberGridTbl_Id_" + _pageRef).trigger("reloadGrid");
				$("#eventsGridTbl_Id_" + _pageRef).trigger("reloadGrid");
			}
		}
		else
		{
			$("#subscriptionsEvtGridTbl_Id_" + _pageRef).trigger("reloadGrid");
		}
		
		
	}
	else if (subscriptionType == "SP")
	{
		$("#subscriptionsPckgGridTbl_Id_" + _pageRef).trigger("reloadGrid");
	}
	else if (subscriptionType == "EG")
	{
		$("#groupsEvtGridTbl_Id_" + _pageRef).trigger("reloadGrid");
	}
	else if (subscriptionType == "GP")
	{
		$("#groupPckgGridTbl_Id_" + _pageRef).trigger("reloadGrid");
	}
}

function returnsGridSelected()
{
	var subscriptionType = $("#subscription_type_" + _pageRef).val();
	var alrtSubGrd;
	if (subscriptionType == "SE")
	{

		alrtSubGrd = $("#subscriptionsEvtGridTbl_Id_" + _pageRef);

	}
	else if (subscriptionType == "SP")
	{

		alrtSubGrd = $("#subscriptionsPckgGridTbl_Id_" + _pageRef);

	}
	else if (subscriptionType == "EG")
	{

		alrtSubGrd = $("#groupsEvtGridTbl_Id_" + _pageRef);

	}
	else if (subscriptionType == "GP")
	{

		alrtSubGrd = $("#groupPckgGridTbl_Id_" + _pageRef);

	}
	return alrtSubGrd;
}

function saveSubscription()
{
	var alrtSubGrd = returnsGridSelected();
	var selectedRows = alrtSubGrd.jqGrid('getGridParam', 'selarrrow');
	if (selectedRows.length > 0)
	{
		_showProgressBar(true);
		if (ifSubscriptionFormChanged() == true)
		{
			//alrtSubEvtTmpVO.SUB_EVT_STATUS
			var crud = $("#iv_crud_" + _pageRef).val();
			var actionSrc = jQuery.contextPath+ "/path/alert/subscription/SubscriptionMaintAction_saveSubscription?iv_crud="+ crud;
			
			//set updates in checkbox fields and src of contact dropdown (for SE and GE subscriptions only)
			var subscriptionType = $("#subscription_type_" + _pageRef).val();
			if (subscriptionType == "SE")
			{
				/**
				 * Added condition if all rows selected then 
				 * set on in flag for bulk insert
				 */
				var $selectAllSubEvtGridFlag = $("#selectAllSubEvtGridFlag_"+_pageRef);
				if ($('#cb_subscriptionsEvtGridTbl_Id_SBT00SEMT').is(":checked"))
				{
					$selectAllSubEvtGridFlag.val("1");
				}
				else
				{
					$selectAllSubEvtGridFlag.val("0");
				}
				var jsonStringUpdates = $("#subscriptionsEvtGridTbl_Id_" + _pageRef).jqGrid('getChangedRowData');
				$("#subscriptionsEvtGrid_" + _pageRef).val(jsonStringUpdates);
			}
			else if (subscriptionType == "EG")
			{
				var jsonStringUpdates =  $("#groupsEvtGridTbl_Id_" + _pageRef).jqGrid('getAllRows');
				$("#groupsEvtGrid_" + _pageRef).val(jsonStringUpdates);
			}
			var selSerialNo = $("#selSerialNo_" + subscriptionType + "_" + _pageRef).val();
			$('#selSerialNoDet_'+_pageRef).val(selSerialNo);
			var theForm = $("#subscriptionMaintForm_" + _pageRef).serializeForm();
			$.ajax({
				url : actionSrc,
				type : "post",
				dataType : "json",
				data : theForm,
				success : function(data)
				{
					if (data["_error"] == null)
					{
						if(typeof data.subscriptionCO != "undefined" &&  data.subscriptionCO.row >= 1)
						{
							_showErrorMsg(record_saved_Successfully_key,success_msg_title);
						}
						else
						{
							_showErrorMsg(changes_not_available_key,success_msg_title);
						}
						
						reloadDetGridsOnSuccess(subscriptionType);
						_showProgressBar(false);
						
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
			_showErrorMsg(changes_not_available_key, error_msg_title);
		}
	}
	else
	{
		_showProgressBar(false);
		_showErrorMsg(no_record_selected, error_msg_title);
	}
}

function updateAfterApproveSubscription()
{
	var alrtSubGrd = returnsGridSelected();
	var selectedRows = alrtSubGrd.jqGrid('getGridParam', 'selarrrow');
	if (selectedRows.length > 0)
	{
	if (ifSubscriptionFormChanged() == true)
	{
		//alrtSubEvtTmpVO.SUB_EVT_STATUS
		var crud = $("#iv_crud_" + _pageRef).val();
		var actionSrc = jQuery.contextPath+"/path/alert/subscription/SubscriptionMaintAction_updateAfterApproveSubscription?iv_crud="+ crud;
		
		//set updates in checkbox fields and src of contact dropdown (for SE and GE subscriptions only)
		var subscriptionType = $("#subscription_type_" + _pageRef).val();
		if (subscriptionType == "SE")
		{
			var jsonStringUpdates = $("#subscriptionsEvtGridTbl_Id_" + _pageRef).jqGrid('getChangedRowData');
			$("#subscriptionsEvtGrid_" + _pageRef).val(jsonStringUpdates);
		}
		else if (subscriptionType == "EG")
		{
			var jsonStringUpdates =  $("#groupsEvtGridTbl_Id_" + _pageRef).jqGrid('getAllRows');
			$("#groupsEvtGrid_" + _pageRef).val(jsonStringUpdates);
		}
		
		var theForm = $("#subscriptionMaintForm_" + _pageRef).serializeForm();

		_showProgressBar(true);
		$.ajax({
			url : actionSrc,
			type : "post",
			dataType : "json",
			data : theForm,
			success : function(data)
			{
				if (data["_error"] == null)
				{
					 var subscriptionType = $( "#subscription_type_" +_pageRef).val(); // / data.subscriptionCO.doAudit = 1;
					 reloadDetGridsOnSuccess(subscriptionType);
					 _showErrorMsg(record_saved_Successfully_key,success_msg_title);
					 _showProgressBar(false);
					 $("#subscriptionMaint_save_populated_" + _pageRef).attr('disabled' , 'disabled');
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

		
		_showErrorMsg(changes_not_available_key, error_msg_title);
	}
	}
}


function approveSubscription()
{
	var subscriptionType = $("#subscription_type_" + _pageRef).val();
	var approveSubEvtBulk = 0;
	
	/********************* Start *******************************************
	/**
	 * Check Approve Bulk Subscriber Event
	 */
	if(subscriptionType != null && typeof  subscriptionType != "undefined" && subscriptionType == "SE")
	{
		/**
		 * Added condition if all rows selected then 
		 * set on in flag for bulk insert
		 */
		if ($('#cb_subscriptionsEvtGridTbl_Id_SBT00SEP').is(":checked"))
		{
			approveSubEvtBulk = 1;
		}
		else
		{
			approveSubEvtBulk = 0;
		}
	}
	//********************* Ends *******************************************
	
	var alrtSubGrd = returnsGridSelected();
	var selectedRows = alrtSubGrd.jqGrid('getGridParam', 'selarrrow');
	if (selectedRows.length > 0)
	{
		
		var allrowsSelected = $("#all_rows_" + subscriptionType + "_" + _pageRef).val();
		var selSerialNo = $("#selSerialNo_" + subscriptionType + "_" + _pageRef).val();
		var params = {};

		params["subscriptionCO.selSerialNoDet"] = selSerialNo;
		params["subscriptionCO.allRowsDet"] = allrowsSelected;
		params["subscriptionCO.subscriptionType"] = subscriptionType;
		params["iv_crud"] = $("#iv_crud_" + _pageRef).val();
		params["subscriptionCO.allRowsSubscription"] = alrtSubGrd.jqGrid('getAllRows');
		params["subscriptionCO.allRowsSE"] = approveSubEvtBulk;

		var actionSrc = jQuery.contextPath+ "/path/alert/subscription/SubscriptionMaintAction_approveSubscription";
		_showProgressBar(true);
		$.ajax({
			url : actionSrc,
			type : "post",
			dataType : "json",
			data : params,
			success : function(data)
			{
				if (data["_error"] == null)
				{
					var subscriptionType = $("#subscription_type_" + _pageRef).val();
					reloadDetGridsOnSuccess(subscriptionType);
					$("#all_rows_" + subscriptionType + "_"+ _pageRef).val("");
					$("#selSerialNo_" + subscriptionType+ "_" + _pageRef).val("");
					if(approveSubEvtBulk == 1)
					{
						_showErrorMsg(all_records_approved_successfully_key, success_msg_title);
					}
					else
					{
						_showErrorMsg(record_was_Approved_Successfully_key, success_msg_title);
					}
					
				}
				var subscriptionType = $("#subscription_type_" + _pageRef).val();
				reloadDetGridsOnSuccess(subscriptionType);
				_showProgressBar(false);
			}
		});
	}
}

function toBeSuspendSubscription()
{

	var alrtSubGrd = returnsGridSelected();
	var selectedRows = alrtSubGrd.jqGrid('getGridParam', 'selarrrow');
	if (selectedRows.length > 0)
	{
		var subscriptionType = $("#subscription_type_" + _pageRef).val();
		var allrowsSelected = $("#all_rows_" + subscriptionType + "_" + _pageRef).val();
		var selSerialNo = $("#selSerialNo_" + subscriptionType + "_" + _pageRef).val();
		var params = {};
		
		params["subscriptionCO.selSerialNoDet"] = selSerialNo;
		params["subscriptionCO.subscriptionType"] = subscriptionType;
		params["subscriptionCO.allRowsDet"] = allrowsSelected;
		params["iv_crud"] = $("#iv_crud_" + _pageRef).val();
		params["_pageRef"] = _pageRef;
		_showProgressBar(true);
		var actionSrc = jQuery.contextPath
				+ "/path/alert/subscription/SubscriptionMaintAction_toBeSuspendSubscription";

		$
				.ajax({
					url : actionSrc,
					type : "post",
					dataType : "json",
					data : params,
					success : function(data)
					{
						if (data["_error"] == null)
						{

							var subscriptionType = $(
									"#subscription_type_" + _pageRef).val();
							reloadDetGridsOnSuccess(subscriptionType);
							$("#all_rows_" + subscriptionType + "_" + _pageRef)
									.val("");
							$(
									"#selSerialNo_" + subscriptionType + "_"
											+ _pageRef).val("");

						}
						_showProgressBar(false);
					}

				});

	}

}

function suspendSubscription()
{
	
	var alrtSubGrd = returnsGridSelected();
	
	var selectedRows = alrtSubGrd.jqGrid('getGridParam', 'selarrrow');
	if (selectedRows.length > 0)
	{
		var subscriptionType = $("#subscription_type_" + _pageRef).val();
		
		var allrowsSelected = $(
				"#all_rows_" + subscriptionType + "_" + _pageRef).val();
		var selSerialNo = $("#selSerialNo_" + subscriptionType + "_" + _pageRef)
		.val();
		var params = {};
		
		params["subscriptionCO.selSerialNoDet"] = selSerialNo;
		params["subscriptionCO.subscriptionType"] = subscriptionType;
		params["subscriptionCO.allRowsDet"] = allrowsSelected;
		params["iv_crud"] = $("#iv_crud_" + _pageRef).val();
		params["_pageRef"] = _pageRef;
		_showProgressBar(true);
		var actionSrc = jQuery.contextPath
		+ "/path/alert/subscription/SubscriptionMaintAction_suspendSubscription";
		
		$
		.ajax({
			url : actionSrc,
			type : "post",
			dataType : "json",
			data : params,
			success : function(data)
			{
				var subscriptionType = $("#subscription_type_" + _pageRef).val();
				if (data["_error"] == null)
				{
					reloadDetGridsOnSuccess(subscriptionType);
					$("#all_rows_" + subscriptionType + "_" + _pageRef)
					.val("");
					$(
							"#selSerialNo_" + subscriptionType + "_"
							+ _pageRef).val("");
					
					_showErrorMsg(
							Record_was_Suspended_Successfully_key,
							success_msg_title);
				}
				reloadDetGridsOnSuccess(subscriptionType);
				_showProgressBar(false);
			}
		});
	}
}

function toBeReactivateSubscription()
{

	var alrtSubGrd = returnsGridSelected();

	var selectedRows = alrtSubGrd.jqGrid('getGridParam', 'selarrrow');
	if (selectedRows.length > 0)
	{
		var subscriptionType = $("#subscription_type_" + _pageRef).val();

		var allrowsSelected = $(
				"#all_rows_" + subscriptionType + "_" + _pageRef).val();
		var selSerialNo = $("#selSerialNo_" + subscriptionType + "_" + _pageRef)
				.val();
		var params = {};

		params["subscriptionCO.selSerialNoDet"] = selSerialNo;
		params["subscriptionCO.subscriptionType"] = subscriptionType;
		params["subscriptionCO.allRowsDet"] = allrowsSelected;
		params["iv_crud"] = $("#iv_crud_" + _pageRef).val();
		params["_pageRef"] = _pageRef;
		_showProgressBar(true);
		var actionSrc = jQuery.contextPath
				+ "/path/alert/subscription/SubscriptionMaintAction_toBeReactivateSubscription";

		$
				.ajax({
					url : actionSrc,
					type : "post",
					dataType : "json",
					data : params,
					success : function(data)
					{
						if (data["_error"] == null)
						{

							var subscriptionType = $(
									"#subscription_type_" + _pageRef).val();
							reloadDetGridsOnSuccess(subscriptionType);
							$("#all_rows_" + subscriptionType + "_" + _pageRef)
									.val("");
							$(
									"#selSerialNo_" + subscriptionType + "_"
											+ _pageRef).val("");

						}
						_showProgressBar(false);
					}

				});

	}

}

function reactivateSubscription()
{
	
	var alrtSubGrd = returnsGridSelected();
	
	var selectedRows = alrtSubGrd.jqGrid('getGridParam', 'selarrrow');
	if (selectedRows.length > 0)
	{
		var subscriptionType = $("#subscription_type_" + _pageRef).val();
		
		var allrowsSelected = $(
				"#all_rows_" + subscriptionType + "_" + _pageRef).val();
		var selSerialNo = $("#selSerialNo_" + subscriptionType + "_" + _pageRef)
		.val();
		var params = {};
		
		params["subscriptionCO.selSerialNoDet"] = selSerialNo;
		params["subscriptionCO.subscriptionType"] = subscriptionType;
		params["subscriptionCO.allRowsDet"] = allrowsSelected;
		params["iv_crud"] = $("#iv_crud_" + _pageRef).val();
		params["_pageRef"] = _pageRef;
		_showProgressBar(true);
		var actionSrc = jQuery.contextPath
		+ "/path/alert/subscription/SubscriptionMaintAction_reactivateSubscription";
		
		$
		.ajax({
			url : actionSrc,
			type : "post",
			dataType : "json",
			data : params,
			success : function(data)
			{
				var subscriptionType = $("#subscription_type_" + _pageRef).val();
				if (data["_error"] == null)
				{
					reloadDetGridsOnSuccess(subscriptionType);
					$("#all_rows_" + subscriptionType + "_" + _pageRef)
					.val("");
					$("#selSerialNo_" + subscriptionType + "_"+ _pageRef).val("");
					
					_showErrorMsg(
							record_reactivated_key,
							success_msg_title);
				}
				reloadDetGridsOnSuccess(subscriptionType);
				_showProgressBar(false);
			}
		});
	}
}

function retrieveSubscription()
{

	var subscriptionType = $("#subscription_type_" + _pageRef).val();
	var params = {};

	params["subscriptionSC.type"] = subscriptionType;
	params["iv_crud"] = 'C';

	var reloadParams = {

		"subscriptionSC.retreiveCrud" : 'C'
	};

	var alrtSubGrd;
	if (subscriptionType == "SE")
	{
		alrtSubGrd = $("#subscriptionsEvtGridTbl_Id_" + _pageRef);
	}
	else if (subscriptionType == "SP")
	{
		alrtSubGrd = $("#subscriptionsPckgGridTbl_Id_" + _pageRef);

	}
	else if (subscriptionType == "EG")
	{
		alrtSubGrd = $("#groupsEvtGridTbl_Id_" + _pageRef);

	}
	else if (subscriptionType == "GP")
	{
		alrtSubGrd = $("#groupPckgGridTbl_Id_" + _pageRef);

	}
	alrtSubGrd
			.jqGrid(
					'setGridParam',
					{
						postData : reloadParams,
						loadComplete : function(obj)
						{
							$("#populatedYN_" + _pageRef).val("0");
							var params = {};
							var url = jQuery.contextPath
									+ "/path/alert/subscription/SubscriptionMaintAction_afterPopulateVisibility?subscriptionCO.row="
									+ 1;
							$
									.ajax({
										url : url,
										type : "post",
										dataType : "json",
										data : params,
										success : function(data)
										{
											if (data["_error"] == null)
											{
												applyAdditionalDynamicDisplay(data["additionalScreenParams"]);

												var theform = document
														.getElementById("subscriptionMaintForm_"
																+ _pageRef);
												$.data(theform, 'changeTrack',
														false);

											}
										}
									});

						}
					}).trigger("reloadGrid");

}

function continueToApprove(yesNo, data)
{
	if (yesNo == true)
	{
		var selSerialNo = $("#selSerialNo_" + data.subscriptionCO.subscriptionType + "_"+ _pageRef).val();
		var actionSrc = jQuery.contextPath
			+ "/path/alert/subscription/SubscriptionMaintAction_continueToApprove?subscriptionCO.subscriptionType="
			+ data.subscriptionCO.subscriptionType
			+ "&subscriptionCO.alrtSubEvtTmpVO.ID="
			+ data.subscriptionCO.alrtSubEvtTmpVO.ID
			+ "&subscriptionCO.confirmation="
			+ data.subscriptionCO.confirmation
			+ "&subscriptionCO.iterator=" + data.subscriptionCO.iterator
			+ "&subscriptionCO.selSerialNoDet=" + selSerialNo
			+ "&subscriptionCO.alrtSubEvtTmpVO.REL_ID="
			+ data.subscriptionCO.alrtSubEvtTmpVO.REL_ID;
		$.ajax({
			url : actionSrc,
			type : "post",
			dataType : "json",
			data : data,
			success : function(data)
			{
				if (data["_error"] == null)
				{
					if (data.subscriptionCO.confirmation == 1)
					{
						data.subscriptionCO.alrtSubEvtTmpVO.REL_ID = data.subscriptionCO.relId;
						_showConfirmMsg("Activation service event is missing or not approved, no alerts will be sent. Do you wish to proceed with the approval?",
										"", "continueToApprove", data, yes_key, no_key);
					}
					else
					{
						var subscriptionType = $("#subscription_type_" + _pageRef).val();
						$("#all_rows_" + subscriptionType + "_"+ _pageRef).val("");
						$("#selSerialNo_" + subscriptionType+ "_" + _pageRef).val("");
						reloadDetGridsOnSuccess(subscriptionType);
						_showErrorMsg(record_was_Approved_Successfully_key, success_msg_title);
					}
				}
			}
		});
	}
}

function toBeDeletedSubscription(reject)
{

	var alrtSubGrd = returnsGridSelected();

	var selectedRows = alrtSubGrd.jqGrid('getGridParam', 'selarrrow');
	if (selectedRows.length > 0)
	{
		var subscriptionType = $("#subscription_type_" + _pageRef).val();

		var allrowsSelected = $(
				"#all_rows_" + subscriptionType + "_" + _pageRef).val();
		var selSerialNo = $("#selSerialNo_" + subscriptionType + "_" + _pageRef)
				.val();
		var params = {};

		params["subscriptionCO.selSerialNoDet"] = selSerialNo;
		params["subscriptionCO.allRowsDet"] = allrowsSelected;
		params["subscriptionCO.subscriptionType"] = subscriptionType;
		params["subscriptionCO.isReject"] = reject;
		params["iv_crud"] = $("#iv_crud_" + _pageRef).val();
		params["_pageRef"] = _pageRef;
		_showProgressBar(true);
		var actionSrc = jQuery.contextPath
				+ "/path/alert/subscription/SubscriptionMaintAction_toBeDeletedSubscription";
		// var theForm = $("#subscriptionMaintForm_" +
		// _pageRef).serializeForm();

		$
				.ajax({
					url : actionSrc,
					type : "post",
					dataType : "json",
					data : params,
					success : function(data)
					{
						if (data["_error"] == null)
						{

							var subscriptionType = $(
									"#subscription_type_" + _pageRef).val();
							reloadDetGridsOnSuccess(subscriptionType);
							$("#all_rows_" + subscriptionType + "_" + _pageRef)
									.val("");
							$(
									"#selSerialNo_" + subscriptionType + "_"
											+ _pageRef).val("");

							if (reject == 1)
							{
								_showErrorMsg(record_rejected_Successfully_key,
										success_msg_title);
							}
						}
						_showProgressBar(false);
					}

				});

	}

}

function onClickcheckBox()
{
	var theform = document.getElementById("subscriptionMaintForm_"+_pageRef);
    $.data(theform, 'changeTrack', true);	
}

function checkSubType(rowId)
{
	var $table;
	var subscriptionType = $("#subscription_type_" + _pageRef).val();
	if (subscriptionType == "SE")
	{
		$table = $("#subscriptionsEvtGridTbl_Id_" + _pageRef);
	}
	else if (subscriptionType == "EG")
	{
		$table = $("#groupsEvtGridTbl_Id_" + _pageRef);
	}
	
	var selRowId = rowId;//$table.jqGrid ('getGridParam', 'selrow');
	
	//disable dropdown if Event Type is not Fixed Event (for SE and GE subscriptions only)
	var myObject = $table.jqGrid('getRowData', selRowId);

	//disable dropdown in Maint screen if record is not active
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	if(ivCrud != null && ivCrud != "" && ivCrud == "R" && myObject["alrtSubEvtTmpVO.SUB_EVT_STATUS"] != "A" && myObject["alrtSubEvtTmpVO.SUB_EVT_STATUS"] != "C")
	{
		$table.jqGrid('setCellReadOnly', selRowId, "alrtSubEvtVO.SRC_CONTACT_TYPE", "true");
	}
	else if(ivCrud != "R" && ivCrud != "UP")
	{
		$table.jqGrid('setCellReadOnly', selRowId, "alrtSubEvtVO.SRC_CONTACT_TYPE", "true");
	}
}

function onSelectChange(id)
{
	var rowId = $(id).parents('tr').attr("id");
//	if(ivcrud == "R")
//	{
//		var myObject = $("#subscriptionsEvtGridTbl_Id_"+_pageRef).jqGrid('getRowData', rowId);
//		var ivcrud = $("#iv_crud_" + _pageRef).val();
//		var rowObject = {};
//		rowObject["subscriptionCO.alrtSubEvtTmpVO.EVT_ID"] = myObject["alrtSubEvtTmpVO.EVT_ID"];
//		rowObject["subscriptionCO.alrtSubEvtTmpVO.SUB_ID"] = myObject["alrtSubEvtTmpVO.SUB_ID"];
//		rowObject["subscriptionCO.alrtSubEvtTmpVO.SRC_CONTACT_TYPE"] = myObject["alrtSubEvtVO.SRC_CONTACT_TYPE"];
//		rowObject["iv_crud"] = ivcrud;
//		rowObject["_pageRef"] = _pageRef;
//		console.log(rowObject)
//		var actionSrc = jQuery.contextPath+ "/path/alert/subscription/SubscriptionMaintAction_updateTempSubscription";
//
//		$.ajax({
//			url : actionSrc,
//			type : "post",
//			dataType : "json",
//			data : rowObject,
//			success : function(data)
//			{
//				if (data["_error"] == null)
//				{
//					
//				}
//			}
//		});
//	}
//	else
//	{
//		console.log("else "+rowId)
		$("#subscriptionsEvtGridTbl_Id_"+_pageRef).find("#"+rowId).attr("changed","1");
		var theform = document.getElementById("subscriptionMaintForm_"+_pageRef);
	    $.data(theform, 'changeTrack', true);
//	}
}

function eventSubscriberEventCommunicationType_viewDetails(cellvalue, options, rowObject)
{
	return '<a href="#" onclick="eventSubscriberEventCommunicationType_viewDetailsList(\''+options.rowId+'\')">'+customization_key+'</a>';
}

function eventSubscriberEventCommunicationType_viewDetailsList(_rowid)
{
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	
	if($('#openCommunicationTypePopup_'+_pageRef).length > 0)
	{
		$('#openCommunicationTypePopup_'+_pageRef).remove();
	}
	
	var	openCommunicationTypePopup = $("<div id='openCommunicationTypePopup_"+_pageRef+"' class='path-common-sceen'></div>");
	openCommunicationTypePopup.css("padding","0");
	openCommunicationTypePopup.insertAfter($('body'));
	
	myObject = $("#subscriptionsEvtGridTbl_Id_"+_pageRef).jqGrid('getRowData',_rowid);
	//Setting Row status to enable disable checkbox of customization
	$("#rowStatus_"+_pageRef).val(myObject["alrtSubEvtTmpVO.SUB_EVT_STATUS"]);
	var reloadParams = {};
	reloadParams["_pageRef"] = _pageRef;
	reloadParams["subscriptionSC.EVT_ID"] = myObject["alrtSubEvtTmpVO.EVT_ID"];
	reloadParams["subscriptionSC.SUB_ID"] = myObject["alrtSubEvtTmpVO.SUB_ID"];
	reloadParams["subscriptionSC.ID"] = myObject["alrtSubEvtTmpVO.ID"];
	reloadParams["iv_crud"] = ivCrud;
	reloadParams["subscriptionSC.subsStatus"]=  myObject["alrtSubEvtTmpVO.SUB_EVT_STATUS"];
	
	var _dialogOptions = {modal:true, 
			            title: event_communication_key ,
			            autoOpen:false,
			            show:'slide',
			            width:returnMaxWidth(450),
			            height:returnMaxHeight(300),
			            position:'center', 
			            buttons:[{
			          	    text: "Ok",
			                  id:"okid" ,//by this id set now you can do all operation base on this id
			                  click:function(){
			                           onOkCustomisation(_rowid)	 
									   var theDialog = $(this);
			                           $('#openCommunicationTypePopup_'+_pageRef).dialog("destroy");
			                           $('#openCommunicationTypePopup_'+_pageRef).remove();
			                           }
			                  },
			                  {
			                   close: function (){
							     var theDialog = $(this);
							     theDialog.dialog("destroy");
							     theDialog.remove();
							    }}]
				         };
	
	mySrc = jQuery.contextPath
			+ "/path/alert/subscription/SubscriptionListAction_LoadCommunicationTypeGrid.action";
	$('#openCommunicationTypePopup_' + _pageRef)
			.load(mySrc,reloadParams, function()
					{
						$("#rowId_" + _pageRef).val(_rowid);
					});
	$('#openCommunicationTypePopup_'+_pageRef).dialog(_dialogOptions);
	$('#openCommunicationTypePopup_' + _pageRef).dialog('open');
}

function disableCheckBox(event,data)
{
	var checked;
	var readOnly;
	//customisation grid
	var $table = $('#communicationTypeDetailPopup_' + _pageRef);
	var rows = $table.jqGrid('getDataIDs');
	
	//subscription grid
	rowId = $("#rowId_" + _pageRef).val();
	myObject = $("#subscriptionsEvtGridTbl_Id_"+_pageRef).jqGrid('getRowData',rowId);
	var customDetails = myObject["customDetails"];
	var rowStatus = $("#rowStatus_"+_pageRef).val();
	for (var j = 0; j < rows.length; j++)
	{
		if(customDetails != undefined && customDetails != null && customDetails != "" )
		{
			data=JSON.parse(customDetails)
			checked = data.root[j]["checked"];
			readOnly = data.root[j]["readOnly"];
			var excludeYn = data.root[j]["EXCLUDE_YN"];
			$table.jqGrid('setCellValue',rows[j],'EXCLUDE_YN',excludeYn);
		}
		else
		{	
			var myObject = $table.jqGrid('getRowData', rows[j]);
			checked = myObject["checked"];
			readOnly = myObject["readOnly"];
			if (checked == 1)
			{
				$table.jqGrid('setCellValue',rows[j],'EXCLUDE_YN',"1");
			}
		}
		if (readOnly == 1 || (rowStatus != null && (rowStatus == "S")))
		{
			$table.jqGrid("setCellReadOnly",rows[j], 'EXCLUDE_YN', "true");
		}
	}
}

function onOkCustomisation(_rowid)
{
	//get the data from the grid
	var rows = $("#communicationTypeDetailPopup_"+_pageRef).jqGrid('getChangedRowData');
	if(rows != "")
	{
		$("#subscriptionsEvtGridTbl_Id_"+_pageRef).jqGrid('setCellValue',_rowid,'customDetails',rows);
		var theform = document.getElementById("subscriptionMaintForm_"+ _pageRef);
		$.data(theform, 'changeTrack', true);
		$("#subscriptionsEvtGridTbl_Id_"+_pageRef).find("#"+_rowid).attr("changed","1");
	}
}



/**
 * Select All rows at all pages
 * @returns
 */
function SubscriptionMaint_selectRecordForAllSelectedRecords(gridId, hiddenFldId)
{

	var table = $("#"+gridId+"_"+_pageRef);
	var rows = table.jqGrid('getDataIDs');
	var rowsLen = rows.length;
	var rowNum = table.jqGrid('getGridParam', 'rowNum');
	
	var allRows = $("#"+hiddenFldId+"_"+_pageRef).val();
	
	if(allRows != ""   &&  typeof allRows != "undefined" && allRows != "0")
	{
		for (var j = 1; j <= rowNum; j++)
		{
			table.jqGrid('setSelection', j, true);
		}
	}
	if(allRows == 1)
	{
		$("#cb_"+gridId+"_"+_pageRef).attr('checked', true);
	}
}


/**
 * Change Form
 * @returns
 */
function SubscriptionMaint_changeForm()
{
	var theform = document.getElementById("subscriptionMaintForm_"+ _pageRef);
	$.data(theform, 'changeTrack', true);
}