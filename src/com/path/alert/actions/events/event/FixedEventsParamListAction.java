package com.path.alert.actions.events.event;

import com.path.alert.bo.events.event.IndividualEventBO;
import com.path.alert.vo.events.event.IndividualEventSC;
import com.path.struts2.lib.common.base.GridBaseAction;

public class FixedEventsParamListAction extends GridBaseAction {
	
	private  IndividualEventBO individualEventBO; 
	private IndividualEventSC indEventSC = new  IndividualEventSC();

	public String loadFixedEvtsParamsGrid() {
		try {
			/**
			 * copy the details related to search criteria to the SC
			 * 
			 */
			copyproperties(indEventSC);
			/**
			 * set number of rows to be displayed in the page of grid, and the
			 * total number of records for first time load only
			 */
		//	List<IndFixedParamListCO> paramListCOs = individualEventBO.indParamList(indEventSC);
			/*if (checkNbRec(indEventSC)) {
				//setRecords(paramListCOs.size());
			}*/

			/**
			 * set the collection into gridModel attribute defined at JSP grid
			 * tag
			 */
			//setGridModel(paramListCOs);
		} catch (Exception e) {
			handleException(e, null, null);

		}
		return SUCCESS;
	}

	public IndividualEventBO getIndividualEventBO() {
		return individualEventBO;
	}

	public void setIndividualEventBO(IndividualEventBO individualEventBO) {
		this.individualEventBO = individualEventBO;
	}

	public IndividualEventSC getIndEventSC() {
		return indEventSC;
	}

	public void setIndEventSC(IndividualEventSC indEventSC) {
		this.indEventSC = indEventSC;
	}

	
}
