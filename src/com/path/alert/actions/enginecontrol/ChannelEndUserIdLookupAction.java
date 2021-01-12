package com.path.alert.actions.enginecontrol;

import com.path.alert.bo.enginecontrol.EngineControlBO;
import com.path.alert.vo.enginecontrol.EngineControlSC;
import com.path.lib.vo.LookupGrid;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.common.SessionCO;

public class ChannelEndUserIdLookupAction extends LookupBaseAction {

	private EngineControlBO engineControlBO;
	private EngineControlSC criteria = new EngineControlSC();

	public String constructChannelEndUserIdLookup() {
		try {
			// Design the Grid by defining the column model and column names
			String[] name = { "alertSubVo.CHANNEL_END_USR_ID" };
			String[] colType = { "text" };

			String[] titles = { getText("channel_end_user_key") };

			// Defining the Grid
			LookupGrid grid = new LookupGrid();
			grid.setCaption(getText(""));
			grid.setRowNum("5");
			grid.setUrl("/path/alert/enginecontrol/channelEndUserIdLookupAction_fillChannelEndUserIdLookupQuery");
			lookup(grid, criteria, name, colType, titles);

		} catch (Exception e) {
			handleException(e, null, null);
		}

		return SUCCESS;

	}

	public String fillChannelEndUserIdLookupQuery() {
		try {
			setSearchFilter(criteria);
			copyproperties(criteria);

			SessionCO sessionCO = returnSessionObject();
			criteria.setCompCode(sessionCO.getCompanyCode());		
			if (checkNbRec(criteria)) {
				setRecords(engineControlBO.channelIdLookupQueryCount(criteria));
			}

			// set the collection into gridModel attribute defined at JSP grid
			setGridModel(engineControlBO.channelIdLookupQueryList(criteria));
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
