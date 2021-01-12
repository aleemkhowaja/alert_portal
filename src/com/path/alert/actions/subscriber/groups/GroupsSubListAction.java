package com.path.alert.actions.subscriber.groups;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.subscriber.groups.GroupsSubscriberBO;
import com.path.alert.vo.subscriber.groups.SubscriberGroupsSubscriberSC;
import com.path.alert.vo.subscriber.groups.SubscriberInGroupsSubscriberListCO;
import com.path.lib.common.util.StringUtil;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;

public class GroupsSubListAction extends GridBaseAction
{

    private GroupsSubscriberBO groupsSubscriberBO;
    protected SubscriberGroupsSubscriberSC subInGrpSubSC = new SubscriberGroupsSubscriberSC();
    private String groupId;
    private String lstSerialNo2;
    private String allSelectedRow2;

    public String loadSubGridData()
    {
    	String[] searchCol = { "alertSubVO.ID","alertSubLangVO.BRIEF_NAME","alertSubVO.CIF_NO", "CIF_TYPE","alertSubVO.USR_ID","alertSubVO.CHANNEL_END_USR_ID", "DESCRIPTION" };

	SessionCO sessionCO = returnSessionObject();
	try
	{
	    /**
	     * copy the details related to search criteria to the SC
	     **/
	    subInGrpSubSC.setSearchCols(searchCol);
	    subInGrpSubSC.setLovTypeId(AlertConstant.subscriberTypeDropDown);
	    subInGrpSubSC.setLangCode(sessionCO.getLanguage());
	    subInGrpSubSC.setCompCode(sessionCO.getCompanyCode());
	    if(StringUtil.isNotEmpty(groupId))
	    {
		subInGrpSubSC.setGrpId(new BigDecimal(groupId));
	    }
	    copyproperties(subInGrpSubSC);

	    if(checkNbRec(subInGrpSubSC))
	    {
		setRecords(groupsSubscriberBO.subInGrpSubscriberCount(subInGrpSubSC));
	    }
	    /**
	     * set the collection into gridModel attribute defined at JSP grid
	     * tag
	     **/
	    setGridModel(groupsSubscriberBO.subInGrpSubscriberList(subInGrpSubSC));

	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }

    public String returnAllSelectedRow()
    {
	try
	{
	    String subId = null;
	    SessionCO sessionCO = returnSessionObject();
	    subInGrpSubSC.setLovTypeId(AlertConstant.subscriberTypeDropDown);
	    subInGrpSubSC.setLangCode(sessionCO.getLanguage());
	    if(!("".equals(StringUtil.nullToEmpty(groupId))))
	    {
		subInGrpSubSC.setGrpId(new BigDecimal(groupId));
	    }
	    copyproperties(subInGrpSubSC);

	    StringBuffer sb = new StringBuffer();
	    subInGrpSubSC.setNbRec(-1);

	    SubscriberInGroupsSubscriberListCO subNotInGrpCO = new SubscriberInGroupsSubscriberListCO();

	    subNotInGrpCO = groupsSubscriberBO.returnInGroupData(subInGrpSubSC);
	    ArrayList<LinkedHashMap> serialNoList = subNotInGrpCO.getReturnGridRowsData();
	    for(int i = 0; i < serialNoList.size(); i++)
	    {

		LinkedHashMap dynamicGridRec = serialNoList.get(i);
		Iterator it = dynamicGridRec.entrySet().iterator();
		while(it.hasNext())
		{
		    Map.Entry element = (Map.Entry) it.next();
		    if("SUB_ID".equals(element.getKey()))
		    {
			subId = element.getValue().toString();
			sb.append("\"subId_").append(element.getValue()).append("\":{");
			sb.append("\"SUB_ID\":\"").append(element.getValue()).append("\"},");
		    }
		    if("SELECTEDROW".equals(element.getKey()))
		    {
			sb.append("\"selectedRow_").append(subId).append("\":{");
			sb.append("\"selectedRow\":\"").append(element.getValue()).append("\"},");
		    }
		}
	    }
	    if(sb.length() > 0)
	    {
		setAllSelectedRow2("{" + sb.substring(0, sb.length() - 1).toString() + "}");
	    }
	    else
	    {
		setAllSelectedRow2("");
	    }
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    public String removeSubfromGrp()
    {
	try
	{
	    groupsSubscriberBO.removeSubFromGrp(lstSerialNo2, subInGrpSubSC);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    public void setGroupsSubscriberBO(GroupsSubscriberBO groupsSubscriberBO)
    {
	this.groupsSubscriberBO = groupsSubscriberBO;
    }

    public String getGroupId()
    {
	return groupId;
    }

    public void setGroupId(String groupId)
    {
	this.groupId = groupId;
    }

    public String getLstSerialNo2()
    {
	return lstSerialNo2;
    }

    public void setLstSerialNo2(String lstSerialNo2)
    {
	this.lstSerialNo2 = lstSerialNo2;
    }

    public String getAllSelectedRow2()
    {
	return allSelectedRow2;
    }

    public void setAllSelectedRow2(String allSelectedRow2)
    {
	this.allSelectedRow2 = allSelectedRow2;
    }

    public Object getModel()
    {
	return subInGrpSubSC;
    }
}
