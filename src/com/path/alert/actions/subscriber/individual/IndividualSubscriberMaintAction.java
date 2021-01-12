package com.path.alert.actions.subscriber.individual;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.path.alert.actions.common.AlertBaseAction;
import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.common.AlrtCommonConstants;
import com.path.alert.bo.subscriber.individual.IndividualSubscriberBO;
import com.path.alert.vo.subscriber.individual.IndividualSubscriberCO;
import com.path.alert.vo.subscriber.individual.IndividualSubscriberSC;
import com.path.alert.vo.subscription.SubscriptionCO;
import com.path.bo.common.ConstantsCommon;
import com.path.bo.common.audit.AuditConstant;
import com.path.dbmaps.vo.ALRT_SUBVO;
import com.path.dbmaps.vo.ALRT_SUB_ACC_EXCLVO;
import com.path.dbmaps.vo.ALRT_SUB_LANGVO;
import com.path.dbmaps.vo.SYS_PARAM_LANGUAGESVO;
import com.path.dbmaps.vo.SYS_PARAM_SCREEN_DISPLAYVO;
import com.path.lib.common.exception.BOException;
import com.path.lib.common.exception.BaseException;
import com.path.lib.common.util.NumberUtil;
import com.path.lib.common.util.StringUtil;
import com.path.lib.vo.GridUpdates;
import com.path.struts2.json.PathJSONUtil;
import com.path.vo.common.SessionCO;
import com.path.vo.common.audit.AuditRefCO;
import com.path.vo.common.select.SelectCO;
import com.path.vo.common.select.SelectSC;
import com.path.vo.core.cif.CifSC;

public class IndividualSubscriberMaintAction extends AlertBaseAction
{

    private IndividualSubscriberBO individualSubscriberBO;
	private List<SelectCO> subscriberTypeDropDown;
    private List<SelectCO> languageDropDown;
    private List<SelectCO> commonlanguageDropDown;
    private IndividualSubscriberCO individualSubscriberCO = new IndividualSubscriberCO();
    private IndividualSubscriberSC criteria = new IndividualSubscriberSC();

    private final List<SelectCO> languageSelect = new ArrayList<SelectCO>();
    private String oldStatus; 
    private CifSC cifCriteria = new CifSC();
    
    private String subscriberEventsGridData;
    private String subscriberPackagesGridData;

    public Object getModel()
    {
	return individualSubscriberCO;
    }
    
    
    /**
     * function that fill the needed data from the session .
     * 
     * @throws BaseException
     */
    public void fillSessionData() throws BaseException
    {
		SessionCO sessionCO = returnSessionObject();
		individualSubscriberCO.setCompCode(sessionCO.getCompanyCode());
		individualSubscriberCO.setBranchCode(sessionCO.getBranchCode());
		individualSubscriberCO.setAppName(sessionCO.getCurrentAppName());
		individualSubscriberCO.setProgRef(get_pageRef());
		individualSubscriberCO.setUserID(sessionCO.getUserName());
		individualSubscriberCO.setRunningDate(returnCommonLibBO().addSystemTimeToDate(sessionCO.getRunningDateRET()));
		individualSubscriberCO.setIvCrud(getIv_crud());
		individualSubscriberCO.setLanguage(sessionCO.getLanguage());
		criteria.setCompCode(sessionCO.getCompanyCode());
		criteria.setBranchCode(sessionCO.getBranchCode());
		criteria.setUserId(sessionCO.getUserName());
		cifCriteria.setComp_code(sessionCO.getCompanyCode());
		cifCriteria.setBranchCode(sessionCO.getBranchCode());
		cifCriteria.setUserId(sessionCO.getUserName());
    }

