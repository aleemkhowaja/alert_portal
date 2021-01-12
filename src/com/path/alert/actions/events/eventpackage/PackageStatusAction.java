package com.path.alert.actions.events.eventpackage;

import java.math.BigDecimal;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.vo.events.eventpackage.PackageEventSC;
import com.path.dbmaps.vo.ALRT_PKGVO;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.common.SessionCO;
import com.path.vo.common.select.SelectSC;
import com.path.vo.common.status.StatusCO;

public class PackageStatusAction extends LookupBaseAction
{

    private final PackageEventSC criteria = new PackageEventSC();
    private String url;

    /**
     * Set the status Grid URL and load the Common Status Jsp Page...
     * 
     * @return
     */
    public String search()
    {
	try
	{
	    ServletContext application = ServletActionContext.getServletContext();
	    String theRealPath = application.getContextPath();

	    url = theRealPath + "/path/alert/events/eventpackage/PackageStatusAction_loadStatusGrid.action?pkgId="
		    + criteria.getPkgId();
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	    return ERROR_ACTION;
	}
	return "SUCCESS_STATUS";
    }

    /**
     * get data from Database, convert them to be compatible with statusCO, get
     * HTML and set the Model.
     * 
     * @return
     */
    @SuppressWarnings("unchecked")
    public String loadStatusGrid()
    {
	String[] searchCol = { "userName", "status_desc", "status_date" };
	List<StatusCO> resultList;
	List<String> colList;
	try
	{
	    SessionCO sessionCO = returnSessionObject();

	    colList = AlertConstant.getStatusFields;
	    BigDecimal compCode = sessionCO.getCompanyCode();

	    SelectSC lovCriteria = new SelectSC();
	    lovCriteria.setLanguage(sessionCO.getLanguage());
	    lovCriteria.setCompCode(compCode);
	    lovCriteria.setLovTypeId(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);

	    criteria.setSearchCols(searchCol);
	    copyproperties(criteria);
	    setSearchFilter(criteria);
	    ALRT_PKGVO alrtPkgVO = new ALRT_PKGVO();
	    alrtPkgVO.setPKG_ID(criteria.getPkgId());

	    resultList = returnCommonLibBO().generateStatusList(alrtPkgVO, colList, lovCriteria);
	    setGridModel(resultList);
	}
	catch(Exception ex)
	{
	    log.error("Error in the loadStatusGrid method");
	    handleException(ex, null, null);
	    return ERROR_ACTION;
	}
	return "loadGrid";
    }

    public Object getModel()
    {
	return criteria;
    }

    public String getUrl()
    {
	return url;
    }

    public void setUrl(String url)
    {
	this.url = url;
    }

    public PackageEventSC getCriteria()
    {
	return criteria;
    }

}
