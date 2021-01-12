function loadFixEventform(fromRetrieve)
{
	var evtType = $("#eventType_" + _pageRef).val();
	var evtID =  $("#eventId_" + _pageRef).val(); 
	var fixedevtId = $("#fixedEventTypeId_" + _pageRef).val();
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var changed = fromRetrieve;
	
	var reloadParams = {};
	if (evtType == "F") 
	{
		url = $.contextPath
				+ '/path/alert/events/event/IndividualEventMaintAction_loadRelatedParamForm';

		reloadParams["_pageRef"] = _pageRef;
		reloadParams["individualEventCO.alrtEvtVO.EVT_ID"] = evtID;
		reloadParams["individualEventCO.alrtEvtVO.EVT_TYPE"] = evtType;
		reloadParams["individualEventCO.alrtEvtVO.FIXED_EVENT_ID"] = fixedevtId;
		reloadParams["individualEventCO.alrtEvtVO.STATUS"] = $("#eventStatus_"+_pageRef).val();
		reloadParams["individualEventCO.ivCrud"] = ivCrud;
		reloadParams["individualEventCO.changed"] = changed;
		reloadParams["iv_crud"] = ivCrud;

		$.post(url, reloadParams, function(params) 
		{
			$("#AlertFixedParam_" + _pageRef).html(params);
		});
	} 
	else 
	{
		$("#AlertFixedParam_" + _pageRef).html('');
	}
}

function loadRelatedParamForm() {

	var params = {};
	var invalid = $("#invalidfixedevtid_" + _pageRef).val();
	var evtType = $("#event_type_" + _pageRef).val();
	var fixedevtId = $("#lookuptxt_fixedEventid_" + _pageRef).val();
	 var ivCrud = $("#iv_crud_" + _pageRef).val();

	if (invalid != "1") {

		if ((evtType == "F" && (null != fixedevtId && "undefined" != fixedevtId))) {
			url = $.contextPath
					+ '/path/alert/events/event/IndividualEventMaintAction_loadRelatedForm';

			var params = {};
			params["_pageRef"] = _pageRef;
			params["individualEventSC.alrtEvtVO.FIXED_EVENT_ID"] = fixedevtId;
			params["individualEventSC.alrtEvtVO.EVT_TYPE"] = evtType;
			$.post(url, params, function(params) {
				$("#individualAlertTags_" + _pageRef).html(params);
				url = $.contextPath
				+ '/path/alert/events/event/IndividualEventMaintAction_loadRelatedSubjectForm';

				var params = {};
				params["_pageRef"] = _pageRef;
				params["individualEventSC.alrtEvtVO.FIXED_EVENT_ID"] = fixedevtId;
				params["individualEventSC.alrtEvtVO.EVT_TYPE"] = evtType;
				$.post(url, params, function(params) {
					$("#individualAlertSubjectTags_" + _pageRef).html(params);
				});
			});
		} else {
			$("#individualAlertTags_" + _pageRef).html('');
		}
		$("#changed_" + _pageRef).val("1");	
		//Omni REQ-3: Channels Services Fixed Event Type 
		if(fixedevtId == 9)
		{
			document.getElementById('AlertFixedParam_'+_pageRef).style.display = 'none';
			return;
		}
		if (evtType == "F" && fixedevtId != 2) {
			url = $.contextPath
					+ '/path/alert/events/event/IndividualEventMaintAction_loadRelatedParamForm';

			params["_pageRef"] = _pageRef;
			params["individualEventCO.alrtEvtVO.EVT_TYPE"] = evtType;
			params["individualEventCO.alrtEvtVO.FIXED_EVENT_ID"] = fixedevtId;
			params["individualEventCO.alrtEvtVO.STATUS"] = $("#STATUS_"+_pageRef).val();
			params["individualEventCO.ivCrud"] = ivCrud;
			params["individualEventCO.changed"] = "1";
			params["iv_crud"] = ivCrud;
	
			$.ajax
			$.post(url, params, function(params) {
				document.getElementById('AlertFixedParam_'+_pageRef).style.display = 'inline';
				$("#AlertFixedParam_" + _pageRef).html(params);
			});
		} else {
			document.getElementById('AlertFixedParam_'+_pageRef).style.display = 'inline';
			$("#AlertFixedParam_" + _pageRef).html('');
		}

	} else if (invalid == "1") {
		_showErrorMsg("Cannot Proceed','Invalid or Missing Fixed Event ID ");
		$("#individualAlertTags_" + _pageRef).html('');
		$("#AlertFixedParam_" + _pageRef).html('');
		$("#lookuptxt_fixedEventid_" + _pageRef).val('');
		params["individualEventCO.invalidfixedevtid"] = "0";
	}
}

