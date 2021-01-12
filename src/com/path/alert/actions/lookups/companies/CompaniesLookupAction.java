package com.path.alert.actions.lookups.companies;

import com.path.alert.bo.companies.CompaniesBO;
import com.path.lib.common.util.StringUtil;
import com.path.lib.vo.LookupGrid;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.admin.companies.CompaniesSC;
import com.path.vo.common.SessionCO;

/**
 * 
 * Copyright 2020, Path Solutions
 * Path Solutions retains all ownership rights to this source code 
 * 
 * @author: Alim Khowaja
 *
 * CompaniesLookupAction.java used to
 */
public class CompaniesLookupAction extends LookupBaseAction
{
    
    private CompaniesSC companiesSC = new CompaniesSC();
    private CompaniesBO companiesBO;

    /**
     * Construct Company Lookup
     * 
     * @return
     */
    public String constructLookup()
    {
	try
	{
	    // Design the Grid by defining the column model and column names
	    String[] name = { "COMP_CODE", "BRIEF_DESC_ENG" };
	    String[] colType = { "number", "text" };
	    String[] titles = { getText("compCode"), getText("briefDesc") };

	    // Defining the Grid
	    LookupGrid grid = new LookupGrid();
	    grid.setCaption(getText("companies.compList"));
	    grid.setRowNum("5");
	    grid.setShrinkToFit("true");

	    grid.setUrl("/path/alert/lookup/CompaniesLookupAction_fillLookupCompanies");
	    
	    lookup(grid, companiesSC, name,  colType,  titles );
	}
	catch(Exception e)
	{
	    log.error(e, "Error in constructLookup of CompaniesLookupAction");
	    handleException(e, null, null);
	}

	return SUCCESS;

    }

    /**
     * Fill the lookup Company data filtered by user.
     * 
     * @return
     */
    public String fillLookupCompanies()
    {
	try
	{
	    setSearchFilter(companiesSC);
	    // Get the data from BO
	    copyproperties(companiesSC);

	    SessionCO sessionCO = returnSessionObject();
	    if(getRecords() == 0)
	    {
		setRecords(companiesBO.returnCompaniesCount(companiesSC));
	    }
	    setGridModel(companiesBO.returnCompaniesList(companiesSC));
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
	return companiesSC;
    }

    /**
     * @return the companiesSC
     */
    public CompaniesSC getCompaniesSC()
    {
        return companiesSC;
    }
    
    /**
     * @param companiesSC the companiesSC to set
     */
    public void setCompaniesSC(CompaniesSC companiesSC)
    {
        this.companiesSC = companiesSC;
    }

    /**
     * @param alertCompaniesBO the alertCompaniesBO to set
     */
    public void setCompaniesBO(CompaniesBO companiesBO)
    {
        this.companiesBO = companiesBO;
    }
}
