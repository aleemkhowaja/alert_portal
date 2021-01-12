package com.path.alert.actions.dynamictags;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.dynamictags.DynamicTagsBO;
import com.path.alert.vo.dynamictags.DynamicTagsSC;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;

/**
 * 
 * Copyright 2013, Path Solutions
 * Path Solutions retains all ownership rights to this source code 
 * 
 * DynamicTagsListAction.java used to
 */
public class DynamicTagsListAction extends GridBaseAction
{
	private DynamicTagsBO dynamicTagsBO;
	private DynamicTagsSC dynamicTagsSC = new DynamicTagsSC();
	
	
	/*Get Model*/
	public Object getModel()
	{
		return dynamicTagsSC;
	}
	
	/*Getter and Setter for dynamicTagsSC */
	public DynamicTagsSC getCriteria()
	{
		return dynamicTagsSC;
	}
	public void setCriteria(DynamicTagsSC dynamicTagsSC)
	{
		this.dynamicTagsSC = dynamicTagsSC;
	}
	
	/*Setter for dynamicTagsBO */
	public void setDynamicTagsBO(DynamicTagsBO dynamicTagsBO)
	{
		this.dynamicTagsBO = dynamicTagsBO;
	}
	
	/*Load the Grid*/
	public String loadDynamicTagsGrid()
	{
		try
		{
			SessionCO sessionCO = returnSessionObject();
            copyproperties(dynamicTagsSC);
            dynamicTagsSC.setDynTagType(AlertConstant.LOV_TYPE_ALERT_TAG_TYPE);
            dynamicTagsSC.setDynSessionLang(sessionCO.getLanguage()); 
            int dynTagCnt = dynamicTagsBO.returnDynamicTagsListCount(dynamicTagsSC);
	        setRecords(dynTagCnt);
	        setGridModel(dynamicTagsBO.returnDynamicTagsList(dynamicTagsSC));
		}
		catch(Exception e)
		{
			log.error(e, "Error in loadDynamicTagsGrid of DynamicTagsListAction");
			handleException(e, null, null);
		}
		return SUCCESS;
	}
}
