package com.path.alert.actions.events.eventpackage;

import java.math.BigDecimal;
import java.util.List;

import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.events.eventpackage.PackageEventBO;
import com.path.alert.vo.events.eventpackage.PackageEventListCO;
import com.path.alert.vo.events.eventpackage.PackageEventSC;
import com.path.struts2.lib.common.base.GridBaseAction;
import com.path.vo.common.SessionCO;

public class PackageEventListAction extends GridBaseAction
{

    private PackageEventBO packageEventBO;
    private List<PackageEventListCO> pkgEvtList;
    protected PackageEventSC pkgEvtSC = new PackageEventSC();
    private BigDecimal pkgId;
    private String iv_crud;

    /**
     * load the data for the screen grid
     * 
     * @return
     */
    public String loadData()
    {
	String[] searchCol = { "PKG_ID", "STATUS", "BRIEF_DESC_ENG", "BRIEF_DESC_ARAB", "LONG_DESC_ENG",
		"LONG_DESC_ARAB" };
	SessionCO sessionCO = returnSessionObject();

	try
	{
	    /**
	     * copy the details related to search criteria to the SC
	     **/
	    pkgEvtSC.setSearchCols(searchCol);
	    pkgEvtSC.setLovTypeId(AlertConstant.SUBSCRIBER_STATUS_LOV_TYPE);
	    pkgEvtSC.setLangCode(sessionCO.getLanguage());
	    pkgEvtSC.setIvCrud(iv_crud);
	    copyproperties(pkgEvtSC);

	    if(checkNbRec(pkgEvtSC))
	    {
		setRecords(packageEventBO.pkgEventCount(pkgEvtSC));
	    }
	    /**
	     * return the collection of records
	     **/
	    pkgEvtList = packageEventBO.pkgEventList(pkgEvtSC);

	    /**
	     * set the collection into gridModel attribute defined at JSP grid
	     * tag
	     **/
	    setGridModel(pkgEvtList);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }

    public PackageEventSC getPkgEvtSC()
    {
	return pkgEvtSC;
    }

    public void setPkgEvtSC(PackageEventSC pkgEvtSC)
    {
	this.pkgEvtSC = pkgEvtSC;
    }

    public List<PackageEventListCO> getPkgEvtList()
    {
	return pkgEvtList;
    }

    public void setPkgEvtList(List<PackageEventListCO> pkgEvtList)
    {
	this.pkgEvtList = pkgEvtList;
    }

    public void setPackageEventBO(PackageEventBO packageEventBO)
    {
	this.packageEventBO = packageEventBO;
    }

    public BigDecimal getPkgId()
    {
	return pkgId;
    }

    public void setPkgId(BigDecimal pkgId)
    {
	this.pkgId = pkgId;
    }

    public String getIv_crud()
    {
	return iv_crud;
    }

    public void setIv_crud(String iv_crud)
    {
	this.iv_crud = iv_crud;
    }

    public Object getModel()
    {
	return pkgEvtSC;
    }
}
