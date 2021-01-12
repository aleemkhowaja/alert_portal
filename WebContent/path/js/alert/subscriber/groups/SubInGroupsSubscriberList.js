// on Row Select 
function dynamicGridSelectRowFunc2Group(selectedRowInd)
{
	var rowId = selectedRowInd.originalEvent.id;
	var $table = $("#subInGrp_" + _pageRef);
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var status = $("#status_" + _pageRef).val();
	if (((status!= "Active" && status!= ""  && ivCrud == "R") && _pageRef =="GRP00MT"))
	{
			$table.jqGrid('setSelection', rowId, false);
	}
	
	var myObject = $table.jqGrid('getRowData', rowId);
	var selSerialNo2 = ($("#selSerialNo2_" + _pageRef).val() != "") ? eval("("
			+ $("#selSerialNo2_" + _pageRef).val() + ")") : new Object();

	var subId = myObject["SUB_ID"] + "";

	if (selectedRowInd.originalEvent.status)
	{
		selSerialNo2["subId_" + subId] = "{\"SUB_ID\":\"" + myObject["SUB_ID"]
				+ "}";
	}
	else
	{
		selSerialNo2["subId_" + subId] = undefined;
		$("#all_rows2_" + _pageRef).val("0");
	}
	if (selectedRowInd.originalEvent.status)
	{
		selSerialNo2["selectedRow_" + subId] = "{\"selectedRow\":\""
				+ myObject["selectedRow"] + "}";
	}
	else
	{
		selSerialNo2["selectedRow_" + subId] = undefined;
		$("#all_rows2_" + _pageRef).val("0");
	}

	$("#selSerialNo2_" + _pageRef).val(JSON.stringify(selSerialNo2));

}
//on Row Select 
function dynamicGridSelectRowFunc2AprGroup(selectedRowInd)
{
	var rowId = selectedRowInd.originalEvent.id;
	var $table = $("#subInGrp_" + _pageRef);
	var ivCrud = $("#iv_crud_" + _pageRef).val();
	var status = $("#status_" + _pageRef).val();
	if (ivCrud == "P"  && _pageRef =="GRP00P")
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
	if (((status!= "Active" && status!= ""  && ivCrud == "R") && _pageRef =="GRP00MT") || (ivCrud == "P"  && _pageRef =="GRP00P") )
	{
		$table.jqGrid('resetSelection'); 
	}

}

// if only record in one page
function dynamicGridOnePageRowsFunc2(selectedRowId, status)
{
	var $table = $("#subInGrp_" + _pageRef);
	var myObject = $table.jqGrid('getRowData', selectedRowId);
	var selSerialNo2 = ($("#selSerialNo2_" + _pageRef).val() != "") ? eval("("
			+ $("#selSerialNo2_" + _pageRef).val() + ")") : new Object();

	var serialNo = myObject["SUB_ID"] + "";
	if (status)
	{
		selSerialNo2["subId_" + serialNo] = "{\"SUB_ID\":\""
				+ myObject["SUB_ID"] + "}";
	}
	else
	{
		selSerialNo2["subId_" + serialNo] = undefined;
		$("#all_rows2_" + _pageRef).val("0");
	}
	if (status)
	{
		selSerialNo2["selectedRow_" + serialNo] = "{\"selectedRow\":\""
				+ myObject["selectedRow"] + "}";
	}
	else
	{
		selSerialNo2["selectedRow_" + serialNo] = undefined;
		$("#all_rows2_" + _pageRef).val("0");
	}

	$("#selSerialNo2_" + _pageRef).val(JSON.stringify(selSerialNo2));

}

function onAfterBatchDetailScreenLoad2Group(selectedRowId)
{
	var $table = $("#subInGrp_" + _pageRef);
	var rows = $table.jqGrid('getDataIDs');
	var rowsLen = rows.length;
	var rowNum = $table.jqGrid('getGridParam', 'rowNum');
	selSerialNo2 = ($("#selSerialNo2_" + _pageRef).val() != "") ? eval("("
			+ $("#selSerialNo2_" + _pageRef).val() + ")") : new Object();
	if (!$.isEmptyObject(selSerialNo2))
	{
		for (var j = 1; j <= rowNum; j++)
		{
			var myObject = $table.jqGrid('getRowData', j);
			var serialNo = myObject["SUB_ID"];
			if (selSerialNo2["subId_" + serialNo] != undefined)
			{
				$table.jqGrid('setSelection', j, true);
				if (selSerialNo2["selectedRow_" + serialNo] == "1")
				{
					checkNewRec = "true";
					$table.jqGrid('deleteGridRow', j);
				}
				else
				{
					if (selSerialNo2["selectedRow_" + serialNo] == "2")
					{
						checkNewRec = "true";
						selSerialNo2["selectedRow_" + serialNo] = "3";
						$("#selSerialNo2_" + _pageRef).val(
								JSON.stringify(selSerialNo2));

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
			var serialNo = myObject["SUB_ID"];
			if (selSerialNo2["subId_" + serialNo] != undefined)
			{
				$table.jqGrid('setSelection', j, false);
			}
			if (selSerialNo2["selectedRow_" + serialNo] == "1")
			{
				$table.jqGrid('deleteGridRow', j);
			}
			else
			{
				if (selSerialNo2["selectedRow_" + serialNo] == "2")
				{
					selSerialNo2["selectedRow_" + serialNo] = "3";
					$("#selSerialNo2_" + _pageRef).val(
							JSON.stringify(selSerialNo2));
					$table.jqGrid('addInlineRow', myObject);
				}
			}
		}
	}

}