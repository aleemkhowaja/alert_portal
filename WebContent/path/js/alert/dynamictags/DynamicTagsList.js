

/*01 - This function is called when the user choose a tag from the Grid */
function dynamicTagsList_onDbClickedEvent()
{
		var changed = $("#dynamicTagsMaintFormId_" + _pageRef).hasChanges();
		if (changed == 'true' || changed == true) 
		{
			_showConfirmMsg(changes_made_confirm_msg, "",
					"dynamicTagsList_loadDynamicTagsForm ", "yesNo");
		}	
		
		else {
			dynamicTagsList_loadDynamicTagsForm(true);
		}
		
}


/*02 - This function is used to load data related to the chosen Tag */
function dynamicTagsList_loadDynamicTagsForm(yesNo){
	if(yesNo)
	{
		var $table = $("#dynamicTagsListGridTbl_Id_" + _pageRef);			
		dynTagsSelRow = $table.jqGrid('getGridParam', 'selrow');
		var myObject = $table.jqGrid('getRowData', dynTagsSelRow);
		var dynamicTagSelectedID =  myObject["alrtTagsVO.TAG_ID"];
		var url = jQuery.contextPath+"/path/dynamicTags/DynamicTagsMaintAction_returnDynamicTagsByID";													
		params = {};
		params["dynamicTagSelectedID"] = dynamicTagSelectedID;
		params["_pageRef"] = _pageRef;
		$.post(url, params, function(param) {
		/* the below condition is added in case the retrieved record is updated in another tab of this screen ex:  status*/
			if (param.indexOf("<script type=") != -1)
			{
			$("#dynamicTagsListMaintDiv_id_" + _pageRef).html(param);
			showHideSrchGrid('dynamicTagsListGridTbl_Id_' + _pageRef);
			}
			else
			{
				var response = jQuery.parseJSON(param);
				_showErrorMsg(response["_error"], response["_msgTitle"], 350,
						100);
			}
			
		}, "html");
	}
}

/*03 - This function is called once the user click on the new button */
function dynamicTagsList_onAddClicked()
{
	var changed =  $("#dynamicTagsMaintFormId_" + _pageRef).hasChanges();		 
	if (changed == 'true' || changed == true)
	{
		_showConfirmMsg(
				changes_made_confirm_msg,
				   "",
				   function(confirmcChoice, theArgs)
				   {
				    if (confirmcChoice)
				    {
				    	dynamicTagsList_dynamicTagsNewClicked(confirmcChoice);
				    }
				   }, {}, yes_confirm, no_confirm, 300, 100);
	}
	else
	{
		dynamicTagsList_dynamicTagsNewClicked(true);
	}
}



/*-04- this function is used to empty the form upon clicking on the "new" button*/
function dynamicTagsList_dynamicTagsNewClicked(yesNo)
{
	if (yesNo)
	{
		_showProgressBar(true);
		var actionSrc = jQuery.contextPath+ "/path/dynamicTags/DynamicTagsMaintAction_emptyDynamicTagsForm.action";
		var params = {};
		params["_pageRef"] = _pageRef;
		$("#dynamicTagsListMaintDiv_id_" + _pageRef).load(actionSrc,
				params, function()
				{
					_showProgressBar(false);
				});
	}
}

