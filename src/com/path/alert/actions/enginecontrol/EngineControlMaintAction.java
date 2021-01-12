package com.path.alert.actions.enginecontrol;

import java.util.ArrayList;
import java.util.List;

import com.path.alert.actions.common.AlertBaseAction;
import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.common.AlrtCommonConstants;
import com.path.alert.bo.enginecontrol.EngineControlBO;
import com.path.alert.vo.enginecontrol.EngineControlCO;
import com.path.bo.common.ConstantsCommon;
import com.path.lib.common.exception.BOException;
import com.path.vo.common.SessionCO;
import com.path.vo.common.select.SelectCO;
import com.path.vo.common.select.SelectSC;

@SuppressWarnings("serial")
public class EngineControlMaintAction extends AlertBaseAction {

	private EngineControlBO engineControlBO;
	private EngineControlCO engineControlCO = new EngineControlCO();
	private List<SelectCO> messageStatusList = new ArrayList<>();

	/**
	 * initialize the landing page page of the action
	 * @return
	 */
	public String loadEngineControlPage() {
		try {
			set_showSmartInfoBtn("false");
			set_showRecordLogsBtn("false");
			
			// fill session info
			SessionCO sessionCO = returnSessionObject();
			engineControlCO.setLangCode(sessionCO.getLanguage());
			engineControlCO.setLovTypeID(AlertConstant.MESSAGE_STATUS);
			
			SelectSC selSC = new SelectSC(AlertConstant.MESSAGE_STATUS);
			selSC.setLanguage(sessionCO.getLanguage());
			selSC.setOrderCriteria(ConstantsCommon.LOV_ORDER_BY_SPECIFIC_ORDER);
			messageStatusList = returnLOV(selSC);
			
			//check if the DB has OADM  (Omni Admin) Application
			//then we need to hide cif lookup and column from screen
			engineControlCO.setOmniAdminInstalledYN(AlrtCommonConstants.isOmniInstalled ? 
					ConstantsCommon.YES : ConstantsCommon.NO);
			
		} catch (Exception e) {
			handleException(e, null, null);
			return ERROR_ACTION;
		}
		return SUCCESS;
	}
	
	/**
	 * this method make RMI call via BO to alert engine to stop or start engine
	 * control
	 */
	public String startStopEngineNode() {

		try {
			// Status may by S (Stopped) or R (Running)
			if (engineControlCO.getSTATUS().equalsIgnoreCase("S")) {
				engineControlBO.start(engineControlCO);
				engineControlCO.setResponse(AlertConstant.RESPONSE_STATUS_START);
			} else if (engineControlCO.getSTATUS().equalsIgnoreCase("R")) {
				engineControlBO.shutdown(engineControlCO);
				engineControlCO.setResponse(AlertConstant.RESPONSE_STATUS_STOP);
			}
		} catch (Exception e) {
			handleException(e, null, null);
			return ERROR_ACTION;
		}
		return "jsonSuccess";
	}

	
	/**
	 * Validate Start/End date
	 * @return
	 */
	public String returnDependencyByStartTime() {
		try {
			if (engineControlCO.getStartDate() != null && engineControlCO.getEndDate() != null) {

				if (engineControlCO.getStartDate().after(engineControlCO.getEndDate())) {
					throw new BOException(getText("start_date_cannot_greater_end_date"));
				}
			}

		} catch (Exception ex) {
			engineControlCO.setStartDate(null);
			engineControlCO.setEndDate(null);
			handleException(ex, null, null);
		}

		return "jsonSuccess";
	}
	
	
	public EngineControlCO getEngineControlCO() {
		return engineControlCO;
	}

	public void setEngineControlCO(EngineControlCO engineControlCO) {
		this.engineControlCO = engineControlCO;
	}

	public void setEngineControlBO(EngineControlBO engineControlBO) {
		this.engineControlBO = engineControlBO;
	}

	public EngineControlBO getEngineControlBO() {
		return engineControlBO;
	}

	public List<SelectCO> getMessageStatusList() {
		return messageStatusList;
	}

	public void setMessageStatusList(List<SelectCO> messageStatusList) {
		this.messageStatusList = messageStatusList;
	}

}
