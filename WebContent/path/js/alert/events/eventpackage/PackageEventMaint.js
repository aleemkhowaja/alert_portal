/**
 * conform delete
 * @returns
 */
function packageEventMaint_conform()
{
	_showConfirmMsg(Confirm_Delete_Process_key, confirm_msg_title,packageEventMaint_delete, {}, '', '', 300, 100);
}

/**
 * delete package event
 * @param conform
 * @returns
 */
function packageEventMaint_delete(conform)
{
	if(conform)
	{
		var actionSrc = jQuery.contextPath+ "/path/alert/events/eventpackage/PackageEventMaintAction_checkSubscription";
		var pkgId = $("#pkgId_" + _pageRef).val();
		var theForm = $("#packageEventMainFormId_" + _pageRef).serializeForm();
		var params = theForm;
		var ivCrud = $("#iv_crud_" + _pageRef).val();

		_showProgressBar(true);
		$.ajax({
			url : actionSrc,
			type : "post",
			dataType : "json",
			data : theForm + "&iv_crud=" + ivCrud + "&pkgId=" + pkgId,
			success : function(data) {
			if (data["_error"] == null) {
				if (data.packageEventCO.checkFlag == true) {
					var arg = theForm + "&iv_crud=" + ivCrud+ "&pkgId=" + pkgId;
					_showProgressBar(false);
					_showConfirmMsg(Confirm_Delete_All_subscriptions_key, confirm_msg_title,packageEventMaint_continueDeletePackage, {}, '', '', 300, 100);
				} else {
						var actionSrc = jQuery.contextPath+ "/path/alert/events/eventpackage/PackageEventMaintAction_deleteRecord";
						var params = theForm;

						_showProgressBar(true);
						$.ajax({
							url : actionSrc,
							type : "post",
							dataType : "json",
							data : theForm + "&iv_crud="+ ivCrud,
							success : function(data) {
								if (data["_error"] == null) {
										var actionSrc = jQuery.contextPath+ "/path/alert/events/eventpackage/PackageEventMaintAction_initializeMain";
										$.post(actionSrc,{
											"iv_crud" : ivCrud,
											"_pageRef" : _pageRef
										},
										function(param) {
											$("#packageEventMaintPage_id_"+ _pageRef).html(param);
											$("#packageEventGridTbl_Id_"+ _pageRef).trigger("reloadGrid");
										}, "html");
										_showProgressBar(false);
										_showErrorMsg(record_was_Deleted_Successfully_key, success_msg_title, 300,100);
								}
							}
						});
					}
				}
			}
		});
	}
}

/**
 * Delete Packages
 * @param yesNo
 * @returns
 */
function packageEventMaint_continueDeletePackage(yesNo)
{
	if (yesNo == true)
	{
		var actionSrc = jQuery.contextPath+ "/path/alert/events/eventpackage/PackageEventMaintAction_deleteRecord";
		var ivCrud = $("#iv_crud_" + _pageRef).val();
		var theForm = $("#packageEventMainFormId_" + _pageRef).serializeForm();
		var params = theForm;
		var args;
		_showProgressBar(true);
		$.ajax({
			url : actionSrc,
			type : "post",
			dataType : "json",
			data : theForm + "&iv_crud=" + ivCrud,
			success : function(data)
			{
				if (data["_error"] == null)
				{
					var actionSrc = jQuery.contextPath+ "/path/alert/events/eventpackage/PackageEventMaintAction_initializeMain";
					$.post(actionSrc, {
						"iv_crud" : ivCrud,
						"_pageRef" : _pageRef
					}, function(param)
					{
						$("#packageEventMaintPage_id_" + _pageRef).html(param);
						("#packageEventGridTbl_Id_" + _pageRef).trigger("reloadGrid");
					}, "html");
				}
				_showProgressBar(false);
				_showErrorMsg(record_was_Deleted_Successfully_key, success_msg_title, 300,100);
			}
		});
	}
}
// this method checks if there are changes in the screen.
function packageEvent_checkIfFormChanged()
{
	if (document.getElementById("packageEventMainFormId_" + _pageRef) == "undefined"
			|| document.getElementById("packageEventMainFormId_" + _pageRef) == null)
	{
		return false;
	}
	var changes = $("#packageEventMainFormId_" + _pageRef).hasChanges();
	if (changes)
	{
		return true;
	}
	return changes;
}

