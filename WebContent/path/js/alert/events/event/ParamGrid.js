function processesGridValidations_SelectRowFunc() {
	var detailsGridId = $("#fixedParam_" + _pageRef);
	var selRow = detailsGridId.jqGrid("getGridParam", 'selrow');
	Boolean
	ls_find = false;
	var evtType = $("#event_type_" + _pageRef).val();
    var ivCrud = $("#iv_crud_" + _pageRef).val();
    var status = $("#STATUS_" + _pageRef).val();

	var myObject = detailsGridId.jqGrid('getRowData', selRow);
	var IS_FIXED_FLAG = myObject["FIXED_FLAG"];
	var IS_OPERATOR = myObject["fixedOperatorDesc"];

	if (IS_FIXED_FLAG == 'B' || IS_FIXED_FLAG == 'E') {
		detailsGridId.jqGrid('setCellValue', selRow, "fixedOperatorDesc",
				"Equals");
		detailsGridId.jqGrid('setCellReadOnly', selRow, 'fixedOperatorDesc',
				"true");

	}
	
    if (null != IS_OPERATOR && "undefined" != IS_OPERATOR)
	{
		if (IS_OPERATOR == '3') {
			detailsGridId.jqGrid('showCol', 'TO_VALUE');
			detailsGridId.jqGrid('setCellReadOnly', selRow, 'TO_VALUE', "false");
		} else {
		//	detailsGridId.jqGrid('hideCol', 'TO_VALUE');
		//	detailsGridId.jqGrid('setCellReadOnly', selRow, 'TO_VALUE', "true");
			  var rowIds = detailsGridId.jqGrid('getDataIDs');
			  for (i = 0; i < rowIds.length; i++)
			  {
			   var myObject = detailsGridId.jqGrid('getRowData', rowIds[i]);
			   if (myObject["fixedOperatorDesc"] == '3')
			   {
				   ls_find = true;
			   }

			  }

			  if (ls_find == false)
			  {
				  detailsGridId.jqGrid('hideCol', "TO_VALUE");
			  }
			  else
			  {
				  detailsGridId.jqGrid('setCellReadOnly', selRow,
			     "TO_VALUE", "true");
			  }
		}
	}
	var fixedevtId = $("#lookuptxt_fixedEventid_" + _pageRef).val();

	if (fixedevtId == 5 || fixedevtId == 6) {
		detailsGridId.jqGrid('hideCol', 'FROM_VALUE');

		if (fixedevtId == 5) {
			detailsGridId.jqGrid('showCol', 'FROM_VALUE2');// show
		} else if (fixedevtId == 6) {
			detailsGridId.jqGrid('showCol', 'FROM_VALUE1');// show
		}

	}
	
	 if (((evtType == "S")|| (evtType == "F" && (null != fixedevtId && "undefined" != fixedevtId ))) && ((ivCrud =="R" && (status == "D" || status == "P")) || ivCrud =="P"))   
	 {
		detailsGridId.jqGrid('setCellReadOnly', selRow,
				'fixedOperatorDesc', "true");
		detailsGridId.jqGrid('setCellReadOnly', selRow,
				'FROM_VALUE1', "true");
		detailsGridId.jqGrid('setCellReadOnly', selRow,
				'FROM_VALUE2', "true");
		detailsGridId.jqGrid('setCellReadOnly', selRow,
				'FROM_VALUE', "true");
		detailsGridId.jqGrid('setCellReadOnly', selRow,
				'TO_VALUE', "true");
		detailsGridId.jqGrid('setCellReadOnly', selRow,
				'FROM_VALUE3', "true");
		
	 }
	 
/*	if (ls_find == false){
	detailsGridId.jqGrid('hideCol', 'TO_VALUE');
	}*/

}

function processesGridValidationsRetrieve() {
	var detailsGridId = $("#fixedParam_" + _pageRef);
	var fixedevtId = $("#lookuptxt_fixedEventid_" + _pageRef).val();
	var evtType = $("#event_type_" + _pageRef).val();
    var ivCrud = $("#iv_crud_" + _pageRef).val();
    var status = $("#STATUS_" + _pageRef).val();

	var selectedRow = detailsGridId.jqGrid("getRowData");
	for (var i = 0; i < selectedRow.length; i++) {
		var myObject = selectedRow[i];
		var IS_FIXED_FLAG = myObject["FIXED_FLAG"];
		var IS_OPERATOR = myObject["fixedOperatorDesc"];

		if (IS_FIXED_FLAG == 'B' || IS_FIXED_FLAG == 'E') {
			detailsGridId.jqGrid('setCellValue', selectedRow[i],
					"fixedOperatorDesc", "Equals");
			detailsGridId.jqGrid('setCellReadOnly', selectedRow[i],
					'fixedOperatorDesc', "true");

		}

		if (IS_OPERATOR == '3') {
			detailsGridId.jqGrid('showCol', 'TO_VALUE');

		}
/*		else
			{
			detailsGridId.jqGrid('hideCol', 'TO_VALUE');
			}*/
			

		if (fixedevtId == 5 || fixedevtId == 6) {
			detailsGridId.jqGrid('hideCol', 'FROM_VALUE');

			if (fixedevtId == 5) {
				detailsGridId.jqGrid('showCol', 'FROM_VALUE2');// show
			} else if (fixedevtId == 6) {
				detailsGridId.jqGrid('showCol', 'FROM_VALUE1');// show
			}

		}
		
		 if (((evtType == "S")|| (evtType == "F" && (null != fixedevtId && "undefined" != fixedevtId ))) && ((ivCrud =="R" && (status == "D" || status == "P")) || ivCrud =="F" || ivCrud =="P"))   
			 {
				detailsGridId.jqGrid('setCellReadOnly', selectedRow[i],
						'fixedOperatorDesc', "true");
				detailsGridId.jqGrid('setCellReadOnly', selectedRow[i],
						'FROM_VALUE', "true");
				detailsGridId.jqGrid('setCellReadOnly', selectedRow[i],
						'TO_VALUE', "true");
				detailsGridId.jqGrid('setCellReadOnly', selectedRow[i],
						'FROM_VALUE1', "true");
				detailsGridId.jqGrid('setCellReadOnly', selectedRow[i],
						'FROM_VALUE2', "true");
				
			 }

	}

}
