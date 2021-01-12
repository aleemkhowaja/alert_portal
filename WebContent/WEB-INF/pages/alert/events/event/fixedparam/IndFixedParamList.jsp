<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@page import="com.path.alert.bo.base.AlertConstant"%>

<ps:set name="ivcrud_${_pageRef}" value="iv_crud" />
<ps:hidden id="iv_crud_${_pageRef}" name="iv_crud" />
<ps:hidden id="changed_${_pageRef}" name="individualEventCO.changed" />
<ps:hidden id="columnType_${_pageRef}" name="columnType" />

<script type="text/javascript">
	var fxdEvtJvType = '<%=AlertConstant.Fixed_EVT_JV_TYPE%>';
	var fxdEvtTrxType = '<%=AlertConstant.Fixed_EVT_TRX_TYPE%>';
</script>

<ps:url id="urlFixedParamGrid" escapeAmp="false" action="IndividualEventGridAction_loadFixedParam" namespace="/path/alert/events/event">
	<ps:param name="individualEventSC.fixedEventId"		value="${individualEventCO.alrtEvtVO.FIXED_EVENT_ID}"></ps:param>
	<ps:param name="individualEventSC.eventID"		    value="individualEventCO.alrtEvtVO.EVT_ID"></ps:param>
	<ps:param name="individualEventSC.status" 			value="individualEventCO.alrtEvtVO.STATUS"></ps:param>
	<ps:param name="individualEventCO.changed" 			value="individualEventCO.changed"></ps:param>
	<ps:param name="iv_crud" 							value="ivcrud_${_pageRef}"></ps:param>
	<ps:param name="individualEventSC.evtType" 			value="individualEventSC.alrtEvtVO.EVT_TYPE"></ps:param>
</ps:url>

<psjg:grid 
	id						="fixedParam_${_pageRef}"
	hidegrid				="" 
	rownumbers				="false" 
	href					="%{urlFixedParamGrid}"
	dataType         		="json"
	pager            		="false"
	sortable         		="true"
	filter           		="false"
	gridModel        		="gridModel"
	rowNum           		="5"
	rowList          		="5,10,15,20"
	viewrecords      		="false"
	navigator       	 	="true"
	navigatorDelete 	    ="true"
	navigatorEdit    		="false"
	navigatorRefresh 		="false"
	navigatorAdd     		="true"
	navigatorSearch  		="false"
	editurl			 		=" " 
	editinline		 		="true" 
	altRows          		="true"
	autowidth				="false"
	width					="1080"
	shrinkToFit				="true"
	addfunc					="fixEventdetails_addParameter()"
	delfunc					="fixEventdetails_deleteParameter()"
	onEditInlineBeforeTopics="fillOpratorSelectByColumn"
	>

	 <psjg:gridColumn id="ID_${_pageRef}" colType="text"
		name="ID" index="ID"
		title="%{getText('ID_KEY')}" editable="false" sortable="false"
		search="false" hidden="true" 
	/>
		
	<psjg:gridColumn id="FIXED_EVENT_ID_${_pageRef}" colType="text"
		name="FIXED_EVENT_ID" index="FIXED_EVENT_ID"
		title="%{getText('FIXED_EVENT_ID_KEY')}" editable="false" sortable="false"
		search="false" hidden="true" 
	/>
		
	<psjg:gridColumn id="OLD_NEW_VAL_LIST" colType="select"
		name="OLD_NEW_VAL_LIST" index="OLD_NEW_VAL_LIST" width="50"
		title="%{getText('old_new_value_key')}" edittype="select"
		formatter="select" loadOnce="true" sortable="false" search="true"
		align="center" editable="true"
		editoptions="{value:function(){  return loadCombo('${pageContext.request.contextPath}/path/alert/events/event/IndividualEventGridAction_loadnewOldValuesCombo','newOldCombo', 'code', 'descValue'); }
		  ,dataEvents: [{ type: 'change', fn: function() {return fixEventdetails_validateDuplicateFixedParams();} }]}"
	/>
	
	<psjg:gridColumn id="COLUMN_ID_${_pageRef}" colType="select"
		name="COLUMN_ID" index="COLUMN_ID"
		title="%{getText('column_name_key')}" edittype="select"
		loadOnce="true" sortable="false" search="true"
		align="center" editable="true"  formatter="select"
		editoptions="{value:function(){  return loadCombo('${pageContext.request.contextPath}/path/alert/events/event/IndividualEventGridAction_loadColumnsCombo?individualEventSC.fixedEventId=${individualEventCO.alrtEvtVO.FIXED_EVENT_ID}','indFixedParamList', 'COLUMN_ID', 'PARAM_COLUMN_NAME'); }
		  ,dataEvents: [{ type: 'change', fn: function() { return fixEventdetails_loadOperatorByColumnType();} }]}"
		width="70"
	/>
	
	<psjg:gridColumn id="OLD_COLUMN_ID_${_pageRef}" colType="text"
		name="OLD_COLUMN_ID" index="OLD_COLUMN_ID"
		title="%{getText('param_column_name_key')}" editable="true"
		sortable="false" search="false" hidden="true" align="center" 
	/>
		  								 
 	<psjg:gridColumn id="COLUMN_NAME_${_pageRef}" colType="text"
		name="COLUMN_NAME" index="COLUMN_NAME"
		title="%{getText('param_column_name_key')}" editable="true" 
		sortable="false" search="false" hidden="true" align="center"  
	/>
	
	<psjg:gridColumn id="PARAM_LABEL_${_pageRef}" colType="text"
		name="PARAM_LABEL" index="PARAM_LABEL"
		title="%{getText('col_desc_key')}" editable="false"
		sortable="false" search="false" hidden="false" align="center"  width="90"
	/>
	
	<psjg:gridColumn id="PARAM_COLUMN_TYPE_${_pageRef}" colType="text"
		name="PARAM_COLUMN_TYPE" index="PARAM_COLUMN_TYPE" 
		title="%{getText('param_column_type_key')}" editable="false"
		sortable="false" search="false" hidden="true" align="center"
	/>
		
	<psjg:gridColumn id="PARAM_COLUMN_TYPE_DESC_${_pageRef}" colType="text"
		name="PARAM_COLUMN_TYPE_DESC" index="PARAM_COLUMN_TYPE_DESC"
		title="%{getText('col_type_key')}" editable="false"
		sortable="false" search="false" hidden="false" align="center" width="40"
	/>
		
	<%-- <psjg:gridColumn id="PARAM_COLUMN_TYPE_${_pageRef}" colType="select"
		name="PARAM_COLUMN_TYPE" index="PARAM_COLUMN_TYPE"
		title="%{getText('param_column_type_key')}" edittype="select"
		formatter="select" loadOnce="true" sortable="false" search="true"
		align="center" editable="true" width="260"
		editoptions="{value:function(){  return loadCombo('${pageContext.request.contextPath}/path/alert/events/event/IndividualEventGridAction_loadColTypeCombo','colTypeCombo', 'code', 'descValue'); }
		  ,dataEvents: [{ type: 'change', fn: function(){}}]}" /> --%>
									 
	<psjg:gridColumn id="OPERATOR_TYPE" colType="select"
		name="OPERATOR_TYPE" index="OPERATOR_TYPE" width="40"
		title="%{getText('fixed_operator_key')}" edittype="select"
		sortable="false" search="false"
		align="center" editable="true"
		editoptions="{value:function(){}
		  ,dataEvents: [{ type: 'change', fn: function(){fixEventdetails_setColumnAndOperatorValue('Operator');}}]}"
	/>
		   
	<psjg:gridColumn id="OLD_OPERATOR_TYPE_${_pageRef}" colType="text"
		name="OLD_OPERATOR_TYPE" index="OLD_OPERATOR_TYPE"
		title="%{getText('operator_type_desc_key')}" editable="false"
		sortable="false" search="false" hidden="true" align="center" 
	/>
	
	<psjg:gridColumn id="PARAM_VALUE_${_pageRef}" colType="text"
		name="PARAM_VALUE" index="PARAM_VALUE"  width="80"
		title="%{getText('value_key')}" editable="true" sortable="false"
		search="false" hidden="false" align="center"
		
		params="individualEventCO.indFixedParamListCO.PARAM_COLUMN_TYPE:PARAM_COLUMN_TYPE,
			    individualEventCO.indFixedParamListCO.PARAM_VALUE:PARAM_VALUE,
			    individualEventCO.indFixedParamListCO.OPERATOR_TYPE:OPERATOR_TYPE"
		dependencySrc="${pageContext.request.contextPath}/path/alert/events/event/IndividualEventMaintAction_validateFixedEventValue"
		dependency="individualEventCO.indFixedParamListCO.PARAM_VALUE:PARAM_VALUE"
	/>

</psjg:grid>


<script type="text/javascript">
	$.struts2_jquery.require("AlertFixedParam.js", null, jQuery.contextPath
			+ "/path/js/alert/events/event/");

	var lastSelRow;
	$.struts2_jquery.require("ParamGrid.js", null, jQuery.contextPath
			+ "/path/js/alert/events/event/");

		$("#fixedParam_" + _pageRef).subscribe(
				"processesGridValidationsEditInline", function() {
					processesGridValidations_SelectRowFunc();
				});


		$("#fixedParam_" + _pageRef).subscribe("processesGridValidationsRetrieve", function()
		{
					processesGridValidationsRetrieve();
					
					//load Columns for select
					//fixEventdetails_loadColumnSelectByFixedEvent();
		});
				
		$("#fixedParam_" + _pageRef).subscribe("enableLiveSearch_"+_pageRef, function(){
			enableLiveSearch();
		});
		
		$("#fixedParam_" + _pageRef).jqGrid('setGridParam', { beforeProcessing: function(data){
			if(data.gridModel!=undefined && data.gridModel!=null
					&&  (data.individualEventSC.alrtEvtVO.FIXED_EVENT_ID==fxdEvtJvType || data.individualEventSC.alrtEvtVO.FIXED_EVENT_ID==fxdEvtTrxType) ){
				for(var i=0;i<data.gridModel.length;i++){
					if(data.gridModel[i].FIXED_CODE==1 ){				
						data.gridModel[i].FROM_VALUE3 = data.gridModel[i].FROM_VALUE;
						data.gridModel[i].FROM_VALUE=null;
					}
				}
			}
		} });
		
		
		$("#fixedParam_" + _pageRef).subscribe("fillOpratorSelectByColumn", function()
		{
			//load Columns for select
			fixEventdetails_loadColumnSelectByFixedEvent(true);
		});
		
</script>