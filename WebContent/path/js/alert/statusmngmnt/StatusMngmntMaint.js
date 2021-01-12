function statusMaint_processSuspend() {

	var relType = $("#status_" + _pageRef).val();
	var grid;
	if (relType == "A") {
		grid = $("#statusGrid_Id_" + _pageRef);
	} else if (relType == "SE") {
		grid = $("#subevtGrid_Id_" + _pageRef);
	} else if (relType == "EG") {
		grid = $("#groupEvtGrid_Id_" + _pageRef);
	} else if (relType == "GP") {

		grid = $("#groupPackageGrid_Id_" + _pageRef);
	} else if (relType == "SP") {
		grid = $("#subscriberPackageGrid_Id_" + _pageRef);
	}
	var selRowId = grid.jqGrid("getGridParam", "selarrrow");

	if (selRowId != null && selRowId != "undefined" && selRowId != "") {

		_showConfirmMsg(are_you_sure_want_to_suspending_subscriptions_key,
				Warning_key, "statusMaint_processSuspendConfirmed", "yesNo");
	} else {
		_showErrorMsg(please_select_a_sub_key);
		
	}
}

function statusMaint_processSuspendConfirmed(yesNo) {

	if (yesNo) {

		var action = jQuery.contextPath
				+ "/path/statusMngmnt/StatusMngmntMaintAction_processSuspend.action";
		var relType = $("#status_" + _pageRef).val();

		checkStatus(relType, _pageRef);

		var $myGrid;

		if (relType == "A") {
			var gridAllRecords = $("#statusGrid_Id_" + _pageRef).jqGrid(
					'getAllRows');
			setInputValue("updateMode_hdn_statusGrid_Id_" + _pageRef,
					gridAllRecords);
			$myGrid = $("#statusGrid_Id_" + _pageRef);
		} else if (relType == "SE") {
			var gridAllRecordsSE = $("#subevtGrid_Id_" + _pageRef).jqGrid(
					'getAllRows');
			setInputValue("updateMode_hdn_subevtGrid_Id_" + _pageRef,
					gridAllRecordsSE);
			$myGrid = $("#subevtGrid_Id_" + _pageRef);
		} else if (relType == "EG") {
			var gridAllRecordsGE = $("#groupEvtGrid_Id_" + _pageRef).jqGrid(
					'getAllRows');
			setInputValue("updateMode_hdn_GrpEvtGrid_Id_" + _pageRef,
					gridAllRecordsGE);
			$myGrid = $("#groupEvtGrid_Id_" + _pageRef);

		} else if (relType == "GP") {

			var gridAllRecordsGP = $("#groupPackageGrid_Id_" + _pageRef)
					.jqGrid('getAllRows');
			setInputValue("updateMode_hdn_groupPkgGrid_Id_" + _pageRef,
					gridAllRecordsGP);
			$myGrid = $("#groupPackageGrid_Id_" + _pageRef);
		} else if (relType == "SP") {
			var gridAllRecordsSP = $("#subscriberPackageGrid_Id_" + _pageRef)
					.jqGrid('getAllRows');

			setInputValue("updateMode_hdn_subPkgGrid_Id_" + _pageRef,
					gridAllRecordsSP);
			$myGrid = $("#subscriberPackageGrid_Id_" + _pageRef);
		}

		var selRowId = $myGrid.jqGrid("getGridParam", "selrow");

		// alert(gridAllRecords);
		var formData = $("#statusMngmntMaintFormId_" + _pageRef)
				.serializeForm();
		_showProgressBar(true);
		$
				.ajax({
					url : action,
					type : "post",
					data : formData,
					dataType : "json",
					success : function(data) {
						// alert(data["_error"]);
						if (typeof data["_error"] == "undefined"
								|| data["_error"] == null) {
							$myGrid.trigger("reloadGrid");

							_showErrorMsg(
									Record_was_Suspended_Successfully_key,
									success_msg_title);

						} else {

							$myGrid.trigger("reloadGrid");
							$myGrid.jqGrid('setCellValue', selRowId,
									'statuschck', 'Y');

						}
						_showProgressBar(false);
					}
				});

	}

}

function statusMaint_processFilter()

