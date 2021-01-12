package com.path.alert.actions.subscription;	    

import java.util.ArrayList;
import java.util.List;

import com.path.alert.actions.common.AlertBaseAction;
import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.common.AlrtCommonConstants;
import com.path.alert.bo.events.event.IndividualEventConstant;
import com.path.alert.bo.subscriber.individual.IndividualSubscriberBO;
import com.path.alert.bo.subscription.SubscriptionBO;
import com.path.alert.bo.subscription.SubscriptionConstant;
import com.path.alert.vo.subscriber.individual.IndividualSubscriberSC;
import com.path.alert.vo.subscription.SubscriptionCO;
import com.path.alert.vo.subscription.SubscriptionSC;
import com.path.dbmaps.vo.AMFVO;
import com.path.lib.common.util.NumberUtil;
import com.path.lib.common.util.StringUtil;
import com.path.struts2.json.PathJSONUtil;
import com.path.vo.common.SessionCO;
import com.path.vo.common.select.SelectCO;
import com.path.vo.common.select.SelectSC;

public class SubscriptionListAction extends AlertBaseAction {
	private SubscriptionBO subscriptionBO;
	private IndividualSubscriberBO individualSubscriberBO;

	private SubscriptionSC subscriptionSC = new SubscriptionSC();
	private IndividualSubscriberSC individualSubscriberSC = new IndividualSubscriberSC();

	private List<SelectCO> subscriptiontypelist = new ArrayList<SelectCO>();
	private SubscriptionCO subscriptionCO = new SubscriptionCO();
	private String allSelectedRow2;
	private List<SelectCO> srcContactList = new ArrayList<SelectCO>();

	public String LoadGroupsGrid() {
		String[] searchCol = { "GRP_ID", "BRIEF_DESC_ENG", "LONG_DESC_ENG", "BRIEF_DESC_ARAB", "LONG_DESC_ARAB" };
		try {
			/**
			 * copy the details related to search criteria to the SC
			 * 
			 */

			SessionCO sessionCO = returnSessionObject();
			subscriptionSC.setSearchCols(searchCol);
			subscriptionSC.setCompCode(sessionCO.getCompanyCode());
			subscriptionSC.setBranchCode(sessionCO.getBranchCode());
			subscriptionSC.setAppName(sessionCO.getCurrentAppName());
			subscriptionSC.setProgRef(returnCommonLibBO().returnOrginProgRef(sessionCO.getCurrentAppName(), get_pageRef()));

			copyproperties(subscriptionSC);

			/**
			 * set number of rows to be displayed in the page of grid, and the
			 * total number of records for first time load only
			 */
			if (checkNbRec(subscriptionSC)) {
				setRecords(subscriptionBO.groupsCount(subscriptionSC));
			}
			/**
			 * return the collection of records
			 */

			/**
			 * set the collection into gridModel attribute defined at JSP grid
			 * tag
			 */

			setGridModel(subscriptionBO.loadGroupsGrid(subscriptionSC));
			emptyObjects();

		} catch (Exception e) {
			handleException(e, null, null);

		}
		return SUCCESS;

	}

	public String LoadPackageGrid() {
		String[] searchCol = { "PKG_ID", "BRIEF_DESC_ENG", "LONG_DESC_ENG", "BRIEF_DESC_ARAB", "LONG_DESC_ARAB" };
		try {
			/**
			 * copy the details related to search criteria to the SC
			 * 
			 */

			SessionCO sessionCO = returnSessionObject();
			subscriptionSC.setSearchCols(searchCol);
			subscriptionSC.setCompCode(sessionCO.getCompanyCode());
			subscriptionSC.setBranchCode(sessionCO.getBranchCode());
			subscriptionSC.setAppName(sessionCO.getCurrentAppName());
			subscriptionSC
					.setProgRef(returnCommonLibBO().returnOrginProgRef(sessionCO.getCurrentAppName(), get_pageRef()));
			subscriptionSC.setEvtLovTypeId(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);
			subscriptionSC.setLangCode(sessionCO.getLanguage());
			// subscriptionSC.setLovType(TransactionTypeConstant.statuslov);
			copyproperties(subscriptionSC);

			/**
			 * set number of rows to be displayed in the page of grid, and the
			 * total number of records for first time load only
			 */
			if (checkNbRec(subscriptionSC)) {
				setRecords(subscriptionBO.packageCount(subscriptionSC));
			}
			/**
			 * return the collection of records
			 */

			/**
			 * set the collection into gridModel attribute defined at JSP grid
			 * tag
			 */

			setGridModel(subscriptionBO.loadPackageGrid(subscriptionSC));
			emptyObjects();

		} catch (Exception e) {
			handleException(e, null, null);

		}
		return SUCCESS;

	}

	public String LoadSubscribersGrid() {
		String[] searchCol = { "ID", "BRIEF_NAME","CIF_NO","cifType","USR_ID","CHANNEL_END_USR_ID","EMAIL_ID","MOBILE_PHONE","subType" };
		try {
			/**
			 * copy the details related to search criteria to the SC
			 * 
			 */

			SessionCO sessionCO = returnSessionObject();
			subscriptionSC.setSearchCols(searchCol);
			subscriptionSC.setCompCode(sessionCO.getCompanyCode());
			subscriptionSC.setBranchCode(sessionCO.getBranchCode());
			subscriptionSC.setAppName(sessionCO.getCurrentAppName());
			subscriptionSC.setProgRef(returnCommonLibBO().returnOrginProgRef(sessionCO.getCurrentAppName(), get_pageRef()));
			subscriptionSC.setSubTypeLovId(SubscriptionConstant.subTypeLovId);
			subscriptionSC.setLangCode(sessionCO.getLanguage());
			copyproperties(subscriptionSC);
			// disable CIF search based on OMNI flag
			subscriptionSC.setEnable_omni(AlrtCommonConstants.isOmniInstalled);	
			/**
			 * set number of rows to be displayed in the page of grid, and the
			 * total number of records for first time load only
			 */
			if (checkNbRec(subscriptionSC)) {
				setRecords(subscriptionBO.subscribersCount(subscriptionSC));
			}
			/**
			 * return the collection of records
			 */

			/**
			 * set the collection into gridModel attribute defined at JSP grid
			 * tag
			 */

			setGridModel(subscriptionBO.loadSubscribersGrid(subscriptionSC));
			emptyObjects();

		} catch (Exception e) {
			e.printStackTrace();
			handleException(e, null, null);

		}
		return SUCCESS;

	}

	public String LoadEventsGrid() {
		String[] searchCol = { "EVT_ID", "EVT_TYPE", "DESC_ENG", "ADDITIONAL_INFO", "EVT_MODE", "SUSPENDED",
				"evtType" };
		try {
			/**
			 * copy the details related to search criteria to the SC
			 * 
			 */

			SessionCO sessionCO = returnSessionObject();
			subscriptionSC.setSearchCols(searchCol);
			subscriptionSC.setCompCode(sessionCO.getCompanyCode());
			subscriptionSC.setBranchCode(sessionCO.getBranchCode());
			subscriptionSC.setAppName(sessionCO.getCurrentAppName());
			subscriptionSC
					.setProgRef(returnCommonLibBO().returnOrginProgRef(sessionCO.getCurrentAppName(), get_pageRef()));
			subscriptionSC.setEventModeLovId(SubscriptionConstant.EventModeLovId);
			subscriptionSC.setEventTypeLovId(SubscriptionConstant.EVENT_TYPE_LOV_TYPE);
			subscriptionSC.setSuspendedLovType(SubscriptionConstant.SuspendedLovType);
			subscriptionSC.setLangCode(sessionCO.getLanguage());
			subscriptionSC.setEvtLovTypeId(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);
			subscriptionSC.setSubStatus(SubscriptionConstant.subStatus);
			// disable CIF search based on OMNI flag
			subscriptionSC.setEnable_omni(AlrtCommonConstants.isOmniInstalled);	
			copyproperties(subscriptionSC);

			/**
			 * set number of rows to be displayed in the page of grid, and the
			 * total number of records for first time load only
			 */
			if (checkNbRec(subscriptionSC)) {
				setRecords(subscriptionBO.eventsCount(subscriptionSC));
			}
			/**
			 * return the collection of records
			 */

			/**
			 * set the collection into gridModel attribute defined at JSP grid
			 * tag
			 */

			setGridModel(subscriptionBO.loadEventsGrid(subscriptionSC));
			emptyObjects();

		} catch (Exception e) {
			handleException(e, null, null);

		}
		return SUCCESS;

	}

	public String LoadSubscribersEvtGrid() {
	    
	    /**
	     *copy the details related to search criteria to the SC
	     * 
	     */
	    String prog_ref = subscriptionSC.getProgRef();
    		
	    String[] searchCol = { "alrtSubEvtTmpVO.ID", "alrtSubEvtTmpVO.REL_ID", "alrtSubEvtTmpVO.REL_TYPE",
				"SUB_ID", "alrtSubEvtTmpVO.CIF_NO", "alrtSubEvtTmpVO.USR_ID", "alrtSubEvtTmpVO.CHANNEL_END_USR_ID",
				"FULL_NAME_ENG","CIF_NO","alrtSubEvtTmpVO.EMAIL_ID","alrtSubEvtTmpVO.MOBILE_PHONE",
				"EVT_ID", "EVT_TYPE", "EVT_DESC_ENG", "statusDesc",
				"SUB_EVT_STATUS", "subType","evtType", "alrtSubEvtVO.SRC_CONTACT_TYPE",
				"alrtSubEvtTmpVO.FULL_NAME_ENG", "alrtSubEvtTmpVO.SUB_ID", "alrtSubEvtTmpVO.EVT_ID", "alrtSubEvtTmpVO.EVT_TYPE",
				"alrtSubEvtTmpVO.EVT_DESC_ENG", "statusDesc"};
	    try {
		
		SessionCO sessionCO = returnSessionObject();
		subscriptionSC.setSearchCols(searchCol);
		subscriptionSC.setCompCode(sessionCO.getCompanyCode());
		subscriptionSC.setBranchCode(sessionCO.getBranchCode());
		subscriptionSC.setAppName(sessionCO.getCurrentAppName());
		subscriptionSC
		.setProgRef(returnCommonLibBO().returnOrginProgRef(sessionCO.getCurrentAppName(), get_pageRef()));
		subscriptionSC.setSubStatus(SubscriptionConstant.subStatus);
		subscriptionSC.setEventModeLovId(SubscriptionConstant.EventModeLovId);
		subscriptionSC.setEventTypeLovId(SubscriptionConstant.EVENT_TYPE_LOV_TYPE);
		if(!NumberUtil.isEmptyDecimal(subscriptionSC.getSubscriberId()))
		{
		    subscriptionSC.setCrud(SubscriptionConstant.PACKAGE_TYPE);
		    subscriptionSC.setSubscribedEvTAndPack("all");
		}
			
		subscriptionSC.setSuspendedLovType(SubscriptionConstant.SuspendedLovType);
		subscriptionSC.setLangCode(sessionCO.getLanguage());
		subscriptionSC.setSubTypeLovId(AlertConstant.subscriberTypeDropDown);
		if ("C".equals(subscriptionSC.getRetreiveCrud())) {
				subscriptionSC.setCrud("C");
		}
		
	    if(AlertConstant.CRUD_P.equals(subscriptionSC.getCrud()))
	    {
		subscriptionSC.setStatus(AlertConstant.STATUS_ACTIVE);
	    }
	    else if(AlertConstant.CRUD_TD.equals(subscriptionSC.getCrud()))
	    {
		subscriptionSC.setStatus(AlertConstant.STATUS_ACTIVE);
		subscriptionSC.setToBeStatus(AlertConstant.STATUS_TO_BE_DELETED);
	    }
	    else if(AlertConstant.CRUD_D.equals(subscriptionSC.getCrud()))
	    {
		subscriptionSC.setToBeStatus(AlertConstant.STATUS_TO_BE_DELETED);
	    }
	    else if(AlertConstant.CRUD_TS.equals(subscriptionSC.getCrud())
		    || AlertConstant.CRUD_TS_SUBS_PKG.equals(subscriptionSC.getCrud())
		    || AlertConstant.EVENT_GROUP.equals(subscriptionSC.getCrud()))
	    {
		subscriptionSC.setStatus(AlertConstant.STATUS_APPROVED);
		subscriptionSC.setToBeStatus(AlertConstant.STATUS_TO_BE_SUSPENDED);
	    }
	    else if(AlertConstant.CRUD_S.equals(subscriptionSC.getCrud()))
	    {
		subscriptionSC.setStatus(AlertConstant.STATUS_SUSPEND);
		subscriptionSC.setToBeStatus(AlertConstant.STATUS_TO_BE_SUSPENDED);
	    }
	    else if(AlertConstant.CRUD_TR.equals(subscriptionSC.getCrud()))
	    {
		subscriptionSC.setStatus(AlertConstant.STATUS_SUSPEND);
		subscriptionSC.setToBeStatus(AlertConstant.STATUS_TO_BE_REACTIVATE);
	    }
	    else if(AlertConstant.CRUD_RA.equals(subscriptionSC.getCrud()))
	    {
		subscriptionSC.setToBeStatus(AlertConstant.STATUS_TO_BE_REACTIVATE);
	    }

	    if(subscriptionSC.getProgRef() == null)
	    {
		subscriptionSC.setProgRef(prog_ref);
	    }
	    
	    copyproperties(subscriptionSC);

	    /**
	     * Due to performace issue we need to pass sub id or cif for
	     * filterering the record Handled if search/refresh without values
	     * that time it will not load the data. Added by Aleem
	     */
	    if(StringUtil.nullToEmpty(prog_ref).equals(SubscriptionConstant.SUB_EVT_UPDATE_AFTER_APPROVE_PROG_REF) && !isColumnsExistForSearch(
		    new String[] { SubscriptionConstant.CIF_CONST, SubscriptionConstant.SUB_ID_CONST }, subscriptionSC)) return SUCCESS;

		// disable CIF search based on OMNI flag
		subscriptionSC.setEnable_omni(AlrtCommonConstants.isOmniInstalled);
	    /**
	     * set number of rows to be displayed in the page of grid, and the
	     * total number of records for first time load only
	     */
	    if(checkNbRec(subscriptionSC))
	    {
		if(StringUtil.isNotEmpty(subscriptionSC.getProgRef()) && (subscriptionSC.getProgRef().equals("IND00MT")
			|| subscriptionSC.getProgRef().equals("IND00P")
			|| subscriptionSC.getProgRef().equals("IND00MA")))
		{
		    setRecords(subscriptionBO.subscriberAllEvtCount(subscriptionSC));
		}
		else
		{
		    setRecords(subscriptionBO.subscriberEvtCount(subscriptionSC));
		}
		// subscriptionSC.setNbRec(subscriptionBO.subscriberEvtCount(subscriptionSC));
	    }
	    /**
	     * return the collection of records
	     */

	    /**
	     * set the collection into gridModel attribute defined at JSP grid
	     * tag
	     */
	    List<SubscriptionCO> subscriberEvetList = new ArrayList<>();
	    if(StringUtil.isNotEmpty(subscriptionSC.getProgRef()) && (subscriptionSC.getProgRef().equals("IND00MT")
		    || subscriptionSC.getProgRef().equals("IND00P") || subscriptionSC.getProgRef().equals("IND00MA")))
	    {
		subscriberEvetList = subscriptionBO.subscriberAllEvtList(subscriptionSC);
	    }
	    else
	    {
		subscriberEvetList = subscriptionBO.subscriberEvtList(subscriptionSC);
	    }
	    // List<SubscriptionCO> subscriberEvetList =
	    // subscriptionBO.subscriberEvtList(subscriptionSC);
	    List<SubscriptionCO> subscriberEvetGridList = new ArrayList<>();
	    for(int i = 0; i < subscriberEvetList.size(); i++)
	    {
		SubscriptionCO subscriptionCO = subscriberEvetList.get(i);
		individualSubscriberSC.setRelType(subscriptionSC.getType());
		if(subscriptionSC.getSubscriberId() != null
			&& !NumberUtil.isEmptyDecimal(subscriptionSC.getSubscriberId()))
		{
		    individualSubscriberSC.setSubID(subscriptionSC.getSubscriberId());
		}
		else
		{
		    individualSubscriberSC.setSubID(subscriptionCO.getAlrtSubEvtTmpVO().getSUB_ID());
		}

		individualSubscriberSC.setCompCode(sessionCO.getCompanyCode());

		if(subscriptionSC.getType() != null
			&& subscriptionSC.getType().equals(SubscriptionConstant.SUB_EVENT_TYPE))
		{
		    individualSubscriberSC.setEvtID(subscriptionCO.getAlrtSubEvtTmpVO().getEVT_ID());
		    List<AMFVO> exludedAccountList = individualSubscriberBO
			    .returnIndividualSubscriberMultipleAccountsList(individualSubscriberSC);
		    if(exludedAccountList != null && !exludedAccountList.isEmpty())
		    {
			subscriptionCO.setEventAccountNumber(
				!exludedAccountList.isEmpty() ? exludedAccountList.size() + " Selected" : "");
			subscriptionCO.setEventCifMultiselectedAccounts(
				"{\"root\":".concat(PathJSONUtil.serialize(exludedAccountList, null, null, false, true))
					.concat("}"));
		    }
		}
		else if(subscriptionSC.getType() != null
			&& subscriptionSC.getType().equals(SubscriptionConstant.SUB_PCKG_TYPE))
		{
		    individualSubscriberSC.setPckgID(subscriptionCO.getAlrtSubEvtTmpVO().getEVT_ID());
		    List<AMFVO> exludedAccountList = individualSubscriberBO
			    .returnIndividualSubscriberMultipleAccountsList(individualSubscriberSC);
		    if(exludedAccountList != null && !exludedAccountList.isEmpty())
		    {
			subscriptionCO.setPackageAccountNumber(
				!exludedAccountList.isEmpty() ? exludedAccountList.size() + " Selected" : "");
			subscriptionCO.setPackageCifMultiselectedAccounts(
				"{\"root\":".concat(PathJSONUtil.serialize(exludedAccountList, null, null, false, true))
					.concat("}"));
		    }
		}
		subscriberEvetGridList.add(subscriptionCO);
	    }
	    // add multiple accounts of individual subscriber
	    setGridModel(subscriberEvetGridList);
	    emptyObjects();

	}
	catch(Exception e)
	{
	    handleException(e, null, null);

	}
	return SUCCESS;

	}

	private void emptyObjects() {
		subscriptionCO = null;
		subscriptionSC = null;
	}

	public Object getModel() {
		return subscriptionSC;
	}

	public String returnAllSelectedRow() {
		try {

			SessionCO sessionCO = returnSessionObject();
			subscriptionSC.setCompCode(sessionCO.getCompanyCode());
			subscriptionSC.setBranchCode(sessionCO.getBranchCode());
			subscriptionSC.setAppName(sessionCO.getCurrentAppName());
			subscriptionSC
					.setProgRef(returnCommonLibBO().returnOrginProgRef(sessionCO.getCurrentAppName(), get_pageRef()));
			subscriptionSC.setSubTypeLovId(SubscriptionConstant.subTypeLovId);

			subscriptionSC.setLangCode(sessionCO.getLanguage());
			subscriptionSC.setEventModeLovId(SubscriptionConstant.EventModeLovId);
			subscriptionSC.setEventTypeLovId(SubscriptionConstant.EVENT_TYPE_LOV_TYPE);
			subscriptionSC.setSuspendedLovType(SubscriptionConstant.SuspendedLovType);
			subscriptionSC.setEvtLovTypeId(SubscriptionConstant.EVENT_TYPE_LOV_TYPE);
			subscriptionSC.setSubStatus(SubscriptionConstant.subStatus);
			copyproperties(subscriptionSC);

			subscriptionSC.setNbRec(-1);
			//String h = subscriptionBO.returnAllSelectedRow(subscriptionSC).getAllRows();
			setAllSelectedRow2(subscriptionBO.returnAllSelectedRow(subscriptionSC).getAllRows());
		} catch (Exception e) {
			handleException(e, null, null);
		}
		return SUCCESS;
	}

	public String returnAllSelectedRowDet() {
		try {

			SessionCO sessionCO = returnSessionObject();
			subscriptionSC.setCompCode(sessionCO.getCompanyCode());
			subscriptionSC.setBranchCode(sessionCO.getBranchCode());
			subscriptionSC.setAppName(sessionCO.getCurrentAppName());
			subscriptionSC
					.setProgRef(returnCommonLibBO().returnOrginProgRef(sessionCO.getCurrentAppName(), get_pageRef()));
			subscriptionSC.setSubTypeLovId(SubscriptionConstant.subTypeLovId);
			subscriptionSC.setSubStatus(SubscriptionConstant.subStatus);
			subscriptionSC.setLangCode(sessionCO.getLanguage());
			if (AlertConstant.CRUD_P.equals(subscriptionSC.getCrud())) {
				subscriptionSC.setStatus(AlertConstant.STATUS_ACTIVE);
			} else if (AlertConstant.CRUD_D.equals(subscriptionSC.getCrud())) {
				subscriptionSC.setStatus(AlertConstant.STATUS_TO_BE_DELETED);
			}
			copyproperties(subscriptionSC);

			subscriptionSC.setNbRec(-1);
			subscriptionSC.setEventTypeLovId(SubscriptionConstant.EVENT_TYPE_LOV_TYPE);
			//String h = subscriptionBO.returnAllSelectedRowDet(subscriptionSC).getAllRows();
			setAllSelectedRow2(subscriptionBO.returnAllSelectedRowDet(subscriptionSC).getAllRows());
		} catch (Exception e) {
			handleException(e, null, null);
		}
		return SUCCESS;
	}
	
	public String LoadsrcContactSelect()
    {
		try
		{
			SelectSC selSC = new SelectSC(SubscriptionConstant.subscriptionSrcContactLovId);
			
			srcContactList = returnLOV(selSC);
		}
		catch(Exception e)
		{
			handleException(e, null, null);
		}

		return SUCCESS;
    }
    
    public String LoadCommunicationTypeGrid()
    {
	try
	{
	    if(AlertConstant.CRUD_F.equals(getIv_crud()) ||AlertConstant.CRUD_TD.equals(getIv_crud())||AlertConstant.CRUD_D.equals(getIv_crud())||
	       AlertConstant.CRUD_TS.equals(getIv_crud())||AlertConstant.CRUD_S.equals(getIv_crud()) || AlertConstant.STATUS_APPROVED.equals(getIv_crud())||
	       AlertConstant.CRUD_TR.equals(getIv_crud())||AlertConstant.CRUD_RA.equals(getIv_crud()) ||
	       AlertConstant.CRUD_R.equals(getIv_crud())&&AlertConstant.STATUS_APPROVED.equals(subscriptionSC.getSubsStatus()))
	    {
		set_recReadOnly("true");
	    }
	    else
	    {
		set_recReadOnly("false");
	    }
	}
	catch(Exception e)
	{
	    log.error(e, "Error while opening communication type popup Grid");
	    handleException(e, null, null);
	}
	return  "CommunicationTypeDetailPopup";
    }
    
    public String LoadCommunicationTypeDetailPopupGrid()
    {
	try
	{
		SessionCO sessionCO = returnSessionObject();
		subscriptionSC.setLangCode(sessionCO.getLanguage());
		subscriptionSC.setLovTypeId(IndividualEventConstant.COMMUNICATION_TYPE_LOV_TYPE);
	    copyproperties(subscriptionSC);
	    int communicationTypeCnt = subscriptionBO.returnCommunicationTypeCnt(subscriptionSC);
	    setRecords(communicationTypeCnt);
	    List<SubscriptionCO> communicationTypeList = subscriptionBO.returnCommunicationTypeList(subscriptionSC);
 	    setGridModel(communicationTypeList);
	}
	catch(Exception e)
	{
	    log.error(e, "Error in Load of Communication Type Detail");
	    handleException(e, null, null);
	}
	return SUCCESS;
    }
    
	public SubscriptionSC getSubscriptionSC() {
		return subscriptionSC;
	}

	public void setSubscriptionSC(SubscriptionSC subscriptionSC) {
		this.subscriptionSC = subscriptionSC;
	}

	public List<SelectCO> getSubscriptiontypelist() {
		return subscriptiontypelist;
	}

	public void setSubscriptiontypelist(List<SelectCO> subscriptiontypelist) {
		this.subscriptiontypelist = subscriptiontypelist;
	}

	public SubscriptionCO getSubscriptionCO() {
		return subscriptionCO;
	}

	public void setSubscriptionCO(SubscriptionCO subscriptionCO) {
		this.subscriptionCO = subscriptionCO;
	}

	public void setSubscriptionBO(SubscriptionBO subscriptionBO) {
		this.subscriptionBO = subscriptionBO;
	}

	public String getAllSelectedRow2() {
		return allSelectedRow2;
	}

	public void setAllSelectedRow2(String allSelectedRow2) {
		this.allSelectedRow2 = allSelectedRow2;
	}

	public List<SelectCO> getSrcContactList() {
		return srcContactList;
	}

	public void setSrcContactList(List<SelectCO> srcContactList) {
		this.srcContactList = srcContactList;
	}
	
	public void setIndividualSubscriberBO(IndividualSubscriberBO individualSubscriberBO) {
		this.individualSubscriberBO = individualSubscriberBO;
	}

	public IndividualSubscriberSC getIndividualSubscriberSC() {
		return individualSubscriberSC;
	}

	public void setIndividualSubscriberSC(IndividualSubscriberSC individualSubscriberSC) {
		this.individualSubscriberSC = individualSubscriberSC;
	}

}
