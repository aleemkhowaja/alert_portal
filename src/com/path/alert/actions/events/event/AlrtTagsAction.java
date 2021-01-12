package com.path.alert.actions.events.event;

import java.util.List;
import com.path.alert.bo.events.event.IndividualEventBO;
import com.path.alert.vo.events.event.IndividualEventCO;
import com.path.alert.vo.events.event.IndividualEventSC;
import com.path.bo.common.ConstantsCommon;
import com.path.dbmaps.vo.ALRT_TAGS_DEFVO;
import com.path.struts2.lib.common.base.GridBaseAction;

public class AlrtTagsAction extends GridBaseAction {

	/**
	 * 
	 */
	private IndividualEventBO individualEventBO;
	private IndividualEventSC individualEventSC = new IndividualEventSC();
	private IndividualEventCO individualEventCO = new IndividualEventCO();

	/**
	 * return Custom and Default Tags
	 * @return
	 */
	public String returnAlertDefaultTags() {

		try 
		{
			individualEventSC.setNbRec(-1);
			List<ALRT_TAGS_DEFVO> alrttagList  = individualEventBO.returnIndEventCustomDefaultTagList(individualEventSC);
			setGridModel(alrttagList);
		} catch (Exception e) {
			handleException(e, null, null);
			return ERROR_ACTION;
		}
		return SUCCESS;
	}

	/**
	 * return Custom and Default Tags
	 * @return
	 */
	public String returnAlertCustomTags() {

		try 
		{
			if(individualEventSC.getEventID() != null && !individualEventSC.getEventID().equals(ConstantsCommon.EMPTY_BIGDECIMAL_VALUE))
			{
				individualEventSC.setNbRec(-1);
				List<ALRT_TAGS_DEFVO> alrttagList  = individualEventBO.returnIndEventCustomDefaultTagList(individualEventSC);
				setGridModel(alrttagList);
			}
		} catch (Exception e) {
			handleException(e, null, null);
			return ERROR_ACTION;
		}
		return SUCCESS;
	}
	
	//Start Getter/Setter methods
	public void setIndividualEventBO(IndividualEventBO individualEventBO) {
		this.individualEventBO = individualEventBO;
	}

	public IndividualEventSC getIndividualEventSC() {
		return individualEventSC;
	}

	public void setIndividualEventSC(IndividualEventSC individualEventSC) {
		this.individualEventSC = individualEventSC;
	}

	public IndividualEventCO getIndividualEventCO() {
		return individualEventCO;
	}

	public void setIndividualEventCO(IndividualEventCO individualEventCO) {
		this.individualEventCO = individualEventCO;
	}
	//End Getter/Setter methods
}
