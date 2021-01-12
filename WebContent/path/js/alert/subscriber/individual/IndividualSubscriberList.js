function initIndividualSubscriberPage(/* arg,subID */)
{
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var actionSrc = jQuery.contextPath + "/path/alert/subscriber/individual/IndividualSubscriberMaintAction_initializeMain";
	_showProgressBar(true);
	$.post(actionSrc, {
		"iv_crud" : ivCrud,
		"_pageRef" : _pageRef
	}, function(param)
	{
		$("#individualSubscriberMaintPage_id_" + _pageRef).html(param);
		$("#individualSubscriberGridTbl_Id_" + _pageRef).trigger("reloadGrid");
		_showProgressBar(false);

	}, "html");

}

function IndividualSubscriber_AddFunc()
{
	
	if (checkIfFormChanged())
	{
		_showConfirmMsg(changes_made_confirm_msg, confirm_msg_title, function(theVal)
		{
			_showProgressBar(true);
			if (theVal)
			{
				individualSubscriberList_NewClicked();
			}
			_showProgressBar(false);
		})
	}
	else
	{
		individualSubscriberList_NewClicked();
		_showProgressBar(false);
	}
};

function individualSubscriberList_NewClicked()
{
	var iv_crud = $("#iv_crud_" + _pageRef).val();
	var actionSrc = jQuery.contextPath+ "/path/alert/subscriber/individual/IndividualSubscriberMaintAction_initializeMain?iv_crud="+ iv_crud + "&_pageRef=" + _pageRef;
	
	_showProgressBar(true);
	var param = {};
	$("#individualSubscriberMaintPage_id_" + _pageRef).load(actionSrc,params, function()
	{
		_showProgressBar(false);
	});
	$("#individualSubscriberGridTbl_Id_" + _pageRef).trigger("reloadGrid");
}

// this method checks if there are changes in the screen.
function checkIfFormChanged()
{
	if (document.getElementById("individualSubscriberMainFormId_" + _pageRef) == "undefined" || document.getElementById("individualSubscriberMainFormId_"+ _pageRef) == null)
	{
		return false;
	}
	var changes = $("#individualSubscriberMainFormId_" + _pageRef).hasChanges();
	if (changes)
	{
		return true;
	}
	return changes;
}

/**
 * individual subscriber on dbclick
 * @returns
 */
function individualSubscriberList_onDbClickedEvent()
{
	var ivCrud = returnHtmlEltValue("iv_crud_" + _pageRef);
	if (ivCrud == 'R')
	{
		var changed = $("#individualSubscriberMainFormId_" + _pageRef).hasChanges();
		if (changed == 'true' || changed == true)
		{
			_showConfirmMsg(changes_made_confirm_msg, "","individualSubscriberList_DbClicked", "yesNo", '', '', 300, 100);
		}
		else
		{
			individualSubscriberList_DbClicked(true);
		}
	}
	else
	{
		individualSubscriberList_DbClicked(true);
	}
}

// this function check if something is changed in the form and show the user a
// confirm msg , and call method from Action to load data in the form .
function individualSubscriberList_DbClicked(yesNo)
{
	var $table = $("#individualSubscriberGridTbl_Id_" + _pageRef);
	var selectedRowId = $table.jqGrid('getGridParam', 'selrow');
	var myObject = $table.jqGrid('getRowData', selectedRowId);
	var subID = myObject["ID"];
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var actionSrc = jQuery.contextPath+ "/path/alert/subscriber/individual/IndividualSubscriberMaintAction_loadIndividualSubMaint";
	if (yesNo)
	{
		_showProgressBar(true);
		$.post(actionSrc, {
			"criteria.subID" : subID,
			"criteria.ivCrud" : ivCrud,
			"iv_crud" : ivCrud,
			"_pageRef" : _pageRef
		},
		function(param)
		{
			_showProgressBar(false);
			showHideSrchGrid('individualSubscriberGridTbl_Id_'+ _pageRef);
			$("#individualSubscriberMaintPage_id_" + _pageRef).html(param);
			individualSubscriberList_addDynamicEmailAndMobileFields();
			$(".subscribercontact").remove();
			$('<span class="subscribercontact slider round"></span>').insertAfter("#FACEBOOK_SOCIAL_ID_"+_pageRef);
			$('<span class="subscribercontact slider round"></span>').insertAfter("#TWITTER_SOCIAL_ID_"+_pageRef);
		})
	}
}

/**
 * 
 * @returns
 */
