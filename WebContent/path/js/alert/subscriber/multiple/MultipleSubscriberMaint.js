
/**
 * Add new row of multi subscriber
 * @returns
 */
function multipleSubscriberMaint_addRow()
{
	
	var grid = $("#createMultipleSubscriberGridTbl_Id_"+_pageRef);
	
	if( !grid.jqGrid("checkRequiredCells")){
		return;
	}
	
	//validation for selected row
	if(!multipleSubscriberMaint_validateFirstMobileAndEmail()) return;
	
	var rowId = grid.jqGrid('addInlineRow', {});
	grid.jqGrid('setSelection',rowId, true);// setting selection to newly added row
}

/**
 * confirmation to delete multiple subscriber
 * @returns
 */
function multipleSubscriberMaint_conformDelete()
{
	_showConfirmMsg(Confirm_Delete_Process_key, confirm_msg_title,multipleSubscriberMaint_deleteRow, {}, '', '', 300, 100);
}

/**
 * delete multiple subscriber rows
 * @returns
 */
function multipleSubscriberMaint_deleteRow(conform)
{
	if (confirm) 
	{
		$("#createMultipleSubscriberGridTbl_Id_" + _pageRef).jqGrid('deleteGridRow');
	}
}

/**
 * Save multiple Subscriber
 * @returns
 */
function multipleSubscriberMaint_save()
{
	var changes = $("#multipleSubscriberMainFormId_" + _pageRef).hasChanges();
	if (changes == 'true' || changes == true)
	{
		/**
		 * check all rows mobile number and email
		 * if any row has both columns empty then will appear error message
		 */
		var isValidated = multipleSubscriberMaint_validateMultipleSubGrid();
		if(!isValidated) return;
		
		
		_showProgressBar(true);
		
		var gridId = "createMultipleSubscriberGridTbl_Id_";
		//var validateProperty = "alrtSubVO.DEFAULT_BRIEF_NAME";
		var columNames = ["alrtSubVO.DEFAULT_BRIEF_NAME", "alrtSubVO.DEFAULT_LONG_NAME", "alrtSubVO.EMAIL_ID", "alrtSubVO.MOBILE_PHONE"];
		//check if previous rows is empty or not
		var multiSubscriberJsonUpdates = $("#createMultipleSubscriberGridTbl_Id_"+_pageRef).jqGrid('getChangedRowData');
		var ivCrud = $("#iv_crud_" + _pageRef).val();
		$("#multpleSubscribersJson_"+_pageRef).val(multiSubscriberJsonUpdates);
			
		var formData = $("#multipleSubscriberMainFormId_" + _pageRef).serializeForm();
		var url = jQuery.contextPath+'/path/alert/subscriber/multiple/MultipleSubscriberMaintAction_save?iv_crud='+ ivCrud;
		$.ajax({
			url : url,
			type : "post",
			dataType : "json",
			data : formData,
				success : function(data)
				{
					if (data["_error"] == null || data["_error"] == "undefined") 
					{
						_showErrorMsg(record_saved_Successfully_key, info_msg_title, 300,100);
						_showProgressBar(false);
						$("#createMultipleSubscriberGridTbl_Id_"+_pageRef).trigger("reloadGrid");
					}
					else
					{
						_showProgressBar(false);
					}
				}
			});
	}
}


/**
 * validate the email and mobile
 * @returns
 */
function multipleSubscriberMaint_validateMultipleSubGrid()
{
	var gridId = "createMultipleSubscriberGridTbl_Id_";
	var rows = $('#'+gridId+_pageRef).jqGrid('getDataIDs');
	/**
	 * there is no record added in grid
	 * then no need to save anything
	 */
	if(rows.length <= 0) return false;
	
	
	for(var i=0; i<rows.length; i++)
	{
		var rowObject =  $('#'+gridId+_pageRef).jqGrid('getRowData', rows[i]);
		var mobileNo = rowObject["alrtSubVO.MOBILE_PHONE"];
		var email = rowObject["alrtSubVO.EMAIL_ID"];
		
		if(!common_isNotEmpty(mobileNo)  && !common_isNotEmpty(email))
	    {
			 _showErrorMsg(email_or_mobile_number_should_be_mandatory_key, info_msg_title, 300,100);
			 $('#'+gridId+_pageRef).jqGrid('setSelection',rows[i], false);// setting selection to newly added row
			 $('#'+gridId+_pageRef).jqGrid('editRow',rows[i]);
	         return false
	    }
	}
	
	return true;
}


/**
 * Process Approve
 * @returns
 */
