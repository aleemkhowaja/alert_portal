<!-- USER STORY #799705	Control record - PWS mapping screen -->

<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt" uri="/path-toolbar-tags"%>

<%--removing grid scrolbards--%>
<style>
.ui-jqgrid .ui-jqgrid-bdiv {
	position: relative;
	margin: 0em;
	padding: 0;
	overflow-x: hidden;
	overflow-y: auto;
	text-align: left;
}
</style>
<div id="webservice_gui_${_pageRef}" style="margin-right:10px;margin-top:18px;">

	<!-- Important form Used For Grid related hidden fields -->
	<ps:form id="webServiceGuiGridForm_${_pageRef}" useHiddenProps="true" namespace="/path/common/pws">
		<ps:hidden id="webServiceExplorerMainGridIds_${_pageRef}" name="gridId" />
		<ps:hidden id="webServiceExplorerRequestMainGridIds_${_pageRef}" name="requestGridId" />
		<ps:hidden id="webServiceExplorerResponseMainGridIds_${_pageRef}" name="responseGridId" />
		<ps:hidden id="explorer_grid_row_id_${_pageRef}" name="pwsMappingExpressionCO.explorerGridRowId"  />
	</ps:form>

	<ps:url id="webServiceGuiUrl" action="PwsWebServiceExplorerList_loadWSDLInfoGrid" namespace="/path/common/pws/" escapeAmp="false">
		<ps:param name="iv_crud" value="iv_crud" />
		<ps:param name="_pageRef" value="_pageRef" />
		<ps:param name="webServiceExplorerCO.screenName" value="webServiceExplorerCO.screenName" />
		<ps:param name="webServiceExplorerCO.operationName" value="webServiceExplorerCO.operationName" />
		<ps:param name="webServiceExplorerCO.applicationName" value="webServiceExplorerCO.applicationName" />
		<ps:param name="webServiceExplorerCO.webServiceName" value="webServiceExplorerCO.webServiceName" />
		<ps:param name="webServiceExplorerGridParamCO.mainGridActionRef" value="webServiceExplorerGridParamCO.mainGridActionRef" />
		<ps:param name="webServiceExplorerGridParamCO.subGridActionRef" value="webServiceExplorerGridParamCO.subGridActionRef" />
		<ps:param name="webServiceExplorerGridParamCO.listSubGridRef" value="webServiceExplorerGridParamCO.listSubGridRef" />
		<ps:param name="webServiceExplorerGridParamCO.hashSubGridRef" value="webServiceExplorerGridParamCO.hashSubGridRef" />
		<ps:param name="webServiceExplorerGridParamCO.screenName" value="webServiceExplorerGridParamCO.screenName" />
		<ps:param name="webServiceExplorerGridParamCO.screenNameSpace" value="webServiceExplorerGridParamCO.screenNameSpace" />
		<ps:param name="webServiceExplorerCO.requestType" value="webServiceExplorerCO.requestType" />		
		<ps:param name="webServiceExplorerCO.parentRowId" value="webServiceExplorerCO.parentRowId" />
		<ps:param name="webServiceExplorerCO.requestResponseCO.fieldType" value="webServiceExplorerCO.requestResponseCO.fieldType" />	
		<ps:param name="webServiceExplorerCO.webServiceExplorerConfigVO.CONFIG_ID" value="webServiceExplorerCO.webServiceExplorerConfigVO.CONFIG_ID" />
		<ps:param name="webServiceExplorerCO.mappingID" value="webServiceExplorerCO.mappingID" />
	</ps:url>
	
	<ps:url id="webServiceGuiSubGridUrl" action="PwsWebServiceExplorerList_loadSubGridInfo" namespace="/path/common/pws/" escapeAmp="false">
		<ps:param name="iv_crud" value="iv_crud" />
		<ps:param name="_pageRef" value="_pageRef" />
	</ps:url>
	
		<psjg:grid id="${gridId}"
			href="%{webServiceGuiUrl}"
			editurl="%{webServiceGuiUrl}"
			editinline="true" 
			dataType="json" 
			pager="false" 
			pagerButtons="false" 
			filter="true"
			gridModel="gridModel" 
			rowNum="50" 
			viewrecords="true" 
			navigator="true" 
			altRows="true"
			navigatorRefresh="false" 
			navigatorDelete="false" 
			navigatorEdit="false"
			navigatorAdd="false" 
			ondblclick="" 
			navigatorSearch="false"
			addfunc=""
			multiselect="true"
			onEditInlineBeforeTopics="onPwsExplorerRowSelTopic_${_pageRef}"
			onGridCompleteTopics ="pwsWebServiceExplorerOnGridCompleteFn_${_pageRef}"
			autowidth="true"
			shrinkToFit="true"
			cssStyle="overflow:hidden;"
		>
	
		<psjg:grid id="webServiceGuiSubGridTbl_Id_${_pageRef}"
			subGridUrl="" 
			gridModel="" 
			subGridOptions="{reloadOnExpand:false}"   
		>

		</psjg:grid>
		
		<psjg:gridColumn id="ID_${_pageRef}" colType="text" key="true"
			name="ID" index="ID" title="ID" editable="false" sortable="false"
			hidden="true"
			width="5"
			 />
			
		<psjg:gridColumn name="fieldName"
			title="%{getText('parameter_key')}" index="PARAMETER"
			colType="text" editable="false" sortable="false" search="false"
			id="PARAMETER_${_pageRef}"
			editoptions="{readonly: 'readonly', maxlength:'15'}"
			width="60"
			 />	
					 		
		<psjg:gridColumn name="fieldType"
			title="%{getText('type_key')}" index="TYPE"
			colType="text" editable="false" sortable="false" search="false"
			width="120"
			id="TYPE_${_pageRef}" />
			
		<psjg:gridColumn name="precision"
			title="%{getText('Precision')}" index="PRECISION"
			colType="text" editable="false" sortable="false" search="false"
			id="PRECISION_${_pageRef}"
			width="25"
			editoptions="{readonly: 'readonly', maxlength:'15'}"
			 />	
			 
		<psjg:gridColumn name="mandatory"
			title="%{getText('mandatory_key')}" index="MANDATORY" colType="text"
			editable="false" sortable="false" search="false"
			id="MANDATORY_${_pageRef}" 	hidden="true"/>
			
 
 		<psjg:gridColumn name="restriction" title="%{getText('Restriction')}" index="RESTRICTION" 
			colType="select" search="false"  formatter="select" editable="true" sortable="false" id="RESTRICTION_${_pageRef}"  edittype="select" 
			loadOnce="false"
			width="60"
			editoptions="{value:function(){
			var rowId = $('#webServiceGuiTbl_Id_'+_pageRef).jqGrid('getGridParam', 'selrow');
			var grid = $('#webServiceGuiTbl_Id_'+_pageRef);
			return enumerationFieldsLoadCombo('${pageContext.request.contextPath}/path/common/WebserviceExplorer/WebServiceExplorerMaint_fillRestrictions','restrictions','code', 'descValue',rowId,grid);}
			,dataEvents: [{ type: 'change', fn: function(e) { onEnumerationFieldChange(e) } }]}
			" 
		/>
	
		<%
			if (request.getAttribute("showValue").equals("true"))
			{
			 %> 
			<psjg:gridColumn id="VALUE_${_pageRef}"
				title="%{getText('value_key')}" index="VALUE" 
				colType="text"
				name="value"
				editable="false" 
				sortable="false" 
				search="false"
				required="false"
				width="40"
				/>
		<%
		}
		else
		{
		%>
				<psjg:gridColumn id="VALUE_${_pageRef}"
				title="%{getText('value_key')}" index="VALUE" 
				colType="text"
				name="value"
				editable="false" 
				sortable="false" 
				search="false"
				required="false"
				width="40"
				/>
		<%
		}
			if(request.getAttribute("showMappingField").equals("true"))
			{
		 %>
		<psjg:gridColumn name="mappingField" title="%{getText('mappingfield_key')}" index="MAPINGFIELD" 
			colType="select" search="false"  formatter="select" editable="true" sortable="false" id="maping_Field_${_pageRef}"  edittype="select" 
			loadOnce="true"
			hidden=""
			width="40"
			editoptions="{value:function(){
			return pwsMappingFieldsLoadCombo('${pageContext.request.contextPath}/path/common/pws/PwsWebServiceExplorerMainAction_fillMappingFields','mappingValues','code', 'descValue');}
			,dataEvents: [{ type: 'change', fn: function(e) { applyOnMappingChange(e) } }
			]
			}
			" 
		/>
			<%
				}
			 %>
	  <psjg:gridColumn id="expression_${_pageRef}" 
			 name="mappingFieldExpression"
			 index="mappingFieldExpression" 
			 colType="text" 
		     formatter="viewExpressionDetails"
			 title="%{getText('Expression')}" 
			 sortable="false"
			 search="false" 
			 width="60" 
			 editable="false" 
		/>
		
		<psjg:gridColumn id="expression_Hidden_Field_${_pageRef}"
			title="%{getText('mapping_field_key')}" index="EXPRESSIONHIDDENFIELD" colType="text"
			name="expressionHiddenField" editable="false" sortable="false" search="false"
			hidden="true"
			required="false" />

		<psjg:gridColumn name="destination"
			title="%{getText('destinatino_key')}" index="DESTINATION" colType="text"
			editable="false" sortable="false" search="false"
			hidden="true"
			id="DESTINATION_${_pageRef}" />

		<psjg:gridColumn name="inout"
			title="%{getText('inout_key')}" index="INOUT" colType="text"
			editable="false" sortable="false" search="false"
			hidden="true"
			id="INOUT_${_pageRef}" />

		<psjg:gridColumn name="hasChildren"
			title="%{getText('hasChildren_key')}" index="HASCHILDREN" colType="text"
			editable="false" sortable="false" search="false"
			hidden="true"
			id="HASCHILDERN_${_pageRef}" />
		
		<psjg:gridColumn name="embeddedTypeEnumParent"
			title="%{getText('embedded_Type_Enum_Parent_key')}" index="EMBEDEDTYPEENUMPARENT" colType="text"
			editable="false" sortable="false" search="false"
			hidden="true"
			id="EMBEDEDTYPEENUMPARENT_${_pageRef}" />
			
		<psjg:gridColumn name="hasRestriction"
			title="%{getText('has_restrictions_key')}" index="HASRESTRICTION" colType="text"
			editable="false" sortable="false" search="false"
			hidden="true"
			id="HASRESTRICTION_${_pageRef}" />
								
		<psjg:gridColumn name="gridColumnID"
			title="%{getText('gridcolumnid_key')}" index="GRIDCOLUMNID" colType="text"
			editable="false" sortable="false" search="false"
			hidden="true"
			id="GRIDCOLUMNID_${_pageRef}" />	
			
		<psjg:gridColumn name="parent_row_id"
			title="%{getText('parent_row_id_key')}" index="PARENT_ROW_ID" colType="text"
			editable="false" sortable="false" search="false"
			hidden="true"
			id="PARENT_ROW_ID_${_pageRef}" />	
			
		<psjg:gridColumn name="wsdlUrl"
			title="%{getText('wsdlUrl_key')}" index="WSDLURL" colType="text"
			editable="false" sortable="false" search="false"
			hidden="true"
			id="WSDLURL_${_pageRef}" />
			
		<psjg:gridColumn name="nameSpaceUri"
			title="%{getText('nameSpaceUri_key')}" index="NAMESPACEURI" colType="text"
			editable="false" sortable="false" search="false"
			hidden="true"
			id="NAMESPACEURI_${_pageRef}" />
		
		<psjg:gridColumn name="soapAction"
			title="%{getText('soap_action_key')}" index="SOAPACTION" colType="text"
			editable="false" sortable="false" search="false"
			hidden="true"
			id="SOAPACTION_${_pageRef}" />			
			
		<psjg:gridColumn name="loadSubGrid"
			title="%{getText('load_sub_grid_key')}" index="LOADSUBGRID" colType="text"
			editable="false" sortable="false" search="false"
			hidden="true"
			id="LOADSUBGRID_${_pageRef}" />
			
		<psjg:gridColumn name="checkGridRow"
			title="%{getText('check_grid_row_key')}" index="CHECKGRIDROW" colType="text"
			editable="false" sortable="false" search="false"
			hidden="true"
			id="CHECKGRIDROW_${_pageRef}" />
			
		<psjg:gridColumn name="nillable"
			title="%{getText('nillable_key')}" index="NILLABLE" colType="text"
			editable="false" sortable="false" search="false"
			hidden="true"
			id="NILLABLE_${_pageRef}" />
			
	</psjg:grid>
 
</div>
<script type="text/javascript">
		$("#${gridId}").subscribe("pwsWebServiceExplorerOnGridCompleteFn_${_pageRef}",function(event,data){		
			pwsWebServiceExplorerOnGridCompleteFn(event,data);
			});
	
		$("#${gridId}").subscribe("onPwsExplorerRowSelTopic_${_pageRef}",function(rowObj){
			onPwsExplorerRowSelTopic(rowObj);
			//processMappingField(rowObj);
			});
		
		$("#${gridId}").subscribe("onRowSubSelTopic",function(rowObj){
			onRowSubSelTopic(rowObj);});
		
		$("#${gridId}").subscribe("onSubGridCompleteFn",function(event,data){
			onSubGridCompleteFn(event,data);});

		$(function(){
			$("#jqgh_${gridId}"+"_cb").hide();
		});	
		
</script>
