package com.path.alert.actions.controlrecord;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.controlrecord.ControlRecordBO;
import com.path.alert.vo.controlrecord.ControlRecordSC;
import com.path.lib.vo.LookupGrid;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.common.SessionCO;

/**
 * 
 * @author FreddyMbarak
 * @value ControlRecordDepAction used for dependencies ...
 *
 */
public class SystemEvtLookupAction extends LookupBaseAction
{

    private ControlRecordBO controlRecordBO;

    public void setControlRecordBO(ControlRecordBO controlRecordBO)
    {
	this.controlRecordBO = controlRecordBO;
    }

    private ControlRecordSC criteria = new ControlRecordSC();

    @Override
    public Object getModel()
    {
	return criteria;
    }

    public String constructSysEvtLookup()
    {
	try
	{
	    // Design the Grid by defining the column model and column names
	    String[] name = { "EVT_ID", "DESC_ENG", "DESC_ARAB" };
	    String[] colType = { "number", "text", "text" };
	    String[] titles = { getText("event_id_key"), getText("desc_eng_key"),
		    getText("desc_arab_key") };

	    /*
	     * PTH_CTRL.LANGUAGE (0,Null= Arabic Visible Not Mandatory But
	     * English Mandatory, 1=Arabic Hidden and English Mandatory, 2=
	     * Arabic Visible and Mandatory And English Mandatory , 3= Arabic
	     * Visible and Mandatory English Not Mandatory).
	     */
	    if(returnSessionObject().getHideArabicColumns())
	    {
		name = new String[] { "EVT_ID", "DESC_ENG" };
		colType = new String[] { "number", "text" };
		titles = new String[] { getText("event_id_key"), getText("desc_eng_key") };
	    }

	    // Defining the Grid
	    LookupGrid grid = new LookupGrid();
	    grid.setCaption(getText(""));
	    grid.setRowNum("5");
	    grid.setUrl("/path/alert/controlrecord/systemEvtLookupAction_fillSystemEvtLookupQuery");
	    lookup(grid, criteria, name, colType, titles);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;

    }

    public String fillSystemEvtLookupQuery()
    {
	try
	{
	    setSearchFilter(criteria);
	    copyproperties(criteria);

	    SessionCO sessionCO = returnSessionObject();
	    criteria.setCompCode(sessionCO.getCompanyCode());
	    criteria.setLovTypeId(AlertConstant.eventModeDropDown); 
	    criteria.setLangCode(sessionCO.getLanguage());
	    if(checkNbRec(criteria))
	    {
		setRecords(controlRecordBO.systemEvtLookupQueryCount(criteria));
		// criteria.setNbRec(individualSubscriberBO.cifLookupQueryListCount(criteria));
	    }
	    // set the collection into gridModel attribute defined at JSP grid
	    setGridModel(controlRecordBO.systemEvtLookupQueryList(criteria));
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    public ControlRecordSC getCriteria()
    {
	return criteria;
    }

	public void setCriteria(ControlRecordSC criteria) 
	{
		this.criteria = criteria;
	}

}