function enableLiveSearch() {
	
	var fixedParamGrid = $("#fixedParam_" + _pageRef);
	var selRow = fixedParamGrid.jqGrid("getGridParam", 'selrow');
	var fixedevtId = $("#lookuptxt_fixedEventid_" + _pageRef).val();

	var myObject = fixedParamGrid.jqGrid('getRowData',selRow); 
	var FIXED_CODE = myObject["FIXED_CODE"];
	var FIXED_LABEL = myObject["FIXED_LABEL"];
	
	if(FIXED_CODE == '1' && (fixedevtId==fxdEvtJvType || fixedevtId==fxdEvtTrxType))
	{
		fixedParamGrid.jqGrid('setCellReadOnly', selRow, 'FROM_VALUE', true);
		fixedParamGrid.jqGrid('setCellReadOnly', selRow, 'FROM_VALUE3', false);
	}else{
		fixedParamGrid.jqGrid('setCellReadOnly', selRow, 'FROM_VALUE', false);
		fixedParamGrid.jqGrid('setCellReadOnly', selRow, 'FROM_VALUE3', true);
	}
}

function fixEventdetails_onCustomExpressionClicked()
{
	var fixEventId = $("#fixedEventTypeId_" + _pageRef).val();
	
	if(fixEventId == null || fixEventId =="")
	{
		return;
	}
	var	openEventFilterPopup = $("<div id='customExpressionPopup_"+_pageRef+"' class='path-common-sceen'></div>");
	openEventFilterPopup.css("padding","0");
	openEventFilterPopup.insertAfter($('body'));
	var _dialogOptions = {
		modal:true, 
		title:"Parameters",
	    autoOpen:false,
	    show:'slide',
	    width:returnMaxWidth(680),
	    height:returnMaxHeight(520),
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
			       individualEventMaint_okCustomExpressionDialog(theDialog)	 
			},
			Cancel: function()
			{
				var theDialog = $(this);
				theDialog.dialog("destroy");
	            theDialog.remove();
			}
	    },
	    position:'center', 
	};
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var status = $('#eventStatus_' + _pageRef).val();
	
	mySrc = jQuery.contextPath+ "/path/alert/events/event/IndividualEventMaintAction_openCustomExpressionDialog.action?_pageRef="+_pageRef+"&iv_crud="+ivCrud;
	$('#customExpressionPopup_' + _pageRef).load(mySrc, {
															"individualEventSC.fixedEventId" : fixEventId,
															"individualEventCO.alrtEvtVO.STATUS" : status
															}, function() {
																//check if json is not empty
																loadDataFromJson();
															});
	$('#customExpressionPopup_' +_pageRef).dialog(_dialogOptions);
	$('#customExpressionPopup_' + _pageRef).dialog('open');
}

function fixedEventCustomExpression_addTagsInTextArea()
{
	var table = $("#customExpressionGridId_" + _pageRef);
	var selectedRowId = table.jqGrid('getGridParam', 'selrow');
	var tagName = "<"+table.jqGrid('getCell', selectedRowId, 'TAG_NAME') +">";
	$("#expressionId_" + _pageRef).val($("#expressionId_" + _pageRef).val() + tagName);
}

function individualEventMaint_okCustomExpressionDialog(theDialog)
{
	//get the data from the grid
	var rows = $("#expressionId_" + _pageRef).val();

	$('#updateCustomExpression_' + _pageRef).val(rows);
	var theform = document.getElementById("individualEventMainFormId_"
			+ _pageRef);
	$.data(theform, 'changeTrack', true);
	theDialog.dialog("destroy");
	theDialog.remove();
}

function loadDataFromJson()
{
	var customDetails = $('#updateCustomExpression_' + _pageRef).val();
	if(typeof customDetails != "undefined" && customDetails != "")
	{
		$("#expressionId_" + _pageRef).val(customDetails);
	}
}

/**
 * load Fixed Event Form
 * @param fromRetrieve
 * @returns
 */
