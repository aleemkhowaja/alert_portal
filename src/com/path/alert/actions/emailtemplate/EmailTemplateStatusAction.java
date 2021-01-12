package com.path.alert.actions.emailtemplate;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;

import com.path.alert.bo.emailtemplate.EmailTemplateConstant;
import com.path.alert.vo.emailtemplate.EmailTemplateSC;
import com.path.bo.common.ConstantsCommon;
import com.path.dbmaps.vo.ALRT_EMAIL_TEMPLATEVOWithBLOBs;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;
import com.path.vo.common.select.SelectSC;
import com.path.vo.common.status.StatusAddFieldCO;
import com.path.vo.common.status.StatusCO;

/**
 * 
 * Copyright 2013, Path Solutions Path Solutions retains all ownership rights to
 * this source code
 * 
 * ReportQueryStatusAction.java used to generate Status common Popup for
 * ReportQuery
 */
public class EmailTemplateStatusAction extends GridBaseAction
{
    private EmailTemplateSC criteria = new EmailTemplateSC();
    private String url;
    private List<StatusAddFieldCO> addFields;

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

    public String getUrl()
    {
	return url;
    }

    public void setUrl(String url)
    {
	this.url = url;
    }

    public List<StatusAddFieldCO> getAddFields()
    {
	return addFields;
    }

    public void setAddFields(List<StatusAddFieldCO> addFields)
    {
	this.addFields = addFields;
    }

    public String search()
    {
	try
	{
	    ServletContext application = ServletActionContext.getServletContext();
	    String theRealPath = application.getContextPath();
	    // TODO add you criteria parameters to the URL
	    url = theRealPath + "/path/emailTemplate/EmailTemplateStatusAction_loadStatusGrid.action?emailTemplate="
		    + criteria.getEmailTemplate();
	    addFields = new ArrayList<StatusAddFieldCO>();
	    StatusAddFieldCO newFld = new StatusAddFieldCO(ConstantsCommon.COLUMN_DATE_TYPE, "server_date");
	    addFields.add(newFld);
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	    return ERROR_ACTION;
	}
	return "SUCCESS_STATUS";
    }

    public String loadStatusGrid()
    {
	String[] searchCol = { "userName", "status_desc", "status_date", "server_date" };

	List<StatusCO> resultList;
	List<String> colList;
	ALRT_EMAIL_TEMPLATEVOWithBLOBs email_templateVO = new ALRT_EMAIL_TEMPLATEVOWithBLOBs();
	try
	{
	    SessionCO sessionCO = returnSessionObject();
	    criteria.setSearchCols(searchCol);
	    copyproperties(criteria);

	    // TODO set vo correct properties
	    // report_queryVO.setCOMP_CODE(sessionCO.getCompanyCode());

	    colList = EmailTemplateConstant.emailTemplateStatusLst;
	    SelectSC lovCriteria = new SelectSC();
	    lovCriteria.setLanguage(sessionCO.getLanguage());
	    lovCriteria.setLovTypeId(EmailTemplateConstant.LOV_TYPE);
	    lovCriteria.setCompCode(sessionCO.getCompanyCode());

	    email_templateVO.setTEMPLATE_ID(criteria.getEmailTemplate());

	    resultList = returnCommonLibBO().generateStatusList(email_templateVO, colList, lovCriteria);
	    setGridModel(resultList);
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	}
	return SUCCESS;
    }
}
