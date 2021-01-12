package com.path.alert.actions.reportquery;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.struts2.json.JSONException;

import com.path.actions.CommonReportingAction;
import com.path.alert.bo.reportquery.ReportQueryBO;
import com.path.alert.vo.reportquery.ReportQueryCO;
import com.path.alert.vo.reportquery.ReportQuerySC;
import com.path.bo.common.MessageCodes;
import com.path.dbmaps.vo.IRP_AD_HOC_QUERYVO;
import com.path.lib.common.exception.BOException;
import com.path.lib.common.exception.BaseException;
import com.path.lib.common.util.NumberUtil;
import com.path.lib.vo.LookupGrid;
import com.path.lib.vo.LookupGridColumn;
import com.path.vo.reporting.IRP_REP_ARGUMENTSCO;

public class QueryDesignerAction extends CommonReportingAction
{
    ReportQuerySC querySC = new ReportQuerySC();
    private ReportQueryBO reportQueryBO;
    private BigDecimal queryIdLkp;
    private BigDecimal queryIdRetieved;
    private String queryNameLkp;
    private ReportQueryCO reportQueryCO;

    public void setReportQueryBO(ReportQueryBO reportQueryBO)
    {
	this.reportQueryBO = reportQueryBO;
    }

    public BigDecimal getQueryIdLkp()
    {
	return queryIdLkp;
    }

    public void setQueryIdLkp(BigDecimal queryIdLkp)
    {
	this.queryIdLkp = queryIdLkp;
    }

    public String getQueryNameLkp()
    {
	return queryNameLkp;
    }

    public void setQueryNameLkp(String queryNameLkp)
    {
	this.queryNameLkp = queryNameLkp;
    }

    public ReportQuerySC getQuerySC()
    {
	return querySC;
    }
    
    public Object getModel()
    {
	return querySC;
    }

    public ReportQueryCO getReportQueryCO()
    {
	return reportQueryCO;
    }

    public void setReportQueryCO(ReportQueryCO reportQueryCO)
    {
	this.reportQueryCO = reportQueryCO;
    }

    public BigDecimal getQueryIdRetieved()
    {
        return queryIdRetieved;
    }

    public void setQueryIdRetieved(BigDecimal queryIdRetieved)
    {
        this.queryIdRetieved = queryIdRetieved;
    }

    public String constructQryLookup()
    {
	try
	{
	    // Design the Grid by defining the column model and column names
	    String[] name = { "QUERY_ID", "QUERY_NAME" };
	    String[] colType = { "number", "text" };
	    String[] titles = { getText("query.id"), getText("query_name_key") };

	    // Defining the Grid
	    LookupGrid grid = new LookupGrid();
	    grid.setCaption(getText("queries.list_key"));
	    grid.setRowNum("10");
	    grid.setUrl("/path/reportQuery/QueryDesignerAction_fillQryLookup.action?_pageRef=" + get_pageRef());
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
	    lookup(grid, lsGridColumn, null, querySC);
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
	    setSearchFilter(querySC);
	    copyproperties(querySC);

	    if(getRecords() == 0)
	    {
		setRecords(reportQueryBO.getQueriesCount(querySC));
	    }

	    List<IRP_AD_HOC_QUERYVO> list = reportQueryBO.getQueriesList(querySC);
	    setGridModel(list);
	}
	catch(Exception e)
	{
	    // log.error(e, "Error filling query lookup");
	    handleException(e, "Error filling query lookup", "fillQryLookup.exceptionMsg._key");
	}
	return SUCCESS;
    }

    public String dependencyByQryId() throws JSONException
    {
	try
	{
	    if(NumberUtil.isEmptyDecimal(queryIdLkp))
	    {
		queryNameLkp = null;
		queryIdLkp = null;
	    }
	    else
	    {
		reportQueryCO = new ReportQueryCO();
		reportQueryCO = reportQueryBO.returnQueryById(queryIdLkp, true);
		if(reportQueryCO == null)
		{
		    queryNameLkp = null;
		    queryIdLkp = null;
		    throw new BOException(MessageCodes.INVALID_ENTRY);
		}
		else
		{
		    queryNameLkp = reportQueryCO.getQUERY_NAME();
		    reportQueryCO.setQuerySyntax((reportQueryCO.getSqlObject().getSqbSyntax()).toString());

		    if(reportQueryCO.getQuerySyntax().toLowerCase().indexOf("message_body") == -1
			    || reportQueryCO.getQuerySyntax().toLowerCase().indexOf("email") == -1
			    || reportQueryCO.getQuerySyntax().toLowerCase().indexOf("mobile") == -1)
		    {
			queryNameLkp = null;
			queryIdLkp = null;
			throw new BOException(MessageCodes.PLEASE_ENTER_VALID_QUERY_VAL);
		    }
		}
	    }
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    public String loadLinkQryGrid() throws ClassNotFoundException, BaseException, IOException
    {
	if(NumberUtil.isEmptyDecimal(queryIdLkp)&&NumberUtil.isEmptyDecimal(queryIdRetieved))
	{
	    setRecords(0);
	    setGridModel(null);
	}
	else if(!NumberUtil.isEmptyDecimal(queryIdRetieved))
	{
	    copyproperties(querySC);
	    querySC.setMenuRef(get_pageRef());
	    querySC.setQueryID(queryIdRetieved);
	    querySC.setRepQueryID(querySC.getRepQueryID());
	    int reportQueryArgCnt = reportQueryBO.returnReportQueryArgCount(querySC);
	    setRecords(reportQueryArgCnt);
	    List<ReportQueryCO> reportQueryArgList = reportQueryBO.returnReportQueryArgList(querySC);
 	    setGridModel(reportQueryArgList);
	    
	}
	else
	{
	    copyproperties(querySC);

	    ReportQueryCO queryCO = reportQueryBO.returnQueryById(queryIdLkp, true);
	    LinkedHashMap<Long, IRP_REP_ARGUMENTSCO> arguments;
	    arguments = queryCO.getSqlObject().getArgumentsList();

	    
	    ArrayList<ReportQueryCO> qryArgMaplst = new ArrayList<ReportQueryCO>();
	    ArrayList<IRP_REP_ARGUMENTSCO> lst = new ArrayList(arguments.values());
	    
	    int nbRec = querySC.getNbRec();
	    int recToSkip = querySC.getRecToskip();
	    int maxRec = nbRec + recToSkip;
	    
	    if(arguments.values().size() > 0)
	    {
		for(int i = 0; i < lst.size(); i++)
		{
		    ReportQueryCO reportQueryCO = new ReportQueryCO();
		    reportQueryCO.getReportQueryArgVO().setARG_NAME(lst.get(i).getARGUMENT_NAME());
		    reportQueryCO.getReportQueryArgVO().setARG_ID(new BigDecimal(i+1));
		    reportQueryCO.getReportQueryArgVO().setQUERY_ID(queryIdLkp);
		    qryArgMaplst.add(reportQueryCO);
		}
	    }
	    if(qryArgMaplst.size() < maxRec)
	    {
		maxRec = qryArgMaplst.size();
	    }
	    
	    ArrayList<ReportQueryCO> qryArgMaplst1 = new ArrayList<ReportQueryCO>();
	    for(int i = recToSkip; i < maxRec; i++)
	    {
		qryArgMaplst1.add((ReportQueryCO) qryArgMaplst.get(i));
	    }
 	    setRecords(qryArgMaplst.size());
	    setGridModel(qryArgMaplst1);
	}
	return SUCCESS;
    }
    
    public String retSqlSytaxQuery() throws JSONException
    {
	try
	{
	    if(NumberUtil.isEmptyDecimal(queryIdLkp))
	    {
		throw new BOException(MessageCodes.INVALID_MISSING, new String[] { "queryIdkey" });
	    }
	    else
	    {
		reportQueryCO = new ReportQueryCO();
		reportQueryCO = reportQueryBO.returnQueryById(queryIdLkp, true);
		reportQueryCO.setQuerySyntax((reportQueryCO.getSqlObject().getSqbSyntax()).toString());
	    }
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }
}
