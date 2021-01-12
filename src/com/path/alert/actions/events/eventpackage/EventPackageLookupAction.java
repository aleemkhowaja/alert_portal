package com.path.alert.actions.events.eventpackage;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.events.eventpackage.PackageEventBO;
import com.path.alert.vo.events.eventpackage.EventInPackageEventListCO;
import com.path.alert.vo.events.eventpackage.EventInPackageEventSC;
import com.path.alert.vo.events.eventpackage.EventNotInPackageEventListCO;
import com.path.lib.common.util.PathPropertyUtil;
import com.path.lib.common.util.StringUtil;
import com.path.lib.vo.LookupGrid;
import com.path.struts2.lib.common.GridParamsSC;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.common.SessionCO;

public class EventPackageLookupAction extends LookupBaseAction
{
	private PackageEventBO packageEventBO;
    private List<EventNotInPackageEventListCO> eventList;    
    protected EventInPackageEventSC criteria = new EventInPackageEventSC();    		  
    private String packageId;
    private String progRef;
    
	public String constructEventPackage() 
	{
		try
		{
			String[] name = { "EVT_ID", "EVT_TYPE", "DESCRIPTION", "STATUS" };
			String[] colType = { "number", "text", "text", "text" };
			String[] titles = { getText("event_id_key"), getText("evt_type_key"), getText("DESC_NAME_KEY"),
					getText("status_key") };

			// Defining the Grid
			LookupGrid grid = new LookupGrid();
			grid.setCaption(getText(""));
			grid.setRowNum("5");
			

			if("PKG00MT".equalsIgnoreCase(progRef) || "PKG00MA".equalsIgnoreCase(progRef)) 
			{
				grid.setUrl("/path/alert/events/eventpackage/EventPackageLookupAction_loadEventPackageData");
				lookup(grid, criteria, name, colType, titles);
			}
			else if("PKG00P".equalsIgnoreCase(progRef))
			{
				grid.setUrl("/path/alert/events/eventpackage/EventPackageLookupAction_loadInEventPackageData");
				lookup(grid, criteria, name, colType, titles);
			}
		} 
		catch (Exception e)
		{
			handleException(e, null, null);
		}
		return SUCCESS;
	}
    
	public String loadEventPackageData() 
	{

		try {
			SessionCO sessionCO = returnSessionObject();
			criteria.setLovTypeId(AlertConstant.eventTypeDropDown);
			criteria.setLangCode(sessionCO.getLanguage());
			criteria.setCompCode(sessionCO.getCompanyCode());
			criteria.setEvtLovTypeId(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);
			
			copyproperties(criteria);			
			setSearchFilter(criteria);
			
			if(StringUtil.isEmptyString(criteria.getSidx())) 
			{
				criteria.setSidx("CHECKED");
				criteria.setSord("DESC");
			}
			
			if(!("".equals(StringUtil.nullToEmpty(packageId))))
		    {
				criteria.setPkgId(new BigDecimal(packageId));
		    }

			if (checkNbRec(criteria))
			{
				setRecords(packageEventBO.evtNotInPackageCount(criteria));
			}

			eventList = packageEventBO.evtNotInPackageList(criteria);

			setGridModel(eventList);

		} 
		catch (Exception e)
		{
			handleException(e, null, null);
		}

		return SUCCESS;

	}

	
	public String loadInEventPackageData()
    {	
		try {
			SessionCO sessionCO = returnSessionObject();

			criteria.setLovTypeId(AlertConstant.eventTypeDropDown);
			criteria.setEvtLovTypeId(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);
			criteria.setLangCode(sessionCO.getLanguage());
			criteria.setCompCode(sessionCO.getCompanyCode());
			
			if(!("".equals(StringUtil.nullToEmpty(packageId))))
		    {
				criteria.setPkgId(new BigDecimal(packageId));
		    }
							
			copyproperties(criteria);

			if (checkNbRec(criteria)) 
			{
				setRecords(packageEventBO.evtInPackageCount(criteria));
			}

			eventList = new ArrayList<>();
			List<EventInPackageEventListCO> listObj = packageEventBO.evtInPackageList(criteria);
				
			for (EventInPackageEventListCO eventInPackageEventListCO : listObj)
			{
				EventNotInPackageEventListCO eventNotInPackageEventListCO = new EventNotInPackageEventListCO();
				PathPropertyUtil.copyProperties(eventInPackageEventListCO, eventNotInPackageEventListCO);
				eventList.add(eventNotInPackageEventListCO);
			}

			setGridModel(eventList);
		}
		catch (Exception e) 
		{
			handleException(e, null, null);
		}

		return SUCCESS;
    }
	
    public void setPackageEventBO(PackageEventBO packageEventBO)
    {
	this.packageEventBO = packageEventBO;
    }

    public String getPackageId()
    {
	return packageId;
    }

    public void setPackageId(String packageId)
    {
	this.packageId = packageId;
    }

    public String getProgRef() 
    {
	return progRef;
	}

	public void setProgRef(String progRef) 
	{
	this.progRef = progRef;
	}

	@Override
	public Object getModel() 
	{
	return criteria;
	}

	public GridParamsSC getCriteria() 
	{
	return criteria;
	}
}
