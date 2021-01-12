package com.path.alert.actions.subscriber.groups;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.path.alert.actions.common.AlertBaseAction;
import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.common.AlrtCommonConstants;
import com.path.alert.bo.subscriber.groups.GroupsSubscriberBO;
import com.path.alert.vo.subscriber.groups.GroupsSubscriberCO;
import com.path.alert.vo.subscriber.groups.GroupsSubscriberSC;
import com.path.alert.vo.subscriber.groups.SubscriberGroupsSubscriberSC;
import com.path.alert.vo.subscriber.groups.SubscriberInGroupsSubscriberListCO;
import com.path.bo.common.ConstantsCommon;
import com.path.bo.common.MessageCodes;
import com.path.bo.common.audit.AuditConstant;
import com.path.lib.common.exception.BOException;
import com.path.lib.common.exception.BaseException;
import com.path.lib.common.util.StringUtil;
import com.path.lib.vo.GridUpdates;
import com.path.vo.common.SessionCO;
import com.path.vo.common.audit.AuditRefCO;

/**
 * 
 * Copyright 2013, Path Solutions Path Solutions retains all ownership rights to
 * this source code
 * 
 * @author: eliasfarah
 * 
 *          java used to
 * 
 */
@SuppressWarnings("serial")
public class GroupsMaintAction extends AlertBaseAction
{

    private GroupsSubscriberCO groupsSubscriberCO = new GroupsSubscriberCO();
    private GroupsSubscriberBO groupsSubscriberBO;
    private GroupsSubscriberSC grpSubSC = new GroupsSubscriberSC();
    private SubscriberGroupsSubscriberSC subNoInGrpSC = new SubscriberGroupsSubscriberSC();
    private String iv_crud;
    private String grpId;
    private String list;
    private String list2;
    private String subcriberInGroup;

    public void setGroupsSubscriberBO(GroupsSubscriberBO groupsSubscriberBO)
    {
	this.groupsSubscriberBO = groupsSubscriberBO;
    }

    public GroupsSubscriberSC getGrpSubSC()
    {
	return grpSubSC;
    }

    public void setGrpSubSC(GroupsSubscriberSC grpSubSC)
    {
	this.grpSubSC = grpSubSC;
    }

    public GroupsSubscriberCO getGroupsSubscriberCO()
    {
	return groupsSubscriberCO;
    }

    public void setGroupsSubscriberCO(GroupsSubscriberCO groupsSubscriberCO)
    {
	this.groupsSubscriberCO = groupsSubscriberCO;
    }

    public SubscriberGroupsSubscriberSC getSubNoInGrpSC()
    {
	return subNoInGrpSC;
    }

    public void setSubNoInGrpSC(SubscriberGroupsSubscriberSC subNoInGrpSC)
    {
	this.subNoInGrpSC = subNoInGrpSC;
    }

    public String getIv_crud()
    {
	return iv_crud;
    }

    public void setIv_crud(String iv_crud)
    {
	this.iv_crud = iv_crud;
    }

    public String getList()
    {
	return list;
    }

    public void setList(String list)
    {
	this.list = list;
    }

    public String getList2()
    {
	return list2;
    }

    public void setList2(String list2)
    {
	this.list2 = list2;
    }

    public String getGrpId()
    {
	return grpId;
    }

    public void setGrpId(String grpId)
    {
	this.grpId = grpId;
    }

