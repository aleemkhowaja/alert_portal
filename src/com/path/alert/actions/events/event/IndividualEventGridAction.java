package com.path.alert.actions.events.event;

import java.util.ArrayList;
import java.util.List;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.events.event.IndividualEventBO;
import com.path.alert.vo.events.event.IndFixedParamListCO;
import com.path.alert.vo.events.event.IndividualEventCO;
import com.path.alert.vo.events.event.IndividualEventSC;
import com.path.bo.common.ConstantsCommon;
import com.path.dbmaps.vo.ALRT_TAGS_DEFVO;
import com.path.lib.common.exception.BaseException;
import com.path.lib.common.util.NumberUtil;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;
import com.path.vo.common.select.SelectCO;
import com.path.vo.common.select.SelectSC;

public class IndividualEventGridAction extends GridBaseAction {

	private IndividualEventBO individualEventBO;
	private List<IndFixedParamListCO> indFixedParamList;
	private IndFixedParamListCO indFixedParamListCO = new IndFixedParamListCO();	
	private IndividualEventCO individualEventCO = new IndividualEventCO();
	private IndividualEventSC individualEventSC = new IndividualEventSC();
	private ArrayList<SelectCO> fixedOperatorCombo = new ArrayList<SelectCO>();
	
	private ArrayList<SelectCO> cardsparamlist = new ArrayList<SelectCO>();
	private ArrayList<SelectCO> checkparamlist = new ArrayList<SelectCO>();
	private ArrayList<SelectCO> newOldCombo = new ArrayList<SelectCO>();
	private ArrayList<SelectCO> colTypeCombo = new ArrayList<SelectCO>();
	private String iv_crud;

	public String getIv_crud() {
		return iv_crud;
	}

	public void setIv_crud(String iv_crud) {
		this.iv_crud = iv_crud;
	}

	@Override
	public Object getModel() {
		return individualEventSC;
	}
	


	public String loadFixedParam() 
	{
			String[] searchCols = { "OLD_NEW_VAL_LIST", "PARAM_COLUMN_NAME", "PARAM_LABEL", "PARAM_COLUMN_TYPE"};
			try 
			{
				if(individualEventSC.getEventID() != null && !individualEventSC.getEventID().equals(ConstantsCommon.EMPTY_BIGDECIMAL_VALUE))
				{
					SessionCO sessionCO = returnSessionObject();
					individualEventSC.setSearchCols(searchCols);
					copyproperties(individualEventSC);

					individualEventSC.setFixedOperator(AlertConstant.fixedOperator);
					individualEventSC.setParamColumnType(AlertConstant.colTypeLov);
					individualEventSC.setLangCode(sessionCO.getLanguage());

					if (checkNbRec(individualEventSC)) 
					{
						setRecords(individualEventBO.indParamCount(individualEventSC));
					}
					
					indFixedParamList = individualEventBO.indParamList(individualEventSC);
				
					setGridModel(indFixedParamList);
				}
			} catch (Exception e) {
				handleException(e, null, null);
			}
			return SUCCESS;
		//}

/*		else {

			String[] searchCol = { "ID", "FIXED_CODE", "FROM_VALUE", "TO_VALUE", "FIXED_OPERATOR" };

			try {

				SessionCO sessionCO = returnSessionObject();
				individualEventSC.setSearchCols(searchCol);
				copyproperties(individualEventSC);
//				individualEventSC.setEventID(individualEventCO.getAlrtEvtVO().getEVT_ID());
		//		individualEventSC.setFixedEventId(individualEventCO.getAlrtEvtVO().getFIXED_EVENT_ID());
			//	individualEventSC.getAlrtEvtVO().setFIXED_EVENT_ID(new BigDecimal(1));
				indFixedParamList = individualEventBO.loadParamDetails(individualEventSC);

				setGridModel(indFixedParamList);
				
				for (int i = 0; i < indFixedParamList.size(); i++) {
					// individualEventCO.getaLRT_EVT_PARAMSETVO().setID(paramList.get(i).getID());

					if ((AlertConstant.Fixed_EVT_CD).equals(individualEventSC.getAlrtEvtVO().getFIXED_EVENT_ID()))
					{
						indFixedParamList.get(i).setFROM_VALUE1(indFixedParamList.get(i).getFROM_VALUE());
					}
					else if ((AlertConstant.Fixed_EVT_CH).equals(individualEventSC.getAlrtEvtVO().getFIXED_EVENT_ID()))
					{
						indFixedParamList.get(i).setFROM_VALUE2(indFixedParamList.get(i).getFROM_VALUE());
					}
				}
     
			} catch (Exception e) {
				handleException(e, null, null);
			//return ERROR_ACTION;
			}
			return SUCCESS;
		}*/
	}

