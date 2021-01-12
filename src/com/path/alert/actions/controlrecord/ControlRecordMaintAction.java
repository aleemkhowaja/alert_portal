package com.path.alert.actions.controlrecord;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.json.JSONException;

import com.path.alert.actions.common.AlertBaseAction;
import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.controlrecord.ControlRecordBO;
import com.path.alert.vo.controlrecord.ControlRecordCO;
import com.path.alert.vo.controlrecord.ControlRecordSC;
import com.path.bo.common.audit.AuditConstant;
import com.path.dbmaps.vo.ALRT_CONTROLVO;
import com.path.lib.common.exception.BaseException;
import com.path.lib.common.util.SecurityUtils;
import com.path.vo.common.SessionCO;
import com.path.vo.common.audit.AuditRefCO;
import com.path.vo.common.select.SelectCO;
import com.path.vo.common.select.SelectSC;

/**
 * 
 * Copyright 2013, Path Solutions Path Solutions retains all ownership rights to
 * this source code
 * 
 * @author: freddymbarak
 * 
 *          java used to
 * 
 */
@SuppressWarnings("serial")
public class ControlRecordMaintAction extends AlertBaseAction {

	private ControlRecordBO controlRecordBO;
	private ControlRecordCO controlRecordCO = new ControlRecordCO();
	private ControlRecordSC controlRecordSC = new ControlRecordSC();
	private List<SelectCO> protocolTypeDropDown = new ArrayList<SelectCO>();
	private boolean isUpdated;
	private boolean isInitialized;
	private List<SelectCO> emailConfigTypeDropDown = new ArrayList<SelectCO>();
	private List<SelectCO> smsConfigTypeDropDown = new ArrayList<SelectCO>();

	public String initialize() {
		//String returnScreen = "controlRecordMaint";
		try {
			set_enableAudit(true);
			set_showSmartInfoBtn("false");
			fillSessionData();
			controlRecordCO.setProgRef(get_pageRef());
			//initList();
			initEmailConfigTypeList();
			initSmsConfigTypeList();
			controlRecordCO = controlRecordBO.initialize(controlRecordCO);
			fillSessionData();
			isInitialized = true;
			//controlRecordCO.setAlrtCtrlVoList(returnListFromCO(controlRecordCO));
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
		}

		return "controlRecordMaint";
	}

	public String fillSmsExpressionVariables()
	{
		try
		{
		    copyproperties(controlRecordSC);
		    controlRecordSC.setNbRec(-1);
		    setGridModel(controlRecordBO.fillSmsExpressionVariables(controlRecordSC));
		}
		catch(Exception e)
		{
		    handleException(e, null, null);
		}
		return SUCCESS;
	}
	
	public String fillEmailExpressionVariables()
	{
		try
		{
			copyproperties(controlRecordSC);
			controlRecordSC.setNbRec(-1);
			setGridModel(controlRecordBO.fillEmailExpressionVariables(controlRecordSC));
		}
		catch(Exception e)
		{
			handleException(e, null, null);
		}
		return SUCCESS;
	}
	
/*	private void initList() throws BaseException {
		SelectSC selSC = new SelectSC(AlertConstant.protocolTypeDropDown);
		protocolTypeDropDown = returnLOV(selSC);
	}*/

	public List<SelectCO> getProtocolTypeDropDown() {
		return protocolTypeDropDown;
	}

	public void setProtocolTypeDropDown(List<SelectCO> protocolTypeDropDown) {
		this.protocolTypeDropDown = protocolTypeDropDown;
	}
	
	private void initEmailConfigTypeList() throws BaseException {
		SelectSC selSC = new SelectSC(AlertConstant.emailConfigTypeDropDown);
		emailConfigTypeDropDown = returnLOV(selSC);
	}
	
	private void initSmsConfigTypeList() throws BaseException {
		SelectSC selSC = new SelectSC(AlertConstant.emailConfigTypeDropDown);
		smsConfigTypeDropDown = returnLOV(selSC);
	}

	public void fillSessionData() throws BaseException {
		SessionCO sessionCO = returnSessionObject();
		controlRecordCO.setCompCode(sessionCO.getCompanyCode());
		controlRecordCO.setBranchCode(sessionCO.getBranchCode());
		controlRecordCO.setAppName(sessionCO.getCurrentAppName());
		controlRecordCO.setLang(sessionCO.getLanguage());
		controlRecordCO.setProgRef(get_pageRef());

	}

	public List<ALRT_CONTROLVO> returnListFromCO(ControlRecordCO ctrlCO) throws BaseException 
	{
		List<ALRT_CONTROLVO> alrtCtrlVoList = new ArrayList<ALRT_CONTROLVO>();
		for (int i = 0; i <= 17; i++) 
		{
			ALRT_CONTROLVO alrtCtrlVO = new ALRT_CONTROLVO();
			alrtCtrlVO.setCOMP_CODE(ctrlCO.getCompCode());
			String reference = "";
			BigDecimal value = BigDecimal.ZERO;
			String valueChar = "";
			switch (i) {
			case 0:
				reference = AlertConstant.ACTIV_FLAG;
				value = ctrlCO.getActivFlag();
				break;
			case 1:
				reference = AlertConstant.ACTIV_EVT;
				value = ctrlCO.getActivEvt();
				break;
			case 2:
				reference = AlertConstant.REACTIV_FLAG;
				value = ctrlCO.getReactivFlag();
				break;
			case 3:
				reference = AlertConstant.REACTIV_EVT;
				value = ctrlCO.getReactivEvt();
				break;
			case 4:
				reference = AlertConstant.MOBILE_FLAG;
				value = ctrlCO.getMobileFlag();
				break;
			case 5:
				reference = AlertConstant.MOBILE_EVT;
				value = ctrlCO.getMobileEvt();
				break;
			case 6:
				reference = AlertConstant.SUSPEND_FLAG;
				value = ctrlCO.getSuspendFlag();
				break;
			case 7:
				reference = AlertConstant.SUSPEND_EVT;
				value = ctrlCO.getSuspendEvt();
				break;
			case 8:
				reference = AlertConstant.PRINT_FLAG;
				value = ctrlCO.getPrintFlag();
				break;
			case 9:
				reference = AlertConstant.ACC_REP_ID;
				value = ctrlCO.getAccRepID();
				break;
/*			case 10:
				reference = AlertConstant.CENTRALIZE_CORE;
				value = ctrlCO.getCentralizeCore();
				break;
*/			case 11:
				reference = AlertConstant.PROTOCOL_TYPE;
				valueChar = ctrlCO.getProtocolType();
				break;
			case 12:
				reference = AlertConstant.SMTP_IP;
				valueChar = ctrlCO.getIpAddress();
				break;
			case 13:
				reference = AlertConstant.SMTP_PORT;
				valueChar = ctrlCO.getPortNumber();
				break;
			case 14:
				reference = AlertConstant.SMTP_SENDER;
				valueChar = ctrlCO.getSenderEmail();
				break;
			case 15:
				reference = AlertConstant.SMTP_USER;
				valueChar = ctrlCO.getUserId();
				break;
			case 16:
				reference = AlertConstant.SMTP_PASSWORD;
				String passStr = "";
				if (isUpdated) {
					ctrlCO.setPasswordChanged(ctrlCO.getPassword());
					passStr = SecurityUtils.encodeB64(ctrlCO.getPassword());
					ctrlCO.setPassword(passStr);
					valueChar = ctrlCO.getPassword();
					isUpdated = false;
				} else {
					if (null == ctrlCO.getPassword() || (" ").equals(ctrlCO.getPassword())) {
						ctrlCO.setPassword("");
						ctrlCO.setPasswordChanged(ctrlCO.getPassword());
						valueChar = ctrlCO.getPassword();
					} else if (isInitialized) {
						ctrlCO.setPassword(SecurityUtils.decodeB64(ctrlCO.getPassword()));
						ctrlCO.setPasswordChanged(ctrlCO.getPassword());
						valueChar = ctrlCO.getPassword();
					} else {
						ctrlCO.setPassword(ctrlCO.getPassword());
						valueChar = ctrlCO.getPassword();
					}
				}
				break;
			case 17:
				reference = AlertConstant.EMAIL_CONFIG_TYPE;
				value = ctrlCO.getEmailConfigType();
				break;
			default:
				reference = null;
				value = null;
			}
			if(reference != null && reference != "") {
				alrtCtrlVO.setCTRL_VALUE(value);
				alrtCtrlVO.setCTRL_VALUE_CHARACTER(valueChar);
				alrtCtrlVO.setCTRL_REFERENCE(reference);
				alrtCtrlVoList.add(alrtCtrlVO);
			}
		}
		return alrtCtrlVoList;
	}

	public String updateCtrlRecord() throws JSONException {
		try {
			fillSessionData();
			/**
			 * call the business layer ...
			 */
			AuditRefCO refCO = initAuditRefCO();
			refCO.setOperationType(AuditConstant.UPDATE);
			refCO.setKeyRef(AuditConstant.ALERT_CTRL_RECORD_KEY_REF);
			controlRecordCO.setAuditRefCO(refCO);

			// get new VO list
			// controlRecordCO.getAlrtCtrlVoList().
			isUpdated = true;
			//controlRecordCO.setAlrtCtrlVoList(returnListFromCO(controlRecordCO));

			controlRecordCO.setAuditObj(returnAuditObject(controlRecordCO.getClass()));

			// get old vo list
			//controlRecordCO.setOldAlrtCtrlVoList(returnListFromCO((ControlRecordCO) controlRecordCO.getAuditObj()));
			controlRecordCO = controlRecordBO.updateControlRecord(controlRecordCO);

		} catch (Exception ex) {
			handleException(ex, null, null);
		}
		return "save";

	}

	public void setControlRecordBO(ControlRecordBO controlRecordBO) {
		this.controlRecordBO = controlRecordBO;
	}

	public ControlRecordCO getControlRecordCO() {
		return controlRecordCO;
	}

	public void setControlRecordCO(ControlRecordCO controlRecordCO) {
		this.controlRecordCO = controlRecordCO;
	}

	public List<SelectCO> getEmailConfigTypeDropDown() {
		return emailConfigTypeDropDown;
	}

	public void setEmailConfigTypeDropDown(List<SelectCO> emailConfigTypeDropDown) {
		this.emailConfigTypeDropDown = emailConfigTypeDropDown;
	}

	public List<SelectCO> getSmsConfigTypeDropDown() {
		return smsConfigTypeDropDown;
	}

	public void setSmsConfigTypeDropDown(List<SelectCO> smsConfigTypeDropDown) {
		this.smsConfigTypeDropDown = smsConfigTypeDropDown;
	}

	public ControlRecordSC getControlRecordSC() {
		return controlRecordSC;
	}

	public void setControlRecordSC(ControlRecordSC controlRecordSC) {
		this.controlRecordSC = controlRecordSC;
	}
	

}