    /**
     * function that initialize the main grid list
     * 
     * @return
     */
    public String initialize()
    {
    	individualSubscriberCO = new IndividualSubscriberCO();
//		String returnScreen = "individualSubscriberList";
		try
		{
		    set_enableAudit(true);
		    set_showSmartInfoBtn("true");
		    set_showRecordLogsBtn("false");
		    if(AlertConstant.CRUD_R.equals(getIv_crud()))
		    {
		    	set_showNewInfoBtn("true");
		    }
		    set_searchGridId("individualSubscriberGridTbl_Id");
		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		    return ERROR_ACTION;
		}
		return "individualSubscriberList";
    }

    /**
     * function that return the main jsp form
     * 
     * @return
     */
    public String initializeMain()
    {
    	individualSubscriberCO = new IndividualSubscriberCO();
		//String returnScreen = "individualSubscriberMaint";
		try
		{
		    fillSessionData();
		    onInitializeVisibilities();
		    if(AlertConstant.CRUD_P.equals(getIv_crud()) || AlertConstant.CRUD_F.equals(getIv_crud()))
		    {
		    	set_recReadOnly("true");
		    }
		    initList();
		    makeFieldsEnableAndDisable(true, true, null);
		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		    return ERROR_ACTION;
		}
		return "individualSubscriberMaint";
    }
    
    /**
     * method to make fields disable and enable
     * @param isReadOnly
     */
    private void makeFieldsEnableAndDisable(Boolean isFacebookReadOnly, Boolean isTwitterReadOnly, ALRT_SUBVO alrt_SUBVO) throws BaseException
    {
    	 // Making Fields Read only
	    HashMap<String, SYS_PARAM_SCREEN_DISPLAYVO> hm = new HashMap<String, SYS_PARAM_SCREEN_DISPLAYVO>();
	    SYS_PARAM_SCREEN_DISPLAYVO facebookBuisnessElement = new SYS_PARAM_SCREEN_DISPLAYVO();
	    SYS_PARAM_SCREEN_DISPLAYVO twitterBuisnessElement = new SYS_PARAM_SCREEN_DISPLAYVO();
		//SYS_PARAM_SCREEN_DISPLAYVO cifRelatedHiddenFields = new SYS_PARAM_SCREEN_DISPLAYVO();
		SYS_PARAM_SCREEN_DISPLAYVO noOfFreeMsgsHiddenFields = new SYS_PARAM_SCREEN_DISPLAYVO();
		SYS_PARAM_SCREEN_DISPLAYVO cifNumberLookup = new SYS_PARAM_SCREEN_DISPLAYVO();
		SYS_PARAM_SCREEN_DISPLAYVO imalUserlookup = new SYS_PARAM_SCREEN_DISPLAYVO();

		/*if(alrt_SUBVO != null && NumberUtil.isEmptyDecimal(alrt_SUBVO.getCIF_NO()))
		{
			cifRelatedHiddenFields.setIS_READONLY(BigDecimal.ZERO);
			individualSubscriberCO.setCifType("");
		} else if(alrt_SUBVO != null)
		{
			cifRelatedHiddenFields.setIS_READONLY(BigDecimal.ONE);
		}*/
		
		if(alrt_SUBVO == null )
		{
			noOfFreeMsgsHiddenFields.setIS_READONLY(BigDecimal.ONE);
		}
		else if(NumberUtil.nullToZero(alrt_SUBVO.getCHARGEABLE()).compareTo(BigDecimal.ZERO) == 0)
		{
			noOfFreeMsgsHiddenFields.setIS_READONLY(BigDecimal.ONE);
		} else
		{
			noOfFreeMsgsHiddenFields.setIS_READONLY(BigDecimal.ZERO);
		}
		
		
		
		if(alrt_SUBVO != null && alrt_SUBVO.getCHANNEL_END_USR_ID() != null && StringUtil.isNotEmpty(alrt_SUBVO.getCHANNEL_END_USR_ID()))
    	{
			cifNumberLookup.setIS_READONLY(BigDecimal.ONE);
			imalUserlookup.setIS_READONLY(BigDecimal.ONE);
    	}
		else
		{
			cifNumberLookup.setIS_READONLY(BigDecimal.ZERO);
			imalUserlookup.setIS_READONLY(BigDecimal.ZERO);
		}

		/*if(alrt_SUBVO != null)
		{
		    hm.put("briefNameEng", cifRelatedHiddenFields);
		    hm.put("middleNameEng", cifRelatedHiddenFields);
		    hm.put("longNameEng", cifRelatedHiddenFields);
		    hm.put("address", cifRelatedHiddenFields);
		}*/
	    if(isFacebookReadOnly)
	    {
	    	facebookBuisnessElement.setIS_READONLY(BigDecimal.ONE);
	    }
	    else
	    {
	    	facebookBuisnessElement.setIS_READONLY(BigDecimal.ZERO);
	    }
	    
	    if(isTwitterReadOnly)
		{
	    	twitterBuisnessElement.setIS_READONLY(BigDecimal.ONE);
	    }
	    else
	    {
	    	twitterBuisnessElement.setIS_READONLY(BigDecimal.ZERO);
	    }
	    hm.put("FACEBOOK_SOCIAL_ID", facebookBuisnessElement);
	    hm.put("TWITTER_SOCIAL_ID", twitterBuisnessElement);
	    hm.put("nbFreeMsgs", noOfFreeMsgsHiddenFields);
	    
	    hm.put("lookuptxt_userId", imalUserlookup);
	    hm.put("lookuptxt_cifNumber", cifNumberLookup);
	    
	    setAdditionalScreenParams(hm);
	    setOMNIAdminField();
    }

