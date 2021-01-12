/**
 * 
 *//*
package com.path.alert.actions.events.event.lookups;

import java.util.List;

import org.apache.struts2.json.JSONException;

import com.path.alert.bo.events.event.IndividualEventBO;
import com.path.alert.vo.events.event.IndividualEventCO;
import com.path.alert.vo.events.event.IndividualEventSC;
import com.path.alert.vo.events.event.IndividualFixedEventListCO;
import com.path.alert.vo.events.event.IndividualMemoListCO;
import com.path.bo.admin.user.UsrBO;
import com.path.dbmaps.vo.PTH_CTRLVO;
import com.path.lib.common.util.NumberUtil;
import com.path.lib.common.util.StringUtil;
import com.path.lib.vo.LookupGrid;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.admin.user.UsrCO;
import com.path.vo.admin.user.UsrSC;
import com.path.vo.common.SessionCO;

//*//**
 * Copyright 2015, Path Solutions
 * Path Solutions retains all ownership rights to this source code 
 * 
 * @author: RoulaKhalil
 
 *//*
public class FixedMemoIdLookupAction extends LookupBaseAction
{
    private final IndividualEventSC criteria = new IndividualEventSC();
	private IndividualEventBO individualEventBO;
    private List<IndividualMemoListCO> MemoList;
    @Override
    public Object getModel()
    {
	return criteria;
    }
    
    public String constructMemoIdQueryLookup()
    
    {

	try
	{
	    // Design the Grid by defining the column model and column names
	    String[] name = { "CODE","briefDescEng","longDescEng","type"};
	    String[] colType = { "number", "text", "text", "text"};
	    String[] titles = { getText("code_key"),getText("brief_desc_eng_key"),getText("long_desc_eng_key"),getText("type_key")};

	    
	    // Defining the Grid
	    LookupGrid grid = new LookupGrid();
	    grid.setCaption(getText("Memo List"));
	    grid.setRowNum("5");
	    grid.setShrinkToFit("true");
	    grid.setUrl("/path/alert/events/event/lookups/FixedMemoIdLookupAction_fillLookupMemo"); 
	    lookup(grid, criteria, name, colType, titles);
	}
	catch(Exception e)
	{
	    log.error(e, "Error in constructLookup of FixedMemoIdLookupAction");
	    handleException(e, null, null);
	}

	return SUCCESS;

    }

    *//**
     * Fill the lookup 
     * 
     * @return
     * @throws JSONException
     *//*
    public String fillLookupMemo()
    {
	try
	{
	    criteria.setSearchCols(new String[]{ "CODE","BRIEF_DESC_ENG","LONG_DESC_ENG","TYPE"});
	    setSearchFilter(criteria);
	    // Get the data from BO
	    copyproperties(criteria);
	    SessionCO sessionCO = returnSessionObject();
	    
            criteria.setCompanyCode(sessionCO.getCompanyCode());
        if(getRecords() == 0)
	    {
		setRecords(individualEventBO.memoCount(criteria));
	    }
	    MemoList = individualEventBO.memoList(criteria);
	    // set the collection into gridModel attribute defined at JSP grid
	    setGridModel(MemoList);

	}
	catch(Exception e)
	{
	    log.error(e, "Error in fillLookupData of BranchesLookupAction");
	    handleException(e, null, null);
	}
	return SUCCESS;
    }



 	public void setIndividualEventBO(IndividualEventBO individualEventBO) {
 		this.individualEventBO = individualEventBO;
 	}


 	public IndividualEventSC getCriteria() {
 		return criteria;
 	}

	public List<IndividualMemoListCO> getMemoList() {
		return MemoList;
	}

	public void setMemoList(List<IndividualMemoListCO> memoList) {
		MemoList = memoList;
	}


 	
}
*/