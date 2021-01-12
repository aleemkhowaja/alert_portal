package com.path.alert.actions.subscriber.individual;

import java.math.BigDecimal;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.vo.subscriber.individual.IndividualSubscriberSC;
import com.path.dbmaps.vo.ALRT_SUBVO;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.common.SessionCO;
import com.path.vo.common.select.SelectSC;
import com.path.vo.common.status.StatusCO;

public class IndSubscriberStatusAction extends LookupBaseAction {

	private final IndividualSubscriberSC criteria = new IndividualSubscriberSC();
	private String url;

	/**
	 * Set the status Grid URL and load the Common Status Jsp Page...
	 * 
	 * @return
	 */
	public String search() {
		try {
			ServletContext application = ServletActionContext.getServletContext();
			String theRealPath = application.getContextPath();

			url = theRealPath
					+ "/path/alert/subscriber/individual/IndSubscriberStatusAction_loadStatusGrid.action?subscriberID="
					+ criteria.getSubscriberID();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return "SUCCESS_STATUS";
	}

	/**
	 * get data from Database, convert them to be compatible with statusCO, get
	 * HTML and set the Model.
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String loadStatusGrid() {
		String[] searchCol = { "userName", "status_desc", "status_date" };

		List<StatusCO> resultList;
		List<String> colList;
		try {
			SessionCO sessionCO = returnSessionObject();
			BigDecimal compCode = sessionCO.getCompanyCode();
			BigDecimal branchCode = sessionCO.getBranchCode();

			colList = AlertConstant.getStatusFields;

			SelectSC lovCriteria = new SelectSC();
			lovCriteria.setLanguage(sessionCO.getLanguage());
			lovCriteria.setCompCode(compCode);
			lovCriteria.setLovTypeId(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);

			criteria.setSearchCols(searchCol);
			copyproperties(criteria);
			setSearchFilter(criteria);
			ALRT_SUBVO alrtSubVO = new ALRT_SUBVO();
			alrtSubVO.setCOMP_CODE(compCode);
			alrtSubVO.setBRANCH_CODE(branchCode);
			alrtSubVO.setID(criteria.getSubscriberID());
			
			resultList = returnCommonLibBO().generateStatusList(alrtSubVO, colList, lovCriteria);
			setGridModel(resultList);
		} catch (Exception ex) {
			log.error("Error in the loadStatusGrid method");
			ex.printStackTrace();
		}
		return "loadGrid";
	}

	public Object getModel() {
		return criteria;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public IndividualSubscriberSC getCriteria() {
		return criteria;
	}

}