    /**
     * method call when dbclick on Main Grid row to load Main Form
     * 
     * @return
     */
    public String loadIndividualSubMaint()
    {
		//String returnScreen = "individualSubscriberMaint";
		try
		{
			//get required data from session
		    fillSessionData();
		    
		    // load required Combobox data
		    initList();
		    //retrieve data from db
		    individualSubscriberCO = individualSubscriberBO.loadDataFromDb(individualSubscriberCO, criteria);
		    
		    ALRT_SUBVO alrt_SUBVO = individualSubscriberCO.getAlrtSubVO();
		    
		    //make facebook and twitter checkboxes disable
		    if(alrt_SUBVO != null)
		    {
		    	if((individualSubscriberCO.getFacebookSocialId() == null || individualSubscriberCO.getFacebookSocialId().compareTo(BigDecimal.ZERO) == 0)
		    	  && (individualSubscriberCO.getTwitterSocialId() != null && individualSubscriberCO.getTwitterSocialId().compareTo(BigDecimal.ONE) == 0))
		    	{
		    		makeFieldsEnableAndDisable(true, false, alrt_SUBVO);
		    	}
		    	else if((individualSubscriberCO.getFacebookSocialId()  != null && individualSubscriberCO.getFacebookSocialId() .compareTo(BigDecimal.ONE) == 0)
				    	  && (individualSubscriberCO.getTwitterSocialId() == null || individualSubscriberCO.getTwitterSocialId().compareTo(BigDecimal.ZERO) == 0))
		    	{
		    		makeFieldsEnableAndDisable(false, true, alrt_SUBVO);
		    	}
		    	else if((individualSubscriberCO.getFacebookSocialId()  != null && individualSubscriberCO.getFacebookSocialId() .compareTo(BigDecimal.ONE) == 0)
				    	  && (individualSubscriberCO.getTwitterSocialId() != null && individualSubscriberCO.getTwitterSocialId().compareTo(BigDecimal.ONE) == 0))
		    	{
		    		makeFieldsEnableAndDisable(false, false, alrt_SUBVO);
		    	}
		    	else
		    	{
		    		makeFieldsEnableAndDisable(true, true, alrt_SUBVO);
		    	}
		    }
		    
		    //make fields readonly according to screen
		    if(AlertConstant.CRUD_P.equals(getIv_crud()))
		    {
				set_recReadOnly("true");
				individualSubscriberCO.setIsReadOnlyDet(BigDecimal.ONE);
		    }
		    else if(AlertConstant.CRUD_F.equals(getIv_crud()))
		    {
				set_recReadOnly("false");
				individualSubscriberCO.setIsReadOnlyDet(BigDecimal.ZERO);
		    }
		    else
		    {
				if(AlertConstant.CRUD_R.equals(getIv_crud()) && (((AlertConstant.STATUS_DELETED)
					.equals(individualSubscriberCO.getAlrtSubVO().getSTATUS()))
					|| ((AlertConstant.STATUS_APPROVED).equals(individualSubscriberCO.getAlrtSubVO().getSTATUS()))))
				{
				    set_recReadOnly("true");
				    individualSubscriberCO.setIsReadOnlyDet(BigDecimal.ONE);
				}
				else
				{
				    set_recReadOnly("false");
				    individualSubscriberCO.setIsReadOnlyDet(BigDecimal.ZERO);
				}
		    }
		    if((AlertConstant.STATUS_DELETED).equals(individualSubscriberCO.getAlrtSubVO().getSTATUS()))
		    {
		    	set_recReadOnly("true");
		    	individualSubscriberCO.setIsReadOnlyDet(BigDecimal.ONE);
		    }
		    //apply retrieve Audit
		    applyRetrieveAudit(AuditConstant.ALERT_SUBSCRIBER_KEY_REF, individualSubscriberCO.getAlrtSubVO(), individualSubscriberCO.getAlrtSubVO());
		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		    return ERROR_ACTION;
		}
		return "individualSubscriberMaint";
    }