{
	_showProgressBar(true);

	var action = jQuery.contextPath
			+ "/path/statusMngmnt/StatusMngmntListAction_LoadFilterGrid";
	var params = {};

	var relType = $("#status_" + _pageRef).val();

	params["criteria.relType"] = relType;

	params["_pageRef"] = _pageRef;

	// $("#trackTabcontent_" + _pageRef).show();
	// $('#trackTabcontent_' + _pageRef).load('Login.jsp');
	// jQuery("#statusGrid_Id_" + _pageRef).jqGrid('setGridParam', {
	// url : action,
	// datatype : 'json',
	// postData : params
	// }).trigger("reloadGrid");
	// _showProgressBar(false);
	$("#trackTabcontent_" + _pageRef).load(action, params, function() {
		$("#Suspend_" + _pageRef).show();
		$("#Reactivate_" + _pageRef).show();
		_showProgressBar(false);

	});

	$("#statusMngmntMaintFormId_" + _pageRef).data("changeTrack", false);
}

/*
 * function statusMaint_processFilter() { // var action = jQuery.contextPath // +
 * "/path/statusMngmnt/StatusMngmntMaintAction_processFilter.action";
 * 
 * 
 * var gridUrl = jQuery.contextPath +
 * '/path/statusMngmnt/StatusMngmntListAction_loadStatusMngmntGrid'; var arr={};
 * 
 * var relType = $("#status_" + _pageRef).val();
 * 
 * arr["criteria.relType"] = relType;
 * 
 * alert("relType :"+relType );
 * 
 * jQuery("#statusGrid_Id_").jqGrid('setGridParam', { url : gridUrl, datatype :
 * 'json', postData: arr }).trigger("reloadGrid"); // $.ajax({ // url : action, //
 * type : "post", // data : formData, // dataType : "json", // success :
 * function(data) // { // _showErrorMsg('Suspended Successfully',
 * info_msg_title); // // $("#statusGrid_Id_" + _pageRef).trigger("reloadGrid"); // // } //
 * }); }
 */
/*
 * var reloadAction = jQuery.contextPath +
 * "/path/newApi/NewApiMaintAction_loadMaintanenceDetails.action"; var
 * reloadParams = {}; var iv_Crud = returnHtmlEltValue("ivcrud_" + _pageRef);
 * reloadParams["iv_crud"] = iv_Crud; reloadParams["_pageRef"] = _pageRef;
 * _showProgressBar(true); $.ajax({ url : reloadAction, type : "post", data :
 * reloadParams, success : function(data) { $("#newApiListMaintDiv_id_" +
 * _pageRef).html(data); _showProgressBar(false); }
 * 
 * }); }
 * 
 * }); }
 * 
 */
function checkStatus(relType, _pageRef) {

	// alert("relType : "+relType+"\n_pageRef : "+_pageRef)
	var table;
	var ALL_SUBSCRIPTION = "A";
	// alert(relType);
	if (relType == ALL_SUBSCRIPTION) {
		table = $("#statusGrid_Id_" + _pageRef);

	} else if (relType == "SE") {

		table = $("#subevtGrid_Id_" + _pageRef);
	} else if (relType == "EG") {

		table = $("#groupEvtGrid_Id_" + _pageRef);

	} else if (relType == "GP") {

		table = $("#groupPackageGrid_Id_" + _pageRef);
	} else if (relType == "SP") {

		table = $("#subscriberPackageGrid_Id_" + _pageRef);
	}

	var selRowIds = table.jqGrid('getGridParam', 'selarrrow');

	for (var i = 0; i < selRowIds.length; i++) {

		// alert("selRowIds[i]:" + selRowIds[i]);

		table.jqGrid('setCellValue', selRowIds[i], "statuschck", 'Y');

	}

	return true;

}

function statusMaint_processApprove() {
	var relType = $("#status_" + _pageRef).val();
	var grid;
	if (relType == "A") {
		grid = $("#statusGrid_Id_" + _pageRef);
	} else if (relType == "SE") {
		grid = $("#subevtGrid_Id_" + _pageRef);
	} else if (relType == "EG") {
		grid = $("#groupEvtGrid_Id_" + _pageRef);
	} else if (relType == "GP") {

		grid = $("#groupPackageGrid_Id_" + _pageRef);
	} else if (relType == "SP") {
		grid = $("#subscriberPackageGrid_Id_" + _pageRef);
	}
	var selRowId = grid.jqGrid("getGridParam", "selarrrow");

	if (selRowId != null && selRowId != "undefined" && selRowId != "") {

		_showConfirmMsg(are_you_sure_want_to_activating_subscriptions_key,
				Warning_key, "statusMaint_processApproveConfirmed", "yesNo");
	}
	
		else {
			_showErrorMsg(please_select_a_sub_key);
		}
	
}

