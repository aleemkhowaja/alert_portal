/**
 * conform Group Subscriber Delete
 * @returns
 */
function groupSubscriberMaint_conformDelete() 
{
	_showConfirmMsg(Confirm_Delete_Process_key, confirm_msg_title,groupSubscriberMaint_delete, {}, '', '', 300, 100);
}

/**
 * delete Group Subscriber
 * @param conform
 * @returns
 */
function groupSubscriberMaint_delete(conform) 
{
	if (conform) 
	{
		var actionSrc = jQuery.contextPath+ "/path/alert/subscriber/groups/GroupsMaintAction_checkSubscription";
		var grpId = $("#grpId_" + _pageRef).val();
		var theForm = $("#groupsSubscriberMainFormId_" + _pageRef).serializeForm();
		var params = theForm;
		var ivCrud = $("#iv_crud_" + _pageRef).val();
		_showProgressBar(true);
		$.ajax({
			url : actionSrc,
			type : "post",
			dataType : "json",
			data : theForm + "&iv_crud=" + ivCrud + "&grpId=" + grpId,
			success : function(data) 
			{
				if (data["_error"] == null) 
				{
					if (data.groupsSubscriberCO.checkFlag == true) 
					{
						var arg = theForm + "&iv_crud=" + ivCrud
						+ "&grpId=" + grpId;
						_showProgressBar(false);
						_showConfirmMsg(Confirm_Delete_All_subscriptions_key, confirm_msg_title,groupSubscriberMaint_continueDeleteGroup, {}, '', '', 300, 100);
					} else 
					{
						var actionSrc = jQuery.contextPath+ "/path/alert/subscriber/groups/GroupsMaintAction_deleteRecord";
						var params = theForm;
						_showProgressBar(true);
						$.ajax({
							url : actionSrc,
							type : "post",
							dataType : "json",
							data : theForm + "&iv_crud="+ ivCrud,
						    success : function(data) {
						    	var actionSrc = jQuery.contextPath
									+ "/path/alert/subscriber/groups/GroupsMaintAction_initializeMain";
								$.post(actionSrc,{
									"iv_crud" : ivCrud,
									"_pageRef" : _pageRef
								},
								function(param) {
									$("#groupsSubscriberMaintPage_id_"+ _pageRef).html(param);
									$("#groupsSubscriberGridTbl_Id_"+ _pageRef).trigger("reloadGrid");
								}, "html");
								_showProgressBar(false);
								_showErrorMsg(record_was_Deleted_Successfully_key, success_msg_title, 300,100);
							}
						});
					}
				}
			}
		});
	}
}

/**
 * Continue to delete group of subscribers
 * @param yesNo
 * @param arg
 * @returns
 */
function groupSubscriberMaint_continueDeleteGroup(yesNo) {
	if (yesNo == true) {
		var actionSrc = jQuery.contextPath
				+ "/path/alert/subscriber/groups/GroupsMaintAction_deleteRecord";
		var ivCrud = $("#iv_crud_" + _pageRef).val();
		var theForm = $("#groupsSubscriberMainFormId_" + _pageRef)
				.serializeForm();
		var params = theForm;
		var args;

		_showProgressBar(true);
		$
				.ajax({
					url : actionSrc,
					type : "post",
					dataType : "json",
					data : theForm + "&iv_crud=" + ivCrud,
					success : function(data) {
						if (data["_error"] == null) {
							var actionSrc = jQuery.contextPath
									+ "/path/alert/subscriber/groups/GroupsMaintAction_initializeMain";
							$.post(actionSrc, {
								"iv_crud" : ivCrud,
								"_pageRef" : _pageRef
							}, function(param) {

								$("#groupsSubscriberMaintPage_id_" + _pageRef)
										.html(param);

								$("#groupsSubscriberGridTbl_Id_" + _pageRef)
										.trigger("reloadGrid");

							}, "html");
						}
						_showProgressBar(false);
						_showErrorMsg(record_was_Deleted_Successfully_key, success_msg_title, 300,100);
					}
				});
	}
}

/**
 * this method checks if there are changes in the screen
 * @returns
 */
