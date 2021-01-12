// on Row Select 
function dynamicGridSelectRowFuncGroup(selectedRowInd, selSerialNo)
{
	var $table = $("#subNotInGrp_" + _pageRef);
	var rowId = selectedRowInd.originalEvent.id;
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var status = $("#status_" + _pageRef).val();
	if (((status!= "Active" && status!= "" && ivCrud == "R") && _pageRef =="GRP00MT"))
	{
			$table.jqGrid('setSelection', rowId, false);
	}
	var myObject = $table.jqGrid('getRowData', rowId);
	var selSerialNo = ($("#selSerialNo_" + _pageRef).val() != "") ? eval("("
			+ $("#selSerialNo_" + _pageRef).val() + ")") : new Object();

	var subId = myObject["alertSubVO.ID"] + "";

	if (selectedRowInd.originalEvent.status)
	{
		selSerialNo["subId_" + subId] = "{\"alertSubVO.ID\":\"" + myObject["alertSubVO.ID"]
				+ "}";
	}
	else
	{
		selSerialNo["subId_" + subId] = undefined;
		$("#all_rows_" + _pageRef).val("0");
	}
	if (selectedRowInd.originalEvent.status)
	{
		selSerialNo["selectedRow_" + subId] = "{\"selectedRow\":\""
				+ myObject["selectedRow"] + "}";
	}
	else
	{
		selSerialNo["selectedRow_" + subId] = undefined;
		$("#all_rows_" + _pageRef).val("0");
	}

	$("#selSerialNo_" + _pageRef).val(JSON.stringify(selSerialNo));

}

//on Row Select 
function dynamicGridSelectRowFuncAprGroup(selectedRowInd, selSerialNo)
{		 
	var $table = $("#subNotInGrp_" + _pageRef);
	var rowId = selectedRowInd.originalEvent.id;
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var status = $("#status_" + _pageRef).val();
	if (ivCrud == "P"  && _pageRef =="GRP00P")
	{
			$table.jqGrid('setSelection', rowId, false);
	}
}
function dynamicGridSelectAllFuncGroup(selectedRowInd)
{

	var grpId = $("#grpId_" + _pageRef).val();

	$("#load_subNotInGrp_" + _pageRef).show();
	var $table = $("#subNotInGrp_" + _pageRef);
	if (selectedRowInd.originalEvent.status)
	{
		var totalRow = $table.jqGrid('getGridParam', 'records');
		var rowNum = $table.jqGrid('getGridParam', 'rowNum');

		if (totalRow > rowNum)
		{
			var gridUrl = jQuery.contextPath
					+ "/path/alert/subscriber/groups/GroupsNotSubListAction_returnAllSelectedRow?groupId="
					+ grpId;
			;
			$.ajax({
				url : gridUrl,
				type : "post",
				dataType : "json",
				success : function(data)
				{

					$("#selSerialNo_" + _pageRef).val(data.allSelectedRow);
					$("#load_subNotInGrp_" + _pageRef).hide();
					$("#all_rows_" + _pageRef).val("1");
				}
			});
		}
		else
		{
			for (i = 0; i < selectedRowInd.originalEvent.ids.length; i++)
			{
				dynamicGridOnePageRowsFunc(selectedRowInd.originalEvent.ids[i],
						selectedRowInd.originalEvent.status);
			}
			$("#all_rows_" + _pageRef).val("0");
			$("#load_subNotInGrp_" + _pageRef).hide();
		}
	}
	else
	{
		$("#selSerialNo_" + _pageRef).val("");
		$("#all_rows_" + _pageRef).val("0");
		$("#load_subNotInGrp_" + _pageRef).hide();
	}
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var status = $("#status_" + _pageRef).val();
	if (((status!= "Active" && status!= "" && ivCrud == "R") && _pageRef =="GRP00MT") || (ivCrud == "P"  && _pageRef =="GRP00P") )
	{
		$table.jqGrid('resetSelection'); 
	}
}

// if only record in one page
function dynamicGridOnePageRowsFunc(selectedRowId, status)
{
	var $table = $("#subNotInGrp_" + _pageRef);
	var myObject = $table.jqGrid('getRowData', selectedRowId);
	var selSerialNo = ($("#selSerialNo_" + _pageRef).val() != "") ? eval("("
			+ $("#selSerialNo_" + _pageRef).val() + ")") : new Object();

	var serialNo = myObject["alertSubVO.ID"] + "";
	if (status)
	{
		selSerialNo["subId_" + serialNo] = "{\"alertSubVO.ID\":\""
				+ myObject["alertSubVO.ID"] + "}";
	}
	else
	{
		selSerialNo["subId_" + serialNo] = undefined;
		$("#all_rows_" + _pageRef).val("0");
	}
	if (status)
	{
		selSerialNo["selectedRow_" + serialNo] = "{\"selectedRow\":\""
				+ myObject["selectedRow"] + "}";
	}
	else
	{
		selSerialNo["selectedRow_" + serialNo] = undefined;
		$("#all_rows_" + _pageRef).val("0");
	}

	$("#selSerialNo_" + _pageRef).val(JSON.stringify(selSerialNo));

}

function onAfterBatchDetailScreenLoadGroup(selectedRowId)
{
	var $table = $("#subNotInGrp_" + _pageRef);
	var rows = $table.jqGrid('getDataIDs');
	var rowsLen = rows.length;
	var rowNum = $table.jqGrid('getGridParam', 'rowNum');
	selSerialNo = ($("#selSerialNo_" + _pageRef).val() != "") ? eval("("
			+ $("#selSerialNo_" + _pageRef).val() + ")") : new Object();
	if (!$.isEmptyObject(selSerialNo))
	{
		for (var j = 1; j <= rowNum; j++)
		{
			var myObject = $table.jqGrid('getRowData', j);
			var serialNo = myObject["alertSubVO.ID"];
			if (selSerialNo["subId_" + serialNo] != undefined)
			{
				$table.jqGrid('setSelection', j, true);
				if (selSerialNo["selectedRow_" + serialNo] == "1")
				{
					checkNewRec = "true";
					$table.jqGrid('deleteGridRow', j);
				}
				else
				{
					if (selSerialNo["selectedRow_" + serialNo] == "2")
					{
						checkNewRec = "true";
						selSerialNo["selectedRow_" + serialNo] = "3";
						$("#selSerialNo_" + _pageRef).val(
								JSON.stringify(selSerialNo));

					}
				}
			}
		}
	}
	else
	{
		for (var j = 1; j <= rowNum; j++)
		{
			var myObject = $table.jqGrid('getRowData', j);
			var serialNo = myObject["alertSubVO.ID"];
			if (selSerialNo["subId_" + serialNo] != undefined)
			{
				$table.jqGrid('setSelection', j, false);
			}
			if (selSerialNo["selectedRow_" + serialNo] == "1")
			{
				$table.jqGrid('deleteGridRow', j);
			}
			else
			{
				if (selSerialNo["selectedRow_" + serialNo] == "2")
				{
					selSerialNo["selectedRow_" + serialNo] = "3";
					$("#selSerialNo_" + _pageRef).val(
							JSON.stringify(selSerialNo));
					$table.jqGrid('addInlineRow', myObject);
				}
			}
		}
	}

}