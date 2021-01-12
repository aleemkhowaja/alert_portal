package com.path.alert.actions.subscriber.individual;

import java.util.ArrayList;
import java.util.List;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.subscriber.individual.IndividualSubscriberBO;
import com.path.bo.common.ConstantsCommon;
import com.path.lib.common.util.StringUtil;
import com.path.lib.vo.LookupGrid;
import com.path.lib.vo.LookupGridColumn;
import com.path.struts2.lib.common.base.LookupBaseAction;
import com.path.vo.common.SessionCO;
import com.path.vo.core.cif.CifSC;

public class IndividualSubscriberCIFLookupAction extends LookupBaseAction {
	private IndividualSubscriberBO individualSubscriberBO;

	public void setIndividualSubscriberBO(IndividualSubscriberBO individualSubscriberBO) {
		this.individualSubscriberBO = individualSubscriberBO;
	}

	private CifSC criteria = new CifSC();

	@Override
	public Object getModel() {
		return criteria;
	}

	public String constructCifQueryLookup() {
		try {
			// Design the Grid by defining the column model and column names
			String[] name = { "cifVO.BRANCH_CODE", "cifVO.CIF_NO", "cifVO.SHORT_NAME_ENG", "cifVO.LONG_NAME_ENG", "cifVO.ADDITIONAL_REFERENCE", "cifVO.TEL",
					"cifVO.RELATION_CODE", "cifCountryDesc", "cifVO.ID_NO", "cifVO.ID_NO2", "cifType", "cifVO.ONE_OBLIGOR", "cifVO.EMAIL_ID",
					"cifVO.SEXE", "cifVO.SHORT_NAME_ARAB", "cifVO.LONG_NAME_ARAB", "cifVO.CARD_NAME", "cifVO.NICK_NAME", "statusDesc" };
			String[] colType = { "number", "number", "text", "text", "text", "text", "text", "text", "text",
					"text", "text", "text", "text", "text", "text", "text", "text", "text", "text" };
			String[] titles = { getText("Branch_key"), getText("CIF_No_key"), getText("Short_name_eng_key"),
					getText("Long_Name_eng_key"), getText("Additional_Reference_key"), getText("Tel_key"),
					getText("Relation_key"), getText("Country_key"), getText("Id_No_key"),
					getText("Id_No_key"), getText("Cif_Type_key"), getText("One_Obligor_key"), getText("Email_Id_key"),
					getText("Gender_key"), getText("Short_Name_Arab_key"), getText("Long_Name_Arab_key"),
					getText("Card_Name_key"), getText("Nick_Name_key"), getText("Status_key") };

			/*
			 * PTH_CTRL.LANGUAGE (0,Null= Arabic Visible Not Mandatory But
			 * English Mandatory, 1=Arabic Hidden and English Mandatory, 2=
			 * Arabic Visible and Mandatory And English Mandatory , 3= Arabic
			 * Visible and Mandatory English Not Mandatory).
			 */
			if (returnSessionObject().getHideArabicColumns()) {
				name = new String[] { "cifVO.BRANCH_CODE", "cifVO.CIF_NO", "cifVO.SHORT_NAME_ENG", "cifVO.LONG_NAME_ENG",
						"cifVO.ADDITIONAL_REFERENCE", "cifVO.TEL", "cifVO.ECO_SECTOR", "cifVO.RELATION_CODE", "cifVO.COUNTRY", "cifVO.ID_NO", "cifVO.ID_NO2",
						"cifType", "cifVO.ONE_OBLIGOR", "cifVO.EMAIL_ID", "cifVO.SEXE", "cifVO.CARD_NAME", "cifVO.NICK_NAME", "statusDesc" };
				colType = new String[] { "number", "number", "text", "text", "text", "text", "text", "text", "text",
						"text", "text", "text", "text", "text", "text", "text", "text", "text" };
				titles = new String[] { getText("Branch_key"), getText("CIF_No_key"), getText("Short_name_eng_key"),
						getText("Long_Name_eng_key"), getText("Additional_Reference_key"), getText("Tel_key"),
						getText("Eco_Sector_key"), getText("Relation_key"), getText("Country_key"),
						getText("Id_No_key"), getText("Id_No_key"), getText("Cif_Type_key"), getText("One_Obligor_key"),
						getText("Email_Id_key"), getText("Gender_key"), getText("Card_Name_key"),
						getText("Nick_Name_key"), getText("Status_key") };
			}

			// Defining the Grid
			LookupGrid grid = new LookupGrid();
			grid.setCaption(getText("cifList_key"));
			grid.setRowNum("5");
			grid.setUrl("/path/alert/subscriber/individual/IndividualSubscriberCIFLookupAction_fillCifLookupQuery");
			lookup(grid, criteria, name, colType, titles);
		} catch (Exception e) {
			handleException(e, null, null);
		}

		return SUCCESS;

	}