  /*  private void loadDataFromDb()
    {
		set_showSmartInfoBtn("false");
		try
		{
		    individualSubscriberCO = individualSubscriberBO.loadDataFromDb(individualSubscriberCO, criteria);
		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		}
    }*/

    /**
     * function that load and return the others subsriber details
     * 
     * @return
     */
    public String loadRelatedForm()
    {
//		String returnScreen = "othersSubscriberForm";
		try
		{
		    fillSessionData();
		    initList();
		    individualSubscriberCO.getAlrtSubVO().setLANG(AlertConstant.ARABIC);
	
		    if(!NumberUtil.isEmptyDecimal(criteria.getSubID()))
		    {
			individualSubscriberCO = individualSubscriberBO.loadRelatedForm(individualSubscriberCO, criteria);
			getAdditionalScreenParams().putAll(individualSubscriberCO.getHm());
		    }
		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		    return ERROR_ACTION;
		}
		return "othersSubscriberForm";
    }

    /**
     * apllies the visibility and readOnly on initialize
     * 
     * @throws BaseException
     */
    private void onInitializeVisibilities() throws BaseException
    {
    	fillSessionData();
    }

    /**
     * initialize the needed lists (lovs)
     * 
     * @throws BaseException
     */
    private void initList() throws BaseException
    {
		SelectSC selSC = new SelectSC(AlertConstant.subscriberTypeDropDown);
		subscriberTypeDropDown = returnLOV(selSC);
		SelectSC sel1SC = new SelectSC(AlertConstant.Lang_LOV_TYPE);
		sel1SC.setLovCodesExclude("'D'");
		languageDropDown = returnLOV(sel1SC);
		SelectSC sel2SC = new SelectSC(AlertConstant.COMMON_LANG_LOV);
		commonlanguageDropDown = returnLOV(sel2SC);
    }

    /**
     * function that load and return the cif subscriber details
     * 
     * @return
     */
    public String loadCifDetailsForm() throws BaseException
    {
//		String returnScreen = "cifSubscriberForm";
		try
		{
		    set_pageRef(individualSubscriberCO.getProgRef());
		    fillSessionData();
		    initList();
		    criteria.setCompCode(individualSubscriberCO.getCompCode());
		    individualSubscriberCO = individualSubscriberBO.loadCifDetails(criteria, individualSubscriberCO);
	
		    getAdditionalScreenParams().putAll(individualSubscriberCO.getHm());
		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		    return ERROR_ACTION;
		}
		return "cifSubscriberForm";
    }

