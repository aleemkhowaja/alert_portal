package com.path.alert.actions.reportquery;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.reportquery.ReportQueryBO;
import com.path.alert.bo.reportquery.ReportQueryConstant;
import com.path.alert.vo.reportquery.ReportQueryCO;
import com.path.alert.vo.reportquery.ReportQuerySC;
import com.path.bo.common.ConstantsCommon;
import com.path.bo.common.MessageCodes;
import com.path.bo.common.audit.AuditConstant;
import com.path.lib.common.exception.BOException;
import com.path.lib.common.exception.BaseException;
import com.path.lib.common.util.FileUtil;
import com.path.lib.vo.GridUpdates;
import com.path.struts2.lib.common.base.BaseAction;
import com.path.vo.common.SessionCO;
import com.path.vo.common.audit.AuditRefCO;
import com.path.vo.common.select.SelectCO;
import com.path.vo.common.select.SelectSC;

/**
 * 
 * Copyright 2013, Path Solutions Path Solutions retains all ownership rights to
 * this source code
 * 
 * ReportQueryMaintAction.java used to
 */
public class ReportQueryMaintAction extends BaseAction
{

    private ReportQueryBO reportQueryBO;
    private ReportQueryCO reportQueryCO;
    ReportQuerySC reportQuerySC = new ReportQuerySC();
    private BigDecimal queryId;
    private BigDecimal repQueryId;
    private String queryIdOldStatus;
    private String subscType;
    private String updates;
    private List<SelectCO> subscriptiontypelist;
    private List<SelectCO> typeList;

    public void setReportQueryBO(ReportQueryBO reportQueryBO)
    {
	this.reportQueryBO = reportQueryBO;
    }

    public ReportQueryBO getReportQueryBO()
    {
	return reportQueryBO;
    }

    public ReportQueryCO getReportQueryCO()
    {
	return reportQueryCO;
    }

    public void setReportQueryCO(ReportQueryCO reportQueryCO)
    {
	this.reportQueryCO = reportQueryCO;
    }

    public Object getModel()
    {
	return reportQuerySC;
    }

    public BigDecimal getQueryId()
    {
	return queryId;
    }

    public void setQueryId(BigDecimal queryId)
    {
	this.queryId = queryId;
    }

    public String getQueryIdOldStatus()
    {
	return queryIdOldStatus;
    }

    public void setQueryIdOldStatus(String queryIdOldStatus)
    {
	this.queryIdOldStatus = queryIdOldStatus;
    }

    public List<SelectCO> getSubscriptiontypelist()
    {
	return subscriptiontypelist;
    }

    public void setSubscriptiontypelist(List<SelectCO> subscriptiontypelist)
    {
	this.subscriptiontypelist = subscriptiontypelist;
    }

    public List<SelectCO> getTypeList()
    {
	return typeList;
    }

    public void setTypeList(List<SelectCO> typeList)
    {
	this.typeList = typeList;
    }

    public String getSubscType()
    {
	return subscType;
    }

    public void setSubscType(String subscType)
    {
	this.subscType = subscType;
    }
    
    public String getUpdates()
    {
        return updates;
    }

    public void setUpdates(String updates)
    {
        this.updates = updates;
    }

    public BigDecimal getRepQueryId()
    {
        return repQueryId;
    }

    public void setRepQueryId(BigDecimal repQueryId)
    {
        this.repQueryId = repQueryId;
    }

    private void initList() throws BaseException
    {
	SelectSC selSC = new SelectSC(AlertConstant.subscriberTypeDropDown);

	StringBuffer excludeOthers = new StringBuffer("'").append(AlertConstant.TYPE_O).append("'");
	selSC.setLovCodesExclude(excludeOthers.toString());

	subscriptiontypelist = returnLOV(selSC);
    }

    public String initTypeList() throws BaseException
    {
		try
		{
		    SelectSC selSC = new SelectSC(AlertConstant.REPORT_QUERY_LOV);
		    typeList = new ArrayList<SelectCO>();
		    typeList = returnLOV(selSC);
		    typeList.add(0,new SelectCO("-1", ""));
		}
	catch(Exception e)
	{
	    e.printStackTrace();
	}
		return SUCCESS;
    }

    public String loadReportQueryPage()
    {
	try
	{
	    set_showSmartInfoBtn("false");
	    set_searchGridId("reportQueryListGridTbl_Id");
	    reportQueryCO = new ReportQueryCO();
	    fillSessionData();
	    initList();
	    if(AlertConstant.CRUD_R.equals(getIv_crud()))
	    {
		set_showNewInfoBtn("true");
	    }
	    if(AlertConstant.CRUD_P.equals(getIv_crud()) || AlertConstant.CRUD_F.equals(getIv_crud()))
	    {
		set_recReadOnly("true");
	    }
	    reportQueryCO.setStatusDesc(getText("New_key"));
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	}
	return "reportQueryList";
    }

