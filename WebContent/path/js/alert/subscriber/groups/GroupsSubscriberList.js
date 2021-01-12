// this method checks if there are changes in the screen.
function checkIfFormChanged()
{
	if (document.getElementById("groupsSubscriberMainFormId_" + _pageRef) == "undefined"
			|| document.getElementById("groupsSubscriberMainFormId_"
					+ _pageRef) == null)
	{
		return false;
	}
	var changes = $("#groupsSubscriberMainFormId_" + _pageRef).hasChanges();
	if (changes)
	{
		return true;
	}
	return changes;
}
function groupsSubscriber_onDbClickedEvent()
{
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var actionSrc = jQuery.contextPath
			+ "/path/alert/subscriber/groups/GroupsMaintAction_edit";
	var $table = $("#groupsSubscriberGridTbl_Id_" + _pageRef);
	var selectedRowId = $table.jqGrid('getGridParam', 'selrow');
	var groupId = $table.jqGrid('getCell', selectedRowId, 'GRP_ID');
	var status = $table.jqGrid('getCell', selectedRowId, 'STATUS');
	
	if (checkIfFormChanged())
	{
		_showConfirmMsg(changes_made_confirm_msg, confirm_msg_title, function(
				theVal)
		{
			_showProgressBar(true);
			$.post(actionSrc, {
				"iv_crud" : ivCrud,
				"grpSubSC.grpId" : groupId,
				"_pageRef" : _pageRef
			}, function(param)
			{

				$("#groupsSubscriberMaintPage_id_" + _pageRef).html(param);

				showHideSrchGrid("groupsSubscriberGridTbl_Id_" + _pageRef);
				_showProgressBar(false);
			}, "html");
		});
	}
	else
	{
		_showProgressBar(true);
		$.post(actionSrc, {
			"iv_crud" : ivCrud,
			"grpSubSC.grpId" : groupId,
			"_pageRef" : _pageRef
		}, function(param)
		{

			$("#groupsSubscriberMaintPage_id_" + _pageRef).html(param);

			showHideSrchGrid("groupsSubscriberGridTbl_Id_" + _pageRef);
			_showProgressBar(false);
		}, "html");
	}

}

function addRowGrid_GrpSub()
{

	if (ifGroupSubFormChanged())
	{
		_showConfirmMsg(
				changes_made_confirm_msg,
				confirm_msg_title,
				function(theVal)
				{
					if (theVal)
					{
						var actionSrc = jQuery.contextPath
								+ "/path/alert/subscriber/groups/GroupsMaintAction_initializeMain.action?iv_crud=R&_pageRef="
								+ _pageRef;
						$.post(actionSrc, {}, function(param)
						{
							$("#groupsSubscriberMaintPage_id_" + _pageRef)
									.html(param);
						}, "html");
					}
				});
	}
	else
	{
		var grpId = $("#grpId_" + _pageRef).val();
		if (grpId == null || grpId == "")
		{
		}
		else
		{
			var actionSrc = jQuery.contextPath
					+ "/path/alert/subscriber/groups/GroupsMaintAction_initializeMain.action?iv_crud=R&_pageRef="
					+ _pageRef;
			$.post(actionSrc, {}, function(param)
			{
				$("#groupsSubscriberMaintPage_id_" + _pageRef).html(param);
			}, "html");
		}
	}
}
function ifGroupSubFormChanged()
{

	var formChanged = false;
	$("#groupsSubscriberMainFormId_" + _pageRef).each(function(i)
	{
		formChanged = $(this).hasChanges();
		if (formChanged)
		{
			return true;
		}
	});
	return formChanged;
	// return $("#groupsSubscriberMainFormId_"+_pageRef).hasChanges();
}
