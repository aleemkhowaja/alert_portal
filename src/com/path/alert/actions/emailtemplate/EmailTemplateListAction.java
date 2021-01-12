package com.path.alert.actions.emailtemplate;

import java.util.List;

import com.path.alert.bo.emailtemplate.EmailTemplateBO;
import com.path.alert.bo.emailtemplate.EmailTemplateConstant;
import com.path.alert.vo.emailtemplate.EmailTemplateCO;
import com.path.alert.vo.emailtemplate.EmailTemplateSC;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;

/**
 * 
 * Copyright 2013, Path Solutions Path Solutions retains all ownership rights to
 * this source code
 * 
 * EmailTemplateListAction.java used to
 */
public class EmailTemplateListAction extends GridBaseAction
{
    private EmailTemplateBO emailTemplateBO;
    private EmailTemplateSC criteria = new EmailTemplateSC();

    public String loadEmailTemplateGrid()
    {
	try
	{
	    SessionCO sessionCO = returnSessionObject();

	    copyproperties(criteria);
	    criteria.setCompCode(sessionCO.getCompanyCode());
	    criteria.setLovTypeId(EmailTemplateConstant.LOV_TYPE);
	    criteria.setLovLkTypeId(EmailTemplateConstant.LOV_LK_OPT);
	    criteria.setCurrAppName(sessionCO.getCurrentAppName());
	    criteria.setPreferredLanguage(sessionCO.getLanguage());
	    criteria.setMenuRef(get_pageRef());
	    criteria.setCrudMode(getIv_crud());
	    int emailTemplateCnt = emailTemplateBO.returnEmailTemplateListCount(criteria);
	    setRecords(emailTemplateCnt);
	    List<EmailTemplateCO> emailTemplateList = emailTemplateBO.returnEmailTemplateList(criteria);
	    setGridModel(emailTemplateList);
	}
	catch(Exception e)
	{
	    log.error(e, "Error in loadEmailTemplateGrid of EmailTemplateListAction");
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    public Object getModel()
    {
	return criteria;
    }

    public EmailTemplateSC getCriteria()
    {
	return criteria;
    }

    public void setCriteria(EmailTemplateSC criteria)
    {
	this.criteria = criteria;
    }

    public void setEmailTemplateBO(EmailTemplateBO emailTemplateBO)
    {
	this.emailTemplateBO = emailTemplateBO;
    }
}