    /**
     * function that load and return the user subscriber details
     * 
     * @return
     */
    public String loadUsrDetailsForm() throws BaseException
    {
//		String returnScreen = "usrSubscriberForm";
		try
		{
		    fillSessionData();
		    initList();
		    criteria.setCompCode(individualSubscriberCO.getCompCode());
		    // criteria.setCif(individualSubscriberCO.getCifVO().get);
		    individualSubscriberCO = individualSubscriberBO.loadUsrDetails(criteria, individualSubscriberCO);
	
		    getAdditionalScreenParams().putAll(individualSubscriberCO.getHm());
		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		    return ERROR_ACTION;
		}
		return "usrSubscriberForm";
    }

    /**
     * function that load and return the others subscriber details
     * 
     * @return
     */
    public String loadAccDetailsForm() throws BaseException
    {
//		String returnScreen = "accSubscriberForm";
		try
		{
		    fillSessionData();
		    initList();
		    criteria.setCompCode(individualSubscriberCO.getCompCode());
		    // criteria.setCif(individualSubscriberCO.getCifVO().get);
		    individualSubscriberCO = individualSubscriberBO.loadAccDetailsForm(criteria, individualSubscriberCO);
		    getAdditionalScreenParams().putAll(individualSubscriberCO.getHm());
	
		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		    return ERROR_ACTION;
		}
		return "accSubscriberForm";
    }

