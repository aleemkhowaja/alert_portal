package com.path.alert.actions.dependencies.progref;

import com.path.alert.bo.progref.ProgRefBO;
import com.path.alert.vo.common.ProgRefSC;
import com.path.bo.common.MessageCodes;
import com.path.dbmaps.vo.OPTVO;
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
 * ProgRefDependencyAction.java used to
 */
public class ProgRefDependencyAction extends BaseAction
{

    private ProgRefBO progRefBO;
    private String appName;
    private String progRef;
    private OPTVO optvo = new OPTVO();

    /**
     * dependency of progref by app name
     * 
     * @return
     */
    public String dependencyByProgRef()
    {
	try
	{
	    /**
	     * If the application was not sent to this method, then take it
	     * from the session
	     */
	    if(StringUtil.isEmptyString(appName))
		throw new BOException(MessageCodes.INVALID_MISSING_TO_APP);
	    
	    ProgRefSC progRefSC = new ProgRefSC();
	    progRefSC.setAppName(appName);
	    progRefSC.setProgRef(progRef);
	    
	    /**
	     * return progref details by appname and progref
	     */
	    optvo = progRefBO.returnProgRefDetailsByProgRef(progRefSC);
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
     * @return the progRef
     */
    public String getProgRef()
    {
	return progRef;
    }

    /**
     * @param progRef the progRef to set
     */
    public void setProgRef(String progRef)
    {
	this.progRef = progRef;
    }

    /**
     * @return the optvo
     */
    public OPTVO getOptvo()
    {
	return optvo;
    }

    /**
     * @param optvo the optvo to set
     */
    public void setOptvo(OPTVO optvo)
    {
	this.optvo = optvo;
    }

    /**
     * @param progRefBO the progRefBO to set
     */
    public void setProgRefBO(ProgRefBO progRefBO)
    {
	this.progRefBO = progRefBO;
    }

}