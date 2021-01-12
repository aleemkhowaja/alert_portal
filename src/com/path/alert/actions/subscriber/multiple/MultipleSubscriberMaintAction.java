package com.path.alert.actions.subscriber.multiple;

import java.util.List;

import com.path.alert.actions.common.AlertBaseAction;
import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.common.AlrtCommonConstants;
import com.path.alert.bo.subscriber.individual.IndividualSubscriberBO;
import com.path.alert.bo.subscriber.individual.IndividualSubscriberConstant;
import com.path.alert.bo.subscriber.multiple.MultipleSubscriberBO;
import com.path.alert.vo.subscriber.individual.IndividualSubscriberCO;
import com.path.alert.vo.subscriber.individual.IndividualSubscriberSC;
import com.path.alert.vo.subscriber.multiple.MultipleSubscriberCO;
import com.path.alert.vo.subscriber.multiple.MultipleSubscriberSC;
import com.path.bo.common.audit.AuditConstant;
import com.path.dbmaps.vo.ALRT_SUBVO;
import com.path.dbmaps.vo.ALRT_SUB_LANGVO;
import com.path.lib.common.exception.BOException;
import com.path.lib.common.exception.BaseException;
import com.path.lib.common.util.StringUtil;
import com.path.lib.vo.GridUpdates;
import com.path.vo.common.SessionCO;
import com.path.vo.common.audit.AuditRefCO;
import com.path.vo.common.select.SelectCO;
import com.path.vo.common.select.SelectSC;

public class MultipleSubscriberMaintAction extends AlertBaseAction
{

    private MultipleSubscriberBO multipleSubscriberBO;
    private MultipleSubscriberCO multipleSubscriberCO = new MultipleSubscriberCO();
    private MultipleSubscriberSC criteria = new MultipleSubscriberSC();
    private IndividualSubscriberBO individualSubscriberBO;

    private IndividualSubscriberCO individualSubscriberCO = new IndividualSubscriberCO();

    private List<SelectCO> languageDropDownList;

    /**
     * Fill Session Data
     * 
     * @throws BaseException
     */
    public void fillSessionData() throws BaseException
    {
	SessionCO sessionCO = returnSessionObject();
	multipleSubscriberCO.setCompCode(sessionCO.getCompanyCode());
	multipleSubscriberCO.setAppName(sessionCO.getCurrentAppName());
	multipleSubscriberCO.setProgRef(get_pageRef());
	multipleSubscriberCO.setUserID(sessionCO.getUserName());
	multipleSubscriberCO.setRunningDate(sessionCO.getRunningDateRET());
	multipleSubscriberCO.setIvCrud(getIv_crud());
	multipleSubscriberCO.setLanguage(sessionCO.getLanguage());

	individualSubscriberCO.setCompCode(sessionCO.getCompanyCode());
	individualSubscriberCO.setBranchCode(sessionCO.getBranchCode());
	individualSubscriberCO.setAppName(sessionCO.getCurrentAppName());
	individualSubscriberCO.setProgRef(get_pageRef());
	individualSubscriberCO.setUserID(sessionCO.getUserName());
	individualSubscriberCO.setRunningDate(returnCommonLibBO().addSystemTimeToDate(sessionCO.getRunningDateRET()));
	individualSubscriberCO.setIvCrud(getIv_crud());
	individualSubscriberCO.setLanguage(sessionCO.getLanguage());
    }

    /**
     * initialize the multiple Subscriber page
     * 
     * @return
     */
    public String initialize()
    {
//		String returnScreen = "multipleSubscriberMaint";
	try
	{
	    set_enableAudit(false);
	    set_showSmartInfoBtn("false");
	    if(getIv_crud().equals(AlertConstant.STATUS_APPROVED))
	    {
		set_recReadOnly("true");
	    }
	    setEnable_omni(AlrtCommonConstants.isOmniInstalled);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	    return ERROR_ACTION;
	}
	return "multipleSubscriberMaint";
    }