    public String initialize()
    {
	//String returnScreen = "groupsList";
	try
	{
	    groupsSubscriberBO.deleteAlrtSubTmp();
	    set_showSmartInfoBtn("false");
	    set_searchGridId("groupsSubscriberGridTbl_Id");
	    set_enableAudit(true);
	    if(iv_crud.equals(AlertConstant.CRUD_R))
	    {
	    	set_showNewInfoBtn("true");
	    }
	    else
	    {
	    	set_showNewInfoBtn("false");
	    }
	    fillSessionData();
	    if(iv_crud.equals(AlertConstant.CRUD_P))
	    {
	    	getAdditionalScreenParams().putAll(groupsSubscriberBO.onInitializeApproveVisibilities(groupsSubscriberCO));
	    }
	    else
	    {
	    	getAdditionalScreenParams().putAll(groupsSubscriberBO.onInitializeMaintVisibilities(groupsSubscriberCO, iv_crud));
	    }
	    setEnable_omni(AlrtCommonConstants.isOmniInstalled);	    
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	    return ERROR_ACTION;
	}

	return "groupsList";
    }

    public String initializeMain()
	    {
//		String returnScreen = "groupsMaint";
		try
		{
		    groupsSubscriberBO.deleteAlrtSubTmp();
		    fillSessionData();
		    if(iv_crud.equals(AlertConstant.CRUD_R))
		    {
			
			getAdditionalScreenParams().putAll(groupsSubscriberBO.onInitializeMaintVisibilities(groupsSubscriberCO, iv_crud));
		    }
		    else
		    {
			getAdditionalScreenParams()
			.putAll(groupsSubscriberBO.onInitializeApproveVisibilities(groupsSubscriberCO));
		    }
		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		    return ERROR_ACTION;
		}
	return "groupsMaint";
    }

    public String edit()
    {
//		String returnScreen = "groupsMaint";
		String status;
		try
		{
		    SessionCO sessionCO = returnSessionObject();
		    groupsSubscriberBO.deleteAlrtSubTmp();
		    grpSubSC.setLangCode(sessionCO.getLanguage());
		    grpSubSC.setLovTypeId(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);
		    groupsSubscriberCO = groupsSubscriberBO.returnGroupById(grpSubSC);
		    grpSubSC.setGrpId(groupsSubscriberCO.getAlrtGrpVO().getGRP_ID());
		    status = groupsSubscriberBO.getStatusByGroup(grpSubSC);
		    
		    /**
		     * hide subscriber lookup if included all subscribers
		     */
		    applyDisplaySettingByIncludeAllSub();
		    
		    
		    if((status.equals(AlertConstant.STATUS_APPROVED) || status.equals(AlertConstant.STATUS_DELETED))
			    && iv_crud.equals(AlertConstant.CRUD_R))
		    {
			getAdditionalScreenParams().putAll(groupsSubscriberBO.onInitializeVisibilities(groupsSubscriberCO));
			set_recReadOnly(ConstantsCommon.TRUE);
		    }
		    
		    else
			if(iv_crud.equals(AlertConstant.CRUD_P))
		    {
			getAdditionalScreenParams()
				.putAll(groupsSubscriberBO.onInitializeApproveVisibilities(groupsSubscriberCO));
			set_recReadOnly(ConstantsCommon.TRUE);
		    }
		    else
		    {
			
			getAdditionalScreenParams()
				.putAll(groupsSubscriberBO.onInitializeMaintVisibilities(groupsSubscriberCO, iv_crud));
			
			set_recReadOnly(ConstantsCommon.FALSE);
		    }
		    applyRetrieveAudit(AuditConstant.ALERT_GROUP_KEY_REF, groupsSubscriberCO.getAlrtGrpVO(),
			    groupsSubscriberCO);
		    setEnable_omni(AlrtCommonConstants.isOmniInstalled);	
		    

		    
		    /**
		     * check condition if 
		     * select specific subscribers
		     */
		    if(!StringUtil.nullToEmpty(groupsSubscriberCO.getAlrtGrpVO().getINCLUDE_ALL_SUB_YN()).equals(ConstantsCommon.YES))
		    {
			loadSubGridData();
		    }
		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		    return ERROR_ACTION;
		}
		return "groupsMaint";
    }

