package com.path.alert.actions.lookups.progref;

import com.path.alert.bo.progref.ProgRefBO;
import com.path.alert.vo.common.ProgRefSC;
import com.path.bo.common.MessageCodes;
import com.path.lib.common.exception.BOException;
import com.path.lib.common.util.NumberUtil;
import com.path.lib.common.util.StringUtil;
import com.path.lib.vo.LookupGrid;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.common.SessionCO;

/**
 * 
 * Copyright 2020, Path Solutions
 * Path Solutions retains all ownership rights to this source code 
 * 
 * @author: Alim Khowaja
 *
 * ProgRefLookupAction.java used to
 */
public class ProgRefLookupAction extends LookupBaseAction
{
    
    private ProgRefSC progRefSC = new ProgRefSC();
    private ProgRefBO progRefBO;

    /**
     * Construct Company Lookup
     * 
     * @return
     */
    /**
     * Method that load the parent Ref lookup
     * 
     * @return SUCCESS
     * @throws Exception
     */
    public String constructLookup()
    {
	try
	{
		 String[] name = { "PROG_REF", "PROG_DESC", "MENU_TITLE_ENG" };
		 String[] colType = { "text", "text", "text" };
		 String[] titles = { getText("progRef"), getText("reporting.description"), getText("reporting.lkpMenuTitle") };
		 
		// Defining the Grid
		 LookupGrid grid = new LookupGrid();
		 grid.setCaption(getText("progref.progrefList"));
		 grid.setRowNum("5");
		 grid.setShrinkToFit("true");
		  
		 grid.setUrl("/path/alert/lookup/ProgRefLookupAction_fillLookupProgRef");
		 lookup(grid, progRefSC, name,  colType,  titles );
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
    public String fillLookupProgRef()
    {
	try
	{
	    /**
	     * If the application was not sent to this method, then take it
	     * from the session
	     */
	    if(StringUtil.isEmptyString(progRefSC.getAppName()))
		throw new BOException(MessageCodes.INVALID_MISSING_TO_APP);
		
	    setSearchFilter(progRefSC);
	    // Get the data from BO
	    copyproperties(progRefSC);

	    if(getRecords() == 0)
	    {
		setRecords(progRefBO.returnProgRefCount(progRefSC));
	    }
	    setGridModel(progRefBO.returnProgRefList(progRefSC));
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
	return progRefSC;
    }


    /**
     * @return the progRefSC
     */
    public ProgRefSC getProgRefSC()
    {
        return progRefSC;
    }

    /**
     * @param progRefSC the progRefSC to set
     */
    public void setProgRefSC(ProgRefSC progRefSC)
    {
        this.progRefSC = progRefSC;
    }

    /**
     * @param progRefBO the progRefBO to set
     */
    public void setProgRefBO(ProgRefBO progRefBO)
    {
        this.progRefBO = progRefBO;
    }
}