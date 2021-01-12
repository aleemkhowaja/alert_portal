package com.path.alert.actions.events.event.lookups;

import java.math.BigDecimal;
import java.util.HashMap;

import org.apache.struts2.json.JSONException;

import com.path.alert.bo.events.event.IndividualEventBO;
import com.path.alert.bo.events.event.IndividualEventConstant;
import com.path.alert.vo.events.event.IndividualEventCO;
import com.path.alert.vo.events.event.IndividualEventSC;
import com.path.bo.common.ConstantsCommon;
import com.path.dbmaps.vo.ALRT_EVT_COMM_MODEVO;
import com.path.dbmaps.vo.SYS_PARAM_SCREEN_DISPLAYVO;
import com.path.lib.common.util.StringUtil;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.common.SessionCO;

public class ReportLookupDependancyAction extends LookupBaseAction{
	
	//Start Variable
	private IndividualEventSC criteria = new IndividualEventSC();
	private IndividualEventCO individualEventCO = new IndividualEventCO();
	private IndividualEventBO individualEventBO;
	private String reportLookup;
    //End Variable
    
    //Start Methods related to Report Dependancy Lookup
    public String dependencyByReportId() throws JSONException 
	{
		try {
				SessionCO sessionCO = returnSessionObject();
				
			    criteria.setCompanyCode(sessionCO.getCompanyCode());
			    criteria.setCurrAppName(sessionCO.getCurrentAppName());
			    criteria.setBranchCode(sessionCO.getBranchCode());
			    criteria.setUserId(sessionCO.getUserName());
			    
			    individualEventCO = individualEventBO.returnReportDetailsById(criteria);

			    //Hide and show Body Text are for email
			    HashMap<String, SYS_PARAM_SCREEN_DISPLAYVO> hm = new HashMap<String, SYS_PARAM_SCREEN_DISPLAYVO>();
			    SYS_PARAM_SCREEN_DISPLAYVO emailTextAreaBuisnessElement = new SYS_PARAM_SCREEN_DISPLAYVO();
		    	ALRT_EVT_COMM_MODEVO email_EVT_COMM_MODEVO = new ALRT_EVT_COMM_MODEVO();
		    	
			    if(StringUtil.isNotEmpty(criteria.getLookupOf() ) && criteria.getLookupOf().equals("report") 
			    		&& individualEventCO.getIrp_AD_HOC_REPORTCO() != null
			    		&& individualEventCO.getIrp_AD_HOC_REPORTCO().getREPORT_ID() != null
			    		&& !individualEventCO.getIrp_AD_HOC_REPORTCO().getREPORT_ID().equals(ConstantsCommon.EMPTY_BIGDECIMAL_VALUE)
			    		)
			    {
					if (!criteria.getReportId().equals(ConstantsCommon.EMPTY_BIGDECIMAL_VALUE)) {
						emailTextAreaBuisnessElement.setIS_READONLY(BigDecimal.ONE);
						email_EVT_COMM_MODEVO.setTEMPLATE_TYPE(IndividualEventConstant.DYNAMIC_TEMPLATE_TYPE);
						individualEventCO.setEmail_EVT_COMM_MODEVO(email_EVT_COMM_MODEVO);
					} else
					{
						emailTextAreaBuisnessElement.setIS_READONLY(BigDecimal.ZERO);
						email_EVT_COMM_MODEVO.setTEMPLATE_TYPE(IndividualEventConstant.STATIC_TEMPLATE_TYPE);
						individualEventCO.setEmail_EVT_COMM_MODEVO(email_EVT_COMM_MODEVO);
					}
					 
			    }
			    else
			    {
			    	emailTextAreaBuisnessElement.setIS_READONLY(BigDecimal.ZERO);
					email_EVT_COMM_MODEVO.setTEMPLATE_TYPE(IndividualEventConstant.STATIC_TEMPLATE_TYPE);
					individualEventCO.setEmail_EVT_COMM_MODEVO(email_EVT_COMM_MODEVO);
			    }
			    hm.put("eventStaticEmailMessageBodyEng", emailTextAreaBuisnessElement);
				 setAdditionalScreenParams(hm);
		} catch (Exception e) {
			handleException(e, null, null);
		}
		return SUCCESS;
	}
    //End Methods related to Report Dependancy Lookup
    
    
    //Start Getter/ Setter Methods
    public void setIndividualEventBO(IndividualEventBO individualEventBO) {
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
	public String getReportLookup() {
		return reportLookup;
	}
	public void setReportLookup(String reportLookup) {
		this.reportLookup = reportLookup;
	}
	//End Getter/ Setter Methods

}