	public String fillCifLookupQuery() {
		try {
			
			/**
			 * For cif performance issue raised by Summit (if there is lacs of records then lookup taking time while loading)
			 * 
			 * Added dontLoadData=true property on cif livesearch
			 * Handled if search/refresh without values that time it will not load the data.
			 * Added by Aleem
			 */
			if (StringUtil.nullToEmpty(criteria.get_search()).equalsIgnoreCase(ConstantsCommon.FALSE))
			{
				return SUCCESS;
			}
			setSearchFilter(criteria);
			copyproperties(criteria);
			criteria.setRaFlag("I");
			/** @todo */
			criteria.setRaStatus("X");
			/** @todo */
			criteria.setRaResident("B");
			// if(getPage() ==1)
			// criteria.set_search("true");
			// else
			// criteria.set_search("false");
			/** @todo */
			SessionCO sessionCO = returnSessionObject();
			criteria.setCompCode(sessionCO.getCompanyCode());
			criteria.setBranchCode(sessionCO.getBranchCode());
			criteria.setLang(sessionCO.getLanguage());
			criteria.setLovTypeId(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);
			if (checkNbRec(criteria)) {
				setRecords(individualSubscriberBO.cifLookupQueryListCount(criteria));
				// criteria.setNbRec(individualSubscriberBO.cifLookupQueryListCount(criteria));
			}
			// set the collection into gridModel attribute defined at JSP grid
			setGridModel(individualSubscriberBO.cifLookupQueryList(criteria));
		} catch (Exception e) {
			handleException(e, null, null);
		}
		return SUCCESS;
	}

	/**
	 * Construct Account Lookup based on the VO returned in the resultMap.
	 * 
	 * @return
	 */
	public String constructAccountQueryLookup() {
		try {
			// Design the Grid by defining the column model and column names
			String[] name = { "BRANCH_CODE", "CURRENCY_CODE", "GL_CODE", "CIF_SUB_NO",
					"SL_NO", "ADDITIONAL_REFERENCE", "BRIEF_NAME_ENG", "LONG_NAME_ENG","IBAN_ACC_NO"};
			String[] colType = { "number", "number", "number", "number", "number", "text", "text", "text", "text" };

			String[] titles = { getText("Branch_Code_key"), getText("Currency_key"), getText("GL_key"),
					getText("CIF_key"), getText("SL_key"), getText("AdditionalReference_key"),
					getText("Short_name_eng_key"), getText("Long_Name_eng_key"), getText("IBAN_Account_Number_key") };

			/*
			 * PTH_CTRL.LANGUAGE (0,Null= Arabic Visible Not Mandatory But
			 * English Mandatory, 1=Arabic Hidden and English Mandatory, 2=
			 * Arabic Visible and Mandatory And English Mandatory , 3= Arabic
			 * Visible and Mandatory English Not Mandatory).
			 */
			if (returnSessionObject().getHideArabicColumns()) {
				name = new String[] { "BRANCH_CODE", "CURRENCY_CODE", "GL_CODE", "CIF_SUB_NO",
						"SL_NO", "ADDITIONAL_REFERENCE", "BRIEF_NAME_ENG", "LONG_NAME_ENG","IBAN_ACC_NO"};
				colType = new String[] { "number", "number", "number", "number", "number", "text", "text", "text", "text"};
				titles = new String[] { getText("Branch_Code_key"), getText("Currency_key"), getText("GL_key"),
						getText("CIF_key"), getText("SL_key"), getText("AdditionalReference_key"),
						getText("Short_name_eng_key"), getText("Long_Name_eng_key"), getText("IBAN_Account_Number_key") };
			}

			// Defining the Grid
			LookupGrid grid = new LookupGrid();
			grid.setCaption(getText("accountList_key") +"(Check records for Exclude Accounts)");
			grid.setRowNum("5");
			grid.setUrl("/path/alert/subscriber/individual/IndividualSubscriberCIFLookupAction_fillAccountLookup");
			List<LookupGridColumn> lsGridColumn = new ArrayList<LookupGridColumn>();
			int cols = name.length;

			for (int i = 0; i < cols; i++) {
				// Defining each column
				LookupGridColumn gridColumn = new LookupGridColumn();
				gridColumn.setName(name[i]);
				gridColumn.setIndex(name[i]);
				gridColumn.setColType(colType[i]);
				gridColumn.setTitle(titles[i]);
				gridColumn.setSearch(true);
				
				if(name[i].equals("ADDITIONAL_REFERENCE") || name[i].equals("IBAN_ACC_NO"))
				{
					gridColumn.setWidth("120");
				}
				else if(name[i].equals("BRIEF_NAME_ENG") || name[i].equals("LONG_NAME_ENG"))
				{
					gridColumn.setWidth("150");
				}
				else
				{
					gridColumn.setWidth("100");
				}
				// adding column to the list
				lsGridColumn.add(gridColumn);
			}
			lookup(grid, lsGridColumn, null, criteria);
		} catch (Exception e) {
			log.error(e, "Error in constructLookup of AccountLookupAction");
		}
		return SUCCESS;
	}

	/**
	 * Fill the lookup account data filtered by the defined criteria
	 * 
	 */
	public String fillAccountLookup() {
		try {
			setSearchFilter(criteria);
			copyproperties(criteria);
			SessionCO sessionCO = returnSessionObject();
			criteria.setUserId(sessionCO.getUserName());
			criteria.setCompCode(sessionCO.getCompanyCode());
			criteria.setBranchCode(sessionCO.getBranchCode());
			if(criteria.getCif_no() != null && !criteria.getCif_no().equals(ConstantsCommon.EMPTY_BIGDECIMAL_VALUE))
			{
				if (checkNbRec(criteria)) {
					setRecords(individualSubscriberBO.accountListCount(criteria));
				}
				// set the collection into gridModel attribute defined at JSP grid
				setGridModel(individualSubscriberBO.accountList(criteria));
			}
		} catch (Exception e) {
			log.error(e, "Error in fillLookupData of AccountLookupAction");
			handleException(e, null, null);
		}
		return SUCCESS;
	}

	public void setCriteria(CifSC criteria) {
		this.criteria = criteria;
	}
	
	public CifSC getCriteria() {
		return criteria;
	}
}