/**
 * save Pacakge events
 * @returns
 */
function packageEventMaint_save()
{
	var changetags = $("#changetags_" + _pageRef).val();

	if (packageEvent_checkIfFormChanged() || changetags == '1')
	{
		var actionSrc = jQuery.contextPath
				+ "/path/alert/events/eventpackage/PackageEventMaintAction_saveRecord";
		var evtNotInPkg = $("#evtNotInPkg_" + _pageRef);
		var distAllRecList = evtNotInPkg.jqGrid('getAllRows');
		var evtInPkg = $("#evtInPkg_" + _pageRef);
		var distAllRecList1 = $("#eventInPackage_" + _pageRef).val();
		var ivCrud = $("#iv_crud_" + _pageRef).val();
		var theForm = $("#packageEventMainFormId_" + _pageRef).serializeForm();
		var params = theForm;

		_showProgressBar(true);
		$
				.ajax({
					url : actionSrc,
					type : "post",
					dataType : "json",
					data : theForm + "&list=" + encodeURIComponent(distAllRecList) + "&list2="
							+ encodeURIComponent(distAllRecList1) + "&iv_crud=" + ivCrud,
					success : function(data)
					{
						if (data["_error"] == null)
						{
							var actionSrc = jQuery.contextPath
									+ "/path/alert/events/eventpackage/PackageEventMaintAction_initializeMain";
							$.post(actionSrc, {
								"iv_crud" : ivCrud,
								"_pageRef" : _pageRef
							}, function(param)
							{
								_showErrorMsg(record_saved_Successfully_key, success_msg_title, 300,100);
								$("#packageEventMaintPage_id_" + _pageRef).html(param);
								$("#packageEventGridTbl_Id_" + _pageRef).trigger("reloadGrid");
								if(_pageRef == "PKG00MA")
								{
									showHideSrchGrid('packageEventGridTbl_Id_'+ _pageRef);
									$("#packageEventMaintPage_id_" + _pageRef).html("");
								}
							}, "html");
						}
						_showProgressBar(false);
					}
				});

	}
}

/**
 * conformApprove
 * @returns
 */
function packageEventMaint_conformApprove()
{
	_showConfirmMsg(Confirm_Authorize_Process_key, confirm_msg_title,packageEventMaint_approve, {}, '', '', 300, 100);
}


/**
 * Package event Approve
 * @returns
 */
function packageEventMaint_approve(conform)
{
	if(conform)
	{
		var actionSrc = jQuery.contextPath+ "/path/alert/events/eventpackage/PackageEventMaintAction_approveRecord";
		var ivCrud = $("#iv_crud_" + _pageRef).val();
		var theForm = $("#packageEventMainFormId_" + _pageRef).serializeForm();
		var params = theForm;
		_showProgressBar(true);
		$.ajax({
			url : actionSrc,
			type : "post",
			dataType : "json",
			data : theForm + "&iv_crud=" + ivCrud,
			success : function(data)
			{
				if (data["_error"] == null)
				{
					$("#packageEventGridTbl_Id_"+ _pageRef).trigger("reloadGrid");
					showHideSrchGrid('packageEventGridTbl_Id_'+_pageRef);
					$("#packageEventMaintPage_id_" + _pageRef).html("");
					_showErrorMsg(record_was_Approved_Successfully_key, success_msg_title, 300,100);
				}
				_showProgressBar(false);
			}
		});
	}			
}

/**
 * Add event to package
 * @returns
 */
