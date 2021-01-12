package com.path.alert.actions.events.event;

import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.json.JSONException;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.events.event.IndividualEventBO;
import com.path.alert.vo.events.event.IndividualEventCO;
import com.path.alert.vo.events.event.IndividualEventSC;
import com.path.lib.common.exception.BaseException;
import com.path.lib.vo.LookupGrid;
import com.path.lib.vo.LookupGridColumn;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.common.SessionCO;

public class IndividualEventDepAction extends LookupBaseAction {

	private IndividualEventBO individualEventBO;
	private IndividualEventCO individualEventCO = new IndividualEventCO();
	private IndividualEventSC criteria = new IndividualEventSC();
	
	
	
	
	


	public void setIndividualEventBO(IndividualEventBO individualEventBO) {
		this.individualEventBO = individualEventBO;
	}

	public IndividualEventCO getIndividualEventCO() {
		return individualEventCO;
	}

	public void setIndividualEventCO(IndividualEventCO individualEventCO) {
		this.individualEventCO = individualEventCO;
	}

	public IndividualEventSC getCriteria() {
		return criteria;
	}

	public void setCriteria(IndividualEventSC criteria) {
		this.criteria = criteria;
	}



	public void fillSessionData() throws BaseException {
		SessionCO sessionCO = returnSessionObject();
		individualEventCO.setCompCode(sessionCO.getCompanyCode());
		individualEventCO.setBranchCode(sessionCO.getBranchCode());
		individualEventCO.setAppName(sessionCO.getCurrentAppName());
		individualEventCO.setProgRef(criteria.getPageRef());
	}

	public String dependencyByEvtType() throws JSONException {
		try {

			if (null != individualEventCO.getAlrtEvtVO().getEVT_TYPE()
					&& !(("").equals(individualEventCO.getAlrtEvtVO().getEVT_TYPE()))) { 
				fillSessionData();
			//	individualEventCO = individualEventBO.dependencyByEvtType(individualEventCO);
				getAdditionalScreenParams().putAll(individualEventCO.getHm());
			}

		} catch (Exception e) {
			handleException(e, null, null);
		}

		return SUCCESS;
	}
	
    public String dependencyByFixedEvtId() throws JSONException
    {
	try
	{
	    individualEventCO.getAlrtEvtVO().setFIXED_EVENT_ID(criteria.getAlrtEvtVO().getFIXED_EVENT_ID());
	    individualEventCO = individualEventBO.dependencyByFixedEvtId(individualEventCO);
	    individualEventCO.getAlrtEvtVO().setFIXED_EVENT_ID(null);
	    String desc;
	    desc = individualEventBO.fixedEventDescription(criteria);
	    individualEventCO.setBriefDescEng(desc);

	}
	catch(Exception e)
	{
	    individualEventCO.setBriefDescEng(null);
	    criteria.getAlrtEvtVO().setFIXED_EVENT_ID(null);
	    handleException(e, null, null);
	}

	return SUCCESS;
    }
	
//    public String dependencyByEmailTemplateId() throws JSONException
//    {
//	try
//	{
//	    if(NumberUtil.isEmptyDecimal(criteria.getAlrtEvtVO().getEMAIL_TEMPLATE_ID()))
//	    {
//		individualEventCO.getEmailTemplateVO().setTEMPLATE_ID(null);
//		individualEventCO.getEmailTemplateVO().setTEMPLATE_DESC(null);
//		criteria.getAlrtEvtVO().setEMAIL_TEMPLATE_ID(null);
//	    }
//	    else
//	    {
//		individualEventCO.getAlrtEvtVO().setEMAIL_TEMPLATE_ID(criteria.getAlrtEvtVO().getEMAIL_TEMPLATE_ID());
//		//individualEventCO = individualEventBO.dependencyByEmailTemplateId(individualEventCO);
//		if(individualEventCO == null)
//		{
//		    criteria.getAlrtEvtVO().setEMAIL_TEMPLATE_ID(null);
//		    throw new BOException(MessageCodes.INVALID_REPAYMENT_TEMPLATE_CODE);
//		}
//	    }
//
//	}
//	catch(Exception e)
//	{
//	    handleException(e, null, null);
//	}
//
//	return SUCCESS;
//    }
//	public String dependencyByReportId() throws JSONException {
//		try {
//			fillSessionData();
//			NumberUtil.resetEmptyValues(individualEventCO.getAlrtEvtVO());
//			individualEventCO.getAlrtEvtVO().setREPORT_ID(criteria.getAlrtEvtVO().getREPORT_ID());
//			individualEventCO = individualEventBO.dependencyByReportId(individualEventCO);
//			String desc;
//			
//			criteria.setCompCode(individualEventCO.getCompCode());
//			desc = individualEventBO.reportEventDesc(criteria);
//			individualEventCO.setBriefDescEng2(desc);
//			if(eventModeColumnsRep == null) eventModeColumnsRep = new ArrayList<SelectCO>();
//			if(individualEventCO.getAlrtEvtVO().getREPORT_ID() != null){
//				eventModeColumnsRep = individualEventBO.fillListColsRep(individualEventCO);
//			}
//			
//
//		} catch (Exception e) {
//			individualEventCO.setBriefDescEng2(null);
//			criteria.getAlrtEvtVO().setREPORT_ID(null);
//			handleException(e, null, null);
//		}
//
//		return SUCCESS;
//	}
	

