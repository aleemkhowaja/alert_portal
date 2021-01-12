function common_showHideAutoCompleteData(actionUrl, actionVariableName, inputId)
{
	 params={};
	 params["_pageRef"]  =_pageRef;
	 //var url =jQuery.contextPath+"/path/atmInterface/ATMInterfaceMaintAction_retAutoCompleteData";
	 $.ajax({
	  url: actionUrl,
	  type:"post",
	  dataType:"json",
	  data: params,
	  success: function(param)
	  {
	   var expression_comparison=(param[actionVariableName]).split(",");
	   autoCompleteConstraints(inputId+"_"+_pageRef,expression_comparison);
	   //Show Data elements into Dialog grid
	  }
	 }); 
}


//show autocomplete list
/**
 * 
 */
autoCompleteConstraints = function(theInputId,expression_cust_tags)
{ 
	var theInput = $("#"+theInputId);
	// don't navigate away from the field on tab when selecting an item
    theInput.bind( "keydown", function( event )
    {
     if( event.keyCode === $.ui.keyCode.DOWN && !theInput.isopened)
     {
         theInput.autocomplete( "search", "" );
     }
    })
    .autocomplete({
     minLength: 0,
     inputId:theInputId,
     source: expression_cust_tags,
     open: function( event, ui )
     {
      theInput.isopened = true;
     },
     close: function( event, ui )
     {
      theInput.isopened = false;
     },
     focus: function()
     {
      // prevent value inserted on focus
      return false;
     },
     select: function( event, ui )
     {
	   var cursPosition   = returnCursorPosStart(document.getElementById(theInputId));
	   var strTillCurrPos = this.value.substring(0,cursPosition)
	   /**
	    * [MarwanMaddah]: this pattern will catch all the words 
	    * that are exists in the input from index 0 untill the current cursor position
	    * then the last word will be replaced by the selected value from the Search result
	    */
	  /* var patt       = /\w+/g;
	   var result     = strTillCurrPos.match(patt);
	   var firstPart  = "";
	   if(result!= null && result.length > 0)
	   {           
		   var resultLgth = result.length;
		   firstPart  = strTillCurrPos.substring(0,strTillCurrPos.lastIndexOf(result[resultLgth-1])); 
	   }
	   else
	   {
	    firstPart = strTillCurrPos; 
	   }*/
	   this.value = strTillCurrPos + " " +ui.item.value +" "+ this.value.substring(cursPosition);
	   return false;
     }
    });
};



/**
 * Add New Row in Gird
 * @returns
 */
function common_addGridRow(gridId)
{
	$("#"+gridId+_pageRef).jqGrid('addInlineRow',{});
}


/**
 * @Author Alim Khowaja
 * validate grid is empty row
 * @param gridId
 * @param propertyValidate
 * @returns
 */
function common_validateGridEmptyRowByProperty(gridId, propertyValidate)
{
	var property = $("#"+gridId+_pageRef).jqGrid('getCol',propertyValidate);
    for (var i=0; i<property.length; i++)
    {
    	if(property[i] == "" || property[i] == undefined)
    	{
    		return true
    		break;
    	}
    }
}


/**
 * 
 * @param gridId e.g "fixedParam_";
 * @param propertiesValidate e.g ["PARAM_VALUE", "OPERATOR_TYPE"];
 * @returns
 */
function common_validateGridEmptyRowByProperties(gridId, propertiesValidate)
{
	var result = false;
	for(var i=0; i<propertiesValidate.length; i++)
	{
		if(result)
		{
			break;
		}
		else
		{
			var property = $("#"+gridId+_pageRef).jqGrid('getCol',propertiesValidate[i]);
			if(property.length > 0)
			{
				for (var j=0; j<property.length; j++)
			    {
			    	if(property[j] == "" || typeof property[j] == "undefined" ||  property[j] == "-1" ||  property[j] == "0")
			    	{
			    		result = true; 
			    		break;
			    	}
			    }
			}
			else
			{
				result = false; 
				break;
			}
		}
	}
	return result;
}


/**
 * @Author Alim Khowaja
 * check duplicate record by Property
 * @param gridId. This is grid id otherSubscriberLanguagesGrid_Id
 * @param property this is column name e.g LANG_CODE
 * @returns
 */
function common_checkDuplicateRecordByProperty(gridId, property)
{
	var Tbl = $("#"+gridId+"_"+_pageRef);
	var selRow= Tbl.jqGrid('getGridParam','selrow');
	var newPropertyValue = Tbl.jqGrid('getCell', selRow, property);
	
	//retrieve all row ids
	var rows = Tbl.jqGrid('getDataIDs');
	var rowsLen = rows.length;
	
	//iterate over grid rows
	for (var i = 0; i < rowsLen; i++) 
	{
		var rowObject = Tbl.jqGrid('getRowData', rows[i]);
		if (rows[i] != selRow) //exclude newly created row
		{
			var oldPropertyValue = rowObject[property];
			if (newPropertyValue == oldPropertyValue && newPropertyValue != "") //checking selected lanaguage code with language code in  current iteration
			{
				_showErrorMsg(msg_duplicate_entry_Of_record_key, error_msg_title, 300,100);
				//For Subscription Languages Grid
				Tbl.jqGrid('setCellValue', selRow, property, "");
				return;
			}
		}
	}
}

/**
 * set layout while grid open
 * @param id
 * @returns
 */
function common_setLayout(id)
{
	$("#gbox_"+id+"_"+_pageRef).removeAttr("style");
	 //$(".ui-jqgrid-btable").removeAttr("style");
	 $("#"+id+"_"+_pageRef+"_pager").removeAttr("style");
	 $("#gview_"+id+"_"+_pageRef).find('.ui-jqgrid-hdiv').removeAttr("style");
	 $("#gview_"+id+"_"+_pageRef).removeAttr("style");
	 $("#gview_"+id+"_"+_pageRef).find('.ui-jqgrid-bdiv').css('width', '');
}

/**
 * check if parameter is empty/undefined/null
 * @param a
 * @returns
 */
function common_isNotEmpty(a)
{
	if( a != null && typeof a != "undefined" && a.trim() != "" ) return true;
	
	return false;
	
	
}
