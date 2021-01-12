package com.path.alert.actions.reportquery;

import java.util.List;

import com.path.alert.bo.reportquery.ReportQueryBO;
import com.path.alert.bo.reportquery.ReportQueryConstant;
import com.path.alert.vo.reportquery.ReportQueryCO;
import com.path.alert.vo.reportquery.ReportQuerySC;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;

/**
 * 
 * Copyright 2013, Path Solutions Path Solutions retains all ownership rights to
 * this source code
 * 
 * ReportQueryListAction.java used to
 */
public class ReportQueryListAction extends GridBaseAction
{
    private ReportQueryBO reportQueryBO;
    private ReportQuerySC criteria = new ReportQuerySC();

    public String loadReportQueryGrid()
    {
	try
	{
	    SessionCO sessionCO = returnSessionObject();
	    
	    copyproperties(criteria);
	    criteria.setCompCode(sessionCO.getCompanyCode());
	    criteria.setLovTypeId(ReportQueryConstant.LOV_TYPE);
	    criteria.setLovTypeSubsc(ReportQueryConstant.LOV_TYPE_DESC);
	    criteria.setCurrAppName(sessionCO.getCurrentAppName());
	    criteria.setPreferredLanguage(sessionCO.getLanguage());
	    criteria.setMenuRef(get_pageRef());
	    criteria.setCrudMode(getIv_crud());
	    int reportQueryCnt = reportQueryBO.returnReportQueryListCount(criteria);
	    setRecords(reportQueryCnt);
	    List<ReportQueryCO> reportQueryList = reportQueryBO.returnReportQueryList(criteria);
 	    setGridModel(reportQueryList);
	}
	catch(Exception e)
	{
	    log.error(e, "Error in loadReportQueryGrid of ReportQueryListAction");
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    public Object getModel()
    {
	return criteria;
    }

    public ReportQuerySC getCriteria()
    {
	return criteria;
    }

    public void setCriteria(ReportQuerySC criteria)
    {
	this.criteria = criteria;
    }

    public void setReportQueryBO(ReportQueryBO reportQueryBO)
    {
	this.reportQueryBO = reportQueryBO;
    }
}
