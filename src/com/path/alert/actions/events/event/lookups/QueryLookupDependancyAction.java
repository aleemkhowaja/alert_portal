package com.path.alert.actions.events.event.lookups;

import org.apache.struts2.json.JSONException;
import com.path.alert.bo.events.event.IndividualEventBO;
import com.path.alert.vo.events.event.IndividualEventCO;
import com.path.alert.vo.events.event.IndividualEventSC;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.common.SessionCO;

public class QueryLookupDependancyAction extends LookupBaseAction{
	
	//Start Variable
	private IndividualEventSC criteria = new IndividualEventSC();
	private IndividualEventBO individualEventBO;
	private IndividualEventCO individualEventCO;
   // private IRP_AD_HOC_QUERYCO iRP_AD_HOC_QUERYCO;
    //End Variable
    
    
    //Start Methods related to Query Dependancy Lookup
    /**
     * 
     * @return
     * @throws JSONException
     */
	public String dependencyByQueryId() throws JSONException 
	{
		try {
			
		    SessionCO sessionCO = returnSessionObject();
		    criteria.setNbRec(-1);
		    criteria.setCompanyCode(sessionCO.getCompanyCode());
		    criteria.setCurrAppName(sessionCO.getCurrentAppName());
		    set_forceAfterDepEvent("true");
		    individualEventCO   = individualEventBO.returnQueryDetailsById(criteria);
		} catch (Exception e) 
		{
			handleException(e, null, null);
		}
		return SUCCESS;
	}
	//End Methods related to Query Dependancy Lookup
    
	//Start Getter/ Setter Methods
    public void setIndividualEventBO(IndividualEventBO individualEventBO) 
    {
 		this.individualEventBO = individualEventBO;
 	}
 	
 	public IndividualEventSC getCriteria() {
		return criteria;
	}

	public void setCriteria(IndividualEventSC criteria) {
		this.criteria = criteria;
	}

	public IndividualEventCO getIndividualEventCO() {
		return individualEventCO;
	}

	public void setIndividualEventCO(IndividualEventCO individualEventCO) {
		this.individualEventCO = individualEventCO;
	}
	//End Getter/ Setter Methods
}