function individualSubscriberList_addDynamicEmailAndMobileFields()
{
	var totalEmailCount = $("#emailFieldsCount_"+_pageRef).val();
	var totalMobileNoCount = $("#mobileNoFieldsCount_"+_pageRef).val();
	//Add dynamic email fields
	individualSubscriberList_addDynamicEmailFields();
	
	//Add dynamic mobile fields
	individualSubscriberList_addDynamicMobileNoFields();
	
	var totalMobileFieldsByClass = $('.accountMobile').length;
}

/**
 * Add Email Dynamic Fields
 * @returns
 */
function individualSubscriberList_addDynamicEmailFields()
{
	var emails = $("#emailIds_"+_pageRef).val().split("<<->>");
	for(var i=0; i<emails.length; i++)
	{
		if(emails[i] != "" && emails[i] != undefined)
		{
			if(i == 0)
			{
				$("#subscriberEmail_"+_pageRef).val(emails[i]);
			}
			else
			{
				var newTextField = "<tr id='lastEmailRow_"+(i+1)+_pageRef+"'><td></td>"+
				   "<td colspan='3'>"+
					   "<div style='margin-bottom: 3px'>"+
							"<input type='text' autocomplete='off' size='70' " +
							"class='accountEmails path-theme-cust-input ui-state-focus ui-corner-all path-text-size' maxlength='250' value='' tabindex='11'" +
							" id='"+(i+1)+"subscriberEmail_"+_pageRef+"' initialvalue='' prevvalue=''>"+
						"</div>"+
					"</td>"+
				    "<td>"+
					"<a id='deleteEmailButton_"+(i+1)+_pageRef+"' onclick='individualSubscriberMaint_removeEmailDynamicField("+(i+1)+");' class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' " +
						"role='button'><span class='ui-button-text'> - </span>" +
					"</a> </td> "+
				"<tr>";
				
				var addRowId = "lastEmailRow_"+((i)+_pageRef);
				individualSubscriberMaint_addDynamicField(addRowId, newTextField);
				$("#"+(i+1)+"subscriberEmail_"+_pageRef).val(emails[i]);
			}
			var ivCrud = $("#iv_crud_" + _pageRef).val();
			var individualStatus = $("#individualSubStatus_"+_pageRef).val(); 
			if(ivCrud == "P" || (individualStatus == "P" && ivCrud != "F") || individualStatus == "D")
			{
				$("#"+(i+1)+"subscriberEmail_"+_pageRef).attr("readonly","readonly");
				$("#deleteEmailButton_"+(i+1)+_pageRef).addClass('disable-link');
				$("#addEmailButton_"+_pageRef).addClass('disable-link');
			}
		}
	}
	
}


/**
 * Add Mobile Dynamic Fields
 * @returns
 */
function individualSubscriberList_addDynamicMobileNoFields()
{
	var mobileNos = $("#mobileNos_"+_pageRef).val().split("<<->>");
	for(var i=0; i<mobileNos.length; i++)
	{
		if(mobileNos[i] != "" && mobileNos[i] != undefined)
		{
			if(i == 0)
			{
				$("#tell_"+_pageRef).val(mobileNos[i]);
			}
			else
			{
				var newTextField = "<tr id='lastMobileRow_"+(i+1)+_pageRef+"'><td></td>"+
				   "<td colspan='3'>"+
					   "<div style='margin-bottom: 3px'>"+
							"<input type='text' autocomplete='off' size='70' " +
							"class='accountMobile path-theme-cust-input ui-state-focus ui-corner-all path-text-size' maxlength='23' value='' tabindex='11'" +
							" id='"+(i+1)+"tell_"+_pageRef+"' initialvalue='' prevvalue=''>"+
						"</div>"+
					"</td>"+
				    "<td>"+
					"<a id='deleteMobileButton_"+(i+1)+_pageRef+"' onclick='individualSubscriberMaint_removeMobileDynamicField("+(i+1)+");' class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' " +
						"role='button'><span class='ui-button-text'> - </span>" +
					"</a> </td> "+
				"<tr>";
				var addRowId = "lastMobileRow_"+((i)+_pageRef);
				individualSubscriberMaint_addDynamicField(addRowId, newTextField)
				$("#"+(i+1)+"tell_"+(_pageRef)).val(mobileNos[i]);
			}
			var ivCrud = $("#iv_crud_" + _pageRef).val();
			var individualStatus = $("#individualSubStatus_"+_pageRef).val();
			if(ivCrud == "P"  || (individualStatus == "P" && ivCrud != "F") || individualStatus == "D")
			{
				$("#"+(i+1)+"tell_"+_pageRef).attr("readonly","readonly");
				$("#deleteMobileButton_"+(i+1)+_pageRef).addClass('disable-link');
				$("#addMobileButton_"+_pageRef).addClass('disable-link');
			}
		}
	}
}