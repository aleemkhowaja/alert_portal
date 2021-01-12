package com.path.alert.actions.events.event;

import java.util.ArrayList;
import java.util.List;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.events.event.OtherLanguagesBO;
import com.path.alert.vo.events.event.IndividualEventSC;
import com.path.alert.vo.events.event.OtherLanguagesCO;
import com.path.alert.vo.events.event.OtherLanguagesSC;
import com.path.bo.common.ConstantsCommon;
import com.path.dbmaps.vo.SYS_PARAM_LANGUAGESVO;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;
import com.path.vo.common.select.SelectCO;
import com.path.vo.common.select.SelectSC;

/**
 * 
 * Copyright 2017, Path Solutions Path Solutions retains all ownership rights to
 * this source code
 * 
 * @author: suhail.shoukathali
 *
 *          CommonLanguagesAction.java used to
 */
public class OtherLanguagesAction extends GridBaseAction
{
    private OtherLanguagesSC otherLanguagesSC = new OtherLanguagesSC();
    private OtherLanguagesBO otherLanguagesBO;
    private List<SYS_PARAM_LANGUAGESVO> languageVO = new ArrayList<SYS_PARAM_LANGUAGESVO>();
    private final List<SelectCO> languageSelect = new ArrayList<SelectCO>();
    private Boolean readOnly = true;
    private String oldStatus;
    private IndividualEventSC individualEventSC = new IndividualEventSC();

	/**
     * Initiate popup
     * @return String
     */
    public String loadPopup()
    {
	if(AlertConstant.CRUD_P.equals(getIv_crud()) && AlertConstant.STATUS_NEW.equals(oldStatus)
		|| (AlertConstant.CRUD_R.equals(getIv_crud()) || AlertConstant.CRUD_SP.equals(getIv_crud())
			|| AlertConstant.CRUD_S.equals(getIv_crud()) || AlertConstant.CRUD_RA.equals(getIv_crud())
			|| AlertConstant.CRUD_A.equals(getIv_crud()))
			&& (AlertConstant.STATUS_APPROVED.equals(oldStatus)
				|| AlertConstant.STATUS_DELETED.equals(oldStatus)
				|| AlertConstant.STATUS_TO_SUSPEND.equals(oldStatus)
				|| AlertConstant.STATUS_SUSPEND.equals(oldStatus)
				|| AlertConstant.STATUS_TO_REACTIVATE.equals(oldStatus)))
	{
	    set_recReadOnly("true");
	}
	return "otherLanguages";
    }
    
    public String loadBodyPopup()
    {
	if(AlertConstant.CRUD_P.equals(getIv_crud()) && AlertConstant.STATUS_NEW.equals(oldStatus)
		|| (AlertConstant.CRUD_R.equals(getIv_crud()) || AlertConstant.CRUD_SP.equals(getIv_crud())
			|| AlertConstant.CRUD_S.equals(getIv_crud()) || AlertConstant.CRUD_RA.equals(getIv_crud())
			|| AlertConstant.CRUD_A.equals(getIv_crud()))
			&& (AlertConstant.STATUS_APPROVED.equals(oldStatus)
				|| AlertConstant.STATUS_DELETED.equals(oldStatus)
				|| AlertConstant.STATUS_TO_SUSPEND.equals(oldStatus)
				|| AlertConstant.STATUS_SUSPEND.equals(oldStatus)
				|| AlertConstant.STATUS_TO_REACTIVATE.equals(oldStatus)))
	{
	    set_recReadOnly("true");
	}
	return "openOtherLangBodyDetailsPopup";
    }

    /**
     * Load languages grid
     * @return String
     */
    public String loadGridData()
    {
	try
	{
		SessionCO sessionCO = returnSessionObject();
	    String[] searchCols = { "langDesc", "DESCRIPTION" };
	    otherLanguagesSC.setSearchCols(searchCols);
	    otherLanguagesSC.setLovTypeId(ConstantsCommon.LANGUAGES_LOV_TYPE);
	    copyproperties(otherLanguagesSC);
	    otherLanguagesSC.setCodesExclude("'"+returnSessionObject().getLanguage()+"'");
	    otherLanguagesSC.setPreferredLanguage(sessionCO.getLanguage());
	    if(checkNbRec(otherLanguagesSC))
	    {
	    	setRecords(otherLanguagesBO.returnOtherLanguagesListCount(otherLanguagesSC));
	    }
	    List<OtherLanguagesCO> otherLanguagesCOs = otherLanguagesBO.returnOtherLanguagesListRec(otherLanguagesSC);
	    setGridModel(otherLanguagesCOs);
	    set_recReadOnly("true");
	    set_ignoreSpecificMenu("true");
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;

    }
    

    /**
     * Fill language select in grid
     * @return String
     */
    public String loadLanguageSelect()
    {
	try
	{
	    SelectSC sc = new SelectSC();
	    SelectCO sco;
	    sc.setLovTypeId(ConstantsCommon.LANGUAGES_LOV_TYPE);
	    sc.setLanguage(returnSessionObject().getLanguage());
	    languageVO = returnCommonLibBO().returnLanguages(sc);
	    
	    languageSelect.add(0, new SelectCO("-1", ""));
	    for(SYS_PARAM_LANGUAGESVO language : languageVO)
	    {
		if(!returnSessionObject().getLanguage().equals(language.getLANG_CODE()))
		{
		    sco = new SelectCO();
		    sco.setCode(language.getLANG_CODE());
		    sco.setDescValue(language.getLANG_NAME());
		    languageSelect.add(sco);
		}
	    }
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }

    public Object getModel()
    {
    	return returnBaseModel(otherLanguagesSC);
    }

    public OtherLanguagesSC getOtherLanguagesSC()
    {
	return otherLanguagesSC;
    }

    public void setOtherLanguagesSC(OtherLanguagesSC otherLanguagesSC)
    {
	this.otherLanguagesSC = otherLanguagesSC;
    }

    public void setOtherLanguagesBO(OtherLanguagesBO otherLanguagesBO)
    {
	this.otherLanguagesBO = otherLanguagesBO;
    }

    public List<SYS_PARAM_LANGUAGESVO> getLanguageVO()
    {
	return languageVO;
    }

    public void setLanguageVO(List<SYS_PARAM_LANGUAGESVO> languageVO)
    {
	this.languageVO = languageVO;
    }

    public List<SelectCO> getLanguageSelect()
    {
	return languageSelect;
    }

    public Boolean getReadOnly()
    {
        return readOnly;
    }

    public void setReadOnly(Boolean readOnly)
    {
        this.readOnly = readOnly;
    }

    public String getOldStatus() 
    {
		return oldStatus;
	}

	public void setOldStatus(String oldStatus) 
	{
		this.oldStatus = oldStatus;
	}
	
	public IndividualEventSC getIndividualEventSC() 
	{
		return individualEventSC;
	}

	public void setIndividualEventSC(IndividualEventSC individualEventSC) 
	{
		this.individualEventSC = individualEventSC;
	}
}
