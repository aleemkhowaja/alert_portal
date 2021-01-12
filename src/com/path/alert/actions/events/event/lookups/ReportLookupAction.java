package com.path.alert.actions.events.event.lookups;

import java.util.List;

import com.path.alert.vo.events.event.IndividualEventSC;
import com.path.bo.admin.user.UsrBO;
import com.path.lib.common.util.PathPropertyUtil;
import com.path.lib.vo.LookupGrid;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.admin.user.UsrCO;
import com.path.vo.admin.user.UsrSC;
import com.path.vo.common.SessionCO;

import net.sf.json.JSONException;

public class ReportLookupAction extends LookupBaseAction{
	
	//Start Variable
	private IndividualEventSC criteria = new IndividualEventSC();
	private UsrSC usrSC = new UsrSC();
//	private IndividualEventBO individualEventBO;
	private UsrBO usrBO;
	 //End Variable
	
	 //Start Methods related to Query Lookup
	/**
	 * Construct Lookup of Report
	 * @return
	 */
	public String constructReportLookup() 
	{

		try 
		{
			// Design the Grid by defining the column model and column names
			String[] name = { "ID","DESCRIPTION"};
			String[] colType = { "number", "text"};
			String[] titles = { getText("id_key"),getText("description_key")};
			
			// Defining the Grid
			LookupGrid grid = new LookupGrid();
			grid.setCaption(getText("Reports List"));
			grid.setRowNum("5");
			grid.setShrinkToFit("true");
			grid.setUrl("/path/alert/events/event/ReportLookupAction_fillLookupReports");
			lookup(grid, usrSC, name, colType, titles);
		} catch (Exception e) 
		{
			handleException(e, null, null);
		}
		return SUCCESS;
	}
	
	/**
	 * Fill the lookup of reports
	 * individualEventBO
	 * @return
	 * @throws JSONException
	 */
	public String fillLookupReports() 
	{
		try 
		{
			setSearchFilter(criteria);
			// Get the data from BO
			copyproperties(criteria);
			
			PathPropertyUtil.copyProperties(criteria, usrSC);
			
			SessionCO sessionCO = returnSessionObject();

			usrSC.setUserId(sessionCO.getUserName());
			usrSC.setCompCode(sessionCO.getCompanyCode());
			usrSC.setBranchCode(sessionCO.getBranchCode());
			usrSC.setAppName(sessionCO.getCurrentAppName());
			
			if (getRecords() == 0) {
				int count = usrBO.getUsrReportsCount(usrSC);
				setRecords(count);
			}
			
			 List<UsrCO> usrReportCOs = usrBO.getUsrReportsList(usrSC);
			// set the collection into gridModel attribute defined at JSP grid
			setGridModel(usrReportCOs);

		} catch (Exception e) {
			e.printStackTrace();
			handleException(e, null, null);
		}
		return SUCCESS;
	}
	//End Methods related to Query Lookup
	
	
	//Start Getter/ Setter Methods
   /* public void setIndividualEventBO(IndividualEventBO individualEventBO) 
    {
 		this.individualEventBO = individualEventBO;
 	}*/
    
	public IndividualEventSC getCriteria() 
	{
		return criteria;
	}
	
	public void setCriteria(IndividualEventSC criteria) 
	{
		this.criteria = criteria;
	}

	public UsrSC getUsrSC() 
	{
		return usrSC;
	}

	public void setUsrSC(UsrSC usrSC) 
	{
		this.usrSC = usrSC;
	}

	public UsrBO getUsrBO() 
	{
		return usrBO;
	}

	public void setUsrBO(UsrBO usrBO) 
	{
		this.usrBO = usrBO;
	}
 	//End Getter/ Setter Methods

}
