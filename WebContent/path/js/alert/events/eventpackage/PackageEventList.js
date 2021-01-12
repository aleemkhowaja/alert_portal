function packageEvent_onDbClickedEvent()
{
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var actionSrc = jQuery.contextPath
			+ "/path/alert/events/eventpackage/PackageEventMaintAction_edit";
	var $table = $("#packageEventGridTbl_Id_" + _pageRef);
	var selectedRowId = $table.jqGrid('getGridParam', 'selrow');
	var packageId = $table.jqGrid('getCell', selectedRowId, 'PKG_ID');
	var status = $table.jqGrid('getCell', selectedRowId, 'STATUS');
	_showProgressBar(true);

	$.post(actionSrc, {
		"iv_crud" : ivCrud,
		"pkgEvtSC.pkgId" : packageId,
		"_pageRef" : _pageRef
	}, function(param)
	{

		$("#packageEventMaintPage_id_" + _pageRef).html(param);
		_showProgressBar(false);
		showHideSrchGrid("packageEventGridTbl_Id_" + _pageRef);

	}, "html");

}

function addRowGrid_PkgEvt()
{

	if (ifPackageEventFormChanged() == true)
	{
		_showConfirmMsg(
				changes_made_confirm_msg,
				confirm_msg_title,
				function(theVal)
				{
					if (theVal)
					{
						var actionSrc = jQuery.contextPath
								+ "/path/alert/events/eventpackage/PackageEventMaintAction_initializeMain.action?iv_crud=R&_pageRef="
								+ _pageRef;
						$.post(actionSrc, {}, function(param)
						{
							$("#packageEventMaintPage_id_" + _pageRef).html(
									param);
						}, "html");
					}
				});
	}
	else
	{
		var pkgId = $("#pkgId_" + _pageRef).val();
		if (pkgId == null || pkgId == "")
		{
		}
		else
		{
			var actionSrc = jQuery.contextPath
					+ "/path/alert/events/eventpackage/PackageEventMaintAction_initializeMain.action?iv_crud=R&_pageRef="
					+ _pageRef;
			$.post(actionSrc, {}, function(param)
			{
				$("#packageEventMaintPage_id_" + _pageRef).html(param);
			}, "html");
		}
	}
}
function ifPackageEventFormChanged()
{
	var formChanged = false;
	$("#packageEventMainFormId_" + _pageRef).each(function(i)
	{
		formChanged = $(this).hasChanges();
		if (formChanged)
		{
			return true;
		}
	});
	return formChanged;
}
