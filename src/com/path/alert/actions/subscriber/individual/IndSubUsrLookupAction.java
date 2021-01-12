package com.path.alert.actions.subscriber.individual;

import java.util.List;

import com.path.alert.bo.subscriber.individual.IndividualSubscriberBO;
import com.path.bo.common.ConstantsCommon;
import com.path.lib.vo.LookupGrid;
import com.path.lib.vo.LookupGridColumn;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.admin.user.UsrSC;
import com.path.vo.common.SessionCO;

public class IndSubUsrLookupAction extends LookupBaseAction
{

    private IndividualSubscriberBO individualSubscriberBO;

    public void setIndividualSubscriberBO(IndividualSubscriberBO individualSubscriberBO)
    {
	this.individualSubscriberBO = individualSubscriberBO;
    }

    private UsrSC usrSC = new UsrSC();

    @Override
    public Object getModel()
    {
	return usrSC;
    }

    public String constructLookup()
    {
	try
	{
	    // / Design the Grid by defining the column model and column names
	    String[] name = { "usrVO.USER_ID", "usrVO.FIRST_NAME", "usrVO.MIDDLE_NAME", "usrVO.LAST_NAME", "usrVO.EMAIL_ID", "usrVO.MOBILE_PHONE",
		    "usrVO.EMP_COMP_CODE" };
	    String[] colType = { "text", "text", "text", "text", "text", "text", "number" };
	    String[] titles = { getText("userId"), getText("First_Name_eng_key"), getText("Middle_Name_eng_key"),
		    getText("Last_Name_eng_key"), getText("Email_Id_key"), getText("mobile_phone_key"),
		    getText("comp_code_key"), };

	    // Defining the Grid
	    LookupGrid grid = new LookupGrid();
	    grid.setRowNum("5");
	    grid.setUrl("/path/alert/subscriber/individual/IndSubUsrLookupAction_fillUserLookup");

	    List<LookupGridColumn> lsGridColumn = returnStandarColSpecs(name, colType, titles);
	    lookup(grid, lsGridColumn, null, usrSC);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;

    }

    /**
     * Fill the lookup for User data filtered by the defined criteria
     * 
     * @return
     */
    public String fillUserLookup()
    {
	try

	{
	    usrSC.setSearchCols(new String[]{"usrVO.USER_ID", "usrVO.FIRST_NAME", "usrVO.MIDDLE_NAME", "usrVO.LAST_NAME", "usrVO.EMAIL_ID", "usrVO.MOBILE_PHONE",
		    "usrVO.EMP_COMP_CODE"});
	    setSearchFilter(usrSC);
	    copyproperties(usrSC);
	    SessionCO sessionCO = returnSessionObject();
	    usrSC.setCompCode(sessionCO.getCompanyCode());

	    usrSC.setPreferredLanguage(sessionCO.getLanguage());
	    usrSC.setLovTypeId(ConstantsCommon.USER_STATUS_LOV_TYPE);

	    if(checkNbRec(usrSC))
	    {
		setRecords(individualSubscriberBO.getUserLookupCount(usrSC));
	    }
	    setGridModel(individualSubscriberBO.getUserLookupList(usrSC));

	}
	catch(Exception e)
	{
	    log.error(e, "Error in fillLookupData of  UserLookupAction");
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    public UsrSC getUsrSC()
    {
	return usrSC;
    }

    public void setUsrSC(UsrSC usrSC)
    {
	this.usrSC = usrSC;
    }

}
