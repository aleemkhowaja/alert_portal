package com.path.alert.actions.enginecontrol;

import com.path.alert.bo.enginecontrol.EngineControlBO;
import com.path.alert.vo.enginecontrol.EngineControlSC;
import com.path.lib.vo.LookupGrid;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.common.SessionCO;

public class AlertUserLookupAction extends LookupBaseAction {

	private EngineControlBO engineControlBO;
	private EngineControlSC criteria = new EngineControlSC();

	

	public String constructUserLookup() {
		try {
			// Design the Grid by defining the column model and column names
			String[] name = { "alertSubVo.USR_ID", "alertSubVo.MOBILE_PHONE", "alertSubVo.EMAIL_ID" };
			String[] colType = { "text", "text", "text" };
			String[] titles = { getText("user_id_key"), getText("mobile_phone_key"), getText("email_id_key")};

			
			// Defining the Grid
			LookupGrid grid = new LookupGrid();
			grid.setCaption(getText(""));
			grid.setRowNum("5");
			grid.setUrl("/path/alert/enginecontrol/alertUserLookupAction_fillUserLookupQuery");
			lookup(grid, criteria, name, colType, titles);
			
		} catch (Exception e) {
			handleException(e, null, null);
		}

		return SUCCESS;

	}

	public String fillUserLookupQuery() {
		try {
			setSearchFilter(criteria);
			copyproperties(criteria);

			SessionCO sessionCO = returnSessionObject();
			criteria.setCompCode(sessionCO.getCompanyCode());
			if (checkNbRec(criteria)) {
				setRecords(engineControlBO.alertUserLookupQueryCount(criteria));
			}

			// set the collection into gridModel attribute defined at JSP grid
			setGridModel(engineControlBO.alertUserLookupQueryList(criteria));
		} catch (Exception e) {
			handleException(e, null, null);
		}
		return SUCCESS;
	}

	
	public EngineControlBO getEngineControlBO() {
		return engineControlBO;
	}

	public void setEngineControlBO(EngineControlBO engineControlBO) {
		this.engineControlBO = engineControlBO;
	}

	@Override
	public Object getModel() {
		return criteria;
	}

	public EngineControlSC getCriteria() {
		return criteria;
	}

	public void setCriteria(EngineControlSC criteria) {
		this.criteria = criteria;
	}
	
}