	public String dependencyByMemoId() throws JSONException {
		try {
			fillSessionData();
			individualEventCO.getAlrtEvtVO().setMEMO_ID(criteria.getAlrtEvtVO().getMEMO_ID());
		//	individualEventCO = individualEventBO.dependencyByMemoId(individualEventCO);			
			criteria.setCompCode(individualEventCO.getCompCode());
		//	desc = individualEventBO.fixedEventDescriptionMemo(criteria);
	//		individualEventCO.setBriefDescEng1(desc);

		} catch (Exception e) {
			individualEventCO.setBriefDescEng1(null);
			criteria.getAlrtEvtVO().setMEMO_ID(null);
			handleException(e, null, null);
		}

		return SUCCESS;
	}
	
	
	public String dependencyByModeType() throws JSONException {
	  try {

				if (null != individualEventCO.getAlrtEvtVO().getEVT_MODE()
						&& !(("").equals(individualEventCO.getAlrtEvtVO().getEVT_MODE()))) { 
					fillSessionData();
					//individualEventCO = individualEventBO.dependencyByModeType(individualEventCO);
					getAdditionalScreenParams().putAll(individualEventCO.getHm());
				}

			} catch (Exception e) {
				handleException(e, null, null);
			}

			return SUCCESS;
		}
	

	
	public String dependencyByPeriodType() throws JSONException {
		  try {

					if (null != individualEventCO.getAlrtEvtVO().getPERIOD_TYPE()
							&& !(("").equals(individualEventCO.getAlrtEvtVO().getPERIOD_TYPE()))) { 
						fillSessionData();
					//	individualEventCO = individualEventBO.dependencyByPeriodType(individualEventCO);
						getAdditionalScreenParams().putAll(individualEventCO.getHm());
					}

				} catch (Exception e) {
					handleException(e, null, null);
				}

				return SUCCESS;
			}
	
	
	public String dependencyByEvtDate() throws JSONException {
		/*try {

			// individualEventCO = individualEventBO.dependencyByEvtDate(individualEventCO);

		} catch (Exception e) {
			handleException(e, null, null);
		}*/

		return SUCCESS;
	}
	
	public String constructQryLookup()
    {
		try
		{
		    // Design the Grid by defining the column model and column names
		    String[] name = { "VALUE_DESC"};
		    String[] colType = {"text"};
		    String[] titles = { getText("mode_type_key")};
	
		    // Defining the Grid
		    LookupGrid grid = new LookupGrid();
		    grid.setCaption("Event Mode List");
		    grid.setRowNum("10");
		    grid.setUrl("/path/alert/events/event/IndividualEventDepAction_fillQryLookup.action?_pageRef=" + get_pageRef());
		    int cols = name.length;
		    List<LookupGridColumn> lsGridColumn = new ArrayList<LookupGridColumn>();
	
		    for(int i = 0; i < cols; i++)
		    {
			// Defining each column
			LookupGridColumn gridColumn = new LookupGridColumn();
			gridColumn.setName(name[i]);
			gridColumn.setIndex(name[i]);
			gridColumn.setColType(colType[i]);
			gridColumn.setTitle(titles[i]);
			gridColumn.setSearch(true);
			// adding column to the list
			lsGridColumn.add(gridColumn);
		    }
		    lookup(grid, lsGridColumn, null, criteria);
		}
		catch(Exception e)
		{
		    // log.error(e, "Error constructing the query lookup");
		    handleException(e, "Error constructing the query lookup", "constructingQryLkp.exceptionMsg._key");
		}
	
		return SUCCESS;
    }

    public String fillQryLookup() throws JSONException
    {
	try
	{
		SessionCO sessionCO = returnSessionObject();
	    setSearchFilter(criteria);
	    copyproperties(criteria);
	    criteria.setLangCode(sessionCO.getLanguage());
	    criteria.setModeType(AlertConstant.eventModeOmni);

	    /*if(getRecords() == 0)
	    {
	    	//setRecords(individualEventBO.returnEventModeListCount(criteria));
	    }*/

	 //   List<SYS_PARAM_LOV_TRANSVO> tempIdList = individualEventBO.returnEventModeList(criteria);
	   // setGridModel(tempIdList);
	}
	catch(Exception e)
	{
	    // log.error(e, "Error filling query lookup");
	    handleException(e, "Error filling query lookup", "fillQryLookup.exceptionMsg._key");
	}
	return SUCCESS;
    }
	
@Override
	public Object getModel() {
		return criteria;
	}


	

}
