/**
 * Add tags in Email Body or and other communication type body textarea
 * @param id
 * @param communicationType
 * @returns
 */
function individualAlertTag_addTagsInTextArea(id, communicationType)
{
	var checkDisable = $("#_recReadOnly_"+_pageRef).val();
	if(checkDisable == "true") return;

	var selectedBodyTextareaId = $("#selectedBodyTextareaId_" + _pageRef).val();

	var reportId = $("#lookuptxt_eventDynamicEmailReportId_" + _pageRef).val();
	if (id == "Query" && communicationType == "Email" && reportId != ""
			&& reportId != undefined)
	{
		return;
	}

	if (id == "Query")
	{
		var table = $("#event" + communicationType + "Static" + id
				+ "TagsGridId_" + _pageRef);
		var selectedRowId = table.jqGrid('getGridParam', 'selrow');

		var tagDescription = table.jqGrid('getCell', selectedRowId,
				'COLUMN_NAME');

		if (typeof selectedBodyTextareaId == "undefined"
				|| selectedBodyTextareaId == "")
		{
			_showErrorMsg(select_message_body_for_adding_tags_key,
					error_msg_title, 300, 100);
			return;
		}

		if ($("#communicationModeEmail_" + _pageRef).prop("checked") == true)
		{
			if (communicationType == "Batch")
			{
				var tag = " <batch." + tagDescription + ">";
				individualAlertTag_setTagInCursorPosition(
						selectedBodyTextareaId, communicationType, tag);
			}
			else
			{
				var tag = " <QUERY." + tagDescription + ">";
				individualAlertTag_setTagInCursorPosition(
						selectedBodyTextareaId, communicationType, tag);
			}
		}
		else
		{
			var tag = " <QUERY." + tagDescription + ">";
			individualAlertTag_setTagInCursorPosition("", communicationType,
					tag);

		}
	}
	else
	{

		var table = $("#eventEmailStatic" + id + "TagsGridId_" + _pageRef);
		var selectedRowId = table.jqGrid('getGridParam', 'selrow');

		if (selectedBodyTextareaId == "eventStaticEmailMessageBodyEng_"
				+ _pageRef)
		{
			var reportId = $("#lookuptxt_eventDynamicEmailReportId_" + _pageRef)
					.val();
			if (reportId != "" && typeof reportId != "undefined")
			{
				_showErrorMsg(select_message_body_for_adding_tags_key,
						error_msg_title, 300, 100);
				return;
			}
		}

		if (typeof selectedBodyTextareaId == "undefined"
				|| selectedBodyTextareaId == "")
		{
			_showErrorMsg(select_message_body_for_adding_tags_key,
					error_msg_title, 300, 100);
			return;
		}

		if (id == "Custom")
		{
			var tagDescription = table.jqGrid('getCell', selectedRowId,
					'TAG_NAME');
			var tag = " <CUSTOM." + tagDescription + ">";
			individualAlertTag_setTagInCursorPosition(selectedBodyTextareaId,
					communicationType, tag);
		}
		else
		{
			var tagDescription = table.jqGrid('getCell', selectedRowId,
					'TAG_NAME');
			var tag = " <" + tagDescription + ">";
			individualAlertTag_setTagInCursorPosition(selectedBodyTextareaId,
					communicationType, tag);
		}

	}
	individualEventMaint_setRemainingCharachter('Email', 4000);
	individualEventMaint_setRemainingCharachter('Sms', 160);
	individualEventMaint_setRemainingCharachter('OmniInbox', 4000);
	// reset row selection
	// table.jqGrid("resetSelection");

	var theform = document.getElementById("individualEventMainFormId_"
			+ _pageRef);
	$.data(theform, 'changeTrack', true);
}


function individualAlertTag_setTagInCursorPosition(textAreaId, communicationType, tag)
{
	if(typeof textAreaId == "undefined" || textAreaId =="")
	{
		textAreaId = "eventStatic"+communicationType+"MessageBodyEng_" + _pageRef;
	}
	else
	{
		var beforetext =  $("#"+textAreaId).val();
		var selectedTextBoxMasLength = $("#selectedBodyTextareaLength_"+_pageRef).val();
		if(((beforetext.length)+tag.length) >  selectedTextBoxMasLength)
		{
			return;
		}
	}
	
	var cursorPos = $("#"+textAreaId).prop('selectionStart');
    var v =  $("#"+textAreaId).val();
    var textBefore = v.substring(0,  cursorPos );
    var textAfter  = v.substring( cursorPos, v.length );
    $("#"+textAreaId).val(textBefore+tag+textAfter );
    $("#"+textAreaId).focus().setCursorPosition((textBefore+tag).length);
}


/**
 * set cursor on particular position
 */
$.fn.setCursorPosition = function (pos) {
    this.each(function (index, elem) {
        if (elem.setSelectionRange) {
            elem.setSelectionRange(pos, pos);
        } else if (elem.createTextRange) {
            var range = elem.createTextRange();
            range.collapse(true);
            range.moveEnd('character', pos);
            range.moveStart('character', pos);
            range.select();
        }
    });
    return this;
};

/**
 * Disable Custom tags grids rows
 * @param communicationType
 * @returns
 */
function individualEventMaint_disableCustomColumnCell(communicationType)
{
	var $table = $("#event"+communicationType+"StaticCustomTagsGridId_" + _pageRef);
	var selectedRowId = $table.jqGrid('getGridParam', 'selrow');
	var myObject = $table.jqGrid('getRowData', selectedRowId);
	
	var tagName = myObject["TAG_NAME"];
	var isNew = myObject["IS_NEW"];
	if(isNew == "" || isNew == undefined)
	{
		$table.jqGrid("setCellReadOnly",selectedRowId,"TAG_NAME",true);
	}
}

