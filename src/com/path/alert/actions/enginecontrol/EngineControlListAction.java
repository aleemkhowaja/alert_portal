package com.path.alert.actions.enginecontrol;

import java.util.ArrayList;
import java.util.List;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.enginecontrol.EngineControlBO;
import com.path.alert.vo.enginecontrol.EngineControlCO;
import com.path.alert.vo.enginecontrol.EngineControlSC;
import com.path.lib.common.exception.BOException;
import com.path.lib.common.util.PathPropertyUtil;
import com.path.lib.common.util.StringUtil;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;

@SuppressWarnings("serial")
public class EngineControlListAction extends GridBaseAction
{

    private EngineControlBO engineControlBO;
    private final List<EngineControlCO> list = new ArrayList<>();
    private EngineControlCO engineControlCO = new EngineControlCO();
    private EngineControlSC criteria = new EngineControlSC();

    /**
     * load the data for the alert engine status grid
     * 
     * @return
     */
    public String returnEngineNodeDataForGrid()
    {
	try
	{
	    String alertServiceUrl = PathPropertyUtil.returnPathPropertyFromFile("PathAlertEngineRemoting.properties",
		    AlertConstant.ALERT_ENGINE_SERVICE_URL) == null
			    ? PathPropertyUtil.returnPathPropertyFromFile("PathRemoting.properties",
				    AlertConstant.ALERT_ENGINE_SERVICE_URL)
			    : PathPropertyUtil.returnPathPropertyFromFile("PathAlertEngineRemoting.properties",
				    AlertConstant.ALERT_ENGINE_SERVICE_URL);
	    /**
	     * load the data for the alert engine nodes and its statuses the
	     * exception will be thrown if PathAlertEngineRemoting.properties
	     * not in class path or file does not contain
	     * "alertEngine.serviceURL" property
	     */
	    if(alertServiceUrl == null)
	    {
		throw new BOException("Invalid Alert Engine URL");
	    }

	    String serviceUrls[] = alertServiceUrl.split(",");
	    for(String serviceUrl : serviceUrls)
	    {
		if(serviceUrl.trim().length() > 0)
		{
		    EngineControlCO co = new EngineControlCO();
		    co.setIP(serviceUrl);
		    try
		    {
			String status = engineControlBO.returnEngineStatus(co);
			co.setSTATUS(status);
			co.setStatusDesc(status);
		    }
		    catch(Exception e)
		    {
			co.setSTATUS(AlertConstant.UNABLE_TO_RETRIEVE_STATUS);
			co.setStatusDesc(AlertConstant.UNABLE_TO_RETRIEVE_STATUS);
		    }

		    list.add(co);
		}
	    }

	    setGridModel(list);

	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    /**
     * load the data for the monitoring grid
     * 
     * @return
     */
    public String returnAlertEngineRequestDataForGrid()
    {
	try
	{

	    SessionCO sessionCO = returnSessionObject();

	    criteria.setStartDate(engineControlCO.getStartDate());
	    criteria.setEndDate(engineControlCO.getEndDate());
	    criteria.setCif(engineControlCO.getCifNumber());
	    criteria.setEventID(engineControlCO.getEventID());	    
	    criteria.setSubId(engineControlCO.getSubId());
	    criteria.setUserId(engineControlCO.getUserId());
	    criteria.setChannelEndUserId(engineControlCO.getChannelEndUserId());
	    criteria.setStatus(engineControlCO.getSTATUS().trim());
	    
	    copyproperties(criteria);

	    criteria.setLangCode(sessionCO.getLanguage());
	    criteria.setLovTypeID(AlertConstant.MESSAGE_STATUS);
	    criteria.setRowsLimit(AlertConstant.ALERT_MESSAGES_ROW_LIMIT);

	    List<EngineControlCO> lst = new ArrayList<>();

	    // check if no order Specified then Order by REQUEST_ID 
	    if(StringUtil.nullToEmpty(criteria.getSidx()).isEmpty())
	    {
		criteria.setSidx("REQUEST_ID");
		criteria.setSord("DESC");
	    }

	    if(checkNbRec(criteria))
	    {
		setRecords(engineControlBO.returnAlertEngineRequestCount(criteria));
	    }

	    lst = engineControlBO.returnAlertEngineRequest(criteria);
	    list.addAll(lst);
	    setGridModel(list);

	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    public EngineControlCO getEngineControlCO()
    {
	return engineControlCO;
    }

    public void setEngineControlCO(EngineControlCO engineControlCO)
    {
	this.engineControlCO = engineControlCO;
    }

    public EngineControlSC getEngineControlSC()
    {
	return criteria;
    }

    public void setEngineControlSC(EngineControlSC engineControlSC)
    {
	this.criteria = engineControlSC;
    }

    public EngineControlBO getEngineControlBO()
    {
	return engineControlBO;
    }

    public void setEngineControlBO(EngineControlBO engineControlBO)
    {
	this.engineControlBO = engineControlBO;
    }

    @Override
    public Object getModel()
    {
	return criteria;
    }
}
