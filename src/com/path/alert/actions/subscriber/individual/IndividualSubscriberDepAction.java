package com.path.alert.actions.subscriber.individual;

import java.math.BigDecimal;
import java.util.HashMap;

import com.path.actions.base.RetailBaseAction;
import com.path.alert.bo.events.event.IndividualEventBO;
import com.path.alert.bo.events.event.IndividualEventConstant;
import com.path.alert.bo.subscriber.individual.IndividualSubscriberBO;
import com.path.alert.vo.events.event.IndividualEventCO;
import com.path.alert.vo.subscriber.individual.IndividualSubscriberCO;
import com.path.alert.vo.subscriber.individual.IndividualSubscriberSC;
import com.path.bo.common.memo.MemoConstants;
import com.path.lib.common.exception.BaseException;
import com.path.lib.common.util.NumberUtil;
import com.path.vo.common.SessionCO;
import com.path.vo.common.memo.MemoSC;

public class IndividualSubscriberDepAction extends RetailBaseAction
{

    private IndividualSubscriberBO individualSubscriberBO;
    private IndividualSubscriberCO individualSubscriberCO = new IndividualSubscriberCO();
    private IndividualSubscriberSC criteria = new IndividualSubscriberSC();
    private IndividualEventBO individualEventBO;

    public void fillSessionData() throws BaseException
    {
	SessionCO sessionCO = returnSessionObject();
	individualSubscriberCO.setCompCode(sessionCO.getCompanyCode());
	individualSubscriberCO.setBranchCode(sessionCO.getBranchCode());
	individualSubscriberCO.setAppName(sessionCO.getCurrentAppName());
	individualSubscriberCO.setProgRef(criteria.getPageRef());
    }

