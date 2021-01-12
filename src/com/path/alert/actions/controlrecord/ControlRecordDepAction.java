package com.path.alert.actions.controlrecord;

import java.math.BigDecimal;

import com.path.alert.bo.controlrecord.ControlRecordBO;
import com.path.alert.vo.controlrecord.ControlRecordCO;
import com.path.lib.common.exception.BaseException;
import com.path.struts2.lib.common.base.BaseAction;
import com.path.vo.common.SessionCO;

/**
 * 
 * @author FreddyMbarak
 * @value ControlRecordDepAction used for dependencies ...
 *
 */
public class ControlRecordDepAction extends BaseAction {

	private ControlRecordCO controlRecordCO = new ControlRecordCO();
	private ControlRecordBO controlRecordBO;

	public String dependencyByBoxes() {
		try {
			fillSessionData();
			controlRecordCO.setIsRequired(BigDecimal.ZERO);
			if (BigDecimal.ONE.equals(controlRecordCO.getCheckBoxFlag())) {
				controlRecordCO.setIsRequired(BigDecimal.ONE);
			} else {
				controlRecordCO.setIsRequired(BigDecimal.ZERO);
			}

			controlRecordCO = controlRecordBO.dependencyByBoxes(controlRecordCO);
			getAdditionalScreenParams().putAll(controlRecordCO.getRequiredHm());

		}

		catch (Exception e) {
			handleException(e, null, null);
		}
		return SUCCESS;
	}
	public String dependencyByProtType(){	
		try
		{
			if (null != controlRecordCO.getProtocolType()
					&& !(("").equals(controlRecordCO.getProtocolType()))) { 	
				fillSessionData();
				controlRecordCO = controlRecordBO.dependencyByProtType(controlRecordCO);
				getAdditionalScreenParams().putAll(controlRecordCO.getRequiredHm());
			}

		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		}

		return SUCCESS;
	}
	
	public String dependencyByEmailConfigType(){	
		try
		{
			fillSessionData();
			controlRecordCO = controlRecordBO.dependencyByEmailConfigType(controlRecordCO);
			getAdditionalScreenParams().putAll(controlRecordCO.getRequiredHm());
		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		}
		return SUCCESS;
	}
	
	public String dependencyBySmsConfigType(){	
		try{
			fillSessionData();
			controlRecordCO = controlRecordBO.dependencySmsConfigType(controlRecordCO);
			getAdditionalScreenParams().putAll(controlRecordCO.getRequiredHm());
		}
		catch(Exception e)
		{
			handleException(e,null,null);
		}
		return SUCCESS;
	}

	public void fillSessionData() throws BaseException {
		SessionCO sessionCO = returnSessionObject();
		controlRecordCO.setCompCode(sessionCO.getCompanyCode());
		controlRecordCO.setBranchCode(sessionCO.getBranchCode());
		controlRecordCO.setAppName(sessionCO.getCurrentAppName());
		//controlRecordCO.setProgRef(sessionCO.getOriginalProgRef());
	}

	public ControlRecordCO getControlRecordCO() {
		return controlRecordCO;
	}

	public void setControlRecordCO(ControlRecordCO controlRecordCO) {
		this.controlRecordCO = controlRecordCO;
	}

	public Object getModel() {
		return controlRecordCO;
	}

	public void setControlRecordBO(ControlRecordBO controlRecordBO) {
		this.controlRecordBO = controlRecordBO;
	}

}