    /**
     * function that save/updates the subscriber
     * 
     * @return
     */
    public String save() throws BaseException
    {
		try
		{
		    fillSessionData();
		    /**
		     * call the business layer ...
		     */
		    
		    fillAudit();
		   // individualSubscriberCO.getAlrtSubVO().setSUSPEND_ALL_SUBSCRIPTIONS(criteria.getSuspendAllSubscriptions());
		    
			if(StringUtil.isNotEmpty(individualSubscriberCO.getJsonOtherLangArray()))
		    {
				GridUpdates gu = getGridUpdates(individualSubscriberCO.getJsonOtherLangArray(), ALRT_SUB_LANGVO.class, false);
				individualSubscriberCO.setNewOtherLanguageList(gu.getLstAdd());
				individualSubscriberCO.setUpdateOtherLanguageList(gu.getLstModify());
				individualSubscriberCO.setDeleteOtherLanguageList(gu.getLstDelete());
				//	newLanguageFieldsList = gu.getLstAllRec();
		    }
			
			List<ALRT_SUB_ACC_EXCLVO> subscriberMultipleAccountsList = new ArrayList();
			
			if(!NumberUtil.isEmptyDecimal(individualSubscriberCO.getAlrtSubVO().getID()))
			{
				if(StringUtil.isNotEmpty(subscriberEventsGridData))
			    {
					GridUpdates subscriberEventGrid = getGridUpdates(subscriberEventsGridData,SubscriptionCO.class, true);
					for(int i=0; i<subscriberEventGrid.getLstAllRec().size(); i++)
					{
						SubscriptionCO subscriptionCO = (SubscriptionCO) subscriberEventGrid.getLstAllRec().get(i);
						if(StringUtil.isNotEmpty(subscriptionCO.getEventAccountNumber()))
						{
							GridUpdates guMultiselect = getGridUpdates(subscriptionCO.getEventCifMultiselectedAccounts(),ALRT_SUB_ACC_EXCLVO.class, true);
							for(int j=0; j<guMultiselect.getLstAllRec().size(); j++)
							{
								ALRT_SUB_ACC_EXCLVO alrt_SUB_ACC_EXCLVO = (ALRT_SUB_ACC_EXCLVO) guMultiselect.getLstAllRec().get(j);
								alrt_SUB_ACC_EXCLVO.setEVT_PKG_ID(subscriptionCO.getAlrtSubEvtTmpVO().getEVT_ID());
								subscriberMultipleAccountsList.add(alrt_SUB_ACC_EXCLVO);
							}
						}
					}
					individualSubscriberCO.setExcludedAccountList(subscriberMultipleAccountsList);
			    }
			    
			    subscriberPackagesGridData = subscriberPackagesGridData.replace("{\"root\":{}}", "");
				if(StringUtil.isNotEmpty(subscriberPackagesGridData))
			    {
					subscriberMultipleAccountsList = new ArrayList();
					GridUpdates subscriberPackageGrid = getGridUpdates(subscriberPackagesGridData,SubscriptionCO.class, true);
					for(int i=0; i<subscriberPackageGrid.getLstAllRec().size(); i++)
					{
						SubscriptionCO subscriptionCO = (SubscriptionCO) subscriberPackageGrid.getLstAllRec().get(i);
						if(StringUtil.isNotEmpty(subscriptionCO.getPackageAccountNumber()))
						{
							GridUpdates guMultiselect = getGridUpdates(subscriptionCO.getPackageCifMultiselectedAccounts(),ALRT_SUB_ACC_EXCLVO.class, true);
							for(int j=0; j<guMultiselect.getLstAllRec().size(); j++)
							{
								ALRT_SUB_ACC_EXCLVO alrt_SUB_ACC_EXCLVO = (ALRT_SUB_ACC_EXCLVO) guMultiselect.getLstAllRec().get(j);
								alrt_SUB_ACC_EXCLVO.setEVT_PKG_ID(subscriptionCO.getAlrtSubEvtTmpVO().getEVT_ID());
								subscriberMultipleAccountsList.add(alrt_SUB_ACC_EXCLVO);
							}
						}
					}
					individualSubscriberCO.setExcludedPackageAccountList(subscriberMultipleAccountsList);
			    }
			}
			//individualSubscriberCO.setOtherLanguageList(newLanguageFieldsList);
		    individualSubscriberCO = individualSubscriberBO.updateindividualSubscriber(individualSubscriberCO);
		}
		catch(Exception ex)
		{
		    handleException(ex, null, null);
		}
		return "save";
    }    
   
    /**
     * function that continues the save/update after showing some validations
     * form js
     * 
     * @return
     */
    public String continueUpdateAfterValidation() throws BaseException
    {
	try
	{
	    fillSessionData();
	    individualSubscriberCO.getAlrtSubVO().setSUSPEND_ALL_SUBSCRIPTIONS(criteria.getSuspendAllSubscriptions());
	    /**
	     * call the business layer ...
	     */
	   /* AuditRefCO refCO;
	    if(null == individualSubscriberCO.getAlrtSubVO().getSTATUS())
	    {
	    	refCO = fillAudit();
	    }
	    else
	    {
	    	refCO = fillAudit();
	    }*/
	    individualSubscriberCO = individualSubscriberBO.continueUpdateAfterValidation(individualSubscriberCO);
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	}
	return "save";

    }

    /**
     * function that set the subscriber to deleted and update the related
     * columns
     * 
     * @return
     */
    public String deleteIndSubscriber() throws BaseException
    {
		try
		{
		    fillSessionData();
		    //AuditRefCO refCO = fillAudit();
		    //individualSubscriberCO.setAuditRefCO(refCO);
		    //individualSubscriberCO.setAuditObj(returnAuditObject(individualSubscriberCO.getClass()));
		    individualSubscriberCO = individualSubscriberBO.deleteIndSubscriber(individualSubscriberCO);
	
		}
		catch(Exception ex)
		{
		    handleException(ex, null, null);
		}
		return "delete";
    }

