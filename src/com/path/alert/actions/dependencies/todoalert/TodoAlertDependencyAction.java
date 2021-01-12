package com.path.alert.actions.dependencies.todoalert;

import com.path.alert.bo.todoalert.TodoAlertBO;
import com.path.alert.vo.common.TodoAlertSC;
import com.path.bo.common.MessageCodes;
import com.path.dbmaps.vo.SYS_PARAM_TODO_ALERT_TYPEVO;
import com.path.lib.common.exception.BOException;
import com.path.lib.common.exception.BaseException;
import com.path.lib.common.util.StringUtil;
import com.path.struts2.lib.common.base.BaseAction;

/**
 * 
 * Copyright 2020, Path Solutions Path Solutions retains all ownership rights to
 * this source code
 * 
 * @author: Alim Khowaja
 *
 * TodoAlertDependencyAction.java used to
 */
public class TodoAlertDependencyAction extends BaseAction
{

    private TodoAlertBO todoAlertBO;
    private String appName;
    private String todoAlert;
    private SYS_PARAM_TODO_ALERT_TYPEVO alert_TYPEVO = new SYS_PARAM_TODO_ALERT_TYPEVO();

    /**
     * dependency of progref by app name
     * 
     * @return
     */
    public String dependencyByTodoAlert()
    {
	try
	{
	    /**
	     * If the application was not sent to this method, then take it
	     * from the session
	     */
	    if(StringUtil.isEmptyString(appName))
		throw new BOException(MessageCodes.INVALID_MISSING_TO_APP);
	    
	    TodoAlertSC criteria = new TodoAlertSC();
	    criteria.setAppName(appName);
	    criteria.setTodoAlert(todoAlert);
	    
	    /**
	     * return todoAler details by appname and todoAlert
	     */
	    alert_TYPEVO = todoAlertBO.returnTodoAlertById(criteria);
	}
	catch(BaseException e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;

    }

    /**
     * @return the appName
     */
    public String getAppName()
    {
	return appName;
    }

    /**
     * @param appName the appName to set
     */
    public void setAppName(String appName)
    {
	this.appName = appName;
    }


    /**
     * @return the todoAlert
     */
    public String getTodoAlert()
    {
        return todoAlert;
    }

    /**
     * @param todoAlert the todoAlert to set
     */
    public void setTodoAlert(String todoAlert)
    {
        this.todoAlert = todoAlert;
    }
    
    /**
     * @return the alert_TYPEVO
     */
    public SYS_PARAM_TODO_ALERT_TYPEVO getAlert_TYPEVO()
    {
        return alert_TYPEVO;
    }

    /**
     * @param alert_TYPEVO the alert_TYPEVO to set
     */
    public void setAlert_TYPEVO(SYS_PARAM_TODO_ALERT_TYPEVO alert_TYPEVO)
    {
        this.alert_TYPEVO = alert_TYPEVO;
    }

    /**
     * @param todoAlertBO the todoAlertBO to set
     */
    public void setTodoAlertBO(TodoAlertBO todoAlertBO)
    {
        this.todoAlertBO = todoAlertBO;
    }
}