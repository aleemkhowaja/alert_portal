package com.path.alert.actions.subscription;

import java.util.ArrayList;
import java.util.List;
import com.path.alert.bo.subscription.SubscriptionBO;
import com.path.alert.bo.subscription.SubscriptionConstant;
import com.path.alert.vo.subscription.SubscriptionCO;
import com.path.alert.vo.subscription.SubscriptionSC;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;
import com.path.vo.common.select.SelectCO;

public class SelectSubscriptionDetailsGridAction extends GridBaseAction
{

    private SubscriptionBO subscriptionBO;
    private SubscriptionSC subscriptionSC = new SubscriptionSC();

    private List<SelectCO> subscriptiontypelist = new ArrayList<SelectCO>();
    private SubscriptionCO subscriptionCO = new SubscriptionCO();

    public String LoadSubscriptionDetailsGrid()
    {
	try
	{
	    /**
	     * copy the details related to search criteria to the SC
	     * 
	     */
	    // subscriptionSC.setType("SP");
	    // subscriptionSC.setLineNumber(new BigDecimal(29582));
	    SessionCO sessionCO = returnSessionObject();
	    subscriptionSC.setCompCode(sessionCO.getCompanyCode());
	    subscriptionSC.setBranchCode(sessionCO.getBranchCode());
	    subscriptionSC.setAppName(sessionCO.getCurrentAppName());
	    subscriptionSC
		    .setProgRef(returnCommonLibBO().returnOrginProgRef(sessionCO.getCurrentAppName(), get_pageRef()));
	    subscriptionSC.setLangCode(sessionCO.getLanguage());

	    copyproperties(subscriptionSC);

	    /**
	     * set number of rows to be displayed in the page of grid, and the
	     * total number of records for first time load only
	     */
	    if(checkNbRec(subscriptionSC))
	    {
		setRecords(subscriptionBO.subscriptionDetailsCount(subscriptionSC));
	    }
	    /**
	     * return the collection of records
	     */

	    /**
	     * set the collection into gridModel attribute defined at JSP grid
	     * tag
	     */

	    setGridModel(subscriptionBO.loadSubscriptionDetailsGrid(subscriptionSC));
	    emptyObjects();

	}
	catch(Exception e)
	{
	    handleException(e, null, null);

	}
	return SUCCESS;
    }

    public String viewSubscriptionDetails()
    {

	return SubscriptionConstant.SUB_DETAILS;
    }

    private void emptyObjects()
    {
	subscriptionCO = null;
	subscriptionSC = null;
    }

    public Object getModel()
    {
	return subscriptionSC;
    }

    public void setSubscriptionBO(SubscriptionBO subscriptionBO)
    {
	this.subscriptionBO = subscriptionBO;
    }

    public SubscriptionSC getSubscriptionSC()
    {
	return subscriptionSC;
    }

    public void setSubscriptionSC(SubscriptionSC subscriptionSC)
    {
	this.subscriptionSC = subscriptionSC;
    }

    public List<SelectCO> getSubscriptiontypelist()
    {
	return subscriptiontypelist;
    }

    public void setSubscriptiontypelist(List<SelectCO> subscriptiontypelist)
    {
	this.subscriptiontypelist = subscriptiontypelist;
    }

    public SubscriptionCO getSubscriptionCO()
    {
	return subscriptionCO;
    }

    public void setSubscriptionCO(SubscriptionCO subscriptionCO)
    {
	this.subscriptionCO = subscriptionCO;
    }

}