    /**
     * insert multiple Subscribers
     * 
     * @return
     */
    public String save()
    {
	try
	{
	    if(StringUtil.isNotEmpty(multipleSubscriberCO.getMultpleSubscribersJson()))
	    {
		// fill session data
		fillSessionData();

		// fill audit details
		// fillAudit();

		// parse all data of grid
		GridUpdates gu = getGridUpdates(multipleSubscriberCO.getMultpleSubscribersJson(),
			MultipleSubscriberCO.class, false);
		List<MultipleSubscriberCO> newMultipleSubscriberList = gu.getLstAdd();
		List<MultipleSubscriberCO> updatedMultipleSubscriberList = gu.getLstModify();
		List<MultipleSubscriberCO> deletedMultipleSubscriberList = gu.getLstDelete();

		// audit
		AuditRefCO refCO = initAuditRefCO();
		refCO.setKeyRef(AuditConstant.ALERT_SUBSCRIBER_KEY_REF);
		refCO.setProgRef(IndividualSubscriberConstant.SUBSCRIBER_PROG_REF);
		/**
		 * new multiple subscribers
		 */
		for(int i = 0; i < newMultipleSubscriberList.size(); i++)
		{
		    // audit
		    refCO.setOperationType(AuditConstant.CREATED);
		    individualSubscriberCO.setAuditRefCO(refCO);

		    MultipleSubscriberCO addMultipleSubscriberCO = (MultipleSubscriberCO) newMultipleSubscriberList
			    .get(i);
		    ALRT_SUBVO aLRT_SUBVO = addMultipleSubscriberCO.getAlrtSubVO();
		    if(aLRT_SUBVO != null && StringUtil.isNotEmpty(aLRT_SUBVO.getDEFAULT_BRIEF_NAME())
			    && StringUtil.isNotEmpty(aLRT_SUBVO.getDEFAULT_LONG_NAME()))
		    {
			individualSubscriberCO.setAlrtSubVO(aLRT_SUBVO);

			if(StringUtil.isNotEmpty(addMultipleSubscriberCO.getOtherLanguagesJson()))
			{
			    // parse other languages grid data
			    GridUpdates otherLanguageGridUpdates = getGridUpdates(
				    addMultipleSubscriberCO.getOtherLanguagesJson(), ALRT_SUB_LANGVO.class, true);

			    individualSubscriberCO.setOtherLanguageList(otherLanguageGridUpdates.getLstAllRec());
			}
			// save new subscribers
			individualSubscriberBO.updateindividualSubscriber(individualSubscriberCO);
		    }
		}

		/**
		 * update multiple subscriber
		 */
		for(int i = 0; i < updatedMultipleSubscriberList.size(); i++)
		{

		    MultipleSubscriberCO updateMultipleSubscriberCO = (MultipleSubscriberCO) updatedMultipleSubscriberList
			    .get(i);
		    ALRT_SUBVO aLRT_SUBVO = updateMultipleSubscriberCO.getAlrtSubVO();

		    if(aLRT_SUBVO != null && StringUtil.isNotEmpty(aLRT_SUBVO.getDEFAULT_BRIEF_NAME())
			    && StringUtil.isNotEmpty(aLRT_SUBVO.getDEFAULT_LONG_NAME())
			    && StringUtil.isNotEmpty(aLRT_SUBVO.getEMAIL_ID())
			    && StringUtil.isNotEmpty(aLRT_SUBVO.getMOBILE_PHONE()))
		    {
			IndividualSubscriberSC criteria = new IndividualSubscriberSC();
			criteria.setSubID(aLRT_SUBVO.getID());
			criteria.setCompCode(individualSubscriberCO.getCompCode());
			IndividualSubscriberCO newIndividualSubscriberCO = individualSubscriberBO
				.loadDataFromDb(individualSubscriberCO, criteria);
			ALRT_SUBVO oldALRT_SUBVO = newIndividualSubscriberCO.getAlrtSubVO();

			individualSubscriberCO.setAlrtSubVO(aLRT_SUBVO);

			refCO.setOperationType(AuditConstant.UPDATE);
			individualSubscriberCO.setAuditObj(oldALRT_SUBVO);
			individualSubscriberCO.setAuditRefCO(refCO);

			if(StringUtil.isNotEmpty(updateMultipleSubscriberCO.getOtherLanguagesJson()))
			{
			    // parse other languages grid data
			    GridUpdates otherLanguageGridUpdates = getGridUpdates(
				    updateMultipleSubscriberCO.getOtherLanguagesJson(), ALRT_SUB_LANGVO.class, true);
			    individualSubscriberCO.setOtherLanguageList(otherLanguageGridUpdates.getLstAllRec());
			}
			// update Subscribers
			individualSubscriberBO.updateindividualSubscriber(individualSubscriberCO);
		    }
		}

		/**
		 * delete multiple subscriber
		 */
		for(int i = 0; i < deletedMultipleSubscriberList.size(); i++)
		{

		    MultipleSubscriberCO deleteMultipleSubscriberCO = (MultipleSubscriberCO) deletedMultipleSubscriberList
			    .get(i);
		    ALRT_SUBVO aLRT_SUBVO = deleteMultipleSubscriberCO.getAlrtSubVO();
		    individualSubscriberCO.setAlrtSubVO(aLRT_SUBVO);
		    individualSubscriberBO.deleteIndSubscriber(individualSubscriberCO);
		}
	    }

	}
	catch(BaseException e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    /**
     * approve multiple subscribers
     * 
     * @return
     */
    public String approve()
    {
	try
	{
	    fillSessionData();

	    AuditRefCO refCO = fillAudit();
	    multipleSubscriberCO.setAuditRefCO(refCO);
	    multipleSubscriberCO = multipleSubscriberBO.approve(multipleSubscriberCO);
	    if(multipleSubscriberCO.getAllApproved() > 0)
	    {
		throw new BOException(multipleSubscriberCO.getAllApproved());
	    }
	}
	catch(Exception e)
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
    private AuditRefCO fillAudit()
    {
	AuditRefCO refCO = initAuditRefCO();
	try
	{
	    refCO.setKeyRef(AuditConstant.ALERT_SUBSCRIBER_KEY_REF);
	    refCO.setOperationType(AuditConstant.UPDATE);
	    refCO.setTrxNbr(getAuditTrxNbr());
	    individualSubscriberCO.setAuditRefCO(refCO);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return refCO;
    }
    

    /**
     * Preffered Language Drop Down
     * 
     * @return
     */
    public String fillPreferedLanguageDropDown()
    {
	try
	{
	    SelectSC sel1SC = new SelectSC(AlertConstant.Lang_LOV_TYPE);
	    sel1SC.setLovCodesExclude("'D'");
	    languageDropDownList = returnLOV(sel1SC);
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	    return ERROR_ACTION;
	}
	return SUCCESS;
    }

    /**
     * Return Other language Dialog
     * 
     * @return
     */
    public String returnOtherLanguageDialog()
    {
	if(getIv_crud().equals(AlertConstant.STATUS_APPROVED))
	{
	    set_recReadOnly("true");
	}
	return "subscriberOtherLanguage";
    }
    
    /**
     * validate email or mobile Dependancy
     * @return
     */
    public String validateEmailOrMobileDependancy()
    {
	try
	{
	    individualSubscriberBO.validateMobileEmail(individualSubscriberCO.getAlrtSubVO().getEMAIL_ID(), 
	    						individualSubscriberCO.getAlrtSubVO().getMOBILE_PHONE(), 
	    						individualSubscriberCO);
	}
	catch(BaseException e)
	{
	    individualSubscriberCO.getAlrtSubVO().setEMAIL_ID(null);
	    individualSubscriberCO.getAlrtSubVO().setMOBILE_PHONE(null);
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
    /*
     * private AuditRefCO fillAudit() { AuditRefCO refCO = initAuditRefCO(); try
     * {
     * 
     * refCO.setKeyRef(AuditConstant.ALERT_SUBSCRIBER_KEY_REF);
     * if(!(ConstantsCommon.EMPTY_BIGDECIMAL_VALUE).equals(
     * individualSubscriberCO.getAlrtSubVO().getID())) {
     * if(!StringUtil.nullToEmpty(individualSubscriberCO.getIvCrud()).equals(
     * AlertConstant.CRUD_P)) { ALRT_SUBVO oldAlrt_SUBVO = (ALRT_SUBVO)
     * returnAuditObject(ALRT_SUBVO.class);
     * individualSubscriberCO.setAuditObj(oldAlrt_SUBVO);
     * multipleSubscriberCO.setAuditObj(returnAuditObject(multipleSubscriberCO.
     * getClass())); } multipleSubscriberCO.setAuditRefCO(refCO);
     * refCO.setOperationType(AuditConstant.UPDATE); } else {
     * refCO.setOperationType(AuditConstant.CREATED); }
     * individualSubscriberCO.setAuditRefCO(refCO); } catch(Exception e) {
     * handleException(e, null, null); } return refCO; }
     */

    public MultipleSubscriberSC getCriteria()
    {
	return criteria;
    }

    public void setCriteria(MultipleSubscriberSC criteria)
    {
	this.criteria = criteria;
    }

    public MultipleSubscriberCO getMultipleSubscriberCO()
    {
	return multipleSubscriberCO;
    }

    public void setMultipleSubscriberCO(MultipleSubscriberCO multipleSubscriberCO)
    {
	this.multipleSubscriberCO = multipleSubscriberCO;
    }

    public void setMultipleSubscriberBO(MultipleSubscriberBO multipleSubscriberBO)
    {
	this.multipleSubscriberBO = multipleSubscriberBO;
    }

    public List<SelectCO> getLanguageDropDownList()
    {
	return languageDropDownList;
    }

    public void setLanguageDropDownList(List<SelectCO> languageDropDownList)
    {
	this.languageDropDownList = languageDropDownList;
    }

    public IndividualSubscriberCO getIndividualSubscriberCO()
    {
	return individualSubscriberCO;
    }

    public void setIndividualSubscriberCO(IndividualSubscriberCO individualSubscriberCO)
    {
	this.individualSubscriberCO = individualSubscriberCO;
    }

    public void setIndividualSubscriberBO(IndividualSubscriberBO individualSubscriberBO)
    {
	this.individualSubscriberBO = individualSubscriberBO;
    }

}