/**
 * query tags validation
 * @param communicationType
 * @returns
 */
function individualAlertTag_queryTagsValidation(communicationType)
{
	var queryTags = $("#eventStatic"+communicationType+"QueryColumnsHiddenId_"+_pageRef).val();

	var queryId = $("#lookuptxt_eventStatic"+communicationType+"QueryId_"+_pageRef).val();
	var oldQueryId = $("#eventStatic"+communicationType+"QueryHiddenId_"+_pageRef).val();
	
	var arabicMessage = $("#eventStatic"+communicationType+"MessageARHiddenId_"+_pageRef).val();
	if(typeof arabicMessage == "undefined")
	{
		arabicMessage="";
	}
	
	var frenchMessage = $("#eventStatic"+communicationType+"MessageFRHiddenId_"+_pageRef).val();
	if(typeof frenchMessage == "undefined")
	{
		frenchMessage="";
	}
	
	var perssionMessage = $("#eventStatic"+communicationType+"MessageFAHiddenId_"+_pageRef).val();
	if(typeof perssionMessage == "undefined")
	{
		perssionMessage="";
	}
	
	var russianMessage = $("#eventStatic"+communicationType+"MessageRUHiddenId_"+_pageRef).val();
	if(typeof russianMessage == "undefined")
	{
		russianMessage="";
	}
	
	var turkishMessage = $("#eventStatic"+communicationType+"MessageTKHiddenId_"+_pageRef).val();
	if(typeof turkishMessage == "undefined")
	{
		turkishMessage="";
	}
	
	var englishMessage = $("#eventStatic"+communicationType+"MessageENHiddenId_"+_pageRef).val();
	if(typeof englishMessage == "undefined")
	{
		englishMessage="";
	}
	
	var defaultMessage = $("#eventStatic"+communicationType+"MessageDefaultBodyHiddenId_"+_pageRef).val();
	//eventStaticEmailMessageDefaultBodyHiddenId_
	if(typeof defaultMessage == "undefined")
	{
		defaultMessage="";
	}
	//eventStaticEmailMessageBodyEng
	var activeMessage = $("#eventStatic"+communicationType+"MessageBodyEng_"+_pageRef).val();
	if(typeof activeMessage == "undefined")
	{
		activeMessage="";
	}
	
	if(typeof oldQueryId != "undefined" && oldQueryId != "" &&  queryId != oldQueryId)
	{
		if(typeof queryTags != "undefined" && queryTags != "")
		{
		    var allRowsArray = JSON.parse(queryTags)["root"];
		    for (var i = 0; i < allRowsArray.length; i++) 
			{
		    	var obj = allRowsArray[i];
		    	arabicMessage = arabicMessage.replace(new RegExp('<QUERY.'+obj.FIELD_ALIAS+'>', 'g'), "");
		    	frenchMessage = frenchMessage.replace(new RegExp('<QUERY.'+obj.FIELD_ALIAS+'>', 'g'), "");
		    	perssionMessage = perssionMessage.replace(new RegExp('<QUERY.'+obj.FIELD_ALIAS+'>', 'g'), "");
		    	russianMessage = russianMessage.replace(new RegExp('<QUERY.'+obj.FIELD_ALIAS+'>', 'g'), "");
		    	turkishMessage = turkishMessage.replace(new RegExp('<QUERY.'+obj.FIELD_ALIAS+'>', 'g'), "");
		    	englishMessage = englishMessage.replace(new RegExp('<QUERY.'+obj.FIELD_ALIAS+'>', 'g'), "");
		    	defaultMessage = defaultMessage.replace(new RegExp('<QUERY.'+obj.FIELD_ALIAS+'>', 'g'), "");
		    	activeMessage = activeMessage.replace(new RegExp('<QUERY.'+obj.FIELD_ALIAS+'>', 'g'), "");
			}
		    
		    $("#eventStatic"+communicationType+"MessageARHiddenId_"+_pageRef).val(arabicMessage);
		    $("#eventStatic"+communicationType+"MessageFRHiddenId_"+_pageRef).val(frenchMessage);
		    $("#eventStatic"+communicationType+"MessageFAHiddenId_"+_pageRef).val(perssionMessage);
		    $("#eventStatic"+communicationType+"MessageRUHiddenId_"+_pageRef).val(russianMessage);
		    $("#eventStatic"+communicationType+"MessageTKHiddenId_"+_pageRef).val(turkishMessage);
		    $("#eventStatic"+communicationType+"MessageENHiddenId_"+_pageRef).val(englishMessage);
		    $("#eventStatic"+communicationType+"MessageDefaultBodyHiddenId_"+_pageRef).val(defaultMessage);
		    $("#eventStatic"+communicationType+"MessageBodyEng_"+_pageRef).val(activeMessage);
		    
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
function individualAlertTag_fillMappingTagInHiddenField()
{
	var tbl = $("#eventArgumentGridId_" + _pageRef);
	var allIds = tbl.jqGrid('getDataIDs'); 
	
	if(allIds != null && typeof allIds != "undefined")
	{
		for(var i=0; i<allIds.length; i++)
		{
			var mappingTagName = tbl.jqGrid('getCell', allIds[i], 'MAPPING_TAG_NAME');
			tbl.jqGrid('setCellValue',allIds[i],'MAPPING_VALUE_HIDDEN',mappingTagName);
		}
	}
}
