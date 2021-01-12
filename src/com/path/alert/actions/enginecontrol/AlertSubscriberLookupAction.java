package com.path.alert.actions.enginecontrol;

import com.path.alert.bo.enginecontrol.EngineControlBO;
import com.path.alert.vo.enginecontrol.EngineControlSC;
import com.path.lib.vo.LookupGrid;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.common.SessionCO;

public class AlertSubscriberLookupAction extends LookupBaseAction {

	private EngineControlBO engineControlBO;
	private EngineControlSC criteria = new EngineControlSC();

	

	public String constructSubIdLookup() {
		try {
			// Design the Grid by defining the column model and column names
			String[] name = { "alertSubVo.ID", "alertSubVo.DEFAULT_BRIEF_NAME"};
			String[] colType = { "number", "text"};
			String[] titles = { getText("sub_id_key"), getText("brief_name_key")};
						
			// Defining the Grid
			LookupGrid grid = new LookupGrid();
			grid.setCaption(getText(""));
			grid.setRowNum("5");
			grid.setUrl("/path/alert/enginecontrol/alertSubscriberLookupAction_fillSubIdLookupQuery");
			lookup(grid, criteria, name, colType, titles);
			
		} catch (Exception e) {
			handleException(e, null, null);
		}

		return SUCCESS;

	}

	public String fillSubIdLookupQuery() {
		try {
			setSearchFilter(criteria);
			copyproperties(criteria);

			SessionCO sessionCO = returnSessionObject();
			criteria.setCompCode(sessionCO.getCompanyCode());
			if (checkNbRec(criteria)) {
				setRecords(engineControlBO.subIdLookupQueryCount(criteria));
			}
			// set the collection into gridModel attribute defined at JSP grid						
			setGridModel(engineControlBO.subIdLookupQueryList(criteria));
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
