package com.path.alert.actions.events.event;

import java.util.List;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.events.event.IndividualEventBO;
import com.path.alert.vo.events.event.AlrtTagsCO;
import com.path.alert.vo.events.event.IndividualEventCO;
import com.path.alert.vo.events.event.IndividualEventListCO;
import com.path.alert.vo.events.event.IndividualEventSC;
import com.path.lib.common.util.StringUtil;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;

 public class IndividualEventListAction extends GridBaseAction {

	
    private IndividualEventBO individualEventBO;
    private List<IndividualEventListCO> indEventList;
    private IndividualEventSC indEventSC = new IndividualEventSC();
    private IndividualEventCO individualEventCO = new IndividualEventCO();
    
	/**
     * load the data for the screen grid
     * 
     * @return
     */
    public String returnIndividualEventDataForGrid()
    {

		String[] searchCol = { "EVT_ID", "DESC_ENG", "EVT_TYPE", "STATUS"};
		try
		{
		    /**
		     * copy the details related to search criteria to the SC
		     **/
	
		    SessionCO sessionCO = returnSessionObject();
		    indEventSC.setSearchCols(searchCol);
		    copyproperties(indEventSC);
	
		    indEventSC.setCompCode(sessionCO.getCompanyCode());
		    indEventSC.setBranchCode(sessionCO.getBranchCode());
		    indEventSC.setIvCrud(getIv_crud());
		    indEventSC.setLovType(AlertConstant.EVENT_STATUS_LOV_TYPE);
		    indEventSC.setEvtType(AlertConstant.eventTypeDropDown);
		    
		    indEventSC.setLangCode(sessionCO.getLanguage());
		
		    /**
		     *  set number of rows to be displayed in the page of grid, and the
		     * total number of records for first time load only
		     **/
		  
		    if(checkNbRec(indEventSC))
		    {
		    	setRecords(individualEventBO.returnIndividualEventCountForGrid(indEventSC));
		    }
		    /**
		     * return the collection of records
		    **/
		    indEventList = individualEventBO.returnIndividualEventListForGrid(indEventSC);
	
		    /**
		     * set the collection into gridModel attribute defined at JSP grid
		     * tag
		     **/
		    setGridModel(indEventList);
	
		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		}
		return SUCCESS;
    }
    
    /**
     * load the Events for Package
     * 
     * @return
     */
    public String returnIndividualEventListForPackage()
    {

		String[] searchCol = { "EVT_ID", "DESC_ENG", "EVT_TYPE", "STATUS"};
		try
		{
		    /**
		     * copy the details related to search criteria to the SC
		     **/
	
		    SessionCO sessionCO = returnSessionObject();
		    indEventSC.setSearchCols(searchCol);
		    copyproperties(indEventSC);
	
		    indEventSC.setCompCode(sessionCO.getCompanyCode());
		    indEventSC.setBranchCode(sessionCO.getBranchCode());
		    indEventSC.setIvCrud(getIv_crud());
		    indEventSC.setLovType(AlertConstant.EVENT_STATUS_LOV_TYPE);
		    indEventSC.setEvtType(AlertConstant.eventTypeDropDown);
		    
		    indEventSC.setLangCode(sessionCO.getLanguage());
		
		    /**
		     *  set number of rows to be displayed in the page of grid, and the
		     * total number of records for first time load only
		     **/
		  
		    if(checkNbRec(indEventSC))
		    {
		    	setRecords(individualEventBO.returnIndividualEventListForPackageCount(indEventSC));
		    }
		    /**
		     * return the collection of records
		    **/
		    indEventList = individualEventBO.returnIndividualEventListForPackageList(indEventSC);
	
		    /**
		     * set the collection into gridModel attribute defined at JSP grid
		     * tag
		     **/
		    setGridModel(indEventList);
	
		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		}
		return SUCCESS;
    }
    
    /**
     * return Report Attachment Grid
     * @return
     */
    public String returnIndividualEventReportAttachmentForGrid()
    {
		return SUCCESS;
    }
    
    public String retFixedAdditionalTags()
    {
	try
	{
	    String[] searchCol = {"TAG_NAME"};
	    indEventSC.setSearchCols(searchCol);
	    copyproperties(indEventSC);
	    
	    
	    if(StringUtil.nullToEmpty(indEventSC.getSidx()).isEmpty())
	    {
	    	indEventSC.setSidx("TAG_NAME");
	    	indEventSC.setSord("ASC");
	    }
	    	
	    //get the list of tags from ALRT_TAGS
	    if(checkNbRec(indEventSC))
	    {
	    	setRecords(individualEventBO.returnAlertTagsSelectCount(indEventSC));
	    }
	    List<AlrtTagsCO> alrtTagsCOList = individualEventBO.returnAlertTagsSelect(indEventSC);
	    setGridModel(alrtTagsCOList);
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	}
	return SUCCESS;
    }

    public Object getModel() {
		return indEventSC;
	}
	public void setIndividualEventBO(IndividualEventBO individualEventBO) {
		this.individualEventBO = individualEventBO;
	}
	public List<IndividualEventListCO> getIndEventList() {
		return indEventList;
	}
	public void setIndEventList(List<IndividualEventListCO> indEventList) {
		this.indEventList = indEventList;
	}
	public IndividualEventSC getIndEventSC() {
		return indEventSC;
	}
	public void setIndEventSC(IndividualEventSC indEventSC) {
		this.indEventSC = indEventSC;
	}

	public IndividualEventCO getIndividualEventCO()
	{
	    return individualEventCO;
	}

	public void setIndividualEventCO(IndividualEventCO individualEventCO)
	{
	    this.individualEventCO = individualEventCO;
	}    
}