function multipleSubscriberMaint_processApprove() 
{
	var grid = $("#createMultipleSubscriberGridTbl_Id_"+_pageRef);
	var selRowId = grid.jqGrid("getGridParam", "selarrrow");
	var allRows = $("#allrows_"+_pageRef).val();
	var subscribersData = ($("#selectedSubscriberIds_"+ _pageRef).val() != "") ? eval("("+ $("#selectedSubscriberIds_"+ _pageRef).val() + ")"): new Object();
	
	if(allRows == "1" || !$.isEmptyObject(subscribersData))
	{
		_showConfirmMsg(conform_selected_records_approved_key, info_msg_title,multipleSubscriberMaint_approve, {}, '', '', 300, 100);
	}
	else
	{
		_showErrorMsg(msg_noRecordSelectedLabel, info_msg_title, 300,100);
	}
}

/**
 * Approve record
 * @param yesNo
 * @returns
 */
function multipleSubscriberMaint_approve(yesNo)
{
	if (yesNo) {
		
		var allRows = $("#allrows_"+_pageRef).val();
		
		var subscribersData = ($("#selectedSubscriberIds_"+ _pageRef).val() != "") ? eval("("+ $("#selectedSubscriberIds_"+ _pageRef).val() + ")"): new Object();
		var excludeSubscribersData = ($("#excludeIdsFromAllSelectedRows_"+ _pageRef).val() != "") ? eval("("+ $("#excludeIdsFromAllSelectedRows_"+ _pageRef).val() + ")"): new Object();
		
		var gridAllRecords = [];
		var excludeSubscriberIds = [];
		
		/**
		 * add subscriber ids in array
		 */
		if (!$.isEmptyObject(subscribersData))
		{
			for (var key in subscribersData) {
			    if (subscribersData.hasOwnProperty(key)) {
			    	gridAllRecords.push(subscribersData[key]);
			    }
			}
		}
		
		/**
		 * add exclude ids in array
		 * if first select all and then uncheck some records
		 */
		if (!$.isEmptyObject(excludeSubscribersData))
		{
			for (var key in excludeSubscribersData) {
			    if (excludeSubscribersData.hasOwnProperty(key)) {
			    	excludeSubscriberIds.push(excludeSubscribersData[key]);
			    }
			}
		}
		
		
		var params = {};
		params["multipleSubscriberCO.subscriberIds"] = gridAllRecords;
		params["multipleSubscriberCO.excludeSubscriberIds"] = excludeSubscriberIds;
		params["multipleSubscriberCO.allrows"] = allRows;
		params["iv_crud"] = $("#iv_crud_" + _pageRef).val();
		params["_pageRef"] = _pageRef;
		_showProgressBar(true);
		var actionSrc = jQuery.contextPath+ "/path/alert/subscriber/multiple/MultipleSubscriberMaintAction_approve";
		$.ajax({
			url : actionSrc,
			type : "post",
			dataType : "json",
			data : params,
			success : function(data)
			{
				if (data["_error"] == null)
				{
					_showErrorMsg(selected_records_approved_successfully_key, info_msg_title, 300,100);
					_showProgressBar(false);
					$("#createMultipleSubscriberGridTbl_Id_"+_pageRef).trigger("reloadGrid",[{page:1}]);
				}
				else
				{
					$("#createMultipleSubscriberGridTbl_Id_"+_pageRef).trigger("reloadGrid",[{page:1}]);
				}
				$("#createMultipleSubscriberGridTbl_Id_"+_pageRef).trigger("reloadGrid",[{page:1}]);
				$("#allrows_"+_pageRef).val("0");
				$("#selectedSubscriberIds_"+_pageRef).val("");
				$("#excludeIdsFromAllSelectedRows_"+ _pageRef).val("");
				_showProgressBar(false);
			}
		});
	}
}

/**
 * Open other language
 * @param dialogName
 * @param selectedRowId
 * @param gridId
 * @returns
 */
function multipleSubscriberMaint_openOtherLanguageDialogue(dialogName, selectedRowId, gridId) 
{
	$("#selectedRow_"+_pageRef).val(selectedRowId);
	var params = {};
	var subscriberId = null;
	/*if(_pageRef == 'MIN00P')
	{*/
		var $table = $("#createMultipleSubscriberGridTbl_Id_" + _pageRef);
		var myObject = $table.jqGrid('getRowData', selectedRowId);
		var languageJson = myObject["otherLanguagesJson"];
		
		if(myObject["alrtSubVO.STATUS"]  == "A")
		{
			subscriberId = myObject["alrtSubVO.ID"];
		}
	//}
	var	openOtherLangDetailsPopup = $("<div id='openOtherLangDetailsPopup_"+_pageRef+"' class='path-common-sceen'></div>");
	openOtherLangDetailsPopup.css("padding","0");
	openOtherLangDetailsPopup.insertAfter($('body'));
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
	               multipleSubscriberMaint_okLang(theDialog,  selectedRowId);	 
	           }},
	           {text:cancel_key,
	           click :function()
	           {
	               var theDialog = $(this);
	               multipleSubscriberMaint_cancelLang(theDialog, selectedRowId);
	           }
	       }]
       
