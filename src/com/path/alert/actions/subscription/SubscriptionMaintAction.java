package com.path.alert.actions.subscription;

import java.util.ArrayList;
import java.util.Map;

import com.path.alert.actions.common.AlertBaseAction;
import com.path.alert.bo.common.AlrtCommonConstants;
import com.path.alert.bo.subscription.SubscriptionBO;
import com.path.alert.bo.subscription.SubscriptionConstant;
import com.path.alert.vo.subscription.SubscriptionCO;
import com.path.alert.vo.subscription.SubscriptionSC;
import com.path.bo.common.audit.AuditConstant;
import com.path.lib.common.exception.BOException;
import com.path.lib.common.exception.BaseException;
import com.path.lib.common.util.StringUtil;
import com.path.lib.vo.GridUpdates;
import com.path.struts2.lib.common.base.PathActionContextMethods;
import com.path.vo.common.CommonLibSC;
import com.path.vo.common.SessionCO;
import com.path.vo.common.audit.AuditRefCO;

public class SubscriptionMaintAction extends AlertBaseAction
{

    private SubscriptionBO subscriptionBO;
    private SubscriptionSC subscriptionSC = new SubscriptionSC();
    private SubscriptionCO subscriptionCO = new SubscriptionCO();
    private String subGrpList;
    private String evtPckgList;
    private String selSerialNoSG;
    private String selSerialNoEP;
    private String allRowsSG;
    private String allRowsEP;
    private String updates;
    private String subType;
    private String allowSubscriptionUpdate;

    @SuppressWarnings("unchecked")
    public String initialize()
    {
	try
	{
		checkAccess();
	    set_enableAudit(true);
	    // set_showSmartInfoBtn("true");
	    subscriptionCO.setSubscriptionType(subType);
	    subscriptionCO.setSubscriptionTypeFlag(subscriptionCO.getSubscriptionType());
	    subscriptionCO.setIvCrud(getIv_crud());
	    subscriptionSC.setCrud(getIv_crud());
	    
	    subscriptionBO.deletePopulatedFromTmp();
	    setEnable_omni(AlrtCommonConstants.isOmniInstalled);
	    onInitializeVisibilities();

	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	    return ERROR_ACTION;
	}
	return "SubscriptionMaint";
    }
    
