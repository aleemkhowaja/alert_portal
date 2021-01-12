package com.path.alert.actions.common;

import com.path.alert.bo.common.AlertCommonLibBO;
import com.path.bo.common.ConstantsCommon;
import com.path.lib.common.util.StringUtil;
import com.path.struts2.lib.common.GridParamsSC;
import com.path.struts2.lib.common.base.GridBaseAction;

public class AlertBaseAction extends GridBaseAction {
	
	private AlertCommonLibBO alertCommonLibBO;
    // enable or disable based on OMNI flag
	private boolean enable_omni;

	
	public AlertCommonLibBO getAlertCommonLibBO() {
		return alertCommonLibBO;
	}
	public void setAlertCommonLibBO(AlertCommonLibBO alertCommonLibBO) {
		this.alertCommonLibBO = alertCommonLibBO;
	}
	public boolean isEnable_omni() {
		return enable_omni;
	}
	public void setEnable_omni(boolean enable_omni) {
		this.enable_omni = enable_omni;
	}
	
	
	/**
	 * check if columns send for search 
	 * if yes then check if requesrd columns are available for searchh
	 * @param cols
	 * @param sc
	 * @return
	 */
	public Boolean isColumnsExistForSearch(String cols[], GridParamsSC sc)
	{
	    Boolean result = Boolean.FALSE;
	    /**
	     * Check if no any columns send for search then return false
	     */
	    if (StringUtil.nullToEmpty(sc.get_search()).equalsIgnoreCase(ConstantsCommon.FALSE))
	    {
		return result;
	    }
	  
	    /**
	     * check if one of the required column send for search then search will be allow
	     */
	    for(String col : cols)
	    {
		if(StringUtil.nullToEmpty(sc.getColSearchQuery()).contains(col)  ||
			StringUtil.nullToEmpty(sc.getSearchQuery()).contains(col))
		{
		    result = Boolean.TRUE;
		    break;
		}
		    
	    }
	    
	    return result;
	}
	
	
}