function addEvtToPkg()
{
	_showProgressBar(true);
	var grid1 = $("#evtNotInPkg_" + _pageRef);
	var selectedRow = grid1.jqGrid("getGridParam", 'selarrrow');
	if (selectedRow.length > 0 )
	{
		for (var i = 0; i < selectedRow.length; i++)
		{
			var evtId = grid1.jqGrid('getCell', selectedRow[i], 'EVT_ID');
			var actionSrc = jQuery.contextPath
					+ "/path/alert/events/eventpackage/PackageEventMaintAction_addEvtToPkg?evtId="+ evtId;
			$.post(actionSrc, {
				"_pageRef" : _pageRef
			}, function(param)
			{
				if (i == selectedRow.length)
				{
					$("#evtNotInPkg_" + _pageRef).trigger("reloadGrid");
					$("#evtInPkg_" + _pageRef).trigger("reloadGrid");
					_showProgressBar(false);
				}
				
			}, "html");
		}
		$("#changetags_" + _pageRef).val("1");
		var theform = document.getElementById("packageEventMainFormId_" +_pageRef);
		$.data(theform , 'changeTrack',true);
	}
	else
	{
		_showProgressBar(false);
	}
}

function removeEvtFromPkg()
{
	_showProgressBar(true);
	var grid1 = $("#evtInPkg_" + _pageRef);
	var selectedRow = grid1.jqGrid("getGridParam", 'selarrrow');
	if (selectedRow.length > 0 )
	{
		for (var i = 0; i < selectedRow.length; i++)
		{
			var evtId = grid1.jqGrid('getCell', selectedRow[i], 'EVT_ID');
			var actionSrc = jQuery.contextPath
					+ "/path/alert/events/eventpackage/PackageEventMaintAction_removeEvtFromPkg?evtId="+ evtId;
			$.post(actionSrc, {
				"_pageRef" : _pageRef
			}, function(param)
			{
				if (i == selectedRow.length)
				{
					$("#evtNotInPkg_" + _pageRef).trigger("reloadGrid");
					$("#evtInPkg_" + _pageRef).trigger("reloadGrid");
					_showProgressBar(false);
				}
				
			}, "html");
		}
		$("#changetags_" + _pageRef).val("1");
		var theform = document.getElementById("packageEventMainFormId_" +_pageRef);
		$.data(theform , 'changeTrack',true);
	}
	else
	{
		_showProgressBar(false);
	}
}

/**
 * this method opens the status list
 * 
 * @return {TypeName}
 */
function showPkgEvtStatus()
{
	var pkgId = $("#pkgId_" + _pageRef).val();
	if (pkgId == "")
	{
		return;
	}

	var loadSrc = jQuery.contextPath
			+ "/path/alert/events/eventpackage/PackageStatusAction_search.action?_pageRef="
			+ _pageRef;

	showStatus("packageEventMainFormId_" + _pageRef, _pageRef, loadSrc, {
		"pkgId" : pkgId
	});
}

//on Row Select maintenance
function dynamicGridSelectRowFunc2Pkg(selectedRowInd)
{
	var rowId = selectedRowInd.originalEvent.id;
	var $table = $("#evtNotInPkg_" + _pageRef);
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var status = $("#status_" + _pageRef).val();
	if ((((status!= "Active" && status!= "") && ivCrud == "R") && _pageRef =="PKG00MT"))
	{
			$table.jqGrid('setSelection', rowId, false);
	}
}

//on Row Select approve
function dynamicGridSelectRowFunc2AprPkg(selectedRowInd)
{
	var rowId = selectedRowInd.originalEvent.id;
	var $table = $("#evtNotInPkg_" + _pageRef);
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var status = $("#status_" + _pageRef).val();
	if (ivCrud == "P"  && _pageRef =="PKG00P")
	{
			$table.jqGrid('setSelection', rowId, false);
	}
}


