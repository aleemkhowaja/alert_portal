package com.path.alert.actions.dependencies.branches;

import java.math.BigDecimal;
import java.util.HashMap;

import com.path.alert.bo.branches.BranchesBO;
import com.path.alert.bo.events.event.IndividualEventBO;
import com.path.alert.vo.branch.BranchCO;
import com.path.alert.vo.branch.BranchSC;
import com.path.alert.vo.events.event.IndividualEventCO;
import com.path.bo.common.MessageCodes;
import com.path.dbmaps.vo.SYS_PARAM_SCREEN_DISPLAYVO;
import com.path.lib.common.exception.BOException;
import com.path.lib.common.exception.BaseException;
import com.path.lib.common.util.NumberUtil;
import com.path.struts2.lib.common.base.BaseAction;

/**
 * 
 * Copyright 2020, Path Solutions
 * Path Solutions retains all ownership rights to this source code 
 * 
 * @author: Alim Khowaja
 *
 * BranchesDependencyAction.java used to
 */
public class BranchesDependencyAction extends BaseAction
{
    private String userId;
    private BigDecimal compCode;
    private BigDecimal branchCode;
    private BranchCO branchCO = new BranchCO();
    private BranchesBO branchesBO;
    private IndividualEventBO individualEventBO;
    

    /**
     * Get dependency between Branch Code and Description
     * 
     * @return
     */
    public String dependencyByBranchCode()
    {
	try
	{
	    BranchSC branchesSC = new BranchSC();

	    if(NumberUtil.isEmptyDecimal(branchCode))
	    {
		branchCO = new BranchCO();
		branchCode = null;
	    }
	    else
	    {
		branchesSC.setBranchCode(branchCode);
		/**
		 * If the company code was not sent to this method, then take it
		 * from the session
		 */
		if(NumberUtil.isEmptyDecimal(compCode))
		    throw new BOException(MessageCodes.INVALID_MISSING_COMPANY_CODE);

		    
		branchesSC.setCompCode(compCode);
		branchCO = branchesBO.returnBranchDetailsByCode(branchesSC);
		
		/**
		 * the below was added by Assets Team to return empty in case we
		 * empty the branch
		 */
		if(branchCO == null || NumberUtil.isEmptyDecimal(branchCO.getBranchCode()))
		{
		    branchCO = new BranchCO();
		    branchCode = null;
		}
	    }
	    /**
	     * apply display setting Prepare hashmap of ids and values
	     */
	    IndividualEventCO individualEventCO = new IndividualEventCO();
	    HashMap<String, Object> map = new HashMap<String, Object>();
	    map.put("branchExpression",  NumberUtil.emptyDecimalToNull(branchCode));
	    individualEventCO.setScreenDisplaySeting(map);
	    setAdditionalScreenParams(individualEventBO.applySysParamSettings(individualEventCO).getElementMap());
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    
    /**
     * @return the branchCO
     */
    public BranchCO getBranchCO()
    {
        return branchCO;
    }

    /**
     * @param branchCO the branchCO to set
     */
    public void setBranchCO(BranchCO branchCO)
    {
        this.branchCO = branchCO;
    }

    /**
     * @param branchesBO the branchesBO to set
     */
    public void setBranchesBO(BranchesBO branchesBO)
    {
        this.branchesBO = branchesBO;
    }
    
    /**
     * @return the userId
     */
    public String getUserId()
    {
        return userId;
    }

    /**
     * @param userId the userId to set
     */
    public void setUserId(String userId)
    {
        this.userId = userId;
    }

    /**
     *
     * @return the compCode
     */
    public BigDecimal getCompCode()
    {
        return compCode;
    }

    /**
     * @return the branchCode
     */
    public BigDecimal getBranchCode()
    {
        return branchCode;
    }

    /**
     * @param compCode the compCode to set
     */
    public void setCompCode(BigDecimal compCode)
    {
        this.compCode = compCode;
    }

    /**
     * @param branchCode the branchCode to set
     */
    public void setBranchCode(BigDecimal branchCode)
    {
        this.branchCode = branchCode;
    }

    /**
     * @param individualEventBO the individualEventBO to set
     */
    public void setIndividualEventBO(IndividualEventBO individualEventBO)
    {
        this.individualEventBO = individualEventBO;
    }
}
