<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt" uri="/path-toolbar-tags"%>

<ps:set name="ivcrud_${_pageRef}" value="iv_crud" />
<ps:set name="reportQueryStatus_${_pageRef}" value="reportQueryCO.reportQueryVO.STATUS" />

<ps:hidden id="queryIdLkp_${_pageRef}" name="reportQueryCO.reportQueryVO.QUERY_ID" />
<ps:hidden id="repQueryID_${_pageRef}" name="reportQueryCO.reportQueryVO.REP_QUER_ID" />

<ps:hidden id="ivcrud_${_pageRef}"  name="iv_crud"/>


<script type="text/javascript">

	$(document).ready(
			function()
			{
				$.struts2_jquery.require("ReportQueryMaint.js", null,jQuery.contextPath + "/path/js/reportquery/");
				
				$("#reportQueryMaintFormId_" + _pageRef).processAfterValid("reportQueryMaint_processSubmit", {});
				
			});
	$("#linkQryGridId_" + _pageRef).subscribe(
			"ChangedQryMapParam", function() {
				reportquery_ChangedQryMapParam();
			});
</script>

<ps:form useHiddenProps="true" id="reportQueryMaintFormId_${_pageRef}">
<ps:hidden id="reportQueryStatus_${_pageRef}" name="reportQueryCO.reportQueryVO.STATUS" />	
<ps:hidden id="reportQueryArgId_${_pageRef}" name="reportQueryCO.reportQueryVO.ARG_ID" />	
<ps:hidden id="DATE_UPDATED_${_pageRef}" name="reportQueryCO.reportQueryVO.DATE_UPDATED" />
	<table width="100%" cellpadding="0" cellspacing="0"
		class="headerPortionContent ui-widget-content" border="0">
		<tr>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
		</tr>
		<tr>
			<td colspan="1">
				<ps:label value="%{getText('Code_key')}" for="Code_${_pageRef}"/>
			</td>
			<td colspan="1">
				<ps:textfield name="reportQueryCO.reportQueryVO.REP_QUER_ID"
				id="Code_${_pageRef}" readonly="true">
				</ps:textfield>
			</td>
			<td colspan="8"></td>
		</tr>
		<tr>
			<td colspan="1"><ps:label value="%{getText('queryIdkey')}" for="lookuptxt_queryLkp_${_pageRef}"/></td>
			<td colspan="1"><psj:livesearch
					actionName="${pageContext.request.contextPath}/path/reportQuery/QueryDesignerAction_constructQryLookup.action?_pageRef=${_pageRef}"
					name="reportQueryCO.reportQueryVO.QUERY_ID"
					id="queryLkp_${_pageRef}" searchElement="QUERY_ID, QUERY_NAME"
					autoSearch="true"
					paramList="QUERY_ID:lookuptxt_queryLkp_${_pageRef},_pageRef:_pageRef"
					resultList="QUERY_ID:lookuptxt_queryLkp_${_pageRef},QUERY_NAME:queryLkpName"
					parameter="repArgName:repArgsName_${_pageRef},queryIdLkp:lookuptxt_queryLkp_${_pageRef},_pageRef:_pageRef"
					dependencySrc="${pageContext.request.contextPath}/path/reportQuery/QueryDesignerAction_dependencyByQryId"
					dependency="lookuptxt_queryLkp_${_pageRef}:queryIdLkp,queryLkpName_${_pageRef}:queryNameLkp"
					afterDepEvent="reloadLinkQryGrid()" required="true"/></td>
			<td colspan="2">
				<ps:textfield name="reportQueryCO.queryDesc"
				id="queryLkpName_${_pageRef}" readonly="true">
				</ps:textfield>
			</td>
			<td colspan="1">
				<psj:submit button="true" type="button" onclick="reportQueryMaint_onDetailsClicked();">
					<ps:text name="Details_key"/>
				</psj:submit>
			</td>
			<td colspan="2"></td>
			<td colspan="1">
				<ps:textfield name="reportQueryCO.statusDesc"
				id="statusDesc_${_pageRef}" readonly="true"
				cssStyle="text-align:center">
				</ps:textfield>
			</td>
			<td colspan="1"><psj:a button="true" href="#"
					buttonIcon="ui-icon-triangle-2-s"
					onclick="reportQuery_onStatusClicked()">
					<ps:text name='status_key' />
				</psj:a></td>
			<td colspan="1"></td>
		</tr>
		<tr>
			<td colspan="1"><ps:label
					key="type_key" for="subscription_type_${_pageRef}" />
			</td>
			<td class="fldDataEdit center" colspan="1"><ps:select
					id="subscription_type_${_pageRef}"
					name="reportQueryCO.reportQueryVO.QYERY_TYPE" list="subscriptiontypelist"
					listValue="descValue" listKey="code" emptyOption="false"
					dependencySrc="" parameter="" dependency=""
					onchange="reloadLinkQryGrid()">

				</ps:select></td>
		</tr>
	</table>

	<ps:url id="urlGrid" action="QueryDesignerAction_loadLinkQryGrid" escapeAmp="false" namespace="/path/reportQuery">
		<ps:param name="_pageRef" value="_pageRef" />
		<ps:param name="queryIdLkp" value="lookuptxt_queryLkp_${_pageRef}" />
		<ps:param name="subscType" value="subscription_type_${_pageRef}" />
		<ps:param name="repQueryID" value="reportQueryCO.reportQueryVO.REP_QUER_ID" />
		<ps:param name="queryIdRetieved" value="reportQueryCO.reportQueryVO.QUERY_ID" />
	</ps:url>

	<psjg:grid
	     	id="linkQryGridId_${_pageRef}" 
	     	dataType="json"  
	     	href="%{urlGrid}"  
	     	editurl="%{urlGrid}" 
	     	gridModel="gridModel" 
	     	pager="true"  
	     	rowNum="5" 
	     	rowList="5,10,15,20" 
	     	viewrecords="true" 
	     	navigator="true"	 
	     	navigatorAdd="false"  
	     	navigatorEdit="false" 
	     	editinline="true" 
	     	navigatorRefresh="false" 
	  		navigatorView="false" 
	  		navigatorSearch="false" 
	   		navigatorDelete="false" 
	   		onEditInlineBeforeTopics="ChangedQryMapParam"
	      >

		<psjg:gridColumn name="reportQueryArgVO.ARG_NAME" id="ARG_NAME"
			searchoptions="{sopt:['eq','ne','lt','gt','le','ge']}"
			index="ARG_NAME" colType="text"
			title="%{getText('retrieval_argument')}" sortable="true" width="50"
			hidden="false" editable="false" />
		<psjg:gridColumn name="reportQueryArgVO.MAPPING_ARG"
			title="%{getText('mapping_argument')}" index="MAPPING_ARG"
			id="MAPPING_ARG" colType="select" editable="true" sortable="true"
			edittype="select" loadOnce="true" required="true" formatter="select"
			editoptions="{value:function(){return loadCombo('${pageContext.request.contextPath}/path/reportQuery/ReportQueryMaintAction_initTypeList.action','typeList', 'code', 'descValue');}}" />
		<psjg:gridColumn name="reportQueryArgVO.ARG_ID" id="ARG_ID"
			searchoptions="{sopt:['eq','ne','lt','gt','le','ge']}" index="ARG_ID"
			colType="number" title="%{getText('retrieval_argument')}"
			sortable="true" width="50" hidden="true" editable="false" />
		<psjg:gridColumn name="reportQueryArgVO.QUERY_ID" id="QUERY_ID"
			searchoptions="{sopt:['eq','ne','lt','gt','le','ge']}"
			index="QUERY_ID" colType="number"
			title="%{getText('retrieval_argument')}" sortable="true" width="50"
			hidden="true" editable="false" />
		<psjg:gridColumn name="reportQueryArgVO.DATE_UPDATED" id="DATE_UPDATED"  formatoptions="{srcformat:'Y-m-d H:i:s.u',newformat:'d/m/Y H:i:s:u' }"  index="DATE_UPDATED"
		    colType="date" title="DATE_UPDATED" sortable="true" editable="false" hidden="true"/>
	</psjg:grid> 

	<ptt:toolBar id="reportQueryMaintToolBar_${_pageRef}"
		hideInAlert="true">
		<ps:if test='%{#ivcrud_${_pageRef}=="R"}'>
			<ps:if
				test='%{#reportQueryStatus_${_pageRef}==null || #reportQueryStatus_${_pageRef}=="N"}'>
				<psj:submit id="reportQueryMaint_save_${_pageRef}" button="true"
					freezeOnSubmit="true">
					<ps:label key="Save_key" for="reportQueryMaint_save_${_pageRef}" />
				</psj:submit>
			</ps:if>

			<ps:if test='%{#reportQueryStatus_${_pageRef}=="N"}'>
				<psj:submit id="reportQueryMaint_delete_${_pageRef}" button="true"
					type="button" freezeOnSubmit="true"
					onclick="reportQueryMaint_onDelClicked()">
					<ps:label key="Delete_key"
						for="reportQueryMaint_delete_${_pageRef}" />
				</psj:submit>
			</ps:if>
		</ps:if>
		<ps:if test='%{#ivcrud_${_pageRef}=="P"}'>
			<psj:submit id="reportQueryMaint_approve_${_pageRef}" button="true"
				freezeOnSubmit="true" onclick="reportQueryMaint_processApprove()">
				<ps:label key="approve_key"
					for="reportQueryMaint_approve_${_pageRef}" />
			</psj:submit>
		</ps:if>
		<ps:if test='%{#ivcrud_${_pageRef}=="F"}'>
			<psj:submit id="reportQueryMaint_UpdateAfterApprove_${_pageRef}"
				button="true" freezeOnSubmit="true">
				<ps:label key="Update_After_Approve_key"
					for="reportQueryMaint_UpdateAfterApprove_${_pageRef}" />
			</psj:submit>
		</ps:if>
	</ptt:toolBar>
	
	<div class="clearfix">
      <ps:url id="reportQueryDetailUrl"  namespace="/path/reportQuery" action="ReportQueryMaintAction_openDetails">
            <ps:param name="_pageRef" value="_pageRef"> </ps:param>
            <ps:param name="queryIdLkp" value="reportQueryCO.reportQueryVO.QUERY_ID"></ps:param>
      </ps:url>
      <psj:dialog
            id="openDetailsPopup_${_pageRef}" 
            href=""
            autoOpen="false"
            dataType="html"
            modal="true" 
            title="%{getText('Details_key')}"
            width="450"
            height="300"
      />    
	</div>
	<ps:hidden name="updates" id="updateSnParameter_${_pageRef}"></ps:hidden>
</ps:form>
