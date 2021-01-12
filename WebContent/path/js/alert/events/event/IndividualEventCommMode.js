/**
 * set id and Max length while click on message body and subject textbox
 * @returns
 */
function individualEventComm_getId(id)
{
	var selectedId = $(id).attr("id");
	var maxLength = $(id).attr("maxlength");
	
	if(selectedId == "eventStaticEmailMessageBodyEng_"+_pageRef)
	{
		var reportId = $("#lookuptxt_eventDynamicEmailReportId_"+_pageRef).val();
		if(reportId != "" && typeof reportId != "undefined")
		{
			return;
		}
	}
	$("#selectedBodyTextareaId_"+_pageRef).val(selectedId);
	$("#selectedBodyTextareaLength_"+_pageRef).val(maxLength);
}