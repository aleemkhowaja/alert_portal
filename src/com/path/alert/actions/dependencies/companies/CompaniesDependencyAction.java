package com.path.alert.actions.dependencies.companies;

import java.math.BigDecimal;
import java.util.HashMap;

import com.path.alert.bo.companies.CompaniesBO;
import com.path.alert.bo.events.event.IndividualEventBO;
import com.path.alert.vo.events.event.IndividualEventCO;
import com.path.dbmaps.vo.COMPANIESVO;
import com.path.dbmaps.vo.SYS_PARAM_SCREEN_DISPLAYVO;
import com.path.lib.common.exception.BaseException;
import com.path.lib.common.util.NumberUtil;
import com.path.lib.common.util.StringUtil;
import com.path.struts2.lib.common.base.BaseAction;
import com.path.vo.admin.companies.CompaniesSC;
import com.path.vo.common.SessionCO;

/**
 * 
 * Copyright 2020, Path Solutions
 * Path Solutions retains all ownership rights to this source code 
 * 
 * @author: Alim Khowaja
 *
 * CompaniesDependencyAction.java used to
 */
public class CompaniesDependencyAction extends BaseAction
{

    private CompaniesBO companiesBO;
    private IndividualEventBO individualEventBO;
    
    private String userId;
    private BigDecimal compCode;
    private COMPANIESVO companiesVO = new COMPANIESVO();
   

   /**
    * dependency of companies by company code
    * @return
    */
    public String dependencyByCompanyCode()
    {
	try
	{
	    CompaniesSC companiesSC = new CompaniesSC();
	    companiesSC.setCompCode(compCode);
	    /**
	     * return company details by id
	     */
	    companiesVO = companiesBO.returnCompanyDetails(companiesSC);

	    /**
	     * apply display setting 
	     * Prepare hashmap of ids and values
	     */
	    IndividualEventCO individualEventCO = new IndividualEventCO();
	    HashMap<String, Object> map = new HashMap<String, Object>();
	    map.put("companyExpression", NumberUtil.emptyDecimalToNull(compCode));
	    map.put("branchExpression", null);
	    individualEventCO.setScreenDisplaySeting(map);
	    setAdditionalScreenParams(individualEventBO.applySysParamSettings(individualEventCO).getElementMap());
	}
	catch(BaseException e)
	{
	    e.printStackTrace();
	}
	return SUCCESS;

    }


    /**
     * @return the cOMP_CODE
     */
    public BigDecimal getCompCode()
    {
	return compCode;
    }

    /**
     * @return the companiesVO
     */
    public COMPANIESVO getCompaniesVO()
    {
	return companiesVO;
    }

    /**
     * @param companiesBO the companiesBO to set
     */
    public void setCompaniesBO(CompaniesBO companiesBO)
    {
	this.companiesBO = companiesBO;
    }

    /**
     * @param compCode the compCode to set
     */
    public void setCompCode(BigDecimal compCode)
    {
	this.compCode = compCode;
    }

    /**
     * @param companiesVO the companiesVO to set
     */
    public void setCompaniesVO(COMPANIESVO companiesVO)
    {
	this.companiesVO = companiesVO;
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
     * @param individualEventBO the individualEventBO to set
     */
    public void setIndividualEventBO(IndividualEventBO individualEventBO)
    {
        this.individualEventBO = individualEventBO;
    }
    
    
}