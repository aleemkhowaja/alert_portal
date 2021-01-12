package com.path.alert.actions.events.eventpackage;

import java.math.BigDecimal;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.events.eventpackage.PackageEventBO;
import com.path.alert.vo.events.eventpackage.EventInPackageEventSC;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;

public class EventInPackageListAction extends GridBaseAction
{

    private PackageEventBO packageEventBO;
    protected EventInPackageEventSC evtInPkgSC = new EventInPackageEventSC();
    private String pkgId;

    public String loadEvtInPkgData()
    {
	String[] searchCol = { "EVT_ID", "EVT_TYPE", "DESCRIPTION","STATUS"};
	SessionCO sessionCO = returnSessionObject();
	try
	{
	    /**
	     * copy the details related to search criteria to the SC
	     **/
	    evtInPkgSC.setSearchCols(searchCol);
	    evtInPkgSC.setLovTypeId(AlertConstant.eventTypeDropDown);
	    evtInPkgSC.setEvtLovTypeId(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);
	    evtInPkgSC.setLangCode(sessionCO.getLanguage());
	    evtInPkgSC.setCompCode(sessionCO.getCompanyCode());
	    if(pkgId != null)
	    {
		evtInPkgSC.setPkgId(new BigDecimal(pkgId));
	    }
	    copyproperties(evtInPkgSC);

	    if(checkNbRec(evtInPkgSC))
	    {
		setRecords(packageEventBO.evtInPackageCount(evtInPkgSC));
	    }

	    /**
	     * set the collection into gridModel attribute defined at JSP grid
	     * tag
	     **/
	    setGridModel(packageEventBO.evtInPackageList(evtInPkgSC));
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }

    public void setPackageEventBO(PackageEventBO packageEventBO)
    {
	this.packageEventBO = packageEventBO;
    }

    public String getPkgId()
    {
	return pkgId;
    }

    public void setPkgId(String pkgId)
    {
	this.pkgId = pkgId;
    }

    public Object getModel()
    {
	return evtInPkgSC;
    }
}
