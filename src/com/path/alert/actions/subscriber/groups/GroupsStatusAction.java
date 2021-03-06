package com.path.alert.actions.subscriber.groups;

import java.math.BigDecimal;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.vo.subscriber.groups.GroupsSubscriberSC;
import com.path.dbmaps.vo.ALRT_GRPVO;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.common.SessionCO;
import com.path.vo.common.select.SelectSC;
import com.path.vo.common.status.StatusCO;

public class GroupsStatusAction extends LookupBaseAction
{

    private final GroupsSubscriberSC criteria = new GroupsSubscriberSC();
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

	    url = theRealPath + "/path/alert/subscriber/groups/GroupsStatusAction_loadStatusGrid.action?grpId="
		    + criteria.getGrpId();
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
	    ALRT_GRPVO alrtGrpVO = new ALRT_GRPVO();
	    alrtGrpVO.setGRP_ID(criteria.getGrpId());

	    resultList = returnCommonLibBO().generateStatusList(alrtGrpVO, colList, lovCriteria);
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

    public GroupsSubscriberSC getCriteria()
    {
	return criteria;
    }

}