function groupSubscriberMaint_checkIfFormChanged() 
{
	if (document.getElementById("groupsSubscriberMainFormId_" + _pageRef) == "undefined"
			|| document.getElementById("groupsSubscriberMainFormId_" + _pageRef) == null) 
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


/**
 * save group subscriber
 * @returns
 */
function groupSubscriberMaint_save() 
{
	var changetags = $("#changetags_" + _pageRef).val();

	if (groupSubscriberMaint_checkIfFormChanged() || changetags == '1') 
	{
		var actionSrc = jQuery.contextPath+ "/path/alert/subscriber/groups/GroupsMaintAction_saveRecord";
		var subInGrp = $("#subInGrp_" + _pageRef);		
		var list2 = $("#SubInGroup_" + _pageRef).val();
		var ivCrud = $("#iv_crud_" + _pageRef).val();
		var theForm = $("#groupsSubscriberMainFormId_" + _pageRef).serializeForm();
		var params = theForm;

		_showProgressBar(true);
		$.ajax({
			url : actionSrc,
			type : "post",
			dataType : "json",
			data : theForm + "&list2="
				+ encodeURIComponent(list2) + "&iv_crud="
				+ ivCrud,
				success : function(data) {
					if (data["_error"] == null) {
						var actionSrc = jQuery.contextPath+ "/path/alert/subscriber/groups/GroupsMaintAction_initializeMain";
							$.post(actionSrc, {
								"iv_crud" : ivCrud,
								"_pageRef" : _pageRef
							}, function(param) 
							{
								
								if (param["_error"] == null || param["_error"] == "undefined") 
								{
									_showErrorMsg(record_saved_Successfully_key, success_msg_title, 300,100);
									_showProgressBar(false);
									$("#groupsSubscriberMaintPage_id_" + _pageRef).html(param);
									$("#groupsSubscriberGridTbl_Id_" + _pageRef).trigger("reloadGrid");
									if(_pageRef == "GRP00MA")
									{
										showHideSrchGrid('groupsSubscriberGridTbl_Id_'+ _pageRef);
										$("#groupsSubscriberMaintPage_id_" + _pageRef).html("");
									}
								}
								else
								{
									_showProgressBar(false);
								}
							}, "html");
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
 * conform Approve group subscriber
 * @returns
 */
function groupSubscriberMaint_conformApprove()
{
	_showConfirmMsg(Confirm_Authorize_Process_key, confirm_msg_title,groupSubscriberMaint_approve, {}, '', '', 300, 100);
}


/**
 * approve Subscriber
 * @returns
 */
function groupSubscriberMaint_approve(conform) 
{
	if(conform) {
		var actionSrc = jQuery.contextPath+ "/path/alert/subscriber/groups/GroupsMaintAction_approveRecord";
		var ivCrud = $("#iv_crud_" + _pageRef).val();
		var theForm = $("#groupsSubscriberMainFormId_" + _pageRef).serializeForm();
		var params = theForm;
		_showProgressBar(true);
		$.ajax({
			url : actionSrc,
			type : "post",
			dataType : "json",
			data : theForm + "&iv_crud=" + ivCrud,
			success : function(data) {
				if (data["_error"] == null) {
					$("#groupsSubscriberGridTbl_Id_" + _pageRef).trigger("reloadGrid");
					showHideSrchGrid('groupsSubscriberGridTbl_Id_'+ _pageRef);
					$("#groupsSubscriberMaintPage_id_" + _pageRef).html("");
				    _showErrorMsg(record_was_Approved_Successfully_key, success_msg_title, 300,100);
				}
				_showProgressBar(false);
			}
		});
	}
}


function removeSubFromGrp() {
	_showProgressBar(true);
	var actionSrc = jQuery.contextPath
			+ "/path/alert/subscriber/groups/GroupsSubListAction_removeSubfromGrp";
	var selSerialNoValue = $("#selSerialNo2_" + _pageRef).val();
	if (selSerialNoValue == "") {
		_showProgressBar(false);
	} else {
		$.post(actionSrc, {
			"_pageRef" : _pageRef,
			"lstSerialNo2" : selSerialNoValue
		}, function(param) {

			$("#subNotInGrp_" + _pageRef).trigger("reloadGrid");
			$("#subInGrp_" + _pageRef).trigger("reloadGrid");
			$("#selSerialNo2_" + _pageRef).val("");
			$("#selSerialNo2_" + _pageRef).val(JSON.stringify(selSerialNo));
			_showProgressBar(false);

		}, "html");
		$("#changetags_" + _pageRef).val("1");
		var theform = document.getElementById("groupsSubscriberMainFormId_"
				+ _pageRef);
		$.data(theform, 'changeTrack', true);
	}
}

/**
 * this method opens the status list
 * 
 * @return {TypeName}
 */
function showGrpSubscriberStatus() {
	var grpId = $("#grpId_" + _pageRef).val();
	if (grpId == "") {
		return;
	}

	var loadSrc = jQuery.contextPath+ "/path/alert/subscriber/groups/GroupsStatusAction_search.action?_pageRef="
			+ _pageRef;

	showStatus("groupsSubscriberMainFormId_" + _pageRef, _pageRef, loadSrc, {
		"grpId" : grpId
	});
}
