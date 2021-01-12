package com.path.alert.actions.lookups.todoalert;

import com.path.alert.bo.todoalert.TodoAlertBO;
import com.path.alert.vo.common.TodoAlertSC;
import com.path.bo.common.MessageCodes;
import com.path.lib.common.exception.BOException;
import com.path.lib.common.util.StringUtil;
import com.path.lib.vo.LookupGrid;
import com.path.struts2.lib.common.base.LookupBaseAction;

/**
 * 
 * Copyright 2020, Path Solutions
 * Path Solutions retains all ownership rights to this source code 
 * 
 * @author: Alim Khowaja
 *
 * ProgRefLookupAction.java used to
 */
public class TodoAlertLookupAction extends LookupBaseAction
{
    
    private TodoAlertSC  todoAlertSC = new TodoAlertSC();
    private TodoAlertBO todoAlertBO;

    /**
     * Method that load the todo Alert
     * 
     * @return SUCCESS
     * @throws Exception
     */
    public String constructLookup()
    {
	try
	{
		 String[] name = { "APP_NAME", "TODO_ALERT", "BRIEF_DESC_ENG", "TODO_ALERT_TYPE", "OPT_URL", "APPROVE_METHOD", "OPEN_METHOD" };
		 String[] colType = { "text", "text", "text", "text", "text", "text", "text" };
		 String[] titles = { getText("app_name_key"), 
			 getText("todo_alert_key"), 
			 getText("brief_desc_eng_key"), 
			 getText("todo_alert_type_key"),
			 getText("opt_url_key"),
			 getText("approve_method_key"),
			 getText("open_method_key"),
			 };
		 
		// Defining the Grid
		 LookupGrid grid = new LookupGrid();
		 grid.setCaption(getText("todo_alert_key"));
		 grid.setRowNum("5");
		 grid.setShrinkToFit("true");
		  
		 grid.setUrl("/path/alert/lookup/TodoAlertLookupAction_fillLookupTodoAlert");
		 lookup(grid, todoAlertSC, name,  colType,  titles );
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    /**
     * Fill the lookup progRef data filtered by Application.
     * 
     * @return
     */
    public String fillLookupTodoAlert()
    {
	try
	{
	    /**
	     * If the application was not sent to this method, then take it
	     * from the session
	     */
	    if(StringUtil.isEmptyString(todoAlertSC.getAppName()))
		throw new BOException(MessageCodes.INVALID_MISSING_TO_APP);
	    
	    setSearchFilter(todoAlertSC);
	    
	    // Get the data from BO
	    copyproperties(todoAlertSC);

	    if(getRecords() == 0)
	    {
		setRecords(todoAlertBO.returnTodoAlertCount(todoAlertSC));
	    }
	    setGridModel(todoAlertBO.returnTodoAlertList(todoAlertSC));
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    /**
     * get Model
     */
    public Object getModel()
    {
	return todoAlertSC;
    }

    /**
     * @return the todoAlertSC
     */
    public TodoAlertSC getTodoAlertSC()
    {
        return todoAlertSC;
    }

    /**
     * @param todoAlertSC the todoAlertSC to set
     */
    public void setTodoAlertSC(TodoAlertSC todoAlertSC)
    {
        this.todoAlertSC = todoAlertSC;
    }

    /**
     * @param todoAlertBO the todoAlertBO to set
     */
    public void setTodoAlertBO(TodoAlertBO todoAlertBO)
    {
        this.todoAlertBO = todoAlertBO;
    }
}