function loadFixEventform(fromRetrieve)
{
	var evtType = $("#eventType_" + _pageRef).val();
	var evtID =  $("#eventId_" + _pageRef).val(); 
	var fixedevtId = $("#fixedEventTypeId_" + _pageRef).val();
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var changed = fromRetrieve;
	
	var reloadParams = {};
	if (evtType == "F") 
	{
		url = $.contextPath
				+ '/path/alert/events/event/IndividualEventMaintAction_loadRelatedParamForm';

		reloadParams["_pageRef"] = _pageRef;
		reloadParams["individualEventCO.alrtEvtVO.EVT_ID"] = evtID;
		reloadParams["individualEventCO.alrtEvtVO.EVT_TYPE"] = evtType;
		reloadParams["individualEventCO.alrtEvtVO.FIXED_EVENT_ID"] = fixedevtId;
		reloadParams["individualEventCO.alrtEvtVO.STATUS"] = $("#eventStatus_"+_pageRef).val();
		reloadParams["individualEventCO.ivCrud"] = ivCrud;
		reloadParams["individualEventCO.changed"] = changed;
		reloadParams["iv_crud"] = ivCrud;

		$.post(url, reloadParams, function(params) 
		{
			$("#AlertFixedParam_" + _pageRef).html(params);
		});
	} 
	else 
	{
		$("#AlertFixedParam_" + _pageRef).html('');
	}
}

/**
 * Expression show/hide Data
 * @returns
 */
function fixEventdetails_expressionShowHideData(obj)
{
	var url = $.contextPath	+ '/path/alert/events/event/IndividualEventMaintAction_expressionShowHideData';
	var fixedevtId = $("#fixedEventTypeId_" + _pageRef).val();
	reloadParams={};
	reloadParams["individualEventCO.alrtEvtVO.FIXED_EVENT_ID"] = fixedevtId;
	$.post(url, reloadParams, function(params)
	{
		expression_showHide = (params["update"]).split("$");
		autoCompleteConstraints(obj.id,expression_showHide);
	});
}

/**
 * add fixed parameter
 * @returns
 */
function fixEventdetails_addParameter()
{
	var fixedevtId = $("#fixedEventTypeId_" + _pageRef).val();
	if(fixedevtId == "" || typeof fixedevtId == "undefined")
	{
		_showErrorMsg(select_fixed_event_key, error_msg_title, 300,100);
		return;
	}
	var Tbl = $("#fixedParam_" + _pageRef);
	var isEmpty = fixEventdetails_validateFixedParams();
	
	if(isEmpty != true)
	{
		// add new row
		var rId = Tbl.jqGrid('addInlineRow', {});
	}
	else
	{
		_showErrorMsg(fill_empty_row_key, error_msg_title, 300,100);
		return true;
	}
	
}

/**
 * validate the fixed param grid for empty
 * @returns
 */
function fixEventdetails_validateFixedParams()
{
	var paramColumnName = $("#fixedParam_" + _pageRef).jqGrid('getCol','OLD_COLUMN_ID');
	var operator = $("#fixedParam_" + _pageRef).jqGrid('getCol','OPERATOR_TYPE');
	var paramValue = $("#fixedParam_" + _pageRef).jqGrid('getCol','PARAM_VALUE');
	
    for (var i=0; i<paramColumnName.length; i++)
    {
    	if((paramColumnName[i] == "" || typeof paramColumnName[i] == "undefined") ||
    		(operator[i] == "" || typeof operator[i] == "undefined") || 
    		(paramValue[i] == "" || typeof paramValue[i] == "undefined"))
    	{
    		return true
    		break;
    	}
    }
}

/**
 * validate duplicate fixed parameters
 * @returns
 */
function fixEventdetails_validateDuplicateFixedParams()
{
	var Tbl = $("#fixedParam_" + _pageRef);
	var selRow= Tbl.jqGrid('getGridParam','selrow');
	
	var newColumn = Tbl.jqGrid('getCell', selRow, 'OLD_COLUMN_ID');
	var newOperatorType = Tbl.jqGrid('getCell', selRow, 'OPERATOR_TYPE');
	var newOldNewVal = Tbl.jqGrid('getCell', selRow, 'OLD_NEW_VAL_LIST');

	var rows = Tbl.jqGrid('getDataIDs');
	var rowsLen = rows.length;
	
	//iterate over grid rows
	for (var i = 0; i < rowsLen; i++) 
	{
		var myObject = Tbl.jqGrid('getRowData', rows[i]);
		if (rows[i] != selRow) //exclude newly created row
		{
			var oldColumn = myObject["OLD_COLUMN_ID"];
			var oldOperatorType = myObject["OPERATOR_TYPE"];
			var oldOldNewVal = myObject['OLD_NEW_VAL_LIST'];
			
			if (newOldNewVal === oldOldNewVal && newColumn === oldColumn && newOperatorType === oldOperatorType) //checking selected lanaguage code with language code in  current iteration
			{
				_showErrorMsg(duplicate_entry_fixed_param_key, error_msg_title, 300,100);
				//For Subscription Languages Grid
				Tbl.jqGrid('setCellValue', selRow, "OPERATOR_TYPE", "0");
				Tbl.jqGrid('setCellValue', selRow, "PARAM_VALUE", "");
				return;
			}
			
		}
	}
}

