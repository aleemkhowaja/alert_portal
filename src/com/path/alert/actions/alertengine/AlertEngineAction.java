package com.path.alert.actions.alertengine;

import java.math.BigDecimal;

import com.path.dbmaps.vo.SYS_PARAM_SCREEN_DISPLAYVO;
import com.path.struts2.lib.common.base.LookupBaseAction;

public class AlertEngineAction extends LookupBaseAction
{
    public String initialize() {
	String returnScreen = "alertEngineMaint";
	    SYS_PARAM_SCREEN_DISPLAYVO facebookBuisnessElement = new SYS_PARAM_SCREEN_DISPLAYVO();
	    
	    facebookBuisnessElement.setIS_READONLY(BigDecimal.ONE);
	    
	/*try {
		set_enableAudit(true);
		set_showSmartInfoBtn("false");
		fillSessionData();
		controlRecordCO.setProgRef(get_pageRef());
		initList();
		controlRecordCO = controlRecordBO.initialize(controlRecordCO);
		fillSessionData();
		isInitialized = true;
		controlRecordCO.setAlrtCtrlVoList(returnListFromCO(controlRecordCO));
		applyRetrieveAudit(AuditConstant.ALERT_CTRL_RECORD_KEY_REF, controlRecordCO, controlRecordCO);
		getAdditionalScreenParams().putAll(controlRecordCO.getRequiredHm());
		// for (int i = 0; i < controlRecordCO.getAlrtCtrlVoList().size();
		// i++) {
		// controlRecordCO.getAuditRefCO().setTrxNbr("CTRL00MT");

		// }
		// applyAuditUponRetrieve(controlRecordCO);

	} catch (Exception e) {
		handleException(e, null, null);
		return ERROR_ACTION;
	}*/

	return returnScreen;
}



public String stopEngine()
{
/*schedulerBO.stopTimer();
lblCurrentStatus = getText("reporting.stopped");*/
return SUCCESS;

}

public String startEngine()
{
/*try
{
    schedulerBO.startEngine();
}
catch(Exception e)
{
    handleException(e, null,null);
}*/
return SUCCESS;
}

}