/*            buttons: {
                OK:function()
                {
                    var theDialog = $(this);
                    multipleSubscriberMaint_okLang(theDialog,  selectedRowId)	 
                },
                Cancel: function()
                {
                     var theDialog = $(this);
                     multipleSubscriberMaint_cancelLang(theDialog, selectedRowId);
		        }
            },
		    position:'center', */
    };
	
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var oldStatus = $("#individualSubStatus_"+_pageRef).val();
	
	mySrc = jQuery.contextPath+ "/path/alert/subscriber/multiple/MultipleSubscriberMaintAction_returnOtherLanguageDialog.action?_pageRef="+_pageRef+"&iv_crud="+ivCrud+"&oldStatus="+oldStatus;
	$('#openOtherLangDetailsPopup_' + _pageRef).load(mySrc, {
		"individualSubscriberCO.alrtSubVO.ID" : subscriberId
	}, function() {
	});
	$('#openOtherLangDetailsPopup_' +_pageRef).dialog(_dialogOptions);
	$('#openOtherLangDetailsPopup_' + _pageRef).dialog('open');
	
}

/**
 * ok button of language dialog
 * @returns
 */
function multipleSubscriberMaint_okLang(theDialog, rowId)
{	
	//get the data from the grid
	var rows = $("#otherSubscriberLanguagesGrid_Id_"+_pageRef).jqGrid('getAllRows');
	var multipleSubscriberGrid = $("#createMultipleSubscriberGridTbl_Id_" + _pageRef);
	multipleSubscriberGrid.jqGrid('setCellValue',rowId,'otherLanguagesJson',rows);
	var theform = document.getElementById("multipleSubscriberMainFormId_"+_pageRef);
	

	var $table = $("#createMultipleSubscriberGridTbl_Id_" + _pageRef);
	var myObject = $table.jqGrid('getRowData', rowId);
	var subscriberId = myObject["alrtSubVO.ID"];
	if(typeof subscriberId == "undefiend" || subscriberId == "")
	{
		$("#createMultipleSubscriberGridTbl_Id_"+_pageRef).find("#"+rowId).attr("Added","1");
	}
	else
	{
		$("#createMultipleSubscriberGridTbl_Id_"+_pageRef).find("#"+rowId).attr("changed","1");
	}
	$.data(theform, 'changeTrack', true);
    $(theDialog).dialog('close')
}

/**
 * cancel button of dialog
 * @returns
 */
function multipleSubscriberMaint_cancelLang(theDialog)
{
	 $(theDialog).dialog('close')
}

/**
 * cif lookup dependancy
 * @returns
 */
function multipleSubscriberMaint_cifDependancy()
{
	var $table = $("#createMultipleSubscriberGridTbl_Id_" + _pageRef);
	var selectedRowId = $table.jqGrid('getGridParam', 'selrow');
	
	var myObject = $table.jqGrid('getRowData', selectedRowId);
	var cifNo = myObject["alrtSubVO.CIF_NO"];
	
	if(cifNo != "" && cifNo != null)
	{
		$table.jqGrid("setCellReadOnly",selectedRowId,"alrtSubVO.DEFAULT_BRIEF_NAME",true);
		$table.jqGrid("setCellReadOnly",selectedRowId,"alrtSubVO.DEFAULT_MIDDLE_NAME",true);
		$table.jqGrid("setCellReadOnly",selectedRowId,"alrtSubVO.DEFAULT_LONG_NAME",true);
		$table.jqGrid("setCellReadOnly",selectedRowId,"alrtSubVO.DEFAULT_ADDRESS",true);
	}
	else
	{
		$table.jqGrid("setCellReadOnly",selectedRowId,"alrtSubVO.DEFAULT_BRIEF_NAME",false);
		$table.jqGrid("setCellReadOnly",selectedRowId,"alrtSubVO.DEFAULT_MIDDLE_NAME",false);
		$table.jqGrid("setCellReadOnly",selectedRowId,"alrtSubVO.DEFAULT_LONG_NAME",false);
		$table.jqGrid("setCellReadOnly",selectedRowId,"alrtSubVO.DEFAULT_ADDRESS",false);
	}
}

