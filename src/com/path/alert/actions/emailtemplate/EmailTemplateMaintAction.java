package com.path.alert.actions.emailtemplate;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.OutputStreamWriter;
import java.math.BigDecimal;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.emailtemplate.EmailTemplateBO;
import com.path.alert.bo.emailtemplate.EmailTemplateConstant;
import com.path.alert.vo.emailtemplate.EmailTemplateCO;
import com.path.alert.vo.emailtemplate.EmailTemplateSC;
import com.path.bo.common.ConstantsCommon;
import com.path.bo.common.MessageCodes;
import com.path.bo.common.audit.AuditConstant;
import com.path.lib.common.exception.BOException;
import com.path.lib.common.exception.BaseException;
import com.path.lib.common.util.FileUtil;
import com.path.lib.common.util.PathPropertyUtil;
import com.path.struts2.lib.common.base.BaseAction;
import com.path.vo.common.SessionCO;
import com.path.vo.common.audit.AuditRefCO;

/**
 * 
 * Copyright 2013, Path Solutions Path Solutions retains all ownership rights to
 * this source code
 * 
 * EmailTemplateMaintAction.java used to
 */
public class EmailTemplateMaintAction extends BaseAction
{
    private EmailTemplateBO emailTemplateBO;
    private EmailTemplateCO emailtemplateCO = new EmailTemplateCO();
    private File uploadTemplateFile;
    private String uploadTemplateFileFileName, tempIdOldStatus;
    private BigDecimal tempId;

    public String getTempIdOldStatus()
    {
	return tempIdOldStatus;
    }

    public void setTempIdOldStatus(String tempIdOldStatus)
    {
	this.tempIdOldStatus = tempIdOldStatus;
    }

    public BigDecimal getTempId()
    {
	return tempId;
    }

    public void setTempId(BigDecimal tempId)
    {
	this.tempId = tempId;
    }

    public String getUploadTemplateFileFileName()
    {
	return uploadTemplateFileFileName;
    }

    public void setUploadTemplateFileFileName(String uploadTemplateFileFileName)
    {
	this.uploadTemplateFileFileName = uploadTemplateFileFileName;
    }

    public EmailTemplateCO getEmailtemplateCO()
    {
	return emailtemplateCO;
    }

    public void setEmailtemplateCO(EmailTemplateCO emailtemplateCO)
    {
	this.emailtemplateCO = emailtemplateCO;
    }

    public void setEmailTemplateBO(EmailTemplateBO emailTemplateBO)
    {
	this.emailTemplateBO = emailTemplateBO;
    }

    public File getUploadTemplateFile()
    {
	return uploadTemplateFile;
    }

    public void setUploadTemplateFile(File uploadTemplateFile)
    {
	this.uploadTemplateFile = uploadTemplateFile;
    }

    public String loadEmailTemplatePage()
    {
	try
	{
	    set_showSmartInfoBtn("false");
	    set_searchGridId("emailTemplateListGridTbl_Id");
	    emailtemplateCO = new EmailTemplateCO();
	    fillSessionData();
	    if(AlertConstant.CRUD_R.equals(getIv_crud()))
	    {
		set_showNewInfoBtn("true");
	    }
	    if(AlertConstant.CRUD_P.equals(getIv_crud()) || AlertConstant.CRUD_UP.equals(getIv_crud()))
	    {
		set_recReadOnly("true");
	    }
	    emailtemplateCO.setStatusDesc(getText("New_key"));
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	}
	return "emailTemplateList";
    }

    public String saveNew()
    {
	try
	{
	    String encodingType = "";
	    String fileEncoding = ConstantsCommon.FILE_ENCODING;
	    // apply session value
	    fillSessionData();

	    if(uploadTemplateFileFileName != null)
	    {
		byte[] fileBytes = FileUtil.readFileBytes(uploadTemplateFile.getCanonicalPath());
		encodingType = PathPropertyUtil.getPathRemotingProp("PathRemoting", "default.database.encoding");
		if(ConstantsCommon.ENCODING_TYPE_ASCII.equals(encodingType))
		{
		    fileEncoding = ConstantsCommon.FILE_ENCODING_CP1256;
		    ByteArrayOutputStream baos = new ByteArrayOutputStream();
		    OutputStreamWriter writer = new OutputStreamWriter(baos, fileEncoding);
		    writer.append(new String(fileBytes, ConstantsCommon.ENCODING_TYPE_UTF));
		    writer.close();
		    fileBytes = baos.toByteArray();
		}
		emailtemplateCO.getEmailTemplateVO().setTEMPLATE_FILE(fileBytes);
		emailtemplateCO.getEmailTemplateVO().setTEMPLATE_FILE_NAME(uploadTemplateFileFileName);
	    }

	    // AuditRefCO refCO;
	    if(null == emailtemplateCO.getEmailTemplateVO().getSTATUS()
		    || emailtemplateCO.getEmailTemplateVO().getSTATUS().isEmpty())
	    {
		emailtemplateCO.setAuditRefCO(fillSessionVariables(AuditConstant.CREATED));
	    }
	    else
	    {
		emailtemplateCO.setAuditRefCO(fillSessionVariables(AuditConstant.UPDATE));
		emailtemplateCO.setAuditObj(returnAuditObject(emailtemplateCO.getClass()));
	    }
	    // save
	    emailTemplateBO.save(emailtemplateCO);
	    // empty form
	    emailtemplateCO = new EmailTemplateCO();
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	}
	return SUCCESS;
    }

