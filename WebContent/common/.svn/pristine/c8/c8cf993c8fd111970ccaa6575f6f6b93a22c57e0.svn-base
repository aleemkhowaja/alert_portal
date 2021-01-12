/**
 * @author Sajjad Soomro
 * @createdate 06 Dec, 2019
 * @description this file is used to handle the events (add, update, delete, droppable, activeTab) of the Tabbed Panel 
 * @returns
 */

$(function() 
{
	/**
	 * @createdBy Sajjad Soomro
	 * @createdDate 10 Dec, 2019
	 * @description This function will open Dialog window to get input for the Tab Title and display Tab
	 * 				and if user cancel the Dialog window, the default Tab Title will be set. 
	 */
	dynamicscreen_addTabbedPanelTab = function(rowId, tabTitle, propId)
	{
		var labelDialogOptions = {
				modal:true,
				title: (typeof tab_title_key === "undefined" || tab_title_key === "")?"Tab Title" :tab_title_key,
				width:'320',
				height:'150',
				dialogClass: 'no-close',
				closeOnEscape: false,
				buttons:{
					ok: function(){

						var newValue = $("#lookuptxt_labelEdit").val();
						if(newValue!=null && typeof newValue !='undefined' && newValue!='')
						{
							tabTitle = newValue;
						}
						
						dynamicscreen_addTab(rowId, tabTitle, propId)
						$(this).dialog("close");	
					},
					cancel: function(){
						dynamicscreen_addTab(rowId, tabTitle, propId);
						$(this).dialog("close");
					}
				}
		};
		var	smartLabelDiv = $("<div id='smartLabel_div' class='path-common-sceen'></div>");
		smartLabelDiv.css("padding","0");
		smartLabelDiv.insertAfter($('body'));
		var _smartLabelParams = {};
	    var smartLabelSrcURL  = jQuery.contextPath+"/path/screenGenerator/generatorMaint_loadSmartLabel";
		$("#smartLabel_div").load(smartLabelSrcURL, _smartLabelParams, function() {_showProgressBar(false);});
		$("#smartLabel_div").dialog(labelDialogOptions);
		$("#smartLabel_div").dialog("open");					                	        
	}
	
	/**
	 * @createdBy Sajjad Soomro
	 * @createdDate 12 Dec, 2019
	 * @description As each newly component created on the designer starts with "new_". 
	 * 				so, this method used to concat "new_" with the TabbedPanel div to create Tabs inside the Tabbed Panel
	 */
	dynamicscreen_addNewTab = function(rowId, tabTitle, propId)
	{
		dynamicscreen_addTab("new_"+rowId, tabTitle, propId);
	}
	
	/**
	 * @createdBy Sajjad Soomro
	 * @createdDate 09 Dec, 2019
	 * @description This function used to build the Tab Title and Div area attached with the tabItem
	 * 				and make the current created tab as active tab and Tab area as droppable to drop further elements on it.
	 */
	dynamicscreen_addTab = function(rowId, tabTitle, propId)
	{
		var divId = rowId + "_tabbedPanelDiv";
		var techId = (new Date()).getTime();
    	var tabId = "new_"+techId;
		var parentTechId;
		var parent_techId;

		//generate parentTechId for save mode
		if(rowId.indexOf("new_")!=-1)
		{
			parentTechId = rowId.substring(4, rowId.length);
		}
		else
		{
			parentTechId= rowId;
		}
		
		 //fetch parent techId when in edit mode
		if($("#"+rowId+"_div").length)
		{
			parent_techId = $("#"+rowId+"_div").attr("techid");
		}
		else
		{
			parent_techId = $("#"+parentTechId+"_div").attr("techid");
			divId = parentTechId + "_tabbedPanelDiv";
		}
		
		 //this block is used to check parent id of the new and existing tab when in edit mode.
		if(parentTechId != parent_techId && parent_techId != "undefined" && parent_techId!="")
		{
			parentTechId = parent_techId;
		}
    	
		// create tab header
		var listItem = "<li onClick=dynamicscreen_activateTab('"+divId+"','"+tabId+"') id='"+tabId+"' propertyid='"+propId+"' title='"+escapeString(tabTitle)+"' class='ui-state-default ui-corner-top'><a href='javascript:void(0);'>"+escapeString(tabTitle)+"</a></li>";
		$("#"+divId+" ul").append(listItem);

		// create tab area/block
		if($("#"+rowId).length==0 && rowId.indexOf("new_")!=-1)
		{
			rowId = rowId.substring(4, rowId.length);
		}
		var width = $("."+rowId+"_div").css("width");
		var height = $("."+rowId+"_div").css("height");
		var _contentWidth = width != null ? parseInt(width)-5 + 'px' : '100%';
		var _contentHeight = height != null ? parseInt(height)-37 + 'px' : '98%';
		var divItem ="<div id='"+tabId+"_div' techid='"+techId+"' parenttechid='"+parentTechId+"' propid='"+propId+"' type='14' style='position:relative; width:"+_contentWidth+"; height:"+_contentHeight+"; border:1px solid #000;' class='_newdrag ui-widget-content ui-corner-bottom "+rowId+"_div_tab'></div>";

		if($("#"+rowId+">div").length)
		{
			$("#"+rowId+">div:last").after(divItem);
		}
		else
		{
			$("#"+divId).after(divItem);	
		}
		
		// fill tab properties into the cache
		fillTabPropertiesJsonArray(tabId, propId, tabTitle);

		//activate newly created tab
		dynamicscreen_activateTab(divId, tabId);
	};
	
	/**
	 * @createdBy Sajjad Soomro
	 * @createdDate 12 Dec, 2019
	 * @description As each component created on the designer starts with "new_". 
	 * 				So, this method used to concat "new_" with the TabbedPanel div 
	 * 				when update Tabs inside the Tabbed Panel
	 */
	dynamicscreen_updateNewTab = function(rowId, tabId, tabTitle, propId, gridId)
	{
		dynamicscreen_updateTab("new_"+rowId, tabId, tabTitle, propId, gridId);
		
		// fill tab properties into the cache
		fillTabPropertiesJsonArray(tabId, propId, tabTitle);
	};
	
	/**
	 * @createdBy Sajjad Soomro
	 * @createdDate 12 Dec, 2019
	 * @description This function used to update the Tab attributes and its related div
	 */
	dynamicscreen_updateTab = function(rowId, tabId, tabTitle, propId, gridId)
	{
		var divId = rowId + "_tabbedPanelDiv";
		$("#"+tabId).attr("propertyid", propId);
		$("#"+tabId+" a").html(escapeString(tabTitle));
		$("#"+tabId).attr("title", $("#"+tabId+" a").text());
		$("#"+tabId+"_div").attr("propId", propId);
	};
	
	/**
	 * @createdBy Sajjad Soomro
	 * @createdDate 12 Dec, 2019
	 * @description This function is used to delete the selected tab
	 */
	dynamicscreen_deleteTab = function(divId, tabId)
	{
		$("#"+divId+" ul li#"+tabId).remove();
		$("#"+tabId+"_div").remove();
	};

	/**
	 * @createdBy Sajjad Soomro
	 * @createdDate 06 Dec, 2019
	 * @description This function is used to display the tab as Active Tab
	 */
	dynamicscreen_activateTab = function(divId, tabId)
	{
		$("#"+divId+" ul li").each(function( index )
		{
			var id = $(this).attr('id');
			if(tabId == id)
			{
				$(this).addClass("ui-tabs-selected ui-state-active");
			}
			else
			{
				$(this).removeClass("ui-tabs-selected ui-state-active");
				$(this).addClass("ui-tabs-disabled");
			}
		});
		
		dynamicscreen_hideOtherTabsDiv(divId, tabId);
		dynamicscreen_addTab_droppable(tabId);
	}
	
	/**
	 * @createdBy Sajjad Soomro
	 * @createdDate 09 Dec, 2019
	 * @description This function is used to hide the Div areas of the tabs other than selected Tab
	 */
	dynamicscreen_hideOtherTabsDiv = function(divId, tabId)
	{
		$("#"+divId+" ul li").each(function( index ) 
		{
			var id = $(this).attr('id');
			if(tabId != id)
			{
				$("#"+id+"_div").hide();	
			}
			else
			{
				$("#"+id+"_div").show();	
			}
		});
	};	
	
	/**
	 * @createdBy Sajjad Soomro
	 * @createdDate 06 Dec, 2019
	 * @description This function is used to make Tab Div area droppable 
	 */
	dynamicscreen_addTab_droppable = function(tabId)
	{
		$("#"+tabId+"_div").droppable({				 
		    activeClass: "ui-state-hover",
		    hoverClass: "ui-state-active",
		    greedy:true,
		    drop: function( event, ui ) 
		    {
				_callActionToCheckSession();
				screenGenerator_onDrop(event,ui,document.getElementById(tabId+"_div"));
			}
		});
	};
});