/**
 * link of main information column
 * @returns
 */
function multipleSubscriberMaint_openMainInfoDialog(cellValue, options, rowObject)
{
		return '<a href ="#" id=mainInformationOtherLanguage_' + options.rowId + "_" + _pageRef + ' onclick= "javascript:multipleSubscriberMaint_openOtherLanguageDialogue(' + "'OtherLanguage'," + "'" + options.rowId + "'"
		+ ",'multipleSubscriberGridTbl_Id'" + ');">'+main_info_other_languages_key+'</a>';
}


/**
 * retrieve previous other language data in dialog
 * @returns
 */
function multipleSubscriberMaint_returnPreviousAddedData()
{
	var selectedRowId = $("#selectedRow_"+_pageRef).val();
	var $table = $("#createMultipleSubscriberGridTbl_Id_" + _pageRef);
	var myObject = $table.jqGrid('getRowData', selectedRowId);
	var otherLanguagesJson = myObject["otherLanguagesJson"];
	if(typeof otherLanguagesJson != "undefined" && otherLanguagesJson != "")
	{
		//jQuery('#otherSubscriberLanguagesGrid_Id_' +_pageRef).jqGrid('clearGridData');
		var allRows = otherLanguagesJson;
	    var allRowsArray = JSON.parse(allRows)["root"];
	    for (var i = 0; i < allRowsArray.length; i++) 
		{
	    	var data = {};
	    	var rowId = "new_"+(new Date()).getTime()+i;
	    	obj = allRowsArray[i];
	    	$("#otherSubscriberLanguagesGrid_Id_" + _pageRef).jqGrid('addRowData', i, obj);	
		}
	}
}

//disable rows of grid while status is approve
function onMultipleSubscriberRowSelTopic(rowObj)
{
	var table = $("#createMultipleSubscriberGridTbl_Id_"+_pageRef);
	var selectedRowId = rowObj.originalEvent.id;
	var myObject = table.jqGrid('getRowData', selectedRowId);
	var statusDesc = myObject["statusDesc"];
	if(statusDesc != "Active" && typeof statusDesc != "undefined" && statusDesc != "")
	{
	   var tr = this.rows.namedItem(selectedRowId);
	   $(tr).addClass('not-editable-row');
	}
	
	/**
	 * store selected columns
	 */
	var columnName = "alrtSubVO.ID";
	var variableName = "alrtSubVO.ID";
	var subscribersData = ($("#selectedSubscriberIds_"+ _pageRef).val() != "") ? eval("("+ $("#selectedSubscriberIds_"+ _pageRef).val() + ")"): new Object();
	var excludeSubscriberData = ($("#excludeIdsFromAllSelectedRows_"+ _pageRef).val() != "") ? eval("("+ $("#excludeIdsFromAllSelectedRows_"+ _pageRef).val() + ")"): new Object();

	var varId = myObject[columnName] + "";
	if (rowObj.originalEvent.status)
	{
		subscribersData["varId_" + varId] = myObject[columnName];
		/**
		 * after checked the unchecked record will be empty
		 */
		excludeSubscriberData["varId_" + varId] = undefined;
	}
	else
	{
		subscribersData["varId_" + varId] = undefined;
		/**
		 * add unchecked records from grid after check all
		 * if first select all and then unchecked some records from grid
		 */
		excludeSubscriberData["varId_" + varId] = myObject[columnName];
		//$("#allrows_"+ _pageRef).val("0");
	}
	if($("#allrows_"+ _pageRef).val() == "0" || $("#allrows_"+ _pageRef).val() == "")
	{
		$("#selectedSubscriberIds_"+_pageRef).val(JSON.stringify(subscribersData));
	}
	else
	{
		/**
		 * if first select all and then unchecked some records from grid
		 */
		$("#excludeIdsFromAllSelectedRows_"+_pageRef).val(JSON.stringify(excludeSubscriberData));
		$("#cb_multipleSubscriberGridTbl_Id_MIN00P").attr('checked', true);
	}
	
	
}

/**
 * After Grid Complete topics
 * It will call on everypage
 * @param rowObj
 * @returns
 */
