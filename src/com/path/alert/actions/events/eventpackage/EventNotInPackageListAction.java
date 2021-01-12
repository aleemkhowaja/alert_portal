package com.path.alert.actions.events.eventpackage;

import java.math.BigDecimal;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.events.eventpackage.PackageEventBO;
import com.path.alert.vo.events.eventpackage.EventInPackageEventSC;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;

public class EventNotInPackageListAction extends GridBaseAction
{

    private PackageEventBO packageEventBO;
    protected EventInPackageEventSC evtNotInPkgSC = new EventInPackageEventSC();
    private String pkgId;

    public String loadEvtNotInPkgData()
    {
	String[] searchCol = { "EVT_ID", "EVT_TYPE", "DESCRIPTION","STATUS" };
	SessionCO sessionCO = returnSessionObject();
	try
	{
	    /**
	     * copy the details related to search criteria to the SC
	     **/
	    evtNotInPkgSC.setSearchCols(searchCol);
	    evtNotInPkgSC.setLovTypeId(AlertConstant.eventTypeDropDown);
	    evtNotInPkgSC.setLangCode(sessionCO.getLanguage());
	    evtNotInPkgSC.setCompCode(sessionCO.getCompanyCode());
	    evtNotInPkgSC.setEvtLovTypeId(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);
	    if(pkgId != null)
	    {
		evtNotInPkgSC.setPkgId(new BigDecimal(pkgId));
	    }
	    copyproperties(evtNotInPkgSC);

	    if(checkNbRec(evtNotInPkgSC))
	    {
		setRecords(packageEventBO.evtNotInPackageCount(evtNotInPkgSC));
	    }
	    /**
	     * set the collection into gridModel attribute defined at JSP grid
	     * tag
	     **/
	    setGridModel(packageEventBO.evtNotInPackageList(evtNotInPkgSC));
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
	return evtNotInPkgSC;
    }
}