    public String dependencyBySubType() throws BaseException
    {
	try
	{

	    if(null != individualSubscriberCO.getAlrtSubVO().getSUB_TYPE()
		    && !(("").equals(individualSubscriberCO.getAlrtSubVO().getSUB_TYPE())))
	    {
		fillSessionData();
		individualSubscriberCO = individualSubscriberBO.dependencyBySubType(individualSubscriberCO);
		getAdditionalScreenParams().putAll(individualSubscriberCO.getHm());
	    }

	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }

    public String dependencyByCifNumber() throws BaseException
    {
		try
		{
	
		    
		    
		    if(!NumberUtil.isEmptyDecimal(criteria.getCif()) && null != criteria.getCif())
		    {
			
			fillSessionData();
			individualSubscriberCO = individualSubscriberBO.dependencyByCifNumber(criteria, individualSubscriberCO);
	
			if(BigDecimal.ONE.equals(individualSubscriberCO.getOpenMemo()))
			{
			    MemoSC memoSC = new MemoSC();
			    memoSC.setCompCode(individualSubscriberCO.getCompCode());
			    memoSC.setForAccOrCif(MemoConstants.CIF);
			    memoSC.setCifNo(individualSubscriberCO.getAlrtSubVO().getCIF_NO()); // memoSC.setAppType(MemoConstants.CSM_APP_TYPE);
			    memoSC.setUseConnection(Boolean.TRUE);
			    checkForMemo(memoSC);
			}
	
		    }
		    else
		    {
			individualSubscriberCO.getAlrtSubVO().setCIF_NO(null);
		    }
	
		}
		catch(Exception e)
		{
		    individualSubscriberCO.getAlrtSubVO().setCIF_NO(null);
		    handleException(e, null, null);
	
		}
	//	CIFVO cifvo = individualSubscriberCO.getCifVO();
/*		HashMap<String, SYS_PARAM_SCREEN_DISPLAYVO> hm = new HashMap<String, SYS_PARAM_SCREEN_DISPLAYVO>();
		SYS_PARAM_SCREEN_DISPLAYVO hiddenFields = new SYS_PARAM_SCREEN_DISPLAYVO();
		if(NumberUtil.isEmptyDecimal(cifvo.getCIF_NO()))
		{
			hiddenFields.setIS_READONLY(BigDecimal.ZERO);
			individualSubscriberCO.setCifType("");
		} else
		{
			hiddenFields.setIS_READONLY(BigDecimal.ONE);
		}
	    hm.put("briefNameEng", hiddenFields);
	    hm.put("middleNameEng", hiddenFields);
	    hm.put("longNameEng", hiddenFields);
	    hm.put("address", hiddenFields);
	    setAdditionalScreenParams(hm);*/
		return SUCCESS;
    }

    public String dependencyByUserID() throws BaseException
    {
	try
	{

	    if(!criteria.getUserID().isEmpty() && null != criteria.getUserID())
	    {
		fillSessionData();
		individualSubscriberCO.setProgRef(get_pageRef());
		individualSubscriberCO = individualSubscriberBO.dependencyByUserID(criteria, individualSubscriberCO);
	    }
	    else
	    {
		individualSubscriberCO.getAlrtSubVO().setUSR_ID(null);
	    }
	    

	    /**
	     * if user dependancy call from event then no need to validate from
	     * subscriber
	     */
	    if(IndividualEventConstant.EVENT_MAINT_PROG_REF.equals(get_pageRef())
		    || IndividualEventConstant.EVENT_UPDATE_AFTER_APPROVE_PROG_REF.equals(get_pageRef()))
	    {

		/**
		 * apply display setting 
		 * Prepare hashmap of ids and values
		 */
		IndividualEventCO individualEventCO = new IndividualEventCO();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("imalUserExpression", criteria.getUserID());
		individualEventCO.setScreenDisplaySeting(map);
		setAdditionalScreenParams(individualEventBO.applySysParamSettings(individualEventCO).getElementMap());
	    }
	    
	}
	catch(Exception e)
	{
	    individualSubscriberCO.getAlrtSubVO().setUSR_ID(null);
	    handleException(e, null, null);

	}

	return SUCCESS;
    }

    public String dependencyByAccSl() throws BaseException
    {
	try
	{
	    fillSessionData();
	    BigDecimal slMemo;
	    if(NumberUtil.isEmptyDecimal(individualSubscriberCO.getAlrtSubVO().getSL_NO()))
	    {
		// individualSubscriberCO.getAlrtSubVO().setBRANCH_CODE(null);
		// individualSubscriberCO.getAlrtSubVO().setCURRENCY_CODE(null);
		// individualSubscriberCO.getAlrtSubVO().setCIF_SUB_NO(null);
		// individualSubscriberCO.getAlrtSubVO().setSL_NO(null);
		slMemo = BigDecimal.ZERO;

		individualSubscriberCO.setAddRef(null);
	    }
	    else
	    {
		individualSubscriberCO = individualSubscriberBO.dependencyByAccSl(criteria, individualSubscriberCO);
		slMemo = individualSubscriberCO.getAlrtSubVO().getSL_NO();
		// ll_sl_memo = dw_main.GetItemNumber(1,"sl_no" )
	    }
	    // lstr_acc.l_sl = ll_sl_memo
	    // f_get_memo('ACC',istr_teller,ll_null,lstr_acc)

	     MemoSC memoSC = new MemoSC();
	     memoSC.setCompCode(individualSubscriberCO.getCompCode());
	     memoSC.setForAccOrCif(MemoConstants.ACCOUNTS);
	     memoSC.setAccSL(slMemo);
	    // memoSC.setAppType(MemoConstants.CSM_APP_TYPE);
	     checkForMemo(memoSC);

	}
	catch(Exception e)
	{
	    individualSubscriberCO.getAlrtSubVO().setSL_NO(null);
	    handleException(e, null, null);

	}

	return SUCCESS;
    }

    public String dependencyByAccCif() throws BaseException
    {
	try
	{
	    fillSessionData();

	    if(NumberUtil.isEmptyDecimal(individualSubscriberCO.getAlrtSubVO().getCIF_SUB_NO()))
	    {
		// individualSubscriberCO.getAlrtSubVO().setBRANCH_CODE(null);
		// individualSubscriberCO.getAlrtSubVO().setCURRENCY_CODE(null);
		// individualSubscriberCO.getAlrtSubVO().setCIF_SUB_NO(null);
		// individualSubscriberCO.getAlrtSubVO().setSL_NO(null);
		individualSubscriberCO.getAlrtSubVO().setCIF_SUB_NO(null);
		individualSubscriberCO.getAlrtSubVO().setSL_NO(null);
		individualSubscriberCO.setAddRef(null);
	    }
	    else
	    {
		individualSubscriberCO.getAlrtSubVO().setSL_NO(null);
		individualSubscriberCO.setAddRef(null);
		individualSubscriberCO = individualSubscriberBO.dependencyByAccCif(criteria, individualSubscriberCO);

	    }

	}
	catch(Exception e)
	{
	    individualSubscriberCO.getAlrtSubVO().setCIF_SUB_NO(null);
	    handleException(e, null, null);

	}

	return SUCCESS;
    }

    public String dependencyByAccGl() throws BaseException
    {
	try
	{
	    fillSessionData();

	    if(NumberUtil.isEmptyDecimal(individualSubscriberCO.getAlrtSubVO().getGL_CODE()))
	    {
		// individualSubscriberCO.getAlrtSubVO().setBRANCH_CODE(null);
		// individualSubscriberCO.getAlrtSubVO().setCURRENCY_CODE(null);
		// individualSubscriberCO.getAlrtSubVO().setCIF_SUB_NO(null);
		// individualSubscriberCO.getAlrtSubVO().setSL_NO(null);
		individualSubscriberCO.getAlrtSubVO().setGL_CODE(null);
		individualSubscriberCO.getAlrtSubVO().setCIF_SUB_NO(null);
		individualSubscriberCO.getAlrtSubVO().setSL_NO(null);
		individualSubscriberCO.setAddRef(null);
	    }
	    else
	    {
		individualSubscriberCO.getAlrtSubVO().setCIF_SUB_NO(null);
		individualSubscriberCO.getAlrtSubVO().setSL_NO(null);
		individualSubscriberCO.setAddRef(null);
		individualSubscriberCO = individualSubscriberBO.dependencyByAccGl(criteria, individualSubscriberCO);

	    }

	}
	catch(Exception e)
	{
	    individualSubscriberCO.getAlrtSubVO().setGL_CODE(null);
	    handleException(e, null, null);

	}

	return SUCCESS;
    }

    public String dependencyByAccCy() throws BaseException
    {
	try
	{
	    fillSessionData();

	    if(NumberUtil.isEmptyDecimal(individualSubscriberCO.getAlrtSubVO().getCURRENCY_CODE()))
	    {
		// individualSubscriberCO.getAlrtSubVO().setBRANCH_CODE(null);
		// individualSubscriberCO.getAlrtSubVO().setCURRENCY_CODE(null);
		// individualSubscriberCO.getAlrtSubVO().setCIF_SUB_NO(null);
		// individualSubscriberCO.getAlrtSubVO().setSL_NO(null);
		individualSubscriberCO.getAlrtSubVO().setCURRENCY_CODE(null);
		individualSubscriberCO.getAlrtSubVO().setGL_CODE(null);
		individualSubscriberCO.getAlrtSubVO().setCIF_SUB_NO(null);
		individualSubscriberCO.getAlrtSubVO().setSL_NO(null);
		individualSubscriberCO.setAddRef(null);
	    }
	    else
	    {
		individualSubscriberCO.getAlrtSubVO().setGL_CODE(null);
		individualSubscriberCO.getAlrtSubVO().setCIF_SUB_NO(null);
		individualSubscriberCO.getAlrtSubVO().setSL_NO(null);
		individualSubscriberCO.setAddRef(null);
		individualSubscriberCO = individualSubscriberBO.dependencyByAccCy(criteria, individualSubscriberCO);

	    }

	}
	catch(Exception e)
	{
	    individualSubscriberCO.getAlrtSubVO().setCURRENCY_CODE(null);
	    handleException(e, null, null);

	}

	return SUCCESS;
    }

    public String dependencyByAccBr() throws BaseException
    {
	try
	{
	    fillSessionData();

	    if(NumberUtil.isEmptyDecimal(individualSubscriberCO.getAlrtSubVO().getBRANCH_CODE()))
	    {
		// individualSubscriberCO.getAlrtSubVO().setBRANCH_CODE(null);
		// individualSubscriberCO.getAlrtSubVO().setCURRENCY_CODE(null);
		// individualSubscriberCO.getAlrtSubVO().setCIF_SUB_NO(null);
		// individualSubscriberCO.getAlrtSubVO().setSL_NO(null);
		individualSubscriberCO.getAlrtSubVO().setBRANCH_CODE(null);
		individualSubscriberCO.getAlrtSubVO().setCURRENCY_CODE(null);
		individualSubscriberCO.getAlrtSubVO().setGL_CODE(null);
		individualSubscriberCO.getAlrtSubVO().setCIF_SUB_NO(null);
		individualSubscriberCO.getAlrtSubVO().setSL_NO(null);
		individualSubscriberCO.setAddRef(null);
	    }
	    else
	    {
		individualSubscriberCO.getAlrtSubVO().setCURRENCY_CODE(null);
		individualSubscriberCO.getAlrtSubVO().setGL_CODE(null);
		individualSubscriberCO.getAlrtSubVO().setCIF_SUB_NO(null);
		individualSubscriberCO.getAlrtSubVO().setSL_NO(null);
		individualSubscriberCO.setAddRef(null);

		individualSubscriberCO = individualSubscriberBO.dependencyByAccBr(criteria, individualSubscriberCO);

	    }

	}
	catch(Exception e)
	{
	    individualSubscriberCO.getAlrtSubVO().setBRANCH_CODE(null);
	    handleException(e, null, null);

	}

	return SUCCESS;
    }

    public IndividualSubscriberCO getIndividualSubscriberCO()
    {
	return individualSubscriberCO;
    }

    public void setIndividualSubscriberCO(IndividualSubscriberCO individualSubscriberCO)
    {
	this.individualSubscriberCO = individualSubscriberCO;
    }

    public IndividualSubscriberSC getCriteria()
    {
	return criteria;
    }

    public void setCriteria(IndividualSubscriberSC criteria)
    {
	this.criteria = criteria;
    }

    public void setIndividualSubscriberBO(IndividualSubscriberBO individualSubscriberBO)
    {
	this.individualSubscriberBO = individualSubscriberBO;
    }

    /**
     * @param individualEventBO the individualEventBO to set
     */
    public void setIndividualEventBO(IndividualEventBO individualEventBO)
    {
        this.individualEventBO = individualEventBO;
    }

    @Override
    public Object getModel()
    {
	return criteria;
    }

}
