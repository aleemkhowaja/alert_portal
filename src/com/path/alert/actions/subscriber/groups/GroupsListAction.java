package com.path.alert.actions.subscriber.groups;

import java.util.List;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.subscriber.groups.GroupsSubscriberBO;
import com.path.alert.vo.subscriber.groups.GroupsSubscriberListCO;
import com.path.alert.vo.subscriber.groups.GroupsSubscriberSC;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;

public class GroupsListAction extends GridBaseAction
{

    private GroupsSubscriberBO groupsSubscriberBO;
    private List<GroupsSubscriberListCO> grpSubList;
    protected GroupsSubscriberSC grpSubSC = new GroupsSubscriberSC();
    private String iv_crud;

    /**
     * load the data for the screen grid
     * 
     * @return
     */
    public String loadData()
    {
	String[] searchCol = { "GRP_ID", "STATUS", "BRIEF_DESC_ENG", "BRIEF_DESC_ARAB", "LONG_DESC_ENG",
		"LONG_DESC_ARAB" };
	SessionCO sessionCO = returnSessionObject();

	try
	{
	    /**
	     * copy the details related to search criteria to the SC
	     **/
	    grpSubSC.setSearchCols(searchCol);
	    grpSubSC.setLovTypeId(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);
	    grpSubSC.setLangCode(sessionCO.getLanguage());
	    grpSubSC.setIvCrud(iv_crud);
	    copyproperties(grpSubSC);

	    if(checkNbRec(grpSubSC))
	    {
		setRecords(groupsSubscriberBO.grpSubscriberCount(grpSubSC));
	    }
	    /**
	     * return the collection of records
	     **/
	    grpSubList = groupsSubscriberBO.grpSubscriberList(grpSubSC);

	    /**
	     * set the collection into gridModel attribute defined at JSP grid
	     * tag
	     **/
	    setGridModel(grpSubList);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }

    public GroupsSubscriberSC getGrpSubSC()
    {
	return grpSubSC;
    }

    public void setGrpSubSC(GroupsSubscriberSC grpSubSC)
    {
	this.grpSubSC = grpSubSC;
    }

    public List<GroupsSubscriberListCO> getGrpSubList()
    {
	return grpSubList;
    }

    public void setGrpSubList(List<GroupsSubscriberListCO> grpSubList)
    {
	this.grpSubList = grpSubList;
    }

    public void setGroupsSubscriberBO(GroupsSubscriberBO groupsSubscriberBO)
    {
	this.groupsSubscriberBO = groupsSubscriberBO;
    }

    public String getIv_crud()
    {
	return iv_crud;
    }

    public void setIv_crud(String iv_crud)
    {
	this.iv_crud = iv_crud;
    }

    public Object getModel()
    {
	return grpSubSC;
    }

}
