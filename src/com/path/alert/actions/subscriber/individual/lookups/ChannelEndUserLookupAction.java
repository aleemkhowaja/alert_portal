/**
 * 
 */
package com.path.alert.actions.subscriber.individual.lookups;

import java.util.List;

import org.apache.struts2.json.JSONException;

import com.path.alert.bo.subscriber.individual.IndividualSubscriberBO;
import com.path.alert.vo.subscriber.individual.IndividualSubscriberCO;
import com.path.alert.vo.subscriber.individual.IndividualSubscriberSC;
import com.path.bo.common.ConstantsCommon;
import com.path.lib.common.exception.BaseException;
import com.path.lib.vo.LookupGrid;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.common.SessionCO;

/**
 * Copyright 2015, Path Solutions
 * Path Solutions retains all ownership rights to this source code 
 * 
 * @author: Alim Khowaja
 
 */
public class ChannelEndUserLookupAction extends LookupBaseAction
{
    private final IndividualSubscriberSC criteria = new IndividualSubscriberSC();
	private IndividualSubscriberBO individualSubscriberBO;
    private List<IndividualSubscriberCO> individualSubscriberCOs;
    
    
    @Override
    public Object getModel()
    {
	return criteria;
    }

    /**
     * Fill the lookup 
     * 
     * @return
     * @throws JSONException
     */
    public String constructOmniChannelUserLookup()
    {
		try
		{
			fillSessionData();
			 // / Design the Grid by defining the column model and column names
		    String[] name = { "omniUserVO.USR_ID", "omniUserVO.USR_CODE", "omniUserVO.NAME", "omniUserVO.CIF_NO", "cifName", "omniUserVO.BUSINESS_PROFILE_ID",
			    "omniUserVO.EMAIL", "omniUserVO.MOBILE_NUMBER" };
		    String[] colType = { "number", "number", "text", "text", "text", "number", "text", "text"};
		    String[] titles = { getText("user_id_key"), getText("user_code_key"), getText("name_key"),
			    getText("cif_no_key"), getText("cif_name_key"), getText("business_profile_key"),
			    getText("email_key"), getText("mobile_no_key"), };
	
		    // Defining the Grid
		    LookupGrid grid = new LookupGrid();
		    grid.setRowNum("5");
		    grid.setUrl("/path/alert/subscriber/individual/ChannelEndUserLookupAction_fillOmniChannelUserLookup");
			lookup(grid, criteria, name, colType, titles);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		    log.error(e, "Error in fillLookupData of BranchesLookupAction");
		    handleException(e, null, null);
		}
		return SUCCESS;
    }
    
    
    /**
     * Fill the lookup for User data filtered by the defined criteria
     * 
     * @return
     */
    public String fillOmniChannelUserLookup()
    {
		try
		{
		    criteria.setSearchCols(new String[]{ "omniUserVO.USR_ID", "omniUserVO.USR_CODE", "omniUserVO.NAME", "omniUserVO.CIF_NO", "cifName", "omniUserVO.BUSINESS_PROFILE_ID",
			    "omniUserVO.EMAIL", "omniUserVO.MOBILE_NUMBER"});
		    setSearchFilter(criteria);
		    copyproperties(criteria);
		    SessionCO sessionCO = returnSessionObject();
		    criteria.setCompCode(sessionCO.getCompanyCode());
	
		    criteria.setPreferredLanguage(sessionCO.getLanguage());
		    criteria.setLovTypeId(ConstantsCommon.USER_STATUS_LOV_TYPE);
		    
		    
		    if(checkNbRec(criteria))
		    {
		    	setRecords(individualSubscriberBO.returnOmniUserListCount(criteria));
		    }
		    setGridModel(individualSubscriberBO.returnOmniUserList(criteria));
		}
		catch(Exception e)
		{
			e.printStackTrace();
		    log.error(e, "Error in fillLookupData of  UserLookupAction");
		    handleException(e, null, null);
		}
		return SUCCESS;
   }
    
    /**
     * function that fill the needed data from the session .
     * 
     * @throws BaseException
     */
    public void fillSessionData() throws BaseException
    {
		SessionCO sessionCO = returnSessionObject();
		criteria.setCompCode(sessionCO.getCompanyCode());
		criteria.setBranchCode(sessionCO.getBranchCode());
		criteria.setPageRef(get_pageRef());
		criteria.setUserID(sessionCO.getUserName());
		criteria.setRunningDate(returnCommonLibBO().addSystemTimeToDate(sessionCO.getRunningDateRET()));
		criteria.setIvCrud(getIv_crud());
		criteria.setPreferredLanguage(sessionCO.getLanguage());
    }
    
	public IndividualSubscriberBO getIndividualSubscriberBO() {
		return individualSubscriberBO;
	}

	public void setIndividualSubscriberBO(IndividualSubscriberBO individualSubscriberBO) {
		this.individualSubscriberBO = individualSubscriberBO;
	}

	public List<IndividualSubscriberCO> getIndividualSubscriberCOs() {
		return individualSubscriberCOs;
	}

	public void setIndividualSubscriberCOs(List<IndividualSubscriberCO> individualSubscriberCOs) {
		this.individualSubscriberCOs = individualSubscriberCOs;
	}

	public IndividualSubscriberSC getCriteria() {
		return criteria;
	}

}
