(function($) {
    $.fn.extend({
        collapsiblePanel: function() {
            // Call the ConfigureCollapsiblePanel function for the selected element
            return $(this).each(ConfigureCollapsiblePanel);
        }
    });

})(jQuery);

// PathSolutions [Libin] modified the header icons to show up/down arrows instead of side/down arrows
function ConfigureCollapsiblePanel() {
    $(this).addClass("ui-widget");	 	

	var content  = $("<div class='collapsibleContainerContent ui-widget-content'></div>");
	var toggleIcon = "";
	
	if($(this).hasClass('collapsed')){
		content.css("display","none");
		$(this).removeClass('collapsed');
		//PathSolutions [Libin] added extra span to correct the collapsible panel resolution issue
		toggleIcon = "<span class=\"collapsibleIcon\"><span class=\"ui-icon ui-icon-circle-triangle-s\">&nbsp</span></span>";	
	}
	else{
		toggleIcon = "<span class=\"collapsibleIcon\"><span class=\"ui-icon ui-icon-circle-triangle-n\">&nbsp</span></span>";
	}
	

    // Wrap the contents of the container within a new div.	
    $(this).children().wrapAll(content);
	//PathSolutions [Libin] added 'ui-corner-top' to panel header and replaced the class 'ui-widget-header' with 'ui-state-focus' and changed the panel text id
    // Create a new div as the first item within the container.  Put the title of the panel in here.
    var toolTip =  $(this).attr("pathCollapsTitle");
    toolTip = (toolTip != "undefined" && toolTip !=null)? "title='"+toolTip+"'":"";
     $("<div class='collapsibleContainerTitle ui-state-focus ui-corner-top' ><span class=\"collapsibleLabel\" "+toolTip+">" + $(this).attr("title") + "</span>"+toggleIcon+"</div>").prependTo($(this));

    //PathSolutions: remove title on div
    $(this).removeAttr("title");
     
    // Assign a call to CollapsibleContainerTitleOnClick for the click event of the new title div.
    $(".collapsibleContainerTitle", this).click(CollapsibleContainerTitleOnClick);

}

function CollapsibleContainerTitleOnClick() {
    // The item clicked is the title div... get this parent (the overall container) and toggle the content within it.
    $(".collapsibleContainerContent", $(this).parent()).slideToggle("fast", function () {
			 var toggleElem = $(this).parent().children(":first-child").find('span .ui-icon');//PathSolutions [Libin] modified js to handle extra span added
			 /**
			  * [marwanmaddah]: changed the children selector to select the first level of children
			  * and added condition to the "if" to avoid the change of translation icon on click.
			  */
			 for(var i=0;i<toggleElem.length;i++)
			 {	
				 if($(toggleElem[i]).hasClass('ui-icon-circle-triangle-s') && !$(toggleElem[i]).hasClass('added_cust_icon'))
				 {
				 	$(toggleElem[i]).removeClass('ui-icon ui-icon-circle-triangle-s');
				 	$(toggleElem[i]).addClass('ui-icon ui-icon-circle-triangle-n');
				 }
				 else 
				 {
					if(!$(toggleElem[i]).hasClass('added_cust_icon'))
					{					  
						$(toggleElem[i]).removeClass('ui-icon ui-icon-circle-triangle-n');
						$(toggleElem[i]).addClass('ui-icon ui-icon-circle-triangle-s');
					}
				 }
			 }
    });
}

/**
 * @description this function used to adjust the element comes after the collapsible panel
 * @createdBy Sajjad Soomro
 * 
 * @param elem
 * @param elemWidth
 * @returns
 */
function adjustBelowElements(elem, elemWidth)
{
	var isClosed = isPanelCollapsed(elem);
	var panelParentDiv = elem.parent().parent();
	var elemHeight = panelParentDiv.height() - elem.height();
	var elemWidth =  panelParentDiv.width();
	var elemLeftPos = panelParentDiv.position().left;
	var elemTopPos = panelParentDiv.offset().top;
	var elemRightPos = elemLeftPos + elemWidth;
	
	panelParentDiv.parent().children().each(function(){
		var childElem = this;
		//used to handle button element
		if($(this).css('top') == "auto" && $(this).children().length > 0)
		{
			childElem = $(this).children()[0];
		}
		var currElemTopPos = $(childElem).offset().top;
		if(currElemTopPos <= elemTopPos) return;
		moveElement($(childElem), elemHeight, elemLeftPos, elemRightPos, isClosed);
	});	
}

/**
 * @description this function used to identify the panel is collapsed or not
 * @createdBy Sajjad Soomro
 * 
 * @param elem
 * @returns Boolean
 */
function isPanelCollapsed(elem)
{
	return elem.parent().find(".collapsibleContainerContent").height() > 1 ? true : false;
}

/**
 * @description this function used to move elements Up and Down according to the panel position
 * @createdBy Sajjad Soomro
 * 
 * @param elem
 * @param parentHeight
 * @param parentLeftPos
 * @param parentRightPos
 * @param isClosed
 * @returns
 */
function moveElement(elem, parentHeight, parentLeftPos, parentRightPos, isClosed)
{
	var elemTopPos = elem.position().top;	
	var elemLeftPos = elem.position().left + 10;	//cover relaxation of 10px to the left
	var elemWidth = elem.width();	
	var elemRightPos = (elemLeftPos + elemWidth) - 10;	//cover relaxation of 10px to the right
	//validate the left and right positions of the element
	if(elemLeftPos >= (parentLeftPos - 10) && elemRightPos <= parentRightPos)
	{
		if(isClosed)
		{
			elem.css('top', elemTopPos - parentHeight); //move up
		}
		else
		{
			elem.css('top', elemTopPos + parentHeight); //move down
		}
	}
}
// PathSolutions [Libin] end of changes