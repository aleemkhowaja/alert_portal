/*01 - This function is used to check the validation of the tag name entered by the user*/
function dynamicTags_checkTagName(){
	
	var tagName =  $("#dynamicTagsName_"+_pageRef).val();
	var res = tagName.substring(0, 5);
	if (res !="<DYN_" && res !="<dyn_" ){
		_showErrorMsg(mandatory_existing_dyn_in_the_tag, info_msg_title, 300,150, function() {dynamicTagsMaint_EmpyTagNameAndFocus()})();
		return
	}
	var lastCHar = tagName.charAt(tagName.length-1);
	if(lastCHar !=">"){
		fulltag = tagName + ">"
		$("#dynamicTagsName_"+_pageRef).val(fulltag);
	}
	
}

/*02 - This function is used to clear+focus the value of the tag name in case the user enter an invalid name */
function dynamicTagsMaint_EmpyTagNameAndFocus(){
	$("#dynamicTagsName_"+_pageRef).val("");
	$("#dynamicTagsName_"+_pageRef).focus();
}

/*03 - This function is used to hide the livesearch of fixed event in case the user choose tag_type = common*/
function dynamicTags_ShowHideFixedEventId(val){
	
	var tagType= $("#dynamicTagsType_"+_pageRef).val();
	var tagId = $("#tagID_"+_pageRef).val();
	//if (val =='C' || tagType =='C' )
	if(val == type_C || tagType ==type_C )
	{
			$("#briefdesceng_"+_pageRef).hide();
			$("#lookuptxt_fixedEventid_"+_pageRef).hide();
			$("#spanLookup_fixedEventid_"+_pageRef).hide();
			$("#lbl_dynamicTagsFixedEventId_"+_pageRef).hide();
			$("#lbl_dynamicTagsFixedEventId_"+_pageRef).removeAttr("required");
			$("#lookuptxt_fixedEventid_"+_pageRef).removeAttr("required","true");
			$("#lbl_dynamicTagsFixedEventId_"+_pageRef).removeAttr("class");
			var lbl = $("#lbl_dynamicTagsFixedEventId_"+_pageRef).text();
			var newLbl= lbl.replace('*', '');
			$("#lbl_dynamicTagsFixedEventId_"+_pageRef).text(newLbl);
	}
	
	//if (val =='S' || tagType =='S' )
	if(val == type_S || tagType ==type_S )
	{
		var fixedevent = $("#lookuptxt_fixedEventid_"+_pageRef).val();
		if(fixedevent==0){
			$("#lookuptxt_fixedEventid_"+_pageRef).val(null);
		}
		$("#lookuptxt_fixedEventid_"+_pageRef).show();
		$("#spanLookup_fixedEventid_"+_pageRef).show();
		$("#briefdesceng_"+_pageRef).show();
		$("#lbl_dynamicTagsFixedEventId_"+_pageRef).show();
		//$("#dynamicTagsFixedEventId_"+_pageRef).attr("required","true");
		$("#lookuptxt_fixedEventid_"+_pageRef).attr("required","true");
		$("#lbl_dynamicTagsFixedEventId_"+_pageRef).attr("class", "required");
		$("#lbl_dynamicTagsFixedEventId_"+_pageRef).append('<span class="required">*</span>');
		
	}
	
}

/*04- this function is used to show and hide the delete button  */
function dynamicTags_showHideDeleteButton(){
	
	var tagId = $("#tagID_"+_pageRef).val();
	
	if (tagId==null || tagId == '')
		{
			$("#dynamicTagsMaint_del_"+_pageRef).hide();
		}
	
	else 
		{
			$("#dynamicTagsMaint_del_"+_pageRef).show();
		}
}



/*05- this function is called upon clicking on the "Delete" button : it will show a confirmation message and it call the "delete process function" */		
function dynamicTagsMaint_onDeleteClicked() {
	_showConfirmMsg(Confirm_Delete_Process_key, Warning_key,
			dynamicTagsMaint_handleDeleteProcess,{},'','',300,100);
}