    /**
     * function that approves the subsriber
     * 
     * @return
     */
    public String approveIndSubscriber() throws BaseException
    {
		try
		{
		    fillSessionData();
		    AuditRefCO refCO = fillAudit();
		    individualSubscriberCO.setAuditRefCO(refCO);
		    individualSubscriberCO.setAuditObj(returnAuditObject(individualSubscriberCO.getClass()));
		    individualSubscriberCO = individualSubscriberBO.approveIndSubscriber(individualSubscriberCO);
		}
		catch(Exception ex)
		{
		    handleException(ex, null, null);
		}
	return "save";

    }

    public String continueToApprove() throws BaseException
    {
		try
		{
		    fillSessionData();
		    // validate if user is allowed to take this action
		    validateMakerChecker(individualSubscriberCO);
		    AuditRefCO refCO = fillAudit();
		    individualSubscriberCO.setAuditRefCO(refCO);
		    individualSubscriberCO.setAuditObj(returnAuditObject(individualSubscriberCO.getClass()));
		    individualSubscriberCO = individualSubscriberBO.continueToApprove(individualSubscriberCO);
		    
		    /**
		     * Send Notification after approve the record
		     * 
		     */
		    individualSubscriberBO.sendAlertNotification(individualSubscriberCO.getAlrtSubVO());
	
		}
		catch(Exception ex)
		{
		    handleException(ex, null, null);
		}
		return "save";
    }
    
    /**
     * used to Validate Maker checker 
     * @param IndividualSubscriberCO
     * @throws BaseException
    */
    private void validateMakerChecker(IndividualSubscriberCO individualSubscriberCO) throws BaseException
    {
    	int result = returnCommonLibBO().validateMakerChecker(individualSubscriberCO.getAlrtSubVO().getCREATED_BY(), 
    			individualSubscriberCO.getAlrtSubVO().getMODIFIED_BY(), individualSubscriberCO.getUserID());
    	if( result > 0 )
    	{
    		throw new BOException(result);
    	}
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
	    if(!(ConstantsCommon.EMPTY_BIGDECIMAL_VALUE).equals(individualSubscriberCO.getAlrtSubVO().getID()))
	    {
		ALRT_SUBVO oldAlrt_SUBVO = (ALRT_SUBVO) returnAuditObject(ALRT_SUBVO.class);
		individualSubscriberCO.setAuditObj(oldAlrt_SUBVO);
		refCO.setOperationType(AuditConstant.UPDATE);
		refCO.setTrxNbr(getAuditTrxNbr());
	    }
	    else
	    {
		refCO.setOperationType(AuditConstant.CREATED);
	    }
	    individualSubscriberCO.setAuditRefCO(refCO);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return refCO;
    }
    
	/**
     * Initiate popup
     * @return String
     */
    public String  returnIndividualSubscriberAllLanguageDialog()
    {
    	individualSubscriberCO.getAlrtSubVO().setID(criteria.getSubID());
    	 if("P".equals(getIv_crud())||"R".equals(getIv_crud()) && ("P".equals(oldStatus)||"D".equals(oldStatus)))
         {
    		 set_recReadOnly("true");
     
         }
    	 return "subscriberOtherLanguage";
    }
    
