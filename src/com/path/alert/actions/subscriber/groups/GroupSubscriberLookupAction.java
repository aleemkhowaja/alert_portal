package com.path.alert.actions.subscriber.groups;

import java.math.BigDecimal;
import java.util.List;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.common.AlertCommonLibBO;
import com.path.alert.bo.common.AlrtCommonConstants;
import com.path.alert.bo.subscriber.groups.GroupsSubscriberBO;
import com.path.alert.vo.subscriber.groups.SubscriberGroupsSubscriberListCO;
import com.path.alert.vo.subscriber.groups.SubscriberGroupsSubscriberSC;
import com.path.alert.vo.subscriber.groups.SubscriberInGroupsSubscriberListCO;
import com.path.bo.common.ConstantsCommon;
import com.path.lib.common.util.ApplicationContextProvider;
import com.path.lib.common.util.StringUtil;
import com.path.lib.vo.LookupGrid;
import com.path.struts2.lib.common.GridParamsSC;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.common.SessionCO;

public class GroupSubscriberLookupAction  extends LookupBaseAction
{
	private GroupsSubscriberBO groupsSubscriberBO;
    private List<SubscriberGroupsSubscriberListCO> subGrpSubList;
    private List<SubscriberInGroupsSubscriberListCO> subInGrpSubList ;
    private SubscriberGroupsSubscriberSC criteria = new SubscriberGroupsSubscriberSC();
    private String groupId;
    private String progRef="";
    
    
	public String constructSubGroup() 
	{
		try 
		{
			// Design the Grid by defining the column model and column names
			String[] name = { "alertSubVO.ID","alertSubLangVO.BRIEF_NAME","alertSubVO.CIF_NO", "CIF_TYPE" ,
							  "alertSubVO.USR_ID","alertSubVO.CHANNEL_END_USR_ID", "STATUS" };
			String[] colType = { "number", "text", "number", "text", "text", "text", "text"};
			String[] titles = { getText("sub_id_key"), getText("brief_name_key"), getText("cif_no_key"), getText("Cif_Type_key"),
								getText("user_id_key"), getText("channel_end_user_key"), getText("status_key")};

			
			// Defining the Grid
			LookupGrid grid = new LookupGrid();
			grid.setCaption(getText(""));
			grid.setRowNum("5");
			if("GRP00MT".equalsIgnoreCase(progRef) || "GRP00MA".equalsIgnoreCase(progRef)) 
			{
				grid.setUrl("/path/alert/subscriber/groups/GroupSubscriberLookupAction_loadNotSubGridData");
				lookup(grid, criteria, name, colType, titles);
			}
			else if("GRP00P".equalsIgnoreCase(progRef))
			{
				grid.setUrl("/path/alert/subscriber/groups/GroupSubscriberLookupAction_loadSubGridData");
				lookup(grid, criteria, name, colType, titles);
			}
		}
		catch (Exception e) 
		{
			handleException(e, null, null);
		}
		return SUCCESS;
	}
	

    public String loadNotSubGridData()
    {
		try
		{
			setSearchFilter(criteria);
			copyproperties(criteria);

			if(StringUtil.isEmptyString(criteria.getSidx())) 
			{
				criteria.setSidx("CHECKED");
				criteria.setSord("DESC");
			}
			SessionCO sessionCO = returnSessionObject();
			criteria.setLovTypeId(AlertConstant.subscriberTypeDropDown);
			criteria.setLangCode(sessionCO.getLanguage());
			criteria.setCompCode(sessionCO.getCompanyCode());
			criteria.setStatus(ConstantsCommon.STATUS_APPROVED);
			criteria.setSubscriberLovType(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);

			if (!("".equals(StringUtil.nullToEmpty(groupId)))) 
			{
				criteria.setGrpId(new BigDecimal(groupId));
			}
			AlertCommonLibBO alertCommonLibBO = (AlertCommonLibBO) ApplicationContextProvider.getApplicationContext().getBean("alertCommonLibBO");
			criteria.setEnable_omni(AlrtCommonConstants.isOmniInstalled);	
			if (checkNbRec(criteria)) 
			{
				setRecords(groupsSubscriberBO.subGrpSubscriberCount(criteria));
			}
			subGrpSubList = groupsSubscriberBO.subGrpSubscriberList(criteria);

			setGridModel(subGrpSubList);

		} 
		catch (Exception e) 
		{
			handleException(e, null, null);
		}

		return SUCCESS;
    }
    
    public String loadSubGridData()
    {    	
		try 
		{
			setSearchFilter(criteria);
			copyproperties(criteria);

			SessionCO sessionCO = returnSessionObject();
			criteria.setLovTypeId(AlertConstant.subscriberTypeDropDown);
			criteria.setSubscriberLovType(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);
			criteria.setLangCode(sessionCO.getLanguage());
			criteria.setCompCode(sessionCO.getCompanyCode());
			

			if (!("".equals(StringUtil.nullToEmpty(groupId)))) 
			{
				criteria.setGrpId(new BigDecimal(groupId));
			}

			if (checkNbRec(criteria))
			{
				setRecords(groupsSubscriberBO.subInGrpSubscriberCount(criteria));
			}

			subInGrpSubList = groupsSubscriberBO.subInGrpSubscriberList(criteria);

			setGridModel(subInGrpSubList);

		} 
		catch (Exception e) 
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

	public String getProgRef() 
	{
		return progRef;
	}

	public void setProgRef(String progRef) {
		this.progRef = progRef;
	}
	
	@Override
	public Object getModel() 
	{
		return criteria;
	}

	public GridParamsSC getCriteria() 
	{
		return criteria;
	}

	public List<SubscriberGroupsSubscriberListCO> getSubGrpSubList() {
		return subGrpSubList;
	}

	public void setSubGrpSubList(List<SubscriberGroupsSubscriberListCO> subGrpSubList) {
		this.subGrpSubList = subGrpSubList;
	}

	public List<SubscriberInGroupsSubscriberListCO> getSubInGrpSubList() {
		return subInGrpSubList;
	}

	public void setSubInGrpSubList(List<SubscriberInGroupsSubscriberListCO> subInGrpSubList) {
		this.subInGrpSubList = subInGrpSubList;
	}

	public void setCriteria(SubscriberGroupsSubscriberSC criteria) {
		this.criteria = criteria;
	}
	
}