	public String loadSubGridData() 
	{
		try 
		{
			SubscriberGroupsSubscriberSC subInGrpSubSC = new SubscriberGroupsSubscriberSC();

			copyproperties(subInGrpSubSC);

			SessionCO sessionCO = returnSessionObject();
			subInGrpSubSC.setLovTypeId(AlertConstant.subscriberTypeDropDown);
			subInGrpSubSC.setStatus(ConstantsCommon.STATUS_APPROVED);
			subInGrpSubSC.setSubscriberLovType(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);
			subInGrpSubSC.setLangCode(sessionCO.getLanguage());
			subInGrpSubSC.setCompCode(sessionCO.getCompanyCode());
			subInGrpSubSC.setGrpId(grpSubSC.getGrpId());
			subInGrpSubSC.setNbRec(-1);
			
			if (checkNbRec(subInGrpSubSC)) 
			{
				setRecords(groupsSubscriberBO.subInGrpSubscriberCount(subInGrpSubSC));
			}
			List<SubscriberInGroupsSubscriberListCO> subInGrpSubList = groupsSubscriberBO
					.subInGrpSubscriberList(subInGrpSubSC);

			StringBuilder sb = new StringBuilder();
			sb.append("{\"root\":[");
	
			subInGrpSubList.stream().forEach((co) -> {
				sb.append("{\"alertSubVO.ID\":\"" + co.getAlertSubVO().getID() + "\",");
				sb.append("\"alertSubLangVO.BRIEF_NAME\":\"" +StringUtil.nullToEmpty(co.getAlertSubLangVO() == null ? "" : co.getAlertSubLangVO().getBRIEF_NAME())+ "\",");
				sb.append("\"alertSubVO.CIF_NO\":\"" + StringUtil.nullToEmpty(co.getAlertSubVO().getCIF_NO()) + "\",");
				sb.append("\"CIF_TYPE\":\"" + StringUtil.nullToEmpty(co.getCIF_TYPE()) + "\",");
				sb.append("\"alertSubVO.USR_ID\":\"" + StringUtil.nullToEmpty(co.getAlertSubVO().getUSR_ID()) + "\",");
				sb.append("\"alertSubVO.CHANNEL_END_USR_ID\":\""+ StringUtil.nullToEmpty(co.getAlertSubVO().getCHANNEL_END_USR_ID()) + "\",");
				sb.append("\"STATUS\":\"" + StringUtil.nullToEmpty(co.getSTATUS()) + "\"},");
			});
			
			if (sb.indexOf(",") >= 0)
			{
				sb.replace(sb.lastIndexOf(","), sb.lastIndexOf(",") + 1, "");
			}
			
			sb.append("]}");
			subcriberInGroup = sb.toString();
		}
		catch (Exception e) 
		{
			handleException(e, null, null);
		}
		return SUCCESS;
	}
    private void fillSessionData() throws BaseException
    {
		SessionCO sessionCO = returnSessionObject();
		groupsSubscriberCO.setCompCode(sessionCO.getCompanyCode());
		groupsSubscriberCO.setBranchCode(sessionCO.getBranchCode());
		groupsSubscriberCO.setAppName(sessionCO.getCurrentAppName());
		groupsSubscriberCO.setRunningDate(returnCommonLibBO().addSystemTimeToDate(sessionCO.getRunningDateRET()));
		groupsSubscriberCO.setProgRef(get_pageRef());
		groupsSubscriberCO.setUserID(sessionCO.getUserName());
    }

