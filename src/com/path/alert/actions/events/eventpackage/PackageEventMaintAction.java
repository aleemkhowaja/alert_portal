package com.path.alert.actions.events.eventpackage;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.events.eventpackage.PackageEventBO;
import com.path.alert.vo.events.eventpackage.EventInPackageEventListCO;
import com.path.alert.vo.events.eventpackage.EventInPackageEventSC;
import com.path.alert.vo.events.eventpackage.EventNotInPackageEventListCO;
import com.path.alert.vo.events.eventpackage.PackageEventCO;
import com.path.alert.vo.events.eventpackage.PackageEventSC;
import com.path.bo.common.MessageCodes;
import com.path.bo.common.audit.AuditConstant;
import com.path.lib.common.exception.BOException;
import com.path.lib.common.exception.BaseException;
import com.path.lib.common.util.StringUtil;
import com.path.lib.vo.GridUpdates;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;
import com.path.vo.common.audit.AuditRefCO;

/**
 * 
 * Copyright 2013, Path Solutions Path Solutions retains all ownership rights to
 * this source code
 * 
 * @author: eliasfarah
 * 
 *          java used to
 * 
 */
@SuppressWarnings("serial")
public class PackageEventMaintAction extends GridBaseAction
{

    private PackageEventCO packageEventCO = new PackageEventCO();
    private PackageEventBO packageEventBO;
    private PackageEventSC pkgEvtSC = new PackageEventSC();
    private EventInPackageEventSC evtNotInPkgSC = new EventInPackageEventSC();
    private String iv_crud;
    private String pkgId;
    private String evtId;
    private String list;
    private String list2;
    private String eventInPackage = "";

    public void setPackageEventBO(PackageEventBO packageEventBO)
    {
	this.packageEventBO = packageEventBO;
    }

    public PackageEventSC getPkgEvtSC()
    {
	return pkgEvtSC;
    }

    public void setPkgEvtSC(PackageEventSC pkgEvtSC)
    {
	this.pkgEvtSC = pkgEvtSC;
    }

    public PackageEventCO getPackageEventCO()
    {
	return packageEventCO;
    }

    public void setPackageEventCO(PackageEventCO packageEventCO)
    {
	this.packageEventCO = packageEventCO;
    }

    public EventInPackageEventSC getEvtNotInPkgSC()
    {
	return evtNotInPkgSC;
    }

    public void setEtNotInPkgSC(EventInPackageEventSC evtNotInPkgSC)
    {
	this.evtNotInPkgSC = evtNotInPkgSC;
    }

    public String getIv_crud()
    {
	return iv_crud;
    }

    public void setIv_crud(String iv_crud)
    {
	this.iv_crud = iv_crud;
    }

    public String getList()
    {
	return list;
    }

    public void setList(String list)
    {
	this.list = list;
    }

    public String getList2()
    {
	return list2;
    }

    public void setList2(String list2)
    {
	this.list2 = list2;
    }

    public String getPkgId()
    {
	return pkgId;
    }

    public void setPkgId(String pkgId)
    {
	this.pkgId = pkgId;
    }
    
    public String getEvtId()
    {
	return evtId;
    }

    public void setEvtId(String evtId)
    {
	this.evtId = evtId;
    }

    public String initialize()
    {
	String returnScreen = "packageEventList";
	try
	{
	    packageEventBO.deleteAlrtInPkgTmp();
	    packageEventBO.deleteAlrtNotInPkgTmp();
	    set_showSmartInfoBtn("false");
	    set_searchGridId("packageEventGridTbl_Id");
	    set_enableAudit(true);
	    if(iv_crud.equals(AlertConstant.CRUD_R))
	    {
		set_showNewInfoBtn("true");
	    }
	    else
	    {
		set_showNewInfoBtn("false");
	    }
	    fillSessionData();
	    if(iv_crud.equals(AlertConstant.CRUD_P))
	    {
		getAdditionalScreenParams().putAll(packageEventBO.onInitializeApproveVisibilities(packageEventCO));
	    }
	    else
	    {
		getAdditionalScreenParams()
			.putAll(packageEventBO.onInitializeMaintVisibilities(packageEventCO, iv_crud));
	    }
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}

	return returnScreen;
    }

