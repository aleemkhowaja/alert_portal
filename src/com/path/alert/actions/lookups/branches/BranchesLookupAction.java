package com.path.alert.actions.lookups.branches;

import org.apache.struts2.json.JSONException;

import com.path.alert.bo.branches.BranchesBO;
import com.path.alert.vo.branch.BranchSC;
import com.path.bo.common.MessageCodes;
import com.path.lib.common.exception.BOException;
import com.path.lib.common.util.NumberUtil;
import com.path.lib.vo.LookupGrid;
import com.path.struts2.lib.common.base.LookupBaseAction;


/**
 * 
 * Copyright 2020, Path Solutions
 * Path Solutions retains all ownership rights to this source code 
 * 
 * @author: Alim Khowaja
 *
 * BranchesLookupAction.java used to
 */
public class BranchesLookupAction extends LookupBaseAction
{
    private BranchSC branchesSC = new BranchSC();
    private BranchesBO branchesBO;
    
    
    /**
     * Construct Branch Lookup
     * 
     * @return
     */
    public String constructLookup()
    {

	try
	{
	    // Design the Grid by defining the column model and column names
	    String[] name = { "branchCode", "briefNameEnglish", "longNameEnglish", "briefNameArabic", "longNameArabic",
		    "remarks", "baseCurrency" };
	    String[] colType = { "text", "text", "text", "text", "text", "text", "text" };
	    String[] titles = { getText("branchCode"), getText("briefDesc"), getText("Long_Description_key"),
		    getText("Brief_Name_Arab_key"), getText("Long_Desc_Arab_key"), getText("remarks_key"),
		    getText("Currency_key") };

	    
	    // Defining the Grid
	    LookupGrid grid = new LookupGrid();
	    grid.setCaption(getText("branches.branchList"));
	    grid.setRowNum("5");
	    grid.setShrinkToFit("true");
	    grid.setUrl("/path/alert/lookup/BranchesLookupAction_fillLookupBranchByUsr");
	    lookup(grid, branchesSC, name, colType, titles);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;

    }

    /**
     * Fill the lookup branch data filtered by user.
     * 
     * @return
     * @throws JSONException
     */
    public String fillLookupBranchByUsr()
    {
	try
	{
	    setSearchFilter(branchesSC);
	    // Get the data from BO
	    copyproperties(branchesSC);

	    /**
	     * If the company code was not sent to this method, then take it
	     * from the session
	     */
	    if(NumberUtil.isEmptyDecimal(branchesSC.getCompCode()))
		throw new BOException(MessageCodes.INVALID_MISSING_COMPANY_CODE);
	    
	    if(getRecords() == 0)
	    {
		setRecords(branchesBO.returnBranchesListCountByCompCode(branchesSC));
	    }
	    // set the collection into gridModel attribute defined at JSP grid
	    setGridModel( branchesBO.returnBranchesListByCompCode(branchesSC));
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }
    
    
    public Object getModel()
    {
	return branchesSC;
    }


    /**
     * @return the branchesSC
     */
    public BranchSC getBranchesSC()
    {
        return branchesSC;
    }

    /**
     * @param branchesSC the branchesSC to set
     */
    public void setBranchesSC(BranchSC branchesSC)
    {
        this.branchesSC = branchesSC;
    }

    public void setBranchesBO(BranchesBO branchesBO)
    {
        this.branchesBO = branchesBO;
    }
}