    public String deleteEmailTemplateId()
    {
	try
	{
	    // apply session value
	    fillSessionData();
	    AuditRefCO refCO = fillSessionVariables(AuditConstant.DELETE);
	    emailtemplateCO.setAuditRefCO(refCO);
	    emailTemplateBO.deleteEmailTemplateId(emailtemplateCO);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    public String approveEmailTemplateId()
    {
	try
	{
	    // apply session value
	    fillSessionData();
	    AuditRefCO refCO = fillSessionVariables(AuditConstant.UPDATE);
	    refCO.setTrxNbr(getAuditTrxNbr());
	    emailtemplateCO.setAuditRefCO(refCO);
	    emailTemplateBO.approveEmailTemplateId(emailtemplateCO);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    public String retrieveSelectedTemplateId()
    {
	try
	{
	    EmailTemplateSC emailTemplateSC = new EmailTemplateSC();
	    SessionCO sessionCO = returnSessionObject();
	    emailTemplateSC.setCompCode(sessionCO.getCompanyCode());
	    emailTemplateSC.setBranchCode(sessionCO.getBranchCode());
	    emailTemplateSC.setEmailTemplate(tempId);
	    emailTemplateSC.setLovTypeId(EmailTemplateConstant.LOV_TYPE);
	    emailTemplateSC.setLovLkTypeId(EmailTemplateConstant.LOV_LK_OPT);
	    emailTemplateSC.setCrudMode(getIv_crud());
	    emailTemplateSC.setCurrAppName(sessionCO.getCurrentAppName());
	    emailTemplateSC.setPreferredLanguage(sessionCO.getLanguage());
	    emailTemplateSC.setMenuRef(get_pageRef());
	    emailTemplateSC.setOldStatus(tempIdOldStatus);
	    emailtemplateCO = emailTemplateBO.retrieveSelectedTemplateId(emailTemplateSC);
	    if(!(emailtemplateCO.getEmailTemplateVO().getSTATUS().equals(emailTemplateSC.getOldStatus())))
	    {
		throw new BOException(MessageCodes.RECORD_CHANGED);
	    }
	    if(AlertConstant.CRUD_P.equals(getIv_crud()))
	    {
		set_recReadOnly(ConstantsCommon.TRUE);
	    }
	    else if(AlertConstant.CRUD_UP.equals(getIv_crud()))
	    {
		set_recReadOnly(ConstantsCommon.FALSE);
	    }
	    else if(AlertConstant.STATUS_NEW.equals(emailtemplateCO.getEmailTemplateVO().getSTATUS()))
	    {
		set_recReadOnly(ConstantsCommon.FALSE);
	    }
	    else
	    {
		set_recReadOnly(ConstantsCommon.TRUE);
	    }
	    applyRetrieveAudit(AuditConstant.ALERT_EMAIL_TEMPLATE_KEY_REF, emailtemplateCO.getEmailTemplateVO(),
		    emailtemplateCO);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	    return ERROR;
	}
	return "emailTemplateMaint";
    }

    public String clearStpForm()
    {
	{
	    try
	    {
		emailtemplateCO = new EmailTemplateCO();
		if(AlertConstant.CRUD_UP.equals(getIv_crud()) || AlertConstant.STATUS_APPROVED.equals(getIv_crud()))
		{
		    set_recReadOnly("true");
		}
		else
		{
		    set_recReadOnly("false");
		}
		emailtemplateCO.getEmailTemplateVO().setSTATUS(null);
		emailtemplateCO.setStatusDesc(getText("New_key"));
	    }
	    catch(Exception e)
	    {
		log.error(e, "");
	    }
	    return "emailTemplateMaint";
	}
    }

    public void fillSessionData() throws BaseException
    {
	SessionCO sessionCO = returnSessionObject();
	emailtemplateCO.setCompCode(sessionCO.getCompanyCode());
	emailtemplateCO.setBranchCode(sessionCO.getBranchCode());
	emailtemplateCO.setAppName(sessionCO.getCurrentAppName());
	emailtemplateCO.setProgRef(get_pageRef());
	emailtemplateCO.setUserID(sessionCO.getUserName());
	emailtemplateCO.setRunningDate(returnCommonLibBO().addSystemTimeToDate(sessionCO.getRunningDateRET()));
	emailtemplateCO.setIvCrud(getIv_crud());
	emailtemplateCO.setLanguage(sessionCO.getLanguage());
	emailtemplateCO.setUserID(sessionCO.getUserName());
    }

    private AuditRefCO fillSessionVariables(String status)
    {

	AuditRefCO refCO = initAuditRefCO();
	try
	{
	    refCO.setOperationType(status);
	    refCO.setKeyRef(AuditConstant.ALERT_EMAIL_TEMPLATE_KEY_REF);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return refCO;
    }
}