	public String loadArgumentGridByReportId()
	{
		String[] searchCols = { "rep_ARGUMENTSVO.ARGUMENT_ID", "rep_ARGUMENTSVO.ARGUMENT_NAME","rep_ARGUMENTSVO.ARGUMENT_LABEL","rep_ARGUMENTSVO.ARGUMENT_TYPE"};

		try {
			
			individualEventSC.setSearchCols(searchCols);
			individualEventSC.setNbRec(-1);
			copyproperties(individualEventSC);
			/*if (checkNbRec(individualEventSC)) 
			{
			//	setRecords(individualEventBO.returnArgumentListByReportIdCount(individualEventSC));
			}*/
			//List<IndividualEventCO> queryArgumentList = individualEventBO.returnArgumentListByReportId(individualEventSC);
			//setGridModel(queryArgumentList);
		} catch (Exception e) {
			handleException(e, null, null);
		}
		return SUCCESS;
	}
	
	public String returnEventsQueryArgumentsForGrid()
	{
		//String[] searchCols = { "alrt_EVT_COMM_MODE_ARG_MAPVO.ARG_NAME", "alrt_EVT_COMM_MODE_ARG_MAPVO.MAPPING_TAG_NAME","alrt_EVT_COMM_MODE_ARG_MAPVO.MAPPING_VALUE"};

		try {
			
		//	individualEventSC.setSearchCols(searchCols);
			individualEventSC.setNbRec(-1);
			//copyproperties(individualEventSC);
			
			/*if (checkNbRec(individualEventSC)) {
				setRecords(individualEventBO.returnQueryArgumentListByQueryIdCount(individualEventSC));
			}*/
			
		//	List<ALRT_EVT_COMM_MODE_ARG_MAPVO> queryArgumentList = individualEventBO.returnQueryArgumentListByQueryId(individualEventSC);
			
			//setGridModel(queryArgumentList);
		} catch (Exception e) {
			handleException(e, null, null);
		}
		return SUCCESS;
	}
	
	public String returnEventQueryColumnsForQueryTagsGrid()
	{
		try 
		{
			if(!NumberUtil.isEmptyDecimal(individualEventSC.getQueryId()))
			{
				List<ALRT_TAGS_DEFVO> alrt_TAGS_DEFVOs = individualEventBO.returnColumnListByQueryId(String.valueOf(individualEventSC.getQueryId()));
				setGridModel(alrt_TAGS_DEFVOs);
			}
		}
		catch (Exception e) 
		{
			handleException(e, null, null);
		}
		return SUCCESS;
	}
	
	
	public String loadFixedOperatorCombo() {
		try {
			SelectSC selSC = new SelectSC(AlertConstant.fixedOperator);
			selSC.setPreferredLanguage(returnSessionObject().getPreferredLanguage());
			fixedOperatorCombo = (ArrayList<SelectCO>) returnLOV(selSC);
		} catch (Exception e) {
			handleException(e, null, null);
		}
		return SUCCESS;
	}

	public String loadnewOldValuesCombo() {
		try {
			SelectSC selSC = new SelectSC(AlertConstant.oldNewValue);
			selSC.setPreferredLanguage(returnSessionObject().getPreferredLanguage());
			newOldCombo = (ArrayList<SelectCO>) returnLOV(selSC);
		} catch (BaseException e) {
			handleException(e, null, null);
		}
		return SUCCESS;
	}
	
	/*public String loadColTypeCombo() 
	{
		try {
			SelectSC selSC = new SelectSC(AlertConstant.colTypeLov);
			selSC.setPreferredLanguage(returnSessionObject().getPreferredLanguage());
			colTypeCombo = (ArrayList<SelectCO>) returnLOV(selSC);
		} catch (BaseException e) {
			handleException(e, null, null);
		}
		return SUCCESS;
	}*/
	