    private void checkAccess(){
    	SessionCO sesCO = returnSessionObject();
    	
    	CommonLibSC criteria = new CommonLibSC();
		criteria.setCompCode(sesCO.getCompanyCode());
		criteria.setBranchCode(sesCO.getBranchCode());
		criteria.setAppName(sesCO.getCurrentAppName());
		criteria.setUserId(sesCO.getUserName());
		criteria.setProgRef("SBT00U");
		
		try {
			allowSubscriptionUpdate = returnCommonLibBO().checkUserPrivileges(criteria);
		} catch (BaseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    /**
     * apllies the visibility and readOnly on initialize
     * 
     * @return
     * 
     * @throws BaseException
     */
    public String onInitializeVisibilities() throws BaseException
    {
	fillSessionData();
	getAdditionalScreenParams().putAll(subscriptionBO.onInitializeVisibilities(subscriptionCO));
	return SUCCESS;
    }

    public void fillSessionData() throws BaseException
    {
	SessionCO sessionCO = returnSessionObject();
	subscriptionCO.setCompCode(sessionCO.getCompanyCode());
	subscriptionCO.setBranchCode(sessionCO.getBranchCode());
	subscriptionCO.setAppName(sessionCO.getCurrentAppName());
	subscriptionCO.setProgRef(get_pageRef());
	subscriptionCO.setUserID(sessionCO.getUserName());
	subscriptionCO.setRunningDate(returnCommonLibBO().addSystemTimeToDate(sessionCO.getRunningDateRET()));
	subscriptionCO.setIvCrud(getIv_crud());
	subscriptionCO.setLanguage(sessionCO.getLanguage());
	subscriptionSC.setSessionId(sessionCO.getHttpSessionID());
    }

    public String viewStatusDetails()
    {
	try
	{
	    SessionCO sessionCO = returnSessionObject();
	    subscriptionSC.setSubStatus(SubscriptionConstant.subStatus);
	    subscriptionSC.setLangCode(sessionCO.getLanguage());
	    subscriptionCO = subscriptionBO.viewStatusDetail(subscriptionSC);

	}
	catch(Exception e)
	{
	    handleException(e, null, null);

	}
	return SubscriptionConstant.STATUS_DETAILS;
    }

    @SuppressWarnings("unchecked")
    public String populateSubscription()
    {
	try
	{
	    fillSessionData();
	    subscriptionCO.setProgRef(get_pageRef());
	    subscriptionCO.setLanguage(returnSessionObject().getLanguage());
	    subscriptionCO.setAllRowsSG(allRowsSG);
	    subscriptionCO.setAllRowsEP(allRowsEP);
	    
	    String[] searchCol = { 
		    	"ID", 
		    	"BRIEF_NAME",
		    	"CIF_NO",
		    	"cifType",
		    	"USR_ID",
		    	"CHANNEL_END_USR_ID",
		    	"EMAIL_ID",
		    	"MOBILE_PHONE", 
		    	"EVT_ID", 
		    	"EVT_TYPE",
		    	"DESC_ENG",
		    	"ADDITIONAL_INFO",
		    	"STATUS"};
	    
	    subscriptionSC.setSearchCols(searchCol);
	    
	    Map<String, String[]> params = PathActionContextMethods.returnParameters();
	    for(String col : searchCol)
	    {
		String values[] = params.get(col);
		if(values != null)
		{
		    for(int i=0; i < values.length; i++) 
		    {
			if(StringUtil.isEmptyString(values[i])) 
			{
			    params.remove(col);
			}
		    }
		}

	    }
	    
	    copysearchgridproperties( subscriptionSC, params, null);
	    subscriptionCO = subscriptionBO.populateSubscription(subscriptionSC,subscriptionCO, selSerialNoSG, selSerialNoEP);
	    /// getAdditionalScreenParams().putAll(multipleSubscriberCO.getHm());

	    /*
	     * subscriptionCO.setProgRef("SBT00MT");
	     * if(SubscriptionConstant.SUB_EVENT_TYPE.equals(subscriptionCO.
	     * getSubscriptionType())) {
	     * 
	     * applyRetrieveAudit(AuditConstant.ALERT_SUB_EVT_KEY_REF,
	     * subscriptionCO.getAlrtSubEvtVO(), subscriptionCO); } else
	     * if(SubscriptionConstant.SUB_PCKG_TYPE.equals(subscriptionCO.
	     * getSubscriptionType())) {
	     * 
	     * applyRetrieveAudit(AuditConstant.ALERT_SUB_PKG_KEY_REF,
	     * subscriptionCO.getAlrtSubEvtVO(), subscriptionCO); } else
	     * if(SubscriptionConstant.EVENT_GRP_TYPE.equals(subscriptionCO.
	     * getSubscriptionType())) {
	     * 
	     * applyRetrieveAudit(AuditConstant.ALERT_EVT_GRP_KEY_REF,
	     * subscriptionCO.getAlrtSubEvtVO(), subscriptionCO); } else
	     * if(SubscriptionConstant.GRP_PCKG_TYPE.equals(subscriptionCO.
	     * getSubscriptionType())) {
	     * applyRetrieveAudit(AuditConstant.ALERT_GRP_PKG_KEY_REF,
	     * subscriptionCO.getAlrtSubEvtVO(), subscriptionCO);
	     * 
	     * }
	     */
	}
	catch(BaseException e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }

    public String afterPopulateVisibility()
    {
	try
	{
	    fillSessionData();
	    getAdditionalScreenParams().putAll(subscriptionBO.afterPopulateVisibility(subscriptionCO));
	}

	catch(BaseException e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }

    public String afterUpdateVisibility()
    {
	try
	{
	    fillSessionData();
	    getAdditionalScreenParams().putAll(subscriptionBO.afterUpdateVisibility(subscriptionCO));
	}

	catch(BaseException e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }

    public String deleteSubscription()
    {
	try
	{
	    fillSessionData();
	    subscriptionCO = subscriptionBO.deleteSubscription(subscriptionCO);
	    if(subscriptionCO.getRow() > 0)
	    {
	    	throw new BOException(subscriptionCO.getRow());
	    }
	}

	catch(BaseException e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }

    public String updateSubDetailsParams()
    {
	try
	{
	    fillSessionData();
	    GridUpdates gridData1 = getGridUpdates(subscriptionCO.getParamAllRecList(), SubscriptionCO.class, false);
	    ArrayList<SubscriptionCO> toBeUpdatedParamList = gridData1.getLstModify();
	    // commitmentCO.setGridUpdateList(gridData.getLstModify());
	    subscriptionCO = subscriptionBO.updateSubDetailsParams(subscriptionCO, toBeUpdatedParamList);

	}
	catch(BaseException e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    private AuditRefCO fillSessionVariables(String status)
    {

	AuditRefCO refCO = initAuditRefCO();
	try
	{
	    refCO.setOperationType(status);
	    if(SubscriptionConstant.SUB_EVENT_TYPE.equals(subscriptionCO.getSubscriptionType()))
	    {
		refCO.setKeyRef(AuditConstant.ALERT_SUB_EVT_KEY_REF);
	    }
	    else if(SubscriptionConstant.SUB_PCKG_TYPE.equals(subscriptionCO.getSubscriptionType()))
	    {
		refCO.setKeyRef(AuditConstant.ALERT_SUB_PKG_KEY_REF);
	    }
	    else if(SubscriptionConstant.EVENT_GRP_TYPE.equals(subscriptionCO.getSubscriptionType()))
	    {
		refCO.setKeyRef(AuditConstant.ALERT_EVT_GRP_KEY_REF);
	    }
	    else if(SubscriptionConstant.GRP_PCKG_TYPE.equals(subscriptionCO.getSubscriptionType()))
	    {
		refCO.setKeyRef(AuditConstant.ALERT_GRP_PKG_KEY_REF);

	    }

	}
	catch(

	Exception e)
	{
	    handleException(e, null, null);
	}
	return refCO;
    }

    public String saveSubscription()
    {
		try
		{
		    subscriptionCO.setAuditRefCO(fillSessionVariables(AuditConstant.UPDATE));
		    fillSessionData();
		    
		    //update ALRT_SUB_EVT_TMP
		    ArrayList lstMod = new ArrayList();
		    if(updates != null && !updates.equals(""))
		    {
				GridUpdates gu = getGridUpdates(updates, SubscriptionCO.class, true);
				lstMod = gu.getLstAllRec();
		    }
		    subscriptionCO = subscriptionBO.saveSubscription(subscriptionCO,lstMod);
		}
		catch(BaseException e)
		{
		    handleException(e, null, null);
		}
		return SUCCESS;
    }
    
    public String updateAfterApproveSubscription()
    {
	try
	{

	    subscriptionCO.setAuditRefCO(fillSessionVariables(AuditConstant.CREATED));
	    fillSessionData();
	    
	    //update ALRT_SUB_EVT_TMP
	    ArrayList lstMod = new ArrayList();
	    if(updates != null && !updates.equals(""))
	    {
			GridUpdates gu = getGridUpdates(updates, SubscriptionCO.class, true);
			lstMod = gu.getLstAllRec();
	    }
	    
	    subscriptionCO = subscriptionBO.updateAfterApproveSubscription(subscriptionCO,lstMod);

	}
	catch(BaseException e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }
    
    public String checkEventModeFlags()
    {
    	try
    	{
    		fillSessionData();
    		subscriptionCO = subscriptionBO.checkEventModeFlags(subscriptionCO);
    	}
    	catch(BaseException e)
    	{
    		handleException(e, null, null);
    	}
    	return SUCCESS;
    }

    public String approveSubscription()
    {
	try
	{
	    fillSessionData();
	    GridUpdates gu = getGridUpdates(subscriptionCO.getAllRowsSubscription(), SubscriptionCO.class, true);
	    subscriptionCO.setSubscriptionCOList(gu.getLstAllRec());
	    subscriptionCO = subscriptionBO.approveSubscription(subscriptionCO);
	    if(subscriptionCO.getRow() > 0)
	    {
	    	throw new BOException(subscriptionCO.getRow());
	    }
	}

	catch(BaseException e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }

    public String continueToApprove()
    {
	try
	{
	    fillSessionData();
	    subscriptionCO = subscriptionBO.continueToApprove(subscriptionCO);
	}

	catch(BaseException e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }

    public String toBeDeletedSubscription()
    {
	try
	{
	    fillSessionData();
	    subscriptionCO = subscriptionBO.toBeDeletedSubscription(subscriptionCO);
	}

	catch(BaseException e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }
    
    public String toBeSuspendSubscription()
    {
	try
	{
	    fillSessionData();
	    subscriptionCO = subscriptionBO.toBeSuspendSubscription(subscriptionCO);
	}
	
	catch(BaseException e)
	{
	    handleException(e, null, null);
	}
	
	return SUCCESS;
    }
    
    public String suspendSubscription()
    {
	try
	{
	    fillSessionData();
	    subscriptionCO = subscriptionBO.suspendSubscription(subscriptionCO);
	    if(subscriptionCO.getRow() > 0)
	    {
	    	throw new BOException(subscriptionCO.getRow());
	    }
	}
	catch(BaseException e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }
    
    public String toBeReactivateSubscription()
    {
	try
	{
	    fillSessionData();
	    subscriptionCO = subscriptionBO.toBeReactivateSubscription(subscriptionCO);
	}
	
	catch(BaseException e)
	{
	    handleException(e, null, null);
	}
	
	return SUCCESS;
    }
    
    public String reactivateSubscription()
    {
	try
	{
	    fillSessionData();
	    subscriptionCO = subscriptionBO.reactivateSubscription(subscriptionCO);
	    if(subscriptionCO.getRow() > 0)
	    {
	    	throw new BOException(subscriptionCO.getRow());
	    }
	}
	catch(BaseException e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }
    
    public String updateTempSubscription()
    {
    	try
    	{
    	    fillSessionData();
    	    subscriptionCO = subscriptionBO.updateTempSubscription(subscriptionCO);
    	}
    	catch(BaseException e)
    	{
    	    handleException(e, null, null);
    	}
    	return SUCCESS;
    }
    
    public SubscriptionCO getSubscriptionCO()
    {
	return subscriptionCO;
    }

    public void setSubscriptionCO(SubscriptionCO subscriptionCO)
    {
	this.subscriptionCO = subscriptionCO;
    }

    public void setSubscriptionBO(SubscriptionBO subscriptionBO)
    {
	this.subscriptionBO = subscriptionBO;
    }

    public SubscriptionSC getSubscriptionSC()
    {
	return subscriptionSC;
    }

    public void setSubscriptionSC(SubscriptionSC subscriptionSC)
    {
	this.subscriptionSC = subscriptionSC;
    }

    public String getSubGrpList()
    {
	return subGrpList;
    }

    public void setSubGrpList(String subGrpList)
    {
	this.subGrpList = subGrpList;
    }

    public String getEvtPckgList()
    {
	return evtPckgList;
    }

    public void setEvtPckgList(String evtPckgList)
    {
	this.evtPckgList = evtPckgList;
    }

    public String getSelSerialNoSG()
    {
	return selSerialNoSG;
    }

    public void setSelSerialNoSG(String selSerialNoSG)
    {
	this.selSerialNoSG = selSerialNoSG;
    }

    public String getSelSerialNoEP()
    {
	return selSerialNoEP;
    }

    public void setSelSerialNoEP(String selSerialNoEP)
    {
	this.selSerialNoEP = selSerialNoEP;
    }

    public String getAllRowsSG()
    {
	return allRowsSG;
    }

    public void setAllRowsSG(String allRowsSG)
    {
	this.allRowsSG = allRowsSG;
    }

    public String getAllRowsEP()
    {
	return allRowsEP;
    }

    public void setAllRowsEP(String allRowsEP)
    {
	this.allRowsEP = allRowsEP;
    }
    
    public String getUpdates() 
    {
		return updates;
	}

	public void setUpdates(String updates) 
	{
		this.updates = updates;
	}

	public String getSubType() {
		return subType;
	}

	public void setSubType(String subType) {
		this.subType = subType;
	}

	public String getAllowSubscriptionUpdate() {
		return allowSubscriptionUpdate;
	}

	public void setAllowSubscriptionUpdate(String allowSubscriptionUpdate) {
		this.allowSubscriptionUpdate = allowSubscriptionUpdate;
	}

	public String loadEventsForPakgGridPage()
    {
		return "eventsForPakgGridPage";
    }
	
	public String loadSubscribersForGrpGridPage()
    {
		return "subscribersForGrpGridPage";
    }
		
	public Object getModel() {
	    return subscriptionSC;
	}
}