	public String saveRecord() {
		try {
		    	
		    fillSessionData();
		    ArrayList<SubscriberInGroupsSubscriberListCO> subInGrpList = new ArrayList<>();
		    /**
		     * check condition if 
		     * select specific subscribers
		     */
		    if(!StringUtil.nullToEmpty(groupsSubscriberCO.getAlrtGrpVO().getINCLUDE_ALL_SUB_YN()).equals(ConstantsCommon.YES))
		    {
			if(getList2().trim().length() <= 0) 
    			{
    				throw new BOException(MessageCodes.ERROR_WHILE_SAVING_GROUP);
    			}
			
			GridUpdates gridData1 = getGridUpdates(getList2(), SubscriberInGroupsSubscriberListCO.class, true);
			subInGrpList = gridData1.getLstAllRec();
		    }

		    if (StringUtil.nullToEmpty(groupsSubscriberCO.getAlrtGrpVO().getCREATED_BY()).isEmpty()) {
			groupsSubscriberCO.setAuditRefCO(fillSessionVariables(AuditConstant.CREATED));
		    } else {
			groupsSubscriberCO.setAuditRefCO(fillSessionVariables(AuditConstant.UPDATE));
			groupsSubscriberCO.setAuditObj(returnAuditObject(groupsSubscriberCO.getClass()));
		    }
		    groupsSubscriberBO.saveRecord(subInGrpList, groupsSubscriberCO);
		} 
		catch (BaseException e) 
		{
			handleException(e, null, null);
		}

		return SUCCESS;
	}

    public String approveRecord()
    {
		try
		{
		    fillSessionData();
		    groupsSubscriberCO.setAuditRefCO(fillSessionVariables(AuditConstant.UPDATE));
		    groupsSubscriberCO.setAuditObj(returnAuditObject(groupsSubscriberCO.getClass()));
		    // validate if user is allowed to take this action
		    validateMakerChecker(groupsSubscriberCO);
		    groupsSubscriberBO.approveRecord(groupsSubscriberCO);
		}
		catch(BaseException e)
		{
		    handleException(e, null, null);
		}
		return SUCCESS;
    }
    
    /**
     * used to Validate Maker checker 
     * @param IndividualEventCO
     * @throws BaseException
     */
    private void validateMakerChecker(GroupsSubscriberCO groupsSubscriberCO) throws BaseException
    {
    	int result = returnCommonLibBO().validateMakerChecker(groupsSubscriberCO.getAlrtGrpVO().getCREATED_BY(), 
    			groupsSubscriberCO.getAlrtGrpVO().getMODIFIED_BY(), groupsSubscriberCO.getUserID());
    	if( result > 0 )
    	{
    		throw new BOException(result);
    	}
    }

    public String checkSubscription()
    {
	try
	{
	    fillSessionData();
	    groupsSubscriberCO = groupsSubscriberBO.checkSubscription(new BigDecimal(grpId), groupsSubscriberCO);
	}
	catch(BaseException e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }

    public String deleteRecord()
    {
	try
	{
	    fillSessionData();
	    groupsSubscriberCO.setAuditRefCO(fillSessionVariables(AuditConstant.UPDATE));
	    groupsSubscriberCO.setAuditObj(returnAuditObject(groupsSubscriberCO.getClass()));
	    groupsSubscriberBO.deleteRecord(groupsSubscriberCO);
	}
	catch(BaseException e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }

    /**
     * used to fill audit variables .
     * 
     * @param status
     * @return
     */
    private AuditRefCO fillSessionVariables(String status)
    {

	AuditRefCO refCO = initAuditRefCO();
	try
	{
	    refCO.setAuditEnabled(true);
	    refCO.setOperationType(status);
	    refCO.setKeyRef(AuditConstant.ALERT_GROUP_KEY_REF);

	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return refCO;
    }
    
    /**
     * Display  Field by Event Type
     * @return
     */
    public String applyDisplaySettingByIncludeAllSub()
    {
    	try
    	{
    	    getAdditionalScreenParams().putAll(groupsSubscriberBO.applyDisplaySettingByIncludeAllSub(groupsSubscriberCO).getHm());
    	}
    	catch(Exception e)
    	{
    	    handleException(e, null, null);
    	}
    	return SUCCESS;
    }
    


	public String getSubcriberInGroup() {
		return subcriberInGroup;
	}

	public void setSubcriberInGroup(String subcriberInGroup) {
		this.subcriberInGroup = subcriberInGroup;
	}

}