//on Row Select 
function dynamicGridSelectRowFuncPkg(selectedRowInd)
{
	var rowId = selectedRowInd.originalEvent.id;
	var $table = $("#evtInPkg_" + _pageRef);
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var status = $("#status_" + _pageRef).val();
	if ((((status!= "Active" && status!= "") && ivCrud == "R") && _pageRef =="PKG00MT"))
	{
			$table.jqGrid('setSelection', rowId, false);
	}
}

//on Row Select approve
function dynamicGridSelectRowFuncAprPkg(selectedRowInd)
{
	var rowId = selectedRowInd.originalEvent.id;
	var $table = $("#evtInPkg_" + _pageRef);
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var status = $("#status_" + _pageRef).val();
	if (ivCrud == "P"  && _pageRef =="PKG00P")
	{
			$table.jqGrid('setSelection', rowId, false);
	}
}

function dynamicGridSelectAllFunc2Group(selectedRowInd)
{

	var grpId = $("#grpId_" + _pageRef).val();

	$("#load_subInGrp_" + _pageRef).show();
	var $table = $("#subInGrp_" + _pageRef);
	if (selectedRowInd.originalEvent.status)
	{
		var totalRow = $table.jqGrid('getGridParam', 'records');
		var rowNum = $table.jqGrid('getGridParam', 'rowNum');

		if (totalRow > rowNum)
		{
			var gridUrl = jQuery.contextPath
					+ "/path/alert/subscriber/groups/GroupsSubListAction_returnAllSelectedRow?groupId="
					+ grpId;
			;
			$.ajax({
				url : gridUrl,
				type : "post",
				dataType : "json",
				success : function(data)
				{

					$("#selSerialNo2_" + _pageRef).val(data.allSelectedRow2);
					$("#load_subInGrp_" + _pageRef).hide();
					$("#all_rows2_" + _pageRef).val("1");
				}
			});
		}
		else
		{
			for (i = 0; i < selectedRowInd.originalEvent.ids.length; i++)
			{
				dynamicGridOnePageRowsFunc2(
						selectedRowInd.originalEvent.ids[i],
						selectedRowInd.originalEvent.status);
			}
			$("#all_rows2_" + _pageRef).val("0");
			$("#load_subInGrp_" + _pageRef).hide();
		}
	}
	else
	{
		$("#selSerialNo2_" + _pageRef).val("");
		$("#all_rows2_" + _pageRef).val("0");
		$("#load_subInGrp_" + _pageRef).hide();
	}
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var status = $("#status_" + _pageRef).val();
	if ((((status!= "Active" && status!= "") && ivCrud == "R") && _pageRef =="GRP00MT") || (ivCrud == "P"  && _pageRef =="GRP00P") )
	{
		$table.jqGrid('resetSelection'); 
	}

}

function dynamicGridSelectAllFuncPkg(selectedRowInd)
{
	$("#load_evtInPkg_" + _pageRef).show();
	var $table = $("#evtInPkg_" + _pageRef);
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var status = $("#status_" + _pageRef).val();
	if ((((status!= "Active" && status!= "") && ivCrud == "R") && _pageRef =="PKG00MT") || (ivCrud == "P"  && _pageRef =="PKG00P") )
	{
		$table.jqGrid('resetSelection'); 
	}
	$("#load_evtInPkg_" + _pageRef).hide();
}

function dynamicGridSelectAllFunc2Pkg(selectedRowInd)
{
	$("#load_evtNotInPkg_" + _pageRef).show();
	var $table = $("#evtNotInPkg_" + _pageRef);
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var status = $("#status_" + _pageRef).val();
	if ((((status!= "Active" && status!= "") && ivCrud == "R") && _pageRef =="PKG00MT") || (ivCrud == "P"  && _pageRef =="PKG00P") )
	{
		$table.jqGrid('resetSelection'); 
	}
	$("#load_evtNotInPkg_" + _pageRef).hide();

}