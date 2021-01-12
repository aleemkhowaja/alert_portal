package com.path.alert.actions.dynamictags;

import com.path.struts2.lib.common.base.BaseAction;

import net.sf.json.JSONException;

import com.path.lib.common.exception.BaseException;

import java.math.BigDecimal;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.dynamictags.DynamicTagsBO;
import com.path.alert.vo.dynamictags.DynamicTagsCO;
import com.path.alert.vo.dynamictags.DynamicTagsSC;
import com.path.vo.common.select.SelectCO;
import com.path.vo.common.select.SelectSC;

import java.util.ArrayList;
import java.util.List;
import com.path.bo.common.ConstantsCommon;
/**
 * 
 * Copyright 2013, Path Solutions
 * Path Solutions retains all ownership rights to this source code 
 * 
 * DynamicTagsMaintAction.java used to
 */
public class DynamicTagsMaintAction extends BaseAction
{
	private DynamicTagsBO dynamicTagsBO;
	
	private BigDecimal dynamicTagSelectedID; 
	private BigDecimal dynamicTagID;
	private  DynamicTagsCO dynamicTagsCO;
	private List<SelectCO> fillTagTypeList           = new ArrayList<SelectCO>();
	
	/*Getter and setter for  filTagTypeList*/
	public List<SelectCO> getFillTagTypeList() {
		return fillTagTypeList;
	}

	public void setFillTagTypeList(List<SelectCO> fillTagTypeList) {
		this.fillTagTypeList = fillTagTypeList;
	}
	
	/*Getter and setter for dynamicTagsCO*/
	public DynamicTagsCO getDynamicTagsCO() 
	{
		return dynamicTagsCO;
	}

	public void setDynamicTagsCO(DynamicTagsCO dynamicTagsCO) 
	{
		this.dynamicTagsCO = dynamicTagsCO;
	}

	/*Getter and setter for dynamicTagID*/
	public BigDecimal getDynamicTagID() 
	{
		return dynamicTagID;
	}

	public void setDynamicTagID(BigDecimal dynamicTagID) 
	{
		this.dynamicTagID = dynamicTagID;
	}

	/*Getter and setter for dynamicTagSelectedID*/
	public BigDecimal getDynamicTagSelectedID() 
	{
		return dynamicTagSelectedID;
	}

	public void setDynamicTagSelectedID(BigDecimal dynamicTagSelectedID) 
	{
		this.dynamicTagSelectedID = dynamicTagSelectedID;
	}
	
	/*Setter for dynamicTagsBO */
	public void setDynamicTagsBO(DynamicTagsBO dynamicTagsBO)
	{
		this.dynamicTagsBO = dynamicTagsBO;
	}
	
	/**Method called to fill "Tag type" drop-down */	
	private void initTagTypeList() {
		try {
			SelectSC selSC = new SelectSC(AlertConstant.LOV_TYPE_ALERT_TAG_TYPE);
			fillTagTypeList = returnLOV(selSC);
		} catch (BaseException e) {
			handleException(e, null, null);
		}
	}
	

	/**Return data related to the select tag*/
	public String returnDynamicTagsByID() 
	{
		try
		{
			 DynamicTagsSC dynamicTagsSC = new  DynamicTagsSC();
			 dynamicTagsSC.setDynTagID(dynamicTagSelectedID);
			 dynamicTagsSC.setProgRef(get_pageRef());
			 // @todo handle case where co is null
			 dynamicTagsCO= dynamicTagsBO.returnDynamicTagsByID(dynamicTagsSC);
			 initTagTypeList();
		}
		
		catch(Exception e)
		{
		    handleException(e, null, null);
		    return "success";
		}
		return "dynamicTagsMaint";
	}
	
   /**Make a loop on the list names to generate them */
	public String loadDynamicTagsPage()
	{
		try
		{
			initTagTypeList();
			set_showNewInfoBtn(ConstantsCommon.TRUE);
			set_showSmartInfoBtn(ConstantsCommon.FALSE);
		    set_searchGridId("dynamicTagsListGridTbl_Id");
		}
		catch(Exception ex)
		{
		    handleException(ex, null, null);
		}
		return "dynamicTagsList";
	}
	
	/**this function used to clear the form*/	
	public String emptyDynamicTagsForm() {
		try
		{
			initTagTypeList();
		  dynamicTagsCO = new DynamicTagsCO();
		  
		}
		catch(Exception e)
		{
		    log.error(e, "");
		}
		return "dynamicTagsMaint";
	}
	
	/**this function used to delete the tag*/	
	 public String deleteDynamicTag(){
		try
		{
			dynamicTagsCO = new DynamicTagsCO();
			dynamicTagsCO.getAlrtTagsVO().setTAG_ID(dynamicTagID);
			//calling BO
			dynamicTagsBO.deleteDynamicTag(dynamicTagsCO);
		    //empty form ( @todo check if can be removed )
			 dynamicTagsCO = new DynamicTagsCO();
		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		}
		return SUCCESS;
	    }	 
	
	 /** Method called on save button click*/
	 public String saveDynamicTags() throws JSONException
	 {
	 try
	 {
		 initTagTypeList();
		 dynamicTagsBO.saveDynamicTags(dynamicTagsCO);
	     //empty ( @todo check if can be removed )
		 dynamicTagsCO = new DynamicTagsCO();
	  }
	   catch(Exception e)
	 {
	     handleException(e, null, null);
	 }
	 return SUCCESS;
	 }

}