/**
 * delete parameter
 * @returns
 */
function fixEventdetails_deleteParameter()
{
	$("#fixedParam_" + _pageRef).jqGrid('deleteGridRow');
}


/**
 * show confirmation dialog while select event type
 * @returns
 */
function fixEventdetails_conformOnChangeFixedEvent()
{
	var oldFixedevtId = $("#oldFixedEvent_" + _pageRef).val();
	var fixedevtId = $("#fixedEventTypeId_" + _pageRef).val();
	var Tbl = $("#fixedParam_" + _pageRef);
	var oldNewVal = Tbl.jqGrid('getCol','OLD_NEW_VAL_LIST');
	if(oldNewVal.length > 0)
	{
		_showConfirmMsg(confirm_remove_fixed_params_key, confirm_msg_title, function(confirmcChoice){
			if(confirmcChoice)
			{
				Tbl.jqGrid('clearGridData');
				//fixEventdetails_loadColumnSelectByFixedEvent(true);
				$("#oldFixedEvent_" + _pageRef).val(fixedevtId);
			}
			else
			{
				$("#fixedEventTypeId_" + _pageRef).val(oldFixedevtId);
				$("#oldFixedEvent_" + _pageRef).val($("#fixedEventTypeId_" + _pageRef).val());
			}
			}, {}, '', '', 300, 100);
		
		//_showConfirmMsg(confirm_remove_fixed_params_key, info_msg_title,function fixEventdetails_loadColumnSelectByFixedEvent, {}, '', '', 300, 100);
	}
	
	//Exclude Source of Contact by Fixed Event Type
	individualEventMaint_retrieveSourceOfContactsDropdown('gen');
	
	//reload fixed event tag grid while select the fixed event
	 var url = $.contextPath+'/path/alert/events/event/IndividualEventListAction_retFixedAdditionalTags?indEventSC.fixedEventId='+fixedevtId;
	 $("#eventEmailStaticFixedEvtTagsGridId_"+_pageRef).jqGrid('setGridParam', { url: url });
	 $("#eventEmailStaticFixedEvtTagsGridId_"+_pageRef).trigger("reloadGrid");
}

/**
 * fill Event column while edit inline row
 * @param confirm
 * @returns
 */
function fixEventdetails_loadColumnSelectByFixedEvent(confirm)
{
	if (confirm) 
	{
		var Tbl = $("#fixedParam_" + _pageRef);
	    var selRowId= Tbl.jqGrid('getGridParam','selrow');
	    var fixedevtId = $("#fixedEventTypeId_" + _pageRef).val();
	    var oldColumnId = Tbl.jqGrid('getCell', selRowId, 'OLD_COLUMN_ID');
	    var evtId = $("#eventId_"+_pageRef).val();
	    
	    if(fixedevtId != "" && typeof fixedevtId != "undefined")
	    {
		    var url = $.contextPath	+ '/path/alert/events/event/IndividualEventGridAction_loadColumnsCombo';
		    reloadParams={};
			reloadParams["individualEventSC.fixedEventId"]  = fixedevtId;
			$.post(url, reloadParams, function(params)
			{
				//fill and filter dropdown of operators based on column name
				var columnsDropdown ;
				
				/**
				 * While form load after double clicking the grid
				 * then every columns id append the grid id 
				 */
				if($("#"+selRowId+"_COLUMN_ID").length){
					columnsDropdown = $("#"+selRowId+"_COLUMN_ID");
				}else{
					columnsDropdown = $("#"+selRowId+"_COLUMN_ID_fixedParam_"+_pageRef);
				}
				
					Tbl.jqGrid('setCellValue',selRowId,'OLD_COLUMN_ID',params.indFixedParamList[0].COLUMN_ID);

				//operator select load after select column
				$(columnsDropdown).empty();
				$.each(params.indFixedParamList, function() 
				{
					columnsDropdown.append($("<option />").val(this.COLUMN_ID).text(this.PARAM_COLUMN_NAME));
				});
				
				
				if(oldColumnId != "" && typeof oldColumnId != "undefined")
				{
					Tbl.jqGrid('setCellValue',selRowId,'COLUMN_ID',oldColumnId);
				}
				
				// load operators by column select
				fixEventdetails_loadOperatorByColumnType();
			});
	    }
	}
	else
	{
		
	}
}