function onMultipleSubscriberGridCompleteTopic(rowObj)
{
	var table = $("#createMultipleSubscriberGridTbl_Id_"+_pageRef);
	var selectedRowId = rowObj.originalEvent.id;
	var myObject = table.jqGrid('getRowData', selectedRowId);
	
	var columnName = "alrtSubVO.ID";
	var variableName = "alrtSubVO.ID";
	
	var rows = table.jqGrid('getDataIDs');
	var rowsLen = rows.length;
	var rowNum = table.jqGrid('getGridParam', 'rowNum');
	
	var allRows = $("#allrows_"+_pageRef).val();
	
	if(allRows == "" || typeof allRows == "undefined" || allRows == "0")
	{
		var subscribersData = ($("#selectedSubscriberIds_"+ _pageRef).val() != "") ? eval("("+ $("#selectedSubscriberIds_"+ _pageRef).val() + ")"): new Object();
		
		if (!$.isEmptyObject(subscribersData))
		{
			for (var j = 1; j <= rowNum; j++)
			{
				var myObject = table.jqGrid('getRowData', j);
				var varId = myObject[columnName];
				if (subscribersData["varId_" + varId] != undefined)
				{
					table.jqGrid('setSelection', j, true);
				}
			}
		}
		else
		{
			for (var j = 1; j <= rowNum; j++)
			{
				var myObject = table.jqGrid('getRowData', j);
				var varId = myObject[columnName];
				if (subscribersData["varId_" + varId] != undefined)
				{
					table.jqGrid('setSelection', j, false);
				}

			}
		}
	}
	else
	{
		for (var j = 1; j <= rowNum; j++)
		{
			table.jqGrid('setSelection', j, true);
		}
		
		/**
		 * While select all rows and then some rows are unchecked 
		 * after pagination those rows should be unselected
		 */
		var excludeIdsFromSelectedRows = ($("#excludeIdsFromAllSelectedRows_"+ _pageRef).val() != "") ? eval("("+ $("#excludeIdsFromAllSelectedRows_"+ _pageRef).val() + ")"): new Object();
		
		if (!$.isEmptyObject(excludeIdsFromSelectedRows))
		{
			for (var j = 1; j <= rowNum; j++)
			{
				var myObject = table.jqGrid('getRowData', j);
				var varId = myObject[columnName];
				if (excludeIdsFromSelectedRows["varId_" + varId] != undefined)
				{
					table.jqGrid('setSelection', j, false);
				}
			}
		}
		
		//check the select all checkbox of grid
		$("#cb_multipleSubscriberGridTbl_Id_MIN00P").attr('checked', true);
	}
}

/**
 * Save multiple Subscriber
 * @returns
 */
function multipleSubscriberMaint_validateMobileAndEmail()
{
	
	var $table = $("#createMultipleSubscriberGridTbl_Id_" + _pageRef);
	var previousOldId = $("#previousOldId_"+_pageRef).val();
	
    var result = true;
	var selectedRowId = $table.jqGrid('getGridParam', 'selrow');
	var myObject = $table.jqGrid('getRowData', previousOldId);
	var mobileNo = myObject["alrtSubVO.MOBILE_PHONE"];
	var email = myObject["alrtSubVO.EMAIL_ID"];
	
	if(common_isNotEmpty(previousOldId) && selectedRowId != previousOldId)
	{
	     if(!common_isNotEmpty(mobileNo) && !common_isNotEmpty(email))
	     {
	         $table.jqGrid('restoreRow', selectedRowId);
	         $table.jqGrid('setSelection',previousOldId, true);
	         _showErrorMsg(email_or_mobile_number_should_be_mandatory_key, info_msg_title, 300,100);
	         result = false;
	     }
	}

	if(result)
		$("#previousOldId_"+_pageRef).val(selectedRowId);
	
	return result;
}


/**
 * Save multiple Subscriber
 * @returns
 */
function multipleSubscriberMaint_validateFirstMobileAndEmail()
{
	
	var $table = $("#createMultipleSubscriberGridTbl_Id_" + _pageRef);
	var selectedRowId = $table.jqGrid('getGridParam', 'selrow');
	
	/**
	 * if no row selected then return true
	 */
	if(!common_isNotEmpty(selectedRowId)) return true;
	
	var rowObject = $table.jqGrid('getRowData', selectedRowId);
	
	var mobileNo = rowObject["alrtSubVO.MOBILE_PHONE"];
	var email = rowObject["alrtSubVO.EMAIL_ID"];
	
	/**
	 * check email and mobile number fields
	 */
	if(!common_isNotEmpty(mobileNo)  && !common_isNotEmpty(email))
     {
         _showErrorMsg(email_or_mobile_number_should_be_mandatory_key, info_msg_title, 300,100);
         $table.jqGrid('setSelection',selectedRowId, true);// setting selection to newly added row
         return false
     }
	return true;
}

