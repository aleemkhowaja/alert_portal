package com.path.alert.actions.dependencies.applications;

import java.math.BigDecimal;
import java.util.HashMap;

import com.path.alert.bo.events.event.IndividualEventBO;
import com.path.alert.vo.events.event.IndividualEventCO;
import com.path.dbmaps.vo.SYS_PARAM_SCREEN_DISPLAYVO;
import com.path.dbmaps.vo.S_APPVO;
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
 * ApplicationsDependencyAction.java used to dependency of application livesearch
 */
public class ApplicationsDependencyAction extends BaseAction
{
    private String appName;
    
    private IndividualEventBO individualEventBO;

    /**
     * dependency of application
     * 
     * @return
     */
    public String dependencyByAppName()
    {
	try
	{
	    /**
	     * apply display setting 
	     * Prepare hashmap of ids and values
	     */
	    IndividualEventCO individualEventCO = new IndividualEventCO();
	    HashMap<String, Object> map = new HashMap<String, Object>();
	    map.put("applicationExpression", appName);
	    individualEventCO.setScreenDisplaySeting(map);
	    setAdditionalScreenParams(individualEventBO.applySysParamSettings(individualEventCO).getElementMap());
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
     * @param individualEventBO the individualEventBO to set
     */
    public void setIndividualEventBO(IndividualEventBO individualEventBO)
    {
        this.individualEventBO = individualEventBO;
    }
    
}