package com.path.alert.actions.subscriber.individual;

import java.math.BigDecimal;
import java.util.List;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.subscriber.individual.IndividualSubscriberBO;
import com.path.alert.bo.subscriber.individual.IndividualSubscriberConstant;
import com.path.alert.vo.subscriber.individual.IndividualSubscriberListCO;
import com.path.alert.vo.subscriber.individual.IndividualSubscriberSC;
import com.path.dbmaps.vo.ALRT_SUB_LANGVO;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;

public class IndividualSubscriberListAction extends GridBaseAction {

	private IndividualSubscriberBO individualSubscriberBO;
	private List<IndividualSubscriberListCO> indSubList;
	protected IndividualSubscriberSC indSubSC = new IndividualSubscriberSC();
	private BigDecimal subscriberId;

	/**
	 * load the data for the screen grid
	 * 
	 * @return
	 */
	public String loadData() {
		// SETTLEMENT_NBR2 added for tp#382346
		String[] searchCol = { "ID", "CIF_NO", "USR_ID", "BRIEF_NAME",  "STATUS_DESC", "CHANNEL_END_USR_ID"};
		
		try {
			/**
			 * copy the details related to search criteria to the SC
			 **/

			SessionCO sessionCO = returnSessionObject();
			indSubSC.setSearchCols(searchCol);
			copyproperties(indSubSC);

			indSubSC.setCompCode(sessionCO.getCompanyCode());
			indSubSC.setBranchCode(sessionCO.getBranchCode());
			indSubSC.setIsRTLDir(sessionCO.getIsRTLDir());
			indSubSC.setIvCrud(getIv_crud());
			indSubSC.setLovTypeId(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);
			indSubSC.setLangCode(sessionCO.getLanguage());
			indSubSC.setSubTypeLov(AlertConstant.subscriberTypeDropDown);
			indSubSC.setIndSubLangCode(IndividualSubscriberConstant.LANG_CODE_EN);
			indSubSC.setPageRef(get_pageRef());
			indSubSC.setCurrAppName(sessionCO.getCurrentAppName());
			/*
			 * If IV_CRUD = 'F' then ls_status[1] = 'P' ElseIf IV_CRUD = 'P'
			 * then ls_status[1] = 'N' Else ls_status[1] = 'N' ls_status[2] =
			 * 'D' ls_status[3] = 'P'//new End If
			 */ /*
				 * indSubSC.setAppName(sessionCO.getCurrentAppName());
				 * 
				 * 
				 * indSubSC.setProgRef(returnCommonLibBO().returnOrginProgRef(
				 * sessionCO.getCurrentAppName(), get_pageRef()));
				 */
			/**
			 * set number of rows to be displayed in the page of grid, and the
			 * total number of records for first time load only
			 **/

			if (checkNbRec(indSubSC)) {
				setRecords(individualSubscriberBO.indSubscriberCount(indSubSC));
			}
			/**
			 * return the collection of records
			 **/
			indSubList = individualSubscriberBO.indSubscriberList(indSubSC);

			/**
			 * set the collection into gridModel attribute defined at JSP grid
			 * tag
			 **/
			setGridModel(indSubList);

		} catch (Exception e) {
			handleException(e, null, null);
		}
		return SUCCESS;
	}

	/**
     * Load languages grid
     * @return String
     */
    public String loadAllLanguageGridData()
    {
		try
		{
			SessionCO sessionCO = returnSessionObject();
		    String[] searchCols = { "langDesc", "BRIEF_NAME", "MIDDLE_NAME", "LONG_NAME", "ADDRESS"};
		    indSubSC.setSearchCols(searchCols);
		    copyproperties(indSubSC);
		    indSubSC.setCompCode(sessionCO.getCompanyCode());
		    indSubSC.setSubID(subscriberId);
		    indSubSC.setLangCode(IndividualSubscriberConstant.LANG_CODE_EN);
		    if(subscriberId != null )
		    {
		    	if(checkNbRec(indSubSC))
			    {
			    	setRecords(individualSubscriberBO.returnIndividualSubscriberOtherLanguageListCount(indSubSC));
			    }
			    List<ALRT_SUB_LANGVO> individualSubscriberListCOs = individualSubscriberBO.returnIndividualSubscriberOtherLanguageList(indSubSC);
			    setGridModel(individualSubscriberListCOs);
			    set_recReadOnly("true");
			    set_ignoreSpecificMenu("true");
		    }
		}
	catch(Exception e)
	{
		e.printStackTrace();
	    handleException(e, null, null);
	}
	return SUCCESS;

    }
	public IndividualSubscriberSC getIndSubSC() {
		return indSubSC;
	}

	public void setIndSubSC(IndividualSubscriberSC indSubSC) {
		this.indSubSC = indSubSC;
	}

	public List<IndividualSubscriberListCO> getIndSubList() {
		return indSubList;
	}

	public void setIndSubList(List<IndividualSubscriberListCO> indSubList) {
		this.indSubList = indSubList;
	}

	public void setIndividualSubscriberBO(IndividualSubscriberBO individualSubscriberBO) {
		this.individualSubscriberBO = individualSubscriberBO;
	}

	public Object getModel() {
		return indSubSC;
	}

	public BigDecimal getSubscriberId() {
		return subscriberId;
	}

	public void setSubscriberId(BigDecimal subscriberId) {
		this.subscriberId = subscriberId;
	}

}
