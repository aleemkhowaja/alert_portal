package com.path.alert.actions.subscriber.groups;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.subscriber.groups.GroupsSubscriberBO;
import com.path.alert.vo.subscriber.groups.SubscriberGroupsSubscriberListCO;
import com.path.alert.vo.subscriber.groups.SubscriberGroupsSubscriberSC;
import com.path.bo.common.ConstantsCommon;
import com.path.lib.common.util.StringUtil;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;

public class GroupsNotSubListAction extends GridBaseAction
{

    private GroupsSubscriberBO groupsSubscriberBO;
    protected SubscriberGroupsSubscriberSC subGrpSubSC = new SubscriberGroupsSubscriberSC();
    private String groupId;
    private String lstSerialNo;
    private String allSelectedRow;

    public String loadNotSubGridData()
    {
	String[] searchCol = { "alertSubVO.ID","BRIEF_NAME","alertSubVO.CIF_NO", "CIF_TYPE" ,"alertSubVO.USR_ID","alertSubVO.CHANNEL_END_USR_ID", "alertSubLangVO.BRIEF_NAME", "STATUS" };
	SessionCO sessionCO = returnSessionObject();

	try
	{
	    /**
	     * copy the details related to search criteria to the SC
	     **/
	    subGrpSubSC.setSearchCols(searchCol);
	    subGrpSubSC.setLovTypeId(AlertConstant.subscriberTypeDropDown);
	    subGrpSubSC.setLangCode(sessionCO.getLanguage());
	    subGrpSubSC.setCompCode(sessionCO.getCompanyCode());
	    subGrpSubSC.setStatus(ConstantsCommon.STATUS_APPROVED);
	    subGrpSubSC.setSubscriberLovType(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);
	    
	    if(!("".equals(StringUtil.nullToEmpty(groupId))))
	    {
		subGrpSubSC.setGrpId(new BigDecimal(groupId));
	    }
	    copyproperties(subGrpSubSC);

	    if(checkNbRec(subGrpSubSC))
	    {
		setRecords(groupsSubscriberBO.subGrpSubscriberCount(subGrpSubSC));
	    }
	    
	    /**
	     * set the collection into gridModel attribute defined at JSP grid
	     * tag
	     **/
	    setGridModel(groupsSubscriberBO.subGrpSubscriberList(subGrpSubSC));

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
	    subGrpSubSC.setLovTypeId(AlertConstant.subscriberTypeDropDown);
	    subGrpSubSC.setLangCode(sessionCO.getLanguage());
	    if(!("".equals(StringUtil.nullToEmpty(groupId))))
	    {
		subGrpSubSC.setGrpId(new BigDecimal(groupId));
	    }
	    copyproperties(subGrpSubSC);

	    StringBuffer sb = new StringBuffer();
	    subGrpSubSC.setNbRec(-1);

	    SubscriberGroupsSubscriberListCO subNotInGrpCO = new SubscriberGroupsSubscriberListCO();

	    subNotInGrpCO = groupsSubscriberBO.returnNotInGroupData(subGrpSubSC);
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
		setAllSelectedRow("{" + sb.substring(0, sb.length() - 1).toString() + "}");
	    }
	    else
	    {
		setAllSelectedRow("");
	    }
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

    public Object getModel()
    {
	return subGrpSubSC;
    }

    public String getLstSerialNo()
    {
	return lstSerialNo;
    }

    public void setLstSerialNo(String lstSerialNo)
    {
	this.lstSerialNo = lstSerialNo;
    }

    public String getAllSelectedRow()
    {
	return allSelectedRow;
    }

    public void setAllSelectedRow(String allSelectedRow)
    {
	this.allSelectedRow = allSelectedRow;
    }
}
