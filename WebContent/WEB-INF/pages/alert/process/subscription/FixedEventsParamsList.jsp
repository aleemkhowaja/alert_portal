<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>

<ps:form id="fixedEventsParamForm_${_pageRef}">
<ps:hidden id="fixedEvtId_${_pageRef}" name="subscriptionCO.fixedEventId"/>
<ps:url id="fixedEvtsParamsGrid" escapeAmp="false"
	action="SelectFixedEventsParamGridAction_loadFixedEvtsParamsGrid" namespace="/path/alert/subscription"> 
	<ps:param name="subscriptionSC.evt_id"
			value="subscriptionSC.evt_id"></ps:param>
	<ps:param name="subscriptionSC.lineNumber"
			value="subscriptionSC.lineNumber"></ps:param>
</ps:url>

<psjg:grid id="fixedEvtsParamGridTbl_Id_${_pageRef}"
	href="%{fixedEvtsParamsGrid}" dataType="json"
	caption =""
	hiddengrid="false" pager="true" sortable="true"
	filter="true" gridModel="gridModel" rowNum="5" rowList="5,10,15,20"
	viewrecords="true" navigator="true" navigatorDelete="false"
	navigatorEdit="false" navigatorRefresh="true" navigatorAdd="false"
	navigatorSearch="false" 
	navigatorSearchOptions="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
	altRows="true" ondblclick="" 
	addfunc="" shrinkToFit="false" height="125"
	multiselect="false" editinline="true" editurl="test" onclick="" onGridCompleteTopics="onFixedEvtsParamGridLoad"
	onEditInlineBeforeTopics="putfixedEvtsParamGridProtectedFields">
	
	
		
		<psjg:gridColumn id="Fixed_Lable_${_pageRef}" colType="text"
		name="fixedLabel" index="fixedLabel"
		title="%{getText('fixed_label_key')}" editable="false" sortable="true"
		search="true" width="150" />
		
		<psjg:gridColumn id="Fixed_Operator_${_pageRef}" colType="select"
		name="alrtSubscriptionParamVO.FIXED_OPERATOR" index="FIXED_OPERATOR"
		title="%{getText('fixed_operator_key')}" edittype="select" sortable="true"
		search="true" width="149" formatter="select" editable="#attr['editFixedOperator']"
		editoptions="{value:function() {  return loadCombo('${pageContext.request.contextPath}/path/alert/subscription/SelectFixedEventsParamGridAction_loadFixedOperatorDropDown','fixedOperatorList', 'code', 'descValue');}
		,dataEvents: [{ type: 'change', fn: function() {onFixedOperatorChanged(this)} }]}"/>
		<ps:if test='subscriptionCO.fromValueFlag=="0"'>
			<psjg:gridColumn id="From_Value_${_pageRef}" colType="text"
			name="alrtSubscriptionParamVO.FROM_VALUE" index="FROM_VALUE"
			title="%{getText('from_value_key')}" editable="true" sortable="true"
			search="true" width="149" />
		</ps:if>
		<ps:else>
			<psjg:gridColumn id="From_Value_Drop_${_pageRef}" colType="select"
			name="alrtSubscriptionParamVO.FROM_VALUE" index="FROM_VALUE"
			title="%{getText('from_value_key')}" edittype="select" sortable="true"
			search="true" width="149" formatter="select" editable="true"
			editoptions="{value:function() {  return loadComboAlrt();}}"
			/> 
		</ps:else>
		<psjg:gridColumn id="To_Value_${_pageRef}" colType="text"
		name="alrtSubscriptionParamVO.TO_VALUE" index="TO_VALUE"
		title="%{getText('To_Value_KEY')}" editable="true" sortable="true"
		search="true" width="149" hidden="true"/>
		
		<psjg:gridColumn id="ID_${_pageRef}" colType="number"
		name="alrtSubscriptionParamVO.ID" index="ID"
		title="" editable="false" sortable="true"
		search="true" width="100" hidden="true" />
		
		<psjg:gridColumn id="Fixed_Code_${_pageRef}" colType="number"
		name="alrtSubscriptionParamVO.FIXED_CODE" index="FIXED_CODE"
		title="" editable="false" sortable="true"
		search="true" width="100" hidden="true" />
		
		<psjg:gridColumn id="Param_Type_${_pageRef}" colType="text"
		name="paramType" index="paramType"
		title="" editable="false" sortable="true"
		search="true" width="100" hidden="true" />
		
		<psjg:gridColumn id="Fixed_Flag_${_pageRef}" colType="text"
		name="fixedFlag" index="fixedFlag"
		title="" editable="false" sortable="true"
		search="true" width="100" hidden="true" />
		
	    <psjg:gridColumn id="OLD_FIXED_OPERATOR_${_pageRef}" colType="text"
		name="alrtSubscriptionParamVO.OLD_FIXED_OPERATOR" index="OLD_FIXED_OPERATOR"
		title="%{getText('old_fixed_operator')}" editable="false" sortable="true"
		search="true" width="100" hidden="true" />
		
		<psjg:gridColumn id="Old_From_Value_${_pageRef}" colType="text"
		name="alrtSubscriptionParamVO.OLD_FROM_VALUE" index="OLD_FROM_VALUE"
		title="%{getText('old_from_value_key')}" editable="false" sortable="true"
		search="true" width="100" hidden="true" />
		
		<psjg:gridColumn id="Old_To_Value_${_pageRef}" colType="text"
		name="alrtSubscriptionParamVO.OLD_TO_VALUE" index="OLD_TO_VALUE"
		title="%{getText('old_to_value_key')}" editable="false" sortable="true"
		search="true" width="100" hidden="true" />
		

	
</psjg:grid>
</ps:form>

<script type="text/javascript">
	$.struts2_jquery.require("SubscriptionMaint.js",null,jQuery.contextPath+"/path/js/alert/subscription/");
	
	$("#fixedEvtsParamGridTbl_Id_"+_pageRef).subscribe("onFixedEvtsParamGridLoad",function(){
		OnFixedEvtsParamGridLoad();
	});
	
	$("#fixedEvtsParamGridTbl_Id_"+_pageRef).unsubscribe(
	"putfixedEvtsParamGridProtectedFields");
	$("#fixedEvtsParamGridTbl_Id_"+_pageRef).subscribe(
	"putfixedEvtsParamGridProtectedFields", function(rowObj) {
		putfixedEvtsParamGridProtectedFields(rowObj);
	});
</script>