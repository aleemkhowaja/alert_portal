package com.path.alert.actions.events.event;

import java.math.BigDecimal;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.events.event.IndividualEventConstant;
import com.path.alert.vo.events.event.IndividualEventCO;
import com.path.alert.vo.events.event.IndividualEventSC;
import com.path.dbmaps.vo.ALRT_EVTVO;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.common.SessionCO;
import com.path.vo.common.select.SelectSC;
import com.path.vo.common.status.StatusCO;

public class IndividualEventStatusAction extends LookupBaseAction
{

	private IndividualEventSC criteria = new IndividualEventSC();
	private IndividualEventCO individualEventCO = new IndividualEventCO();
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

	    url = theRealPath + "/path/alert/events/event/EventStatusAction_loadStatusGrid.action?eventID="
		    + criteria.getEventID();
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
	    

	    colList = IndividualEventConstant.getStatusFields;
	    BigDecimal compCode = sessionCO.getCompanyCode();

	    SelectSC lovCriteria = new SelectSC();
	    lovCriteria.setLanguage(sessionCO.getLanguage());
	    lovCriteria.setCompCode(compCode);
	    lovCriteria.setLovTypeId(AlertConstant.EVENT_STATUS_LOV_TYPE);

	    criteria.setSearchCols(searchCol);
	    copyproperties(criteria);
	    setSearchFilter(criteria);
	    
	    ALRT_EVTVO alrtEvtVO = new ALRT_EVTVO();
	    alrtEvtVO.setEVT_ID(criteria.getEventID());
		

	    resultList = returnCommonLibBO().generateStatusList(alrtEvtVO, colList, lovCriteria);
	    setGridModel(resultList);
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	    return ERROR_ACTION;
	}
	return "loadGrid";
    }

    public IndividualEventSC getCriteria() {
		return criteria;
	}

	public void setCriteria(IndividualEventSC criteria) {
		this.criteria = criteria;
	}

	public IndividualEventCO getIndividualEventCO() {
		return individualEventCO;
	}

	public void setIndividualEventCO(IndividualEventCO individualEventCO) {
		this.individualEventCO = individualEventCO;
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



}