function statusMaint_processApproveConfirmed(yesNo) {

	if (yesNo) {
		var action = jQuery.contextPath
				+ "/path/statusMngmnt/StatusMngmntMaintAction_processApprove.action";

		var relType = $("#status_" + _pageRef).val();

		checkStatus(relType, _pageRef)

		var $myGrid;

		if (relType == "A") {
			var gridAllRecords = $("#statusGrid_Id_" + _pageRef).jqGrid(
					'getAllRows');
			setInputValue("updateMode_hdn_statusGrid_Id_" + _pageRef,
					gridAllRecords);
			$myGrid = $("#statusGrid_Id_" + _pageRef);
		} else if (relType == "SE") {
			var gridAllRecordsSE = $("#subevtGrid_Id_" + _pageRef).jqGrid(
					'getAllRows');
			setInputValue("updateMode_hdn_subevtGrid_Id_" + _pageRef,
					gridAllRecordsSE);
			$myGrid = $("#subevtGrid_Id_" + _pageRef);
		} else if (relType == "EG") {
			var gridAllRecordsGE = $("#groupEvtGrid_Id_" + _pageRef).jqGrid(
					'getAllRows');
			setInputValue("updateMode_hdn_GrpEvtGrid_Id_" + _pageRef,
					gridAllRecordsGE);
			$myGrid = $("#groupEvtGrid_Id_" + _pageRef);

		} else if (relType == "GP") {

			var gridAllRecordsGP = $("#groupPackageGrid_Id_" + _pageRef)
					.jqGrid('getAllRows');
			setInputValue("updateMode_hdn_groupPkgGrid_Id_" + _pageRef,
					gridAllRecordsGP);
			$myGrid = $("#groupPackageGrid_Id_" + _pageRef);
		} else if (relType == "SP") {
			var gridAllRecordsSP = $("#subscriberPackageGrid_Id_" + _pageRef)
					.jqGrid('getAllRows');

			setInputValue("updateMode_hdn_subPkgGrid_Id_" + _pageRef,
					gridAllRecordsSP);
			$myGrid = $("#subscriberPackageGrid_Id_" + _pageRef);
		}

		// alert(gridAllRecords);
		var formData = $("#statusMngmntMaintFormId_" + _pageRef)
				.serializeForm();
		_showProgressBar(true);
		$.ajax({
			url : action,
			type : "post",
			data : formData,
			dataType : "json",
			success : function(data) {
				if (typeof data["_error"] == "undefined"
						|| data["_error"] == null) {

					_showErrorMsg(record_reactivated_successfully_key);

				}
				$myGrid.trigger("reloadGrid");
				_showProgressBar(false);
			}
		});

	}
}

function statusMngmntMaint_processSubmit() {
	alert("Coding Needed of statusMngmntMaint_onDbClickedEvent()");
}

function onSelRow(rowObj)
{
	var gridSelectorName = rowObj.target.id;
	var rowId = rowObj.originalEvent.id
	grid = $("#"+gridSelectorName);
	grid.jqGrid('setCellReadOnly',rowId,'alrt_sub_evtvo.EMAIL_YN',"true");
	grid.jqGrid('setCellReadOnly',rowId,'alrt_sub_evtvo.FILE_YN',"true");
	grid.jqGrid('setCellReadOnly',rowId,'alrt_sub_evtvo.FACEBOOK_PRIVATE_WALL_YN',"true");
	grid.jqGrid('setCellReadOnly',rowId,'alrt_sub_evtvo.INBOX_YN',"true");
	grid.jqGrid('setCellReadOnly',rowId,'alrt_sub_evtvo.MOBILE_PUSH_NOTIFICATION_YN',"true");
	grid.jqGrid('setCellReadOnly',rowId,'alrt_sub_evtvo.SMS_YN',"true");
	grid.jqGrid('setCellReadOnly',rowId,'alrt_sub_evtvo.TWITTER_DIRECT_MESSAGE_YN',"true");

}