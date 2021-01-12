/**
 * 
 */
package com.path.alert.actions.events.event.lookups;

import java.util.List;

import org.apache.struts2.json.JSONException;

import com.path.alert.bo.events.event.IndividualEventBO;
import com.path.alert.vo.events.event.IndividualEventSC;
import com.path.alert.vo.events.event.IndividualFixedEventListCO;
import com.path.lib.vo.LookupGrid;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.common.SessionCO;

/**
 * Copyright 2015, Path Solutions
 * Path Solutions retains all ownership rights to this source code 
 * 
 * @author: RoulaKhalil
 
 */
public class FixedEvtIdLookupAction extends LookupBaseAction
{
    private final IndividualEventSC criteria = new IndividualEventSC();
	private IndividualEventBO individualEventBO;
    private List<IndividualFixedEventListCO> FixedEventList,EmailTemplateList;
    @Override
    public Object getModel()
    {
	return criteria;
    }
    
    public String constructFixedEventQueryLookup()
    {

	try
	{
	    // Design the Grid by defining the column model and column names
	    String[] name = { "ID","DESCRIPTION"};
	    String[] colType = { "number", "text"};
	    String[] titles = { getText("id_key"),getText("description_key")};

	    // Defining the Grid
	    LookupGrid grid = new LookupGrid();
	    grid.setCaption(getText("Fixed Events List"));
	    grid.setRowNum("5");
	    grid.setShrinkToFit("true");
	    grid.setUrl("/path/alert/events/event/FixedEvtIdLookupAction_fillLookupFixedEvent");
	    lookup(grid, criteria, name, colType, titles);
	}
	catch(Exception e)
	{
	    log.error(e, "Error in constructLookup of FixedEvtIdLookupAction");
	    handleException(e, null, null);
	}

	return SUCCESS;

    }

    /**
     * Fill the lookup 
     * 
     * @return
     * @throws JSONException
     */
    public String fillLookupFixedEvent()
    {
	try
	{
	    criteria.setSearchCols(new String[]{"ID", "DESCRIPTION"});
	    setSearchFilter(criteria);
	    // Get the data from BO
	    copyproperties(criteria);
	    SessionCO sessionCO = returnSessionObject();
	    
	    criteria.setCompanyCode(sessionCO.getCompanyCode());

	    if(getRecords() == 0)
	    {
		setRecords(individualEventBO.fixedEventCount(criteria));
	    }
	    FixedEventList = individualEventBO.fixedEventList(criteria);
	    // set the collection into gridModel attribute defined at JSP grid
	    setGridModel(FixedEventList);

	}
	catch(Exception e)
	{
	    log.error(e, "Error in fillLookupData of BranchesLookupAction");
	    handleException(e, null, null);
	}
	return SUCCESS;
    }


//    public String constructEmailTemplateQueryLookup()
//    {
//	try
//	{
//	    // Design the Grid by defining the column model and column names
//	    String[] name = { "emailTemplateVO.TEMPLATE_ID", "emailTemplateVO.TEMPLATE_DESC" };
//	    String[] colType = { "number", "text" };
//	    String[] titles = { getText("id_key"), getText("description_key") };
//
//	    // Defining the Grid
//	    LookupGrid grid = new LookupGrid();
//	    grid.setCaption(getText("Email Template List"));
//	    grid.setRowNum("5");
//	    grid.setShrinkToFit("true");
//	    grid.setUrl("/path/alert/events/event/FixedEvtIdLookupAction_fillLookupEmailTemplate");
//	    lookup(grid, criteria, name, colType, titles);
//	}
//	catch(Exception e)
//	{
//	    log.error(e, "Error in constructLookup of EmailTemplateLookupAction");
//	    handleException(e, null, null);
//	}
//
//	return SUCCESS;
//
//    }
//
//    /**
//     * Fill the lookup
//     * 
//     * @return
//     * @throws JSONException
//     */
//    public String fillLookupEmailTemplate()
//    {
//	try
//	{
//	    criteria.setSearchCols(new String[] { "emailTemplateVO.TEMPLATE_ID", "emailTemplateVO.TEMPLATE_DESC" });
//	    setSearchFilter(criteria);
//	    // Get the data from BO
//	    copyproperties(criteria);
//	    SessionCO sessionCO = returnSessionObject();
//
//	    criteria.setCompanyCode(sessionCO.getCompanyCode());
//
//	    if(getRecords() == 0)
//	    {
//		setRecords(individualEventBO.emailTemplateCount(criteria));
//	    }
//	    EmailTemplateList = individualEventBO.emailTemplateList(criteria);
//	    // set the collection into gridModel attribute defined at JSP grid
//	    setGridModel(EmailTemplateList);
//
//	}
//	catch(Exception e)
//	{
//	    log.error(e, "Error in fillLookupData of BranchesLookupAction");
//	    handleException(e, null, null);
//	}
//	return SUCCESS;
//    }
    
 	public void setIndividualEventBO(IndividualEventBO individualEventBO) {
 		this.individualEventBO = individualEventBO;
 	}


 	public IndividualEventSC getCriteria() {
 		return criteria;
 	}

	public List<IndividualFixedEventListCO> getFixedEventList() {
		return FixedEventList;
	}

	public void setFixedEventList(List<IndividualFixedEventListCO> fixedEventList) {
		FixedEventList = fixedEventList;
	}

	public List<IndividualFixedEventListCO> getEmailTemplateList() 
	{
		return EmailTemplateList;
	}

	public void setEmailTemplateList(List<IndividualFixedEventListCO> emailTemplateList) 
	{
		EmailTemplateList = emailTemplateList;
	}
}