    public String initializeMain()
    {
	String returnScreen = "packageEventMaint";
	try
	{
	    packageEventBO.deleteAlrtInPkgTmp();
	    packageEventBO.deleteAlrtNotInPkgTmp();
	    fillSessionData();
	    if(iv_crud.equals(AlertConstant.CRUD_R))
	    {
		getAdditionalScreenParams().putAll(packageEventBO.onInitializeMaintVisibilities(packageEventCO, iv_crud));
	    }
	    else
	    {
	    	getAdditionalScreenParams().putAll(packageEventBO.onInitializeApproveVisibilities(packageEventCO));
	    }
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return returnScreen;
    }

    public String edit()
    {
	String returnScreen = "packageEventMaint";
	String status;
	try
	{
	    SessionCO sessionCO = returnSessionObject();
	    packageEventBO.deleteAlrtInPkgTmp();
	    packageEventBO.deleteAlrtNotInPkgTmp();
	    pkgEvtSC.setLangCode(sessionCO.getLanguage());
	    pkgEvtSC.setLovTypeId(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);
	    packageEventCO = packageEventBO.returnPackageById(pkgEvtSC);
	    pkgEvtSC.setPkgId(packageEventCO.getAlrtPkgVO().getPKG_ID());
	    status = packageEventBO.getStatusByPackage(pkgEvtSC);
	    if((status.equals(AlertConstant.STATUS_APPROVED) || status.equals(AlertConstant.STATUS_DELETED))
		    && iv_crud.equals(AlertConstant.CRUD_R))
	    {
		getAdditionalScreenParams().putAll(packageEventBO.onInitializeVisibilities(packageEventCO));
	    }
	    if(iv_crud.equals(AlertConstant.CRUD_P))
	    {
		getAdditionalScreenParams().putAll(packageEventBO.onInitializeApproveVisibilities(packageEventCO));
	    }
	    else
	    {
		getAdditionalScreenParams()
			.putAll(packageEventBO.onInitializeMaintVisibilities(packageEventCO, iv_crud));
	    }
	    applyRetrieveAudit(AuditConstant.ALERT_PACKAGE_KEY_REF, packageEventCO.getAlrtPkgVO(), packageEventCO);

	    loadSubGridData();
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return returnScreen;
    }
    
	public String loadSubGridData() 
	{
		try
		{
			EventInPackageEventSC evtInPkgSC = new EventInPackageEventSC();

			SessionCO sessionCO = returnSessionObject();
			evtInPkgSC.setLovTypeId(AlertConstant.eventTypeDropDown);
			evtInPkgSC.setEvtLovTypeId(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);
			evtInPkgSC.setLangCode(sessionCO.getLanguage());
			evtInPkgSC.setCompCode(sessionCO.getCompanyCode());

			if(!("".equals(StringUtil.nullToEmpty(pkgId))))
		    {			
				evtInPkgSC.setPkgId(new BigDecimal(pkgId));
			}
			else
			{
				evtInPkgSC.setPkgId(pkgEvtSC.getPkgId());
			}
			
			copyproperties(evtInPkgSC);
			evtInPkgSC.setNbRec(-1);
			
			if (checkNbRec(evtInPkgSC)) 
			{
				setRecords(packageEventBO.evtInPackageCount(evtInPkgSC));
			}

			List<EventInPackageEventListCO> evtInPkgList = packageEventBO.evtInPackageList(evtInPkgSC);
			StringBuilder sb = new StringBuilder();

			sb.append("{\"root\":[");
			
			evtInPkgList.stream().forEach((co) ->{
				sb.append("{\"EVT_ID\":\"" + co.getEVT_ID() + "\",");
				sb.append("\"EVT_TYPE\":\"" + StringUtil.nullToEmpty(co.getEVT_TYPE()) + "\",");
				sb.append("\"DESCRIPTION\":\"" + StringUtil.nullToEmpty(co.getDESCRIPTION()) + "\",");
				sb.append("\"STATUS\":\"" + StringUtil.nullToEmpty(co.getSTATUS()) + "\"},");
			});
			
			if (sb.indexOf(",") >= 0)
			{
				sb.replace(sb.lastIndexOf(","), sb.lastIndexOf(",") + 1, "");
			}
			sb.append("]}");
			
			eventInPackage = sb.toString();
		}
		catch (Exception e) 
		{
			handleException(e, null, null);
		}

		return SUCCESS;
	}
    
    
    

    private void fillSessionData() throws BaseException
    {
	SessionCO sessionCO = returnSessionObject();
	packageEventCO.setCompCode(sessionCO.getCompanyCode());
	packageEventCO.setBranchCode(sessionCO.getBranchCode());
	packageEventCO.setAppName(sessionCO.getCurrentAppName());
	packageEventCO.setRunningDate(returnCommonLibBO().addSystemTimeToDate(sessionCO.getRunningDateRET()));
	packageEventCO.setProgRef(get_pageRef());
	packageEventCO.setUserID(sessionCO.getUserName());
    }

    public String saveRecord()
    {
	try
	{
		if(getList2().trim().length() == 0) 
		{
			throw new BOException(MessageCodes.ERROR_WHILE_SAVING_PACKAGE);
		}
		fillSessionData();
	    GridUpdates gridData1 = getGridUpdates(getList2(), EventInPackageEventListCO.class, true);	    
	    ArrayList<EventNotInPackageEventListCO> evtNotInPkgList = new ArrayList<>();
	    ArrayList<EventInPackageEventListCO> evtInPkgList = gridData1.getLstAllRec();
	    if(StringUtil.nullToEmpty(packageEventCO.getAlrtPkgVO().getCREATED_BY()).isEmpty())
	    {
		packageEventCO.setAuditRefCO(fillSessionVariables(AuditConstant.CREATED));
	    }
	    else
	    {
		packageEventCO.setAuditRefCO(fillSessionVariables(AuditConstant.UPDATE));
		packageEventCO.setAuditObj(returnAuditObject(packageEventCO.getClass()));
	    }
	    packageEventBO.saveRecord(evtNotInPkgList,evtInPkgList,packageEventCO);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }
    
    public String approveRecord()
    {
		try
		{
		    fillSessionData();
		    packageEventCO.setAuditRefCO(fillSessionVariables(AuditConstant.UPDATE));
		    packageEventCO.setAuditObj(returnAuditObject(packageEventCO.getClass()));
		    // validate if user is allowed to take this action
		 	validateMakerChecker(packageEventCO);
		    packageEventBO.approveRecord(packageEventCO);
		}
		catch(BaseException e)
		{
		    handleException(e, null, null);
		}
		return SUCCESS;
    }

    /**
     * used to Validate Maker checker 
     * @param IndividualEventCO
     * @throws BaseException
     */
    private void validateMakerChecker(PackageEventCO packageEventCO) throws BaseException
    {
    	int result = returnCommonLibBO().validateMakerChecker(packageEventCO.getAlrtPkgVO().getCREATED_BY(), 
    			packageEventCO.getAlrtPkgVO().getMODIFIED_BY(), packageEventCO.getUserID());
    	if( result > 0 )
    	{
    		throw new BOException(result);
    	}
    }
    
    public String checkSubscription()
    {
	try
	{
	    fillSessionData();
	    packageEventCO.setPkgId(new BigDecimal(pkgId));
	    packageEventCO = packageEventBO.checkSubscription(packageEventCO);
	}
	catch(BaseException e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }


    public String deleteRecord()
    {
	try
	{
	    packageEventCO.setAuditRefCO(fillSessionVariables(AuditConstant.UPDATE));
	    packageEventCO.setAuditObj(returnAuditObject(packageEventCO.getClass()));
	    packageEventBO.deleteRecord(packageEventCO);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }
    
    public String addEvtToPkg()
    {
	try
	{
	    packageEventCO.setEvtId(new BigDecimal(evtId));
	    packageEventBO.insertAlrtInPkgTmp(packageEventCO);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }
    
    public String removeEvtFromPkg()
    {
	try
	{
	    packageEventCO.setEvtId(new BigDecimal(evtId));
	    packageEventBO.insertAlrtNotInPkgTmp(packageEventCO);
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
	    refCO.setAuditEnabled(true);
	    refCO.setOperationType(status);
	    refCO.setKeyRef(AuditConstant.ALERT_PACKAGE_KEY_REF);

	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return refCO;
    }

	public String getEventInPackage() {
		return eventInPackage;
	}

	public void setEventInPackage(String eventInPackage) {
		this.eventInPackage = eventInPackage;
	}
    
    
}
