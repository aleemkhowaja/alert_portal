package com.path.alert.actions.statusmngmnt;

import java.util.HashMap;

import com.path.alert.bo.statusmngmnt.StatusMngmntBO;
import com.path.alert.vo.statusmngmnt.StatusMngmntSC;
import com.path.struts2.lib.common.base.GridBaseAction;

/**
 * 
 * Copyright 2013, Path Solutions Path Solutions retains all ownership rights to
 * this source code
 * 
 * StatusMngmntListAction.java used to
 */
public class StatusMngmntListAction extends GridBaseAction
{
    private StatusMngmntBO statusMngmntBO;
    private StatusMngmntSC criteria = new StatusMngmntSC();

    public String LoadFilterGrid()
    {
	// if(criteria.getRelType().equals("A"))
	// {
	// return "statusmanagemnt";
	// }
	// else if(criteria.getRelType().equals("SP"))
	// {
	//
	// return "subscriberpackage";
	// }
	// else if(criteria.getRelType().equals("GP"))
	// {
	// return "grouppackage";
	// }
	// else if(criteria.getRelType().equals("EG"))
	//
	// {
	// return "groupevent";
	// }
	// else if(criteria.getRelType().equals("SE"))
	// {
	// return "subscriberevent";
	// }
	return "loadGridpage";

    }