    public String retrieveSelectedQueryId()
    {
	try
	{
	    initList();
	    ReportQuerySC reportQuerySC = new ReportQuerySC();
	    SessionCO sessionCO = returnSessionObject();
	    reportQuerySC.setCompCode(sessionCO.getCompanyCode());
	    reportQuerySC.setBranchCode(sessionCO.getBranchCode());
	    reportQuerySC.setQueryID(queryId);
	    reportQuerySC.setRepQueryID(repQueryId);
	    reportQuerySC.setLovTypeId(ReportQueryConstant.LOV_TYPE);
	    reportQuerySC.setCrudMode(getIv_crud());
	    reportQuerySC.setCurrAppName(sessionCO.getCurrentAppName());
	    reportQuerySC.setPreferredLanguage(sessionCO.getLanguage());
	    reportQuerySC.setMenuRef(get_pageRef());
	    reportQuerySC.setOldStatus(queryIdOldStatus);
	    reportQueryCO = reportQueryBO.retrieveSelecetdQueryId(reportQuerySC);
	    if(!(reportQueryCO.getReportQueryVO().getSTATUS().equals(reportQuerySC.getOldStatus())))
	    {
		throw new BOException(MessageCodes.RECORD_CHANGED);
	    }
	    if(AlertConstant.CRUD_P.equals(getIv_crud()))
	    {
		set_recReadOnly(ConstantsCommon.TRUE);
	    }
	    else if(AlertConstant.CRUD_F.equals(getIv_crud()))
	    {
		set_recReadOnly(ConstantsCommon.FALSE);
	    }
	    else if(AlertConstant.STATUS_NEW.equals(reportQueryCO.getReportQueryVO().getSTATUS()))
	    {
		set_recReadOnly(ConstantsCommon.FALSE);
	    }
	    else
	    {
		set_recReadOnly(ConstantsCommon.TRUE);
	    }
	    applyRetrieveAudit(AuditConstant.REPORT_QUERY_KEY_REF, reportQueryCO.getReportQueryVO(),
		    reportQueryCO);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	    return ERROR;
	}
	return "reportQueryMaint";
    }

    public String clearStpForm()
    {
	{
	    try
	    {
		initList();
		reportQueryCO = new ReportQueryCO();
		if(AlertConstant.CRUD_F.equals(getIv_crud()) || AlertConstant.STATUS_APPROVED.equals(getIv_crud()))
		{
		    set_recReadOnly("true");
		}
		else
		{
		    set_recReadOnly("false");
		}
		reportQueryCO.getReportQueryVO().setSTATUS(null);
		reportQueryCO.setStatusDesc(getText("New_key"));
	    }
	    catch(Exception e)
	    {
		log.error(e, "");
	    }
	    return "reportQueryMaint";
	}
    }
    
    public String saveNew()
    {
	try
	{
	    // apply session value
	    fillSessionData();

	    // AuditRefCO refCO;
	    if(null == reportQueryCO.getReportQueryVO().getSTATUS() || reportQueryCO.getReportQueryVO().getSTATUS().isEmpty())
	    {
		reportQueryCO.setAuditRefCO(fillSessionVariables(AuditConstant.CREATED));
	    }
	    else
	    {
		reportQueryCO.setAuditRefCO(fillSessionVariables(AuditConstant.UPDATE));
		reportQueryCO.setAuditObj(returnAuditObject(reportQueryCO.getClass()));
	    }
	    if(updates.lastIndexOf("-1") != -1)
	    {
		throw new BOException(MessageCodes.PLEASE_FILL_REQUIRED_FIELDS_VAL);
	    }
	    
	    ArrayList lstMod = new ArrayList();
	    if(updates != null && !updates.equals(""))
	    {
		GridUpdates gu = getGridUpdates(updates, ReportQueryCO.class, true);
		lstMod = gu.getLstAllRec();
		// changing the created_by for modified records
		Iterator itt = lstMod.iterator();
		while(itt.hasNext())
		{
		    ((ReportQueryCO) itt.next()).getReportQueryVO().setCREATED_BY(reportQueryCO.getUserID());
		}
	    }
	    // save
	    reportQueryBO.save(reportQueryCO,lstMod);
	    // empty form
	    reportQueryCO = new ReportQueryCO();
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }
    
    public String approve()
    {
	try
	{
	    // apply session value
	    fillSessionData();
	    AuditRefCO refCO = fillSessionVariables(AuditConstant.UPDATE);
	    refCO.setTrxNbr(getAuditTrxNbr());
	    reportQueryCO.setAuditRefCO(refCO);
	    reportQueryBO.approve(reportQueryCO);

	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }
    
    public String deleteReportQueryId()
    {
	try
	{
	    // apply session value
	    fillSessionData();
	    AuditRefCO refCO = fillSessionVariables(AuditConstant.DELETE);
	    reportQueryCO.setAuditRefCO(refCO);
	    reportQueryBO.deleteReportQueryId(reportQueryCO);
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
    private AuditRefCO fillSessionVariables(String status)
    {

	AuditRefCO refCO = initAuditRefCO();
	try
	{
	    refCO.setOperationType(status);
	    refCO.setKeyRef(AuditConstant.REPORT_QUERY_KEY_REF);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return refCO;
    }
    
    public String openDetails()throws Exception
    {
    		if(reportQueryCO !=null)
    		{
    			reportQueryCO.setQuerySyntax(new String(reportQueryCO.getQuerySyntax().getBytes(),FileUtil.DEFAULT_FILE_ENCODING));
    		}
            return "reportQueryDetailPopup";
    }

    /**
     * function that fill the needed data from the session .
     * 
     * @throws BaseException
     */
    public void fillSessionData() throws BaseException
    {
	SessionCO sessionCO = returnSessionObject();
	reportQueryCO.setCompCode(sessionCO.getCompanyCode());
	reportQueryCO.setBranchCode(sessionCO.getBranchCode());
	reportQueryCO.setAppName(sessionCO.getCurrentAppName());
	reportQueryCO.setProgRef(get_pageRef());
	reportQueryCO.setUserID(sessionCO.getUserName());
	reportQueryCO.setRunningDate(returnCommonLibBO().addSystemTimeToDate(sessionCO.getRunningDateRET()));
	reportQueryCO.setIvCrud(getIv_crud());
	reportQueryCO.setLanguage(sessionCO.getLanguage());
	reportQueryCO.setUserID(sessionCO.getUserName());
    }
}
