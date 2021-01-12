package com.path.alert.actions.statusmngmnt;

import java.util.List;

import com.path.alert.bo.statusmngmnt.StatusMngmntBO;
import com.path.alert.vo.statusmngmnt.StatusMngmntCO;
import com.path.lib.common.exception.BaseException;
import com.path.lib.vo.GridUpdates;
import com.path.struts2.lib.common.base.BaseAction;
import com.path.vo.common.SessionCO;

/**
 * 
 * Copyright 2013, Path Solutions Path Solutions retains all ownership rights to
 * this source code
 * 
 * StatusMngmntMaintAction.java used to
 */

public class StatusMngmntMaintAction extends BaseAction {

	StatusMngmntCO stmgmtco = new StatusMngmntCO();
	private StatusMngmntBO statusMngmntBO;
	private String subType;

	public String loadStatusMngmntPage() {
		SessionCO sessionCO = returnSessionObject();
		stmgmtco.setLsLang(sessionCO.getPreferredLanguage());
		set_enableAudit(false);
		set_showRecordLogsBtn("false");
		set_showSmartInfoBtn("false");
		try {
			set_searchGridId("statusMngmntListGridTbl_Id");
			stmgmtco.setCompCode(sessionCO.getCompanyCode());
			stmgmtco.setBranchCode(sessionCO.getBranchCode());
			stmgmtco.setProgRef(get_pageRef());
			stmgmtco.setAppName(sessionCO.getCurrentAppName());
			stmgmtco.setStatus(subType);
			stmgmtco = statusMngmntBO.loadStatusMngmntPage(stmgmtco);
			getAdditionalScreenParams().putAll(stmgmtco.getHm());
		} catch (Exception ex) {
			handleException(ex, null, null);
		}

		return "statusMngmntList";
	}

	public String processSuspend() {
		try {

			if (stmgmtco.getStatusGridListString() != null && !stmgmtco.getStatusGridListString().isEmpty()) {
				GridUpdates gridUpdates = getGridUpdates(stmgmtco.getStatusGridListString(), StatusMngmntCO.class,
						true);

				List<StatusMngmntCO> listOfStatusGrid = gridUpdates.getLstAllRec();
				stmgmtco.setStatusGridList(listOfStatusGrid);
			}

			if (stmgmtco.getGroupEventListString() != null && !stmgmtco.getGroupEventListString().isEmpty()) {
				GridUpdates gridUpdates = getGridUpdates(stmgmtco.getGroupEventListString(), StatusMngmntCO.class,
						true);

				List<StatusMngmntCO> listOfStatusGrid = gridUpdates.getLstAllRec();
				stmgmtco.setStatusGridList(listOfStatusGrid);
			}
			if (stmgmtco.getGroupPkgListString() != null && !stmgmtco.getGroupPkgListString().isEmpty()) {
				GridUpdates gridUpdates = getGridUpdates(stmgmtco.getGroupPkgListString(), StatusMngmntCO.class, true);

				List<StatusMngmntCO> listOfStatusGrid = gridUpdates.getLstAllRec();
				stmgmtco.setStatusGridList(listOfStatusGrid);
			}
			if ("SE".equals(stmgmtco.getStatus())) {
				if (stmgmtco.getSubevtListString() != null && !stmgmtco.getSubevtListString().isEmpty()) {
					GridUpdates gridUpdates = getGridUpdates(stmgmtco.getSubevtListString(), StatusMngmntCO.class,
							true);

					List<StatusMngmntCO> listOfStatusGrid = gridUpdates.getLstAllRec();
					stmgmtco.setStatusGridList(listOfStatusGrid);
				}
			}

			if ("SP".equals(stmgmtco.getStatus())) {
				if (stmgmtco.getSubPkgListString() != null && !stmgmtco.getSubPkgListString().isEmpty()) {
					GridUpdates gridUpdates = getGridUpdates(stmgmtco.getSubPkgListString(), StatusMngmntCO.class,
							true);

					List<StatusMngmntCO> listOfStatusGrid = gridUpdates.getLstAllRec();
					stmgmtco.setStatusGridList(listOfStatusGrid);
				}
			}
			SessionCO sessionCO = returnSessionObject();
			stmgmtco.setUserId(sessionCO.getUserName());
			stmgmtco.setRunningDate(sessionCO.getRunningDateRET());
			statusMngmntBO.processSuspend(stmgmtco);
		} catch (BaseException e) {
			// TODO Auto-generated catch block

			handleException(e, null, null);
		}

		return SUCCESS;
	}

	public String processApprove() {
		try {
			SessionCO sessionCO = returnSessionObject();
			stmgmtco.setRunningDate(sessionCO.getRunningDateRET());

			if ("A".equals(stmgmtco.getStatus()) || "SE".equals(stmgmtco.getStatus())) {
				if (stmgmtco.getStatusGridListString() != null && !stmgmtco.getStatusGridListString().isEmpty()) {
					GridUpdates gridUpdates = getGridUpdates(stmgmtco.getStatusGridListString(), StatusMngmntCO.class,
							true);

					List<StatusMngmntCO> listOfStatusGrid = gridUpdates.getLstAllRec();
					stmgmtco.setStatusGridList(listOfStatusGrid);
				}
			}

			if ("EG".equals(stmgmtco.getStatus())) {
				if (stmgmtco.getGroupEventListString() != null && !stmgmtco.getGroupEventListString().isEmpty()) {
					GridUpdates gridUpdates = getGridUpdates(stmgmtco.getGroupEventListString(), StatusMngmntCO.class,
							true);

					List<StatusMngmntCO> listOfStatusGrid = gridUpdates.getLstAllRec();
					stmgmtco.setStatusGridList(listOfStatusGrid);
				}
			}
			if ("GP".equals(stmgmtco.getStatus())) {
				if (stmgmtco.getGroupPkgListString() != null && !stmgmtco.getGroupPkgListString().isEmpty()) {
					GridUpdates gridUpdates = getGridUpdates(stmgmtco.getGroupPkgListString(), StatusMngmntCO.class,
							true);

					List<StatusMngmntCO> listOfStatusGrid = gridUpdates.getLstAllRec();
					stmgmtco.setStatusGridList(listOfStatusGrid);
				}
			}

			if ("A".equals(stmgmtco.getStatus()) || "SE".equals(stmgmtco.getStatus())) {
				if (stmgmtco.getSubevtListString() != null && !stmgmtco.getSubevtListString().isEmpty()) {
					GridUpdates gridUpdates = getGridUpdates(stmgmtco.getSubevtListString(), StatusMngmntCO.class,
							true);

					List<StatusMngmntCO> listOfStatusGrid = gridUpdates.getLstAllRec();
					stmgmtco.setStatusGridList(listOfStatusGrid);
				}
			}

			if ("SP".equals(stmgmtco.getStatus())) {
				if (stmgmtco.getSubPkgListString() != null && !stmgmtco.getSubPkgListString().isEmpty()) {
					GridUpdates gridUpdates = getGridUpdates(stmgmtco.getSubPkgListString(), StatusMngmntCO.class,
							true);

					List<StatusMngmntCO> listOfStatusGrid = gridUpdates.getLstAllRec();
					stmgmtco.setStatusGridList(listOfStatusGrid);
				}
			}
			statusMngmntBO.processApprove(stmgmtco);
		} catch (BaseException e) {
			// TODO Auto-generated catch block

			handleException(e, null, null);
		}

		return SUCCESS;
	}

	public void setStatusMngmntBO(StatusMngmntBO statusMngmntBO) {
		this.statusMngmntBO = statusMngmntBO;
	}

	public StatusMngmntCO getStmgmtco() {
		return stmgmtco;
	}

	public void setStmgmtco(StatusMngmntCO stmgmtco) {
		this.stmgmtco = stmgmtco;
	}

	public String getSubType() {
		return subType;
	}

	public void setSubType(String subType) {
		this.subType = subType;
	}
}