    public String loadStatusMngmntGrid()
    {
	try
	{

	    String[] searchCol = { "alrt_subvo.ID", "alrt_evtvo.EVT_ID", "alrt_sub_evtvo.ID", "alrt_sub_evtvo.SUB_ID",
		    "alrt_evtvo.DESC_ENG", "alrtSubEvtRelTypeDesc", "alrt_sub_evtvo.REL_TYPE", "alrt_subvo.CIF_NO",
		    "alrt_subvo.USR_ID", "alrt_subvo.BRANCH_CODE", "alrt_subvo.COMP_CODE", "alrt_subvo.CURRENCY_CODE",
		    "alrt_subvo.GL_CODE", "alrt_subvo.CIF_SUB_NO", "alrt_subvo.SL_NO", "statusmodeTypeDesc",
		    "alrtSubTypeDesc", "alrtEvtTypeDesc", "alrtevtModeTypeDesc", "SUB_DESCRIPTION", "SUB_LASTNAME",
		    "alrt_sub_evtvo.SUSPENDED_BY" };

	    HashMap<String, String> hmDate = new HashMap<>();
	    hmDate.put("alrt_sub_evtvo.DATE_SUSPENDED", "alrt_sub_evtvo.DATE_SUSPENDED");	    
	    criteria.setSearchCols(searchCol);

	    criteria.setDateSearchCols(hmDate);
	    copyproperties(criteria);
	    if(checkNbRec(criteria))
	    {
		setRecords(statusMngmntBO.returnStatusMngmntListCount(criteria));
	    }
	    setGridModel(statusMngmntBO.returnStatusMngmntList(criteria));
	}
	catch(Exception e)
	{
	    log.error(e, "Error in loadStatusMngmntGrid of StatusMngmntListAction");
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    public String loadSubscriberPackageGrid()
    {

	try
	{

	    String[] searchCol = { "alertSubPkgVO.STATUS", "alertSubPkgVO.LINE_NO", "alertSubPkgVO.SUB_ID",
		    " alrt_subvo.SUB_TYPE", "alertSubPkgVO.PKG_ID", "alert_pkgVO.BRIEF_DESC_ENG", "subDescription",
		    "sublastname", "alrtSubTypeDesc", "statusmodeTypeDesc" };

	    HashMap<String, String> hmDate = new HashMap<>();
	    hmDate.put("alrt_sub_evtvo.DATE_SUSPENDED", "alrt_sub_evtvo.DATE_SUSPENDED");	    
	    criteria.setSearchCols(searchCol);

	    criteria.setDateSearchCols(hmDate);
	    copyproperties(criteria);
	    if(checkNbRec(criteria))
	    {
		setRecords(statusMngmntBO.returnSubscriberPackageListCount(criteria));
	    }
	    setGridModel(statusMngmntBO.returnSubscriberPackageList(criteria));
	}
	catch(Exception e)
	{
	    log.error(e, "Error in loadStatusMngmntGrid of StatusMngmntListAction");
	    handleException(e, null, null);
	}

	return SUCCESS;

    }

    public String loadGroupPackageGrid()
    {
	try
	{

	    String[] searchCol = { "statusmodeTypeDesc", "alertGrpPkgVO.LINE_NO", "alertGrpPkgVO.GRP_ID",
		    "alertGrpVO.BRIEF_DESC_ENG", " alertGrpPkgVO.PKG_ID", "alertGrpVO.GRP_ID",
		    "alert_pkgVO.BRIEF_DESC_ENG", "alert_pkgVO.PKG_ID" };

	    HashMap<String, String> hmDate = new HashMap<>();
	    hmDate.put("alrt_sub_evtvo.DATE_SUSPENDED", "alrt_sub_evtvo.DATE_SUSPENDED");	    
	    criteria.setSearchCols(searchCol);

	    criteria.setDateSearchCols(hmDate);
	    copyproperties(criteria);
	    if(checkNbRec(criteria))
	    {
		setRecords(statusMngmntBO.returnGroupPackageListCount(criteria));
	    }
	    setGridModel(statusMngmntBO.returnGroupPackageList(criteria));
	}
	catch(Exception e)
	{
	    log.error(e, "Error in loadStatusMngmntGrid of StatusMngmntListAction");
	    handleException(e, null, null);
	}

	return SUCCESS;

    }

    public String loadsubscribereventGrid()
    {

	try
	{

	    String[] searchCol = { "alrt_subvo.ID", "alrt_evtvo.EVT_ID", "alrt_sub_evtvo.ID", "alrt_sub_evtvo.SUB_ID",
		    "alrt_evtvo.DESC_ENG", "alrtSubEvtRelTypeDesc", "alrt_sub_evtvo.REL_TYPE", "alrt_subvo.CIF_NO",
		    "alrt_subvo.USR_ID", "alrt_subvo.BRANCH_CODE", "alrt_subvo.COMP_CODE", "alrt_subvo.CURRENCY_CODE",
		    "alrt_subvo.GL_CODE", "alrt_subvo.CIF_SUB_NO", "alrt_subvo.SL_NO", "statusmodeTypeDesc",
		    "alrtSubTypeDesc", "alrtEvtTypeDesc", "alrtevtModeTypeDesc", "SUB_DESCRIPTION", "SUB_LASTNAME",
		    "alrt_sub_evtvo.SUSPENDED_BY" };

	    HashMap<String, String> hmDate = new HashMap<>();
	    hmDate.put("alrt_sub_evtvo.DATE_SUSPENDED", "alrt_sub_evtvo.DATE_SUSPENDED");
	    criteria.setSearchCols(searchCol);

	    criteria.setDateSearchCols(hmDate);
	    copyproperties(criteria);
	    if(checkNbRec(criteria))
	    {
		setRecords(statusMngmntBO.returnsubScriberEventCount(criteria));
	    }
	    setGridModel(statusMngmntBO.returnSubscriberEventList(criteria));
	}
	catch(Exception e)
	{
	    log.error(e, "Error in loadStatusMngmntGrid of StatusMngmntListAction");
	    handleException(e, null, null);
	}

	return SUCCESS;

    }

    public String loadGroupEvtGrid()
    {
	try
	{

	    String[] searchCol = { "statusmodeTypeDesc", "alertEvtGrpVO.LINE_NO", "alertGrpVO.GRP_ID",
		    "alertGrpVO.BRIEF_DESC_ENG", "alrt_evtvo.EVT_ID", "alrtEvtTypeDesc", "statusmodeTypeDesc",
		    "alrtevtModeTypeDesc", "alrt_evtvo.DESC_ENG" };

	    HashMap<String, String> hmDate = new HashMap<>();
	    hmDate.put("alrt_sub_evtvo.DATE_SUSPENDED", "alrt_sub_evtvo.DATE_SUSPENDED");
	    criteria.setSearchCols(searchCol);

	    criteria.setDateSearchCols(hmDate);
	    copyproperties(criteria);
	    if(checkNbRec(criteria))
	    {
		setRecords(statusMngmntBO.returnGroupEventListCount(criteria));
	    }
	    setGridModel(statusMngmntBO.returnGroupEventList(criteria));
	}
	catch(Exception e)
	{
	    log.error(e, "Error in loadStatusMngmntGrid of StatusMngmntListAction");
	    handleException(e, null, null);
	}

	return SUCCESS;
    }

    @Override
    public Object getModel()
    {
	return criteria;
    }

    public StatusMngmntSC getCriteria()
    {
	return criteria;
    }

    public void setCriteria(StatusMngmntSC criteria)
    {
	this.criteria = criteria;
    }

    public void setStatusMngmntBO(StatusMngmntBO statusMngmntBO)
    {
	this.statusMngmntBO = statusMngmntBO;
    }
}
