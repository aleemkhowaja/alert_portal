
/**
 * Add grid rows
 **/ 
function OtherLanguages_addRecord(id) {
	
	if(!OtherLanguages_validateGrid())
		return false;
	
	var Tbl = $("#"+id+ _pageRef);
	// add new row
	var rId = Tbl.jqGrid('addInlineRow', {});
}

/**
 * Add grid rows Body section
 **/ 
function OtherLanguagesBody_addRecord() {
	
	if(!OtherLanguagesBody_validateGrid())
		return false;
	var Tbl = $("#otherLanguagesBodyGrid_Id_" + _pageRef);
	// add new row
	var rId = Tbl.jqGrid('addInlineRow', {});
}

// *****************************************************************************************************************************************//

/**
 * Delete grid row
 **/ 
function OtherLanguages_deleteRecord(rowID) {
	_showConfirmMsg(Confirm_Delete_Process_key, confirm_msg_title, function(
			yesNo) {
		if (yesNo) {
			var Tbl = $("#otherLanguagesGrid_Id_" + _pageRef);
			Tbl.jqGrid('deleteGridRow',rowID);
		}
	}, "yesNo");
}

/**
 * Delete grid row Body section
 **/ 
function OtherLanguagesBody_deleteRecord(rowID) {
	_showConfirmMsg(Confirm_Delete_Process_key, confirm_msg_title, function(
			yesNo) {
		if (yesNo) {
			var Tbl = $("#otherLanguagesBodyGrid_Id_" + _pageRef);
			Tbl.jqGrid('deleteGridRow',rowID);
		}
	}, "yesNo");
}

// *****************************************************************************************************************************************//

/**
 * This function checks if user selects a languages which is already chosen.
 **/ 
function OtherLanguages_onLanguageChange(tableId) {
	
	var Tbl = $("#"+tableId + _pageRef);
	var selRow = Tbl.jqGrid("getGridParam", 'selrow');
	
	if(tableId == "otherSubscriberLanguagesGrid_Id_")
	{
		selLangCode = Tbl.jqGrid('getCell', selRow, 'alrt_SUB_LANGVO.LANG_CODE'); // selLangCode = selected language code
	}
	else
	{
		selLangCode = Tbl.jqGrid('getCell', selRow, 'otherLanguagesVO.LANG_CODE'); // selLangCode = selected language code
	}
	
	var rows = Tbl.jqGrid('getDataIDs');
	var rowsLen = rows.length;
	
	//iterate over grid rows
	for (var i = 0; i < rowsLen; i++) 
	{
		var myObject = Tbl.jqGrid('getRowData', rows[i]);
		if (rows[i] !== selRow) //exclude newly created row
		{
			if(tableId == "otherSubscriberLanguagesGrid_Id_")
			{
				var rowLanCode = myObject["alrt_SUB_LANGVO.LANG_CODE"];
			}
			else
			{
				var rowLanCode = myObject["otherLanguagesVO.LANG_CODE"];
			}
			if (rowLanCode === selLangCode) //checking selected lanaguage code with language code in  current iteration
			{
				_showErrorMsg(same_language_key, error_msg_title);
				//For Event Multiple Languages
				Tbl.jqGrid('setCellValue', selRow, "otherLanguagesVO.LANG_CODE", "-1");
				//empty the description
				Tbl.jqGrid('setCellValue', selRow, "otherLanguagesVO.DESCRIPTION", "");
				
				//For Subscription Languages Grid
				Tbl.jqGrid('setCellValue', selRow, "alrt_SUB_LANGVO.LANG_CODE", "-1");
				Tbl.jqGrid('setCellValue', selRow, "alrt_SUB_LANGVO.BRIEF_NAME", "");
				Tbl.jqGrid('setCellValue', selRow, "alrt_SUB_LANGVO.MIDDLE_NAME", "");
				Tbl.jqGrid('setCellValue', selRow, "alrt_SUB_LANGVO.LONG_NAME", "");
				Tbl.jqGrid('setCellValue', selRow, "alrt_SUB_LANGVO.ADDRESS", "");
				return;
			}
		}
	}
	//set LANG_CODE with selected value
	Tbl.jqGrid('setCellValue', selRow, "otherLanguagesVO.LANG_CODE",
			selLangCode);
	//empty the description
	Tbl.jqGrid('setCellValue', selRow, "otherLanguagesVO.DESCRIPTION", "");
}

/**
 * This function checks if user selects a languages which is already chosen. Vody section
 **/ 
function OtherLanguagesBody_onLanguageChange() {

	var Tbl = $("#otherLanguagesBodyGrid_Id_" + _pageRef);
	var selRow = Tbl.jqGrid("getGridParam", 'selrow');

	selLangCode = Tbl.jqGrid('getCell', selRow, 'otherLanguagesVO.LANG_CODE'); // selLangCode = selected language code
	
	var rows = Tbl.jqGrid('getDataIDs');
	var rowsLen = rows.length;
	
	//iterate over grid rows
	for (var i = 0; i < rowsLen; i++) 
	{
		var myObject = Tbl.jqGrid('getRowData', rows[i]);
		if (rows[i] !== selRow) //exclude newly created row
		{
			var rowLanCode = myObject["otherLanguagesVO.LANG_CODE"];
			if (rowLanCode === selLangCode) //checking selected lanaguage code with language code in  current iteration
			{
				_showErrorMsg(same_language_key, error_msg_title);
				Tbl.jqGrid('setCellValue', selRow,
						"otherLanguagesVO.LANG_CODE", "-1");
				//empty the description
				Tbl.jqGrid('setCellValue', selRow, "otherLanguagesVO.DESCRIPTION", "");
				return;
			}
		}
	}
	//set LANG_CODE with selected value
	Tbl.jqGrid('setCellValue', selRow, "otherLanguagesVO.LANG_CODE",
			selLangCode);
	//empty the description
	Tbl.jqGrid('setCellValue', selRow, "otherLanguagesVO.DESCRIPTION", "");
}

// *****************************************************************************************************************************************//

/**
 * Check any field contains no data
 * @returns
 */
function OtherLanguages_validateGrid(){
	var Tbl = $("#otherLanguagesGrid_Id_" + _pageRef);
	var isValid = true;
	var rows = Tbl.jqGrid('getDataIDs');
	for(a=0;a<rows.length;a++)//iterate over grid rows
	{
		var row=Tbl.jqGrid('getRowData', rows[a]);
		if(row['otherLanguagesVO.LANG_CODE']=="" || row['otherLanguagesVO.LANG_CODE']=='-1' ||row['otherLanguagesVO.DESCRIPTION'].length<=0)
		{
			_showErrorMsg(language_field_required_key, error_msg_title)//not valid;
			isValid = false;
			break;
		}
	}
	return isValid;
}
/**
 * Check any field contains no data Body section
 * @returns
 */
function OtherLanguagesBody_validateGrid(){
	var Tbl = $("#otherLanguagesBodyGrid_Id_" + _pageRef);
	var isValid = true;
	var rows = Tbl.jqGrid('getDataIDs');
	for( var a=0;a<rows.length;a++)//iterate over grid rows
	{
		var row=Tbl.jqGrid('getRowData', rows[a]);
		if(row['otherLanguagesVO.LANG_CODE']=="" || row['otherLanguagesVO.LANG_CODE']=='-1' ||row['otherLanguagesVO.DESCRIPTION'].length<=0)
		{
			_showErrorMsg(language_field_required_key, error_msg_title)//not valid;
			isValid = false;
			break;
		}
	}
	return isValid;
}
//*****************************************************************************************************************************************//