/**
 * load operator select column while select event column
 * @returns
 */
function fixEventdetails_loadOperatorByColumnType()
{
	
	//set column id in hidden
	fixEventdetails_setColumnAndOperatorValue("Column");
	
    var Tbl = $("#fixedParam_" + _pageRef);
    var selRowId= Tbl.jqGrid('getGridParam','selrow');
    var id = Tbl.jqGrid('getCell', selRowId, 'OLD_COLUMN_ID');
    var evtId = $("#eventId_"+_pageRef).val();
    
    var operatorDropdown;
    
	/**
	 * While form load after double clicking the grid
	 * then every columns id append the grid id 
	 */
    if($("#"+selRowId+"_OPERATOR_TYPE").length){
    	operatorDropdown = $("#"+selRowId+"_OPERATOR_TYPE");
    }else{
    	operatorDropdown = $("#"+selRowId+"_OPERATOR_TYPE_fixedParam_"+_pageRef);
    }
	
    if(id == undefined || id == 0)
    {
    	$(operatorDropdown).empty();
    	return;
    }
    var fixedevtId = $("#fixedEventTypeId_" + _pageRef).val();
    var url = $.contextPath	+ '/path/alert/events/event/IndividualEventGridAction_loadColumnsCombo';
	reloadParams={};
	reloadParams["individualEventSC.fixedColumnId"] = id;
	reloadParams["individualEventSC.fixedEventId"]  = fixedevtId;
	
	$.post(url, reloadParams, function(params)
	{
		Tbl.jqGrid('setCellValue',selRowId,'PARAM_COLUMN_TYPE',params.indFixedParamListCO.PARAM_COLUMN_TYPE);
		$("#columnType_"+_pageRef).val(params.indFixedParamListCO.PARAM_COLUMN_TYPE);
		Tbl.jqGrid('setCellValue',selRowId,'COLUMN_NAME',params.indFixedParamListCO.PARAM_COLUMN_NAME);
		Tbl.jqGrid('setCellValue',selRowId,'ID',params.indFixedParamListCO.COLUMN_ID);
		Tbl.jqGrid('setCellValue',selRowId,'PARAM_COLUMN_TYPE_DESC',params.indFixedParamListCO.PARAM_COLUMN_TYPE_DESC);
		Tbl.jqGrid('setCellValue',selRowId,'PARAM_LABEL',params.indFixedParamListCO.PARAM_LABEL);
		//fill and filter dropdown of operators based on column name
		var oldOperatorType = Tbl.jqGrid('getCell', selRowId, 'OLD_OPERATOR_TYPE');
		/*if(operatorTypeDesc == "" || typeof operatorTypeDesc == "undefined")
		{
			Tbl.jqGrid('setCellValue',selRowId,'OLD_OPERATOR_TYPE',params.fixedOperatorCombo[0].code);
		}*/
		
		//operator select load after select column
		$(operatorDropdown).empty();
		$.each(params.fixedOperatorCombo, function() 
		{
			operatorDropdown.append($("<option />").val(this.code).text(this.descValue));
		});
		
		if(oldOperatorType != "" && typeof oldOperatorType != "undefined")
		{
			Tbl.jqGrid('setCellValue',selRowId,'OPERATOR_TYPE',oldOperatorType);
		}
		//check duplicate fixed event row
		fixEventdetails_validateDuplicateFixedParams();
		
	});
}

/**
 * set old value of comlumn and operator
 * @param columnName
 * @returns
 */
function fixEventdetails_setColumnAndOperatorValue(columnName)
{
	
	fixEventdetails_validateDuplicateFixedParams()
	
	var Tbl = $("#fixedParam_" + _pageRef);
	var selRow= Tbl.jqGrid('getGridParam','selrow');
	if(columnName == "Column")
	{
		var columnId = Tbl.jqGrid('getCell', selRow, 'COLUMN_ID');
		if(columnId == "") return;
		Tbl.jqGrid('setCellValue',selRow,'OLD_COLUMN_ID',columnId);
	}
	else if(columnName == "Operator")
	{
		var operatorType = Tbl.jqGrid('getCell', selRow, 'OPERATOR_TYPE');
		if(operatorType == "") return;
		Tbl.jqGrid('setCellValue',selRow,'OLD_OPERATOR_TYPE',operatorType);
	}
}