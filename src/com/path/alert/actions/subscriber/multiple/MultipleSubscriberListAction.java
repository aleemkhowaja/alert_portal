package com.path.alert.actions.subscriber.multiple;

import java.util.List;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.subscriber.multiple.MultipleSubscriberBO;
import com.path.alert.vo.subscriber.multiple.MultipleSubscriberCO;
import com.path.alert.vo.subscriber.multiple.MultipleSubscriberSC;
import com.path.lib.common.util.StringUtil;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;

public class MultipleSubscriberListAction extends GridBaseAction
{

    private MultipleSubscriberBO multipleSubscriberBO;
    private List<MultipleSubscriberCO> multipleSubList;
    protected MultipleSubscriberSC multipleSubscriberSC = new MultipleSubscriberSC();

    
    /**
     * load the data for the screen grid
     * 
     * @return
     */
    public String returnMultiSubscriberListForGrid()
    {
		String[] searchCol = { "alrtSubVO.ID","alrtSubVO.DEFAULT_BRIEF_NAME", "alrtSubVO.DEFAULT_MIDDLE_NAME", "alrtSubVO.DEFAULT_LONG_NAME", "alrtSubVO.DEFAULT_ADDRESS",
			"statusDesc", "alrtSubVO.LANG", "alrtSubVO.CIF_NO", "alrtSubVO.USR_ID", "alrtSubVO.EMAIL_ID", "alrtSubVO.MOBILE_PHONE"};
	
		try
		{
			if(StringUtil.isEmptyString(multipleSubscriberSC.getIsSelectAll()))
			{
				/**
			     * copy the details related to search criteria to the SC
			     **/
			    SessionCO sessionCO = returnSessionObject();
			    multipleSubscriberSC.setSearchCols(searchCol);
			    copyproperties(multipleSubscriberSC);
		
			    multipleSubscriberSC.setLovTypeId(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);
			    multipleSubscriberSC.setLangCode(sessionCO.getLanguage());
			    multipleSubscriberSC.setPageRef(get_pageRef());
			    multipleSubscriberSC.setCurrAppName(sessionCO.getCurrentAppName());
			    multipleSubscriberSC.setIvCrud(getIv_crud());
			  //  multipleSubscriberSC.setNbRec(-1);
			    multipleSubscriberSC.setCompCode(sessionCO.getCompanyCode());
			    multipleSubscriberSC.setStatus(AlertConstant.CRUD_D);
			    /**
			     * set number of rows to be displayed in the page of grid, and the
			     * total number of records for first time load only
			     **/
	/*		    if(getIv_crud().equals(AlertConstant.CRUD_P))
			    {
			    	multipleSubscriberSC.setStatus(AlertConstant.CRUD_P);
			    }
			    else
			     if(getIv_crud().equals(AlertConstant.CRUD_R))
			     {
			    	 multipleSubscriberSC.setStatus(AlertConstant.CRUD_A);
			     }*/
			    
			    /*if(getIv_crud().equals("P"))
			    {*/
			    	if(checkNbRec(multipleSubscriberSC))
				    {
				    	setRecords(multipleSubscriberBO.returnMultiSubscriberCountForGrid(multipleSubscriberSC));
				    }
				    /**
				     * return the collection of records
				     **/
				    multipleSubList = multipleSubscriberBO.returnMultiSubscriberListForGrid(multipleSubscriberSC);
			  //  }
			    /**
			     * set the collection into gridModel attribute defined at JSP grid
			     * tag
			     **/
			    setGridModel(multipleSubList);
			}
	
		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		}
			return SUCCESS;
    }

    public List<MultipleSubscriberCO> getMultipleSubList()
    {
	return multipleSubList;
    }

    public void setMultipleSubList(List<MultipleSubscriberCO> multipleSubList)
    {
	this.multipleSubList = multipleSubList;
    }

    public MultipleSubscriberSC getMultipleSubscriberSC()
    {
	return multipleSubscriberSC;
    }

    public void setMultipleSubscriberSC(MultipleSubscriberSC multipleSubscriberSC)
    {
	this.multipleSubscriberSC = multipleSubscriberSC;
    }

    public void setMultipleSubscriberBO(MultipleSubscriberBO multipleSubscriberBO)
    {
	this.multipleSubscriberBO = multipleSubscriberBO;
    }

    public Object getModel()
    {
	return multipleSubscriberSC;
    }

}