	/**
	 * retrieve Columns List and Operators
	 * @return
	 */
	public String loadColumnsCombo()
	{
		try 
		{
			SessionCO sessionCO = returnSessionObject();
			individualEventSC.setParamColumnType(AlertConstant.colTypeLov);
			individualEventSC.setFixedOperator(AlertConstant.fixedOperator);
			individualEventSC.setLangCode(sessionCO.getLanguage());
			individualEventSC.setNbRec(-1);
			if(!individualEventSC.getFixedEventId().equals(ConstantsCommon.EMPTY_BIGDECIMAL_VALUE))
			{
				indFixedParamList = individualEventBO.indParamList(individualEventSC);
				/*IndFixedParamListCO co = new IndFixedParamListCO();
				co.setCOLUMN_ID(new BigDecimal(0));
				co.setPARAM_COLUMN_NAME("Select Columns");
				indFixedParamList.add(0, co);*/
			}
			
			if(individualEventSC.getFixedColumnId() != null && !individualEventSC.getFixedColumnId().equals(ConstantsCommon.EMPTY_BIGDECIMAL_VALUE))
			{
				if( !indFixedParamList.isEmpty())
				{
					indFixedParamListCO = indFixedParamList.get(0);
					SelectSC selSC = new SelectSC(AlertConstant.fixedOperator);
					if(indFixedParamListCO.getPARAM_COLUMN_TYPE() != null && indFixedParamListCO.getPARAM_COLUMN_TYPE().matches("D"))
					{
						selSC.setLovCodesInlude("'<','<=','<>','=','>','>='");
						selSC.setPreferredLanguage(returnSessionObject().getPreferredLanguage());
						fixedOperatorCombo = (ArrayList<SelectCO>) returnLOV(selSC);
					}
					else
						if(indFixedParamListCO.getPARAM_COLUMN_TYPE() != null && indFixedParamListCO.getPARAM_COLUMN_TYPE().matches("N"))
						{
							selSC.setLovCodesInlude("'<','<=','<>','=','>','>=','IN', 'NOT IN'");
							selSC.setPreferredLanguage(returnSessionObject().getPreferredLanguage());
							fixedOperatorCombo = (ArrayList<SelectCO>) returnLOV(selSC);
						}
					else 
						if(indFixedParamListCO.getPARAM_COLUMN_TYPE() != null && indFixedParamListCO.getPARAM_COLUMN_TYPE().matches("V"))
						{
							selSC.setLovCodesInlude("'IN', 'NOT IN','LIKE','NOT LIKE', '=', '<>'");
							selSC.setPreferredLanguage(returnSessionObject().getPreferredLanguage());
							fixedOperatorCombo = (ArrayList<SelectCO>) returnLOV(selSC);
						}
					
					SelectCO selectCO = new SelectCO();
					selectCO.setCode("0");
					selectCO.setDescValue("");
					fixedOperatorCombo.add(0, selectCO);
				}
			}
		} catch (BaseException e) 
		{
			handleException(e, null, null);
		}
		return SUCCESS;
	}
	
	
	public String loadCardsParam() {
		try {
			  SelectSC selSC = new  SelectSC(AlertConstant.cardsparam);
			  selSC.setPreferredLanguage(returnSessionObject().getPreferredLanguage());
			  cardsparamlist = ((ArrayList<SelectCO>)  returnLOV(selSC));
			 

		} catch (BaseException e) {
			handleException(e, null, null);
		}

		return SUCCESS;
	}

	public String loadCheckParam() {
		try {
			SelectSC sel1SC = new SelectSC(AlertConstant.chequebookparam);
			sel1SC.setPreferredLanguage(returnSessionObject().getPreferredLanguage());
			checkparamlist = ((ArrayList<SelectCO>) returnLOV(sel1SC));
		} catch (BaseException e) {
			handleException(e, null, null);
		}

		return SUCCESS;
	}

	public void setIndividualEventBO(IndividualEventBO individualEventBO) {
		this.individualEventBO = individualEventBO;
	}

	public IndividualEventCO getIndividualEventCO() {
		return individualEventCO;
	}

	public void setIndividualEventCO(IndividualEventCO individualEventCO) {
		this.individualEventCO = individualEventCO;
	}

	public ArrayList<SelectCO> getFixedOperatorCombo() {
		return fixedOperatorCombo;
	}

	public void setFixedOperatorCombo(ArrayList<SelectCO> fixedOperatorCombo) {
		this.fixedOperatorCombo = fixedOperatorCombo;
	}

	public IndividualEventSC getIndividualEventSC() {
		return individualEventSC;
	}

	public void setIndividualEventSC(IndividualEventSC individualEventSC) {
		this.individualEventSC = individualEventSC;
	}

	public ArrayList<SelectCO> getCardsparamlist() {
		return cardsparamlist;
	}

	public void setCardsparamlist(ArrayList<SelectCO> cardsparamlist) {
		this.cardsparamlist = cardsparamlist;
	}

	public ArrayList<SelectCO> getCheckparamlist() {
		return checkparamlist;
	}

	public void setCheckparamlist(ArrayList<SelectCO> checkparamlist) {
		this.checkparamlist = checkparamlist;
	}

	public ArrayList<SelectCO> getNewOldCombo() {
		return newOldCombo;
	}

	public void setNewOldCombo(ArrayList<SelectCO> newOldCombo) {
		this.newOldCombo = newOldCombo;
	}

	public ArrayList<SelectCO> getColTypeCombo() {
		return colTypeCombo;
	}

	public void setColTypeCombo(ArrayList<SelectCO> colTypeCombo) {
		this.colTypeCombo = colTypeCombo;
	}

	public List<IndFixedParamListCO> getIndFixedParamList() {
		return indFixedParamList;
	}

	public void setIndFixedParamList(List<IndFixedParamListCO> indFixedParamList) {
		this.indFixedParamList = indFixedParamList;
	}

	public IndFixedParamListCO getIndFixedParamListCO() {
		return indFixedParamListCO;
	}

	public void setIndFixedParamListCO(IndFixedParamListCO indFixedParamListCO) {
		this.indFixedParamListCO = indFixedParamListCO;
	}

}
