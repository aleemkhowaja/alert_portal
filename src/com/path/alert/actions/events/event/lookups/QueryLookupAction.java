package com.path.alert.actions.events.event.lookups;

import java.util.List;
import com.path.alert.bo.events.event.IndividualEventBO;
import com.path.alert.vo.events.event.IndividualEventSC;
import com.path.dbmaps.vo.IRP_AD_HOC_QUERYVO;
import com.path.lib.vo.LookupGrid;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.common.SessionCO;

public class QueryLookupAction extends LookupBaseAction{
	
	//Start Variable
	private IndividualEventSC criteria = new IndividualEventSC();
	private IndividualEventBO individualEventBO;
    //End Variable
    
	
	@Override
	public Object getModel() {
		return criteria;
	}
    //Start Methods related to Query Lookup
    
	/**
	 * Construct Query Lookup
	 * @return
	 */
	public String constructQueryLookup()
    {

		try
		{
		    // Design the Grid by defining the column model and column names
		    String[] name = { "QUERY_ID","QUERY_NAME"};
		    String[] colType = { "number", "text"};
		    String[] titles = { getText("id_key"),getText("description_key")};
	
		    // Defining the Grid
		    LookupGrid grid = new LookupGrid();
		    grid.setCaption(getText("Reports Events List"));
		    grid.setRowNum("5");
		    grid.setShrinkToFit("true");
		    grid.setUrl("/path/alert/events/event/QueryLookupAction_fillQueryLookup");
		    //fillLookupReportIdEvent();
		    lookup(grid, criteria, name, colType, titles);
		}
		catch(Exception e)
		{
		    log.error(e, "Error in constructLookup of ReportIdLookupAction");
		    handleException(e, null, null);
		}
		return SUCCESS;
    }
	
	/**
	 * fill Query Lookup
	 * @return
	 */
	public String fillQueryLookup()
    {
		try
		{
		    setSearchFilter(criteria);
		    // Get the data from BO
		    copyproperties(criteria);
		    SessionCO sessionCO = returnSessionObject();
		    
		    criteria.setCompanyCode(sessionCO.getCompanyCode());
	
		    if(checkNbRec(criteria))
		    {
		    	setRecords(individualEventBO.returnQueryListCount(criteria));
		    }
		    List<IRP_AD_HOC_QUERYVO> ad_HOC_QUERYVOs = individualEventBO.returnQueryList(criteria);
		    // set the collection into gridModel attribute defined at JSP grid
		    setGridModel(ad_HOC_QUERYVOs);
	
		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		}
		return SUCCESS;
    }

	//End Methods related to Query Lookup
	
	//Start Getter/ Setter Methods
    public void setIndividualEventBO(IndividualEventBO individualEventBO) 
    {
 		this.individualEventBO = individualEventBO;
 	}

	public IndividualEventSC getCriteria() {
		return criteria;
	}

	public void setCriteria(IndividualEventSC criteria) {
		this.criteria = criteria;
	}
	//End Getter/Setter Methods
	
}
