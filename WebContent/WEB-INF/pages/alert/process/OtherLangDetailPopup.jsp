<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>


<ps:hidden name="individualSubscriberCO.alrtSubVO.ID" id="individualSubscriberId_${_pageRef}"/>
<ps:set name="individualSubscriberId_${_pageRef}" value="individualSubscriberCO.alrtSubVO.ID" />
 <ps:set name="iv_crud" value="iv_crud" />
 <ps:set name="indStatus" value="individualSubscriberCO.alrtSubVO.STATUS" />
  <ps:hidden name="individualSubscriberCO.alrtSubVO.STATUS" id="indStat" />
 
<ps:url id="otherSubscriberLanguagesUrl" namespace="/path/alert/subscriber/individual" escapeAmp="false" action="IndividualSubscriberListAction_loadAllLanguageGridData">
	<ps:param name="_pageRef" value="${_pageRef}"/>
	<ps:param name="subscriberId" value="individualSubscriberId_${_pageRef}"/>
</ps:url>

<psjg:grid 
	id="otherSubscriberLanguagesGrid_Id_${_pageRef}"
	dataType="json" 
	hiddengrid="false" 
	pager="true" 
	href="%{otherSubscriberLanguagesUrl}"
	filter="false"
	gridModel="gridModel" 
	rowNum="5" 
	rowList="5,10,15,20"
	navigator='true'
	altRows="false" 
	navigatorDelete="true"
	navigatorEdit="false" 
	navigatorSearch="false"
	navigatorSearchOptions="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt']}"
	sortable="true" 
	editurl=" " 
	editinline="true" 
	multiselect="false"
	navigatorAdd="true" 
	navigatorRefresh="false" 
	pagerButtons="false"
	rownumbers="false" 
	autowidth="false"
	width="790" 
	viewrecords="false"
	addfunc="otherLanguagesBody_addRecord" 
	delfunc="otherLanguagesBody_conformDelete"
	onCompleteTopics="individualSubscriberMaint_addOtherLanguageHiddenData">
	
	<psjg:gridColumn id="LANG_CODE" 
		name="LANG_CODE"
		index="LANG_CODE" formatter="select"
		title="%{getText('Language_key')}" editable="true" sortable="false"
		edittype="select" colType="select"
		editoptions="{value:function() {  return loadCombo('${pageContext.request.contextPath}/path/alert/subscriber/individual/IndividualSubscriberMaintAction_loadLanguageSelect','languageSelect', 'code', 'descValue');}
					,dataEvents: [{ type: 'change', fn: function() {otherLanguage_checkDuplicateByLangCode()  } }]}"
		search="true" align="center"  width="20" required="true" />

	<psjg:gridColumn id="BRIEF_NAME" 	
		editoptions="{maxlength: '100'}"
		colType="text" name="BRIEF_NAME" title="%{getText('brief_name_key')}"
		index="BRIEF_NAME" editable="true" sortable="true" search="true"
		searchoptions="{sopt:['cn']}" align="center" width="30" required="true" />
		
	<psjg:gridColumn id="MIDDLE_NAME" 	
		editoptions="{maxlength: '100'}"
		colType="text" name="MIDDLE_NAME" title="%{getText('Middle_Name_eng_key')}"
		index="MIDDLE_NAME" editable="true" sortable="true" search="true" 
		searchoptions="{sopt:['cn']}" align="center" width="30" />
		
	<psjg:gridColumn id="LONG_NAME" 
		editoptions="{maxlength: '100'}"	
		colType="text" name="LONG_NAME" title="%{getText('long_name_key')}"
		index="LONG_NAME" editable="true" sortable="true" search="true"
		searchoptions="{sopt:['cn']}" align="center" width="40" />
		
	<psjg:gridColumn id="ADDRESS" 	
		editoptions="{maxlength: '150'}"
		colType="text" name="ADDRESS" title="%{getText('address_key')}"
		index="ADDRESS" editable="true" sortable="true" search="true" 
		searchoptions="{sopt:['cn']}" align="center" width="40" edittype="textarea" />

</psjg:grid>

<script type="text/javascript">
	$.struts2_jquery.require("OtherLanguages.js" ,null,jQuery.contextPath+"/path/js/alert/otherlanguage/");
	var same_language_key = "<ps:text name='same_language_key' />";
	var language_field_required_key = "<ps:text name='language_field_required_key' />";
	
	$("#otherSubscriberLanguagesGrid_Id_" + _pageRef).subscribe(
			"individualSubscriberMaint_addOtherLanguageHiddenData", function() {
				if(_pageRef != "MIN00MT" && _pageRef != "MIN00P")
				{
					individualSubscriberMaint_addOtherLanguageHiddenData();
				}
				else
				{
					multipleSubscriberMaint_returnPreviousAddedData();
				}
			});
</script>