    /**
     * Fill language select in grid
     * @return String
     */
    public String loadLanguageSelect()
    {
		try
		{
		    SelectSC sc = new SelectSC();
		    SelectCO sco;
		    sc.setLovTypeId(ConstantsCommon.LANGUAGES_LOV_TYPE);
		    sc.setLanguage(returnSessionObject().getLanguage());
		    
		    languageSelect.add(0, new SelectCO("", ""));
		    for(SYS_PARAM_LANGUAGESVO language : returnCommonLibBO().returnLanguages(sc))
		    {
		    	sco = new SelectCO();
				sco.setCode(language.getLANG_CODE());
				sco.setDescValue(language.getLANG_NAME());
				languageSelect.add(sco);
		    }
		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		}
		return SUCCESS;
    }
	
    
    public String returnAccountsByCifCode()
    {
    	try
		{
    		SessionCO sessionCO = returnSessionObject();
    		cifCriteria.setUserId(sessionCO.getUserName());
			cifCriteria.setComp_code(sessionCO.getCompanyCode());
			cifCriteria.setCif_no(criteria.getCif());
			cifCriteria.setNbRec(-1);
			//add multiple accounts of individual subscriber
		    individualSubscriberCO.setCifAccountsMultiselectArray("{\"root\":".concat(
		    	PathJSONUtil.serialize(individualSubscriberBO.accountList(cifCriteria), null, null, false, true)).concat("}"));
		}
    	catch(Exception e)
		{
		    handleException(e, null, null);
		}
    	return SUCCESS;
    }
	
    /*
     * disable CIF livesearch based on OMNI flag
     */
	private void setOMNIAdminField() throws BaseException 
	{
		if (AlrtCommonConstants.isOmniInstalled) 
		{
			HashMap<String, SYS_PARAM_SCREEN_DISPLAYVO> elementMap = new HashMap<>();

			SYS_PARAM_SCREEN_DISPLAYVO sysParam = new SYS_PARAM_SCREEN_DISPLAYVO();
			sysParam.setIS_READONLY(BigDecimal.ONE);
			elementMap.put("lookuptxt_cifNumber", sysParam);

			setAdditionalScreenParams(elementMap);
		}
	}
    public void setIndividualSubscriberBO(IndividualSubscriberBO individualSubscriberBO)
    {
    	this.individualSubscriberBO = individualSubscriberBO;
    }
    
    public List<SelectCO> getSubscriberTypeDropDown()
    {
    	return subscriberTypeDropDown;
    }

    public void setSubscriberTypeDropDown(List<SelectCO> subscriberTypeDropDown)
    {
    	this.subscriberTypeDropDown = subscriberTypeDropDown;
    }

    public IndividualSubscriberCO getIndividualSubscriberCO()
    {
    	return individualSubscriberCO;
    }

    public void setIndividualSubscriberCO(IndividualSubscriberCO individualSubscriberCO)
    {
    	this.individualSubscriberCO = individualSubscriberCO;
    }

    public List<SelectCO> getLanguageDropDown()
    {
    	return languageDropDown;
    }

    public void setLanguageDropDown(List<SelectCO> languageDropDown)
    {
    	this.languageDropDown = languageDropDown;
    }

    public List<SelectCO> getCommonlanguageDropDown()
    {
    	return commonlanguageDropDown;
    }

    public void setCommonlanguageDropDown(List<SelectCO> commonlanguageDropDown)
    {
    	this.commonlanguageDropDown = commonlanguageDropDown;
    }

    public IndividualSubscriberSC getCriteria()
    {
    	return criteria;
    }

    public void setCriteria(IndividualSubscriberSC criteria)
    {
    	this.criteria = criteria;
    }

	public String getOldStatus() {
		return oldStatus;
	}

	public void setOldStatus(String oldStatus) {
		this.oldStatus = oldStatus;
	}

	public CifSC getCifCriteria() {
		return cifCriteria;
	}

	public void setCifCriteria(CifSC cifCriteria) {
		this.cifCriteria = cifCriteria;
	}

	public List<SelectCO> getLanguageSelect() {
		return languageSelect;
	}

	public String getSubscriberEventsGridData() {
		return subscriberEventsGridData;
	}

	public String getSubscriberPackagesGridData() {
		return subscriberPackagesGridData;
	}

	public void setSubscriberEventsGridData(String subscriberEventsGridData) {
		this.subscriberEventsGridData = subscriberEventsGridData;
	}

	public void setSubscriberPackagesGridData(String subscriberPackagesGridData) {
		this.subscriberPackagesGridData = subscriberPackagesGridData;
	}

}
