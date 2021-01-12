package com.path.alert.actions.subscription;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.subscription.SubscriptionBO;
import com.path.alert.bo.subscription.SubscriptionConstant;
import com.path.alert.vo.subscription.SubscriptionCO;
import com.path.alert.vo.subscription.SubscriptionSC;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;
import com.path.vo.common.select.SelectCO;
import com.path.vo.common.select.SelectSC;

public class SelectFixedEventsParamGridAction extends GridBaseAction {
	private SubscriptionBO subscriptionBO;
	private SubscriptionSC subscriptionSC = new SubscriptionSC();
	private List<SelectCO> fixedOperatorList = new ArrayList<SelectCO>();
	private List<SelectCO> fromValueList = new ArrayList<SelectCO>();
	private SubscriptionCO subscriptionCO = new SubscriptionCO();

	public String loadFixedEvtsParamsGrid() {
		try {
			/**
			 * copy the details related to search criteria to the SC
			 * 
			 */
			SessionCO sessionCO = returnSessionObject();
			subscriptionSC.setCompCode(sessionCO.getCompanyCode());
			subscriptionSC.setBranchCode(sessionCO.getBranchCode());
			subscriptionSC.setAppName(sessionCO.getCurrentAppName());
			subscriptionSC
					.setProgRef(returnCommonLibBO().returnOrginProgRef(sessionCO.getCurrentAppName(), get_pageRef()));
			subscriptionSC.setLangCode(sessionCO.getLanguage());
			subscriptionSC.setLovTypeId(AlertConstant.fixedOperator);
			copyproperties(subscriptionSC);

			/**
			 * set number of rows to be displayed in the page of grid, and the
			 * total number of records for first time load only
			 */
			List<SubscriptionCO> evtParamsList = subscriptionBO.loadEventsParamsGrid(subscriptionSC);
			if (checkNbRec(subscriptionSC)) {
				setRecords(evtParamsList.size());
			}

			/**
			 * set the collection into gridModel attribute defined at JSP grid
			 * tag
			 */
			setGridModel(evtParamsList);
			emptyObjects();
		} catch (Exception e) {
			handleException(e, null, null);

		}
		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	public String loadFixedOperatorDropDown() {
		try {
			SelectSC selSC = new SelectSC(new BigDecimal(892));
			List<SelectCO> fixedoperatorList = returnLOV(selSC);
			SelectCO selCO = new SelectCO();
			selCO.setDescValue("");
			fixedOperatorList.add(0, selCO);
			fixedOperatorList.addAll(1, fixedoperatorList);

		} catch (Exception e) {
			handleException(e, null, null);
		}
		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	public String loadFromValueDropDown() {
		try {
			if (SubscriptionConstant.FIVE.equals(subscriptionSC.getFixedEventId())) {
				SelectSC selSC = new SelectSC(SubscriptionConstant.populateChequebook);
				List<SelectCO> fromvalueList = returnLOV(selSC);
				SelectCO selCO = new SelectCO();
				selCO.setDescValue("");
				fromValueList.add(0, selCO);
				fromValueList.addAll(1, fromvalueList);
			} else if (SubscriptionConstant.SIX.equals(subscriptionSC.getFixedEventId())) {
				SelectSC selSC = new SelectSC(SubscriptionConstant.populateCards);
				List<SelectCO> fromvalueList = returnLOV(selSC);
				SelectCO selCO = new SelectCO();
				selCO.setDescValue("");
				fromValueList.add(0, selCO);
				fromValueList.addAll(1, fromvalueList);
			}

		} catch (Exception e) {
			handleException(e, null, null);
		}
		return SUCCESS;
	}

	public String checkIfFixedEvtParamExist() {
		try {
			SessionCO sessionCO = returnSessionObject();
			subscriptionSC.setCompCode(sessionCO.getCompanyCode());
			subscriptionSC.setBranchCode(sessionCO.getBranchCode());
			subscriptionSC.setAppName(sessionCO.getCurrentAppName());
			subscriptionSC
					.setProgRef(returnCommonLibBO().returnOrginProgRef(sessionCO.getCurrentAppName(), get_pageRef()));
			subscriptionSC.setLangCode(sessionCO.getLanguage());

			subscriptionBO.checkIfFixedEvtParamExist(subscriptionSC);
		} catch (Exception e) {
			handleException(e, null, null);
		}
		return SUCCESS;
	}

	public String viewEventsParams() {
		try {
			SubscriptionCO subCO = subscriptionBO.hideFromValueFields(subscriptionSC);
			subscriptionCO.setFixedEventId(subCO.getFixedEventId());
			if (subCO.getEvtParamCount() == 0) {
				if (SubscriptionConstant.FIVE.equals(subCO.getFixedEventId())
						|| SubscriptionConstant.SIX.equals(subCO.getFixedEventId())) {

					ServletActionContext.getRequest().setAttribute("editFixedOperator", false);
					subscriptionCO.setFromValueFlag("1");
				} else {

					ServletActionContext.getRequest().setAttribute("editFixedOperator", true);
					subscriptionCO.setFromValueFlag("0");
				}
			} else {
				if (SubscriptionConstant.FIVE.equals(subCO.getFixedEventId())
						|| SubscriptionConstant.SIX.equals(subCO.getFixedEventId())) {

					ServletActionContext.getRequest().setAttribute("editFixedOperator", true);
					subscriptionCO.setFromValueFlag("1");
				} else {

					ServletActionContext.getRequest().setAttribute("editFixedOperator", true);
					subscriptionCO.setFromValueFlag("0");
				}
			}

			if (AlertConstant.CRUD_P.equals(subscriptionSC.getCrud())
					|| AlertConstant.CRUD_D.equals(subscriptionSC.getCrud())) {
				set_recReadOnly("true");
			}

		} catch (Exception e) {
			handleException(e, null, null);
		}
		return SubscriptionConstant.eventsParam;
	}

	private void emptyObjects() {
		subscriptionCO = null;
		subscriptionSC = null;
	}

	public Object getModel() {
		return subscriptionSC;
	}

	public SubscriptionSC getSubscriptionSC() {
		return subscriptionSC;
	}

	public void setSubscriptionSC(SubscriptionSC subscriptionSC) {
		this.subscriptionSC = subscriptionSC;
	}

	public SubscriptionCO getSubscriptionCO() {
		return subscriptionCO;
	}

	public void setSubscriptionCO(SubscriptionCO subscriptionCO) {
		this.subscriptionCO = subscriptionCO;
	}

	public void setSubscriptionBO(SubscriptionBO subscriptionBO) {
		this.subscriptionBO = subscriptionBO;
	}

	public List<SelectCO> getFixedOperatorList() {
		return fixedOperatorList;
	}

	public void setFixedOperatorList(List<SelectCO> fixedOperatorList) {
		this.fixedOperatorList = fixedOperatorList;
	}

	public List<SelectCO> getFromValueList() {
		return fromValueList;
	}

	public void setFromValueList(List<SelectCO> fromValueList) {
		this.fromValueList = fromValueList;
	}

}