/*06 - this function include the delete process*/
function dynamicTagsMaint_handleDeleteProcess(confirm) {
	if (confirm) {
		_showProgressBar(true);
		var form = $("#dynamicTagsMaintFormId_" + _pageRef).serializeForm();
		var tagId =   $("#tagID_"+_pageRef).val();
		var actionUrl = jQuery.contextPath+"/path/dynamicTags/DynamicTagsMaintAction_deleteDynamicTag.action?dynamicTagID="+ tagId;
		
		$.ajax({
			url : actionUrl,
			type : "post",
			dataType : "json",
			data : form,
			success : function(data) {
				if (data["_error"] == null || data["_error"] == "undefined") {
							$("#dynamicTagsListGridTbl_Id_" + _pageRef).trigger("reloadGrid");	
							dynamicTagsMaint_clearForm();
							_showProgressBar(false);
							_showErrorMsg(Deleted_Successfully_key, info_msg_title,300, 100);
				} else {
					_showProgressBar(false);
				}

			}
		});

	}
}


/*07- this function is used to empty all fields existing at the level of the form and also to empty the  in-line grid */
function dynamicTagsMaint_clearForm() {
			var reloadUrl = jQuery.contextPath + "/path/dynamicTags/DynamicTagsMaintAction_emptyDynamicTagsForm.action";
			var reloadParams = {};
			reloadParams["_pageRef"] = _pageRef;
			$.post(reloadUrl, reloadParams, function(param) {
				$("#dynamicTagsListMaintDiv_id_" + _pageRef).html(param);
			}, "html");

}


/*08- this function is called upon clicking on the "Save" button from the maintenance screen : it will show a confirmation message and it call the "Save or Submit process function" */
function DynamicTagsMaint_processSubmit(){
	
				var formChanged = $("#dynamicTagsMaintFormId_"+_pageRef).hasChanges();
				if (!formChanged)
				{
					_showErrorMsg(changes_not_available_key, info_msg_title);
					return false;
				}
				_showConfirmMsg(
						Confirm_Save_Process_key,
						info_msg_title,
						   function(confirmcChoice, theArgs)
						   {
						    if (confirmcChoice)
						    {
						    	DynamicTagsMaint_submit(confirmcChoice);
						    }
						   }, {}, yes_confirm, no_confirm, 300, 100);
				
				return false;
}


/*09 - This function includes the save process*/
function DynamicTagsMaint_submit(confirm) 
{
			if (confirm) 
			{		_showProgressBar(true);	
				var action = jQuery.contextPath+"/path/dynamicTags/DynamicTagsMaintAction_saveDynamicTags.action";
				
				var TagNameUpper =  $("#dynamicTagsName_"+_pageRef).val().toUpperCase();
				$("#dynamicTagsName_"+_pageRef).val(TagNameUpper);
				
				
				var myObject = $("#dynamicTagsMaintFormId_" + _pageRef).serializeForm();
				$.ajax({
					url : action,
					type : "post",
					dataType : "json",
					data : myObject,
					success : function(param) {
						
										if (typeof param["_error"] == "undefined" || param["_error"] == null){
																$("#dynamicTagsListGridTbl_Id_" + _pageRef).trigger("reloadGrid");
																showHideSrchGrid('dynamicTagsListGridTbl_Id_' + _pageRef);
																dynamicTagsMaint_clearForm();
																_showProgressBar(false);
										}
					}
				});
			}
}

/*10- Function used to empty the event live search in case the entered event does not exists*/
function DynamicTagsMaint_CheckValidityOfeventType(){
	
	var invalid = $("#invalidfixedevtid_" + _pageRef).val();
	var fixedevtId = $("#lookuptxt_fixedEventid_" + _pageRef).val();
	
	if (invalid == "1") {
		//_showErrorMsg("Cannot Proceed','Invalid or Missing Fixed Event ID ");
		_showErrorMsg(invalid_fixed_event_id, info_msg_title,300, 100);
		$("#lookuptxt_fixedEventid_" + _pageRef).val('');
	}
	
}
