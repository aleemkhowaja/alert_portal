<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@include file="/WEB-INF/pages/alert/common/AlertAppTrans.jsp"%>
<%@taglib prefix="ptt" uri="/path-toolbar-tags"%>


	<ps:url id="createMultipleSubscriberGrid" escapeAmp="false" action="MultipleSubscriberListAction_returnMultiSubscriberListForGrid" namespace="/path/alert/subscriber/multiple">
		<ps:param name="iv_crud" value="ivcrud_${_pageRef}"></ps:param>
    	<ps:param name="_pageRef" value="_pageRef"></ps:param>
    	<ps:param name="multipleSubscriberSC.isSelectAll" value="'false'"></ps:param>
	</ps:url> 
	<div class="data-grid">
		<psjg:grid 
		id="createMultipleSubscriberGridTbl_Id_${_pageRef}"
		href="%{createMultipleSubscriberGrid}" 
		dataType="json" 
		pager="false" 
		sortable="true"
		filter="true" 
		gridModel="gridModel" 
		rowNum="5" 
		rowList="5,10,15,20"
		viewrecords="true" 
		navigator="true" 
		navigatorDelete="true"
		navigatorEdit="false" 
		navigatorRefresh="false" 
		navigatorAdd="true"
		navigatorSearch="false" 
		navigatorSearchOptions="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
		altRows="true" 
		addfunc="multipleSubscriberMaint_addRow"
		delfunc="multipleSubscriberMaint_conformDelete"
		height="150"
		editinline="true"
		editurl=" "
		shrinkToFit="false"
		autowidth="false"
		width="1000"
		>
		
		<psjg:gridColumn 
			id="ID_${_pageRef}" 
			colType="text"
			name="alrtSubVO.ID"
			title="%{getText('id_key')}" 
			editable="false"
			key="true"
			hidden="false"
			width="100"
			search="false"
			sortable="false" />
			
		<psjg:gridColumn 
			id="BRIEF_NAME_${_pageRef}" 
			colType="text"
			name="alrtSubVO.DEFAULT_BRIEF_NAME"
			editoptions="{maxlength: '100'}"
			title="%{getText('brief_name_key')}"
			editable="true" 
			width="150"
			search="false"
			required="true"
			sortable="false" />
			
		<psjg:gridColumn 
			id="MIDDLE_NAME_${_pageRef}" 
			colType="text"
			name="alrtSubVO.DEFAULT_MIDDLE_NAME" 
			editoptions="{maxlength: '100'}"
			title="%{getText('Middle_Name_eng_key')}" 
			editable="true" 
			width="150"
			search="false"
			sortable="false"  />
			
	    <psjg:gridColumn 
	    	id="LONG_NAME_${_pageRef}" 
	    	colType="text"
			name="alrtSubVO.DEFAULT_LONG_NAME" 
			editoptions="{maxlength: '100'}"
			title="%{getText('long_name_key')}"
			editable="true" 
			width="150"
			search="false"
			required="true"
			sortable="false"  />
				
		<psjg:gridColumn 
			id="ADDRESS_${_pageRef}" 
			colType="text"
			name="alrtSubVO.DEFAULT_ADDRESS"
			editoptions="{maxlength: '150'}"
			title="%{getText('address_key')}" 
			editable="true" 
			edittype="textarea"
			width="250"
			search="false"
			sortable="false"  />
			
		<psjg:gridColumn 
	    	id="STATUS_DESC_${_pageRef}" 
	    	colType="text"
			name="statusDesc" 
			title="%{getText('status_key')}"
			editable="true" 
			width="150"
			search="false"
			required="false"
			sortable="false"
			hidden="true"
			  />
			
		<psjg:gridColumn 
			name="alrtSubVO.LANG" 
			id="PREFERED_LANG_${_pageRef}" 
			title="%{getText('preferred_language_key')}"
			editable='true' 
			formatter="select"
			colType="select" 
			edittype="select" 
			editoptions="{ value:function() {return loadCombo('${pageContext.request.contextPath}/path/alert/subscriber/multiple/MultipleSubscriberMaintAction_fillPreferedLanguageDropDown.action','languageDropDownList', 'code', 'descValue');}
						, dataEvents: [{ type: 'change', fn: function(e) {}}]}"
			align="center"  
			width="150"
			search="false"
			sortable="false"
		/>
		
		<psjg:gridColumn 
			colType="liveSearch" 
			id="cifNumber_${_pageRef}"
			name="alrtSubVO.CIF_NO" 
			title="%{getText('cif_number_key')}" 
			editable="%{!enable_omni}" 
			autoSearch="true"
			dataAction="${pageContext.request.contextPath}/path/alert/subscriber/individual/IndividualSubscriberCIFLookupAction_constructCifQueryLookup"
			resultList="cifVO.CIF_NO:alrtSubVO.CIF_NO_lookuptxt"
			params="criteria.Cif:alrtSubVO.CIF_NO_lookuptxt"
			searchElement="CIF_NO" 
			dependencySrc="${pageContext.request.contextPath}/path/alert/subscriber/individual/IndividualSubscriberDepAction_dependencyByCifNumber"
			dependency="alrtSubVO.CIF_NO_lookuptxt:individualSubscriberCO.cifVO.CIF_NO,individualSubscriberCO.cifVO.LONG_NAME_ARAB:alrtSubVO.DEFAULT_LONG_NAME,
			individualSubscriberCO.cifVO.SHORT_NAME_ENG:alrtSubVO.DEFAULT_BRIEF_NAME,individualSubscriberCO.cifVO.ADDRESS1_ENG:alrtSubVO.DEFAULT_ADDRESS,
			individualSubscriberCO.emailId:alrtSubVO.EMAIL_ID,individualSubscriberCO.tel:alrtSubVO.MOBILE_PHONE"
			width="100"
			search="false"
			sortable="false" 
			beforeDepEvent="common_checkDuplicateRecordByProperty('multipleSubscriberGridTbl_Id','alrtSubVO.CIF_NO')"
			editoptions="{maxlength: '8'}"
			dontLoadData="true"
		/>
		
		<psjg:gridColumn 
			colType="liveSearch" 
			id="userId_${_pageRef}"
			name="alrtSubVO.USR_ID" 
			title="%{getText('imal_user_key')}" 
			editable="true"
			autoSearch="true"
			dataAction="${pageContext.request.contextPath}/path/alert/subscriber/individual/IndSubUsrLookupAction_constructLookup"
			resultList="usrVO.USER_ID:alrtSubVO.USR_ID_lookuptxt"
			params="criteria.userID:alrtSubVO.USR_ID_lookuptxt"
			searchElement="usrVO.USER_ID"
 			dependencySrc="${pageContext.request.contextPath}/path/alert/subscriber/individual/IndividualSubscriberDepAction_dependencyByUserID"
			dependency="alrtSubVO.USR_ID_lookuptxt:individualSubscriberCO.alrtSubVO.USR_ID,
			individualSubscriberCO.usrVO.LAST_NAME:alrtSubVO.DEFAULT_LONG_NAME,
			individualSubscriberCO.usrVO.FIRST_NAME:alrtSubVO.DEFAULT_BRIEF_NAME,
			individualSubscriberCO.usrVO.EMAIL_ID:alrtSubVO.EMAIL_ID,
			individualSubscriberCO.usrVO.MOBILE_PHONE:alrtSubVO.MOBILE_PHONE"
			
			width="100"
			search="false"
			sortable="false"
			editoptions="{maxlength: '8'}"
		/>
		
		 <psjg:gridColumn 
	    	id="EMAIL_${_pageRef}" 
	    	colType="text"
			name="alrtSubVO.EMAIL_ID"
			editoptions="{maxlength: '255'}" 
			title="%{getText('email_address_key')}"
			editable="true" 
			width="200"
			search="false"
			required="false"
			sortable="false"
			params="individualSubscriberCO.alrtSubVO.EMAIL_ID:alrtSubVO.EMAIL_ID"
			dependencySrc="${pageContext.request.contextPath}/path/alert/subscriber/multiple/MultipleSubscriberMaintAction_validateEmailOrMobileDependancy"
			dependency="individualSubscriberCO.alrtSubVO.EMAIL_ID:alrtSubVO.EMAIL_ID" />
			
		 <psjg:gridColumn 
	    	id="MOBILE_${_pageRef}" 
	    	colType="text"
			name="alrtSubVO.MOBILE_PHONE" 
			editoptions="{maxlength: '23'}"
			title="%{getText('Mobile_key')}"
			editable="true" 
			width="150"
			search="false"
			required="false"
			sortable="false"
			params="individualSubscriberCO.alrtSubVO.MOBILE_PHONE:alrtSubVO.MOBILE_PHONE"
			dependencySrc="${pageContext.request.contextPath}/path/alert/subscriber/multiple/MultipleSubscriberMaintAction_validateEmailOrMobileDependancy"
			dependency="individualSubscriberCO.alrtSubVO.MOBILE_PHONE:alrtSubVO.MOBILE_PHONE"
			  />
			
		 <psjg:gridColumn 
			name="fullPath" 
			colType="text" 
			title="%{getEscText('main_info_other_languages_key')}" 
		 	editable="false" 
		 	formatter="multipleSubscriberMaint_openMainInfoDialog"
		 	align="center"
		 	width="200"
		 	search="false"
		 	sortable="false" >
		</psjg:gridColumn>
		 
		<psjg:gridColumn 
	    	id="otherLanguages_${_pageRef}" 
	    	colType="text"
			name="otherLanguagesJson" 
			title="%{getText('Other_Language_key')}"
			editable="true" 
			width="100"
			hidden="true"
			search="false"
			sortable="false" />
	</psjg:grid>
	
	
<script>


$("#createMultipleSubscriberGridTbl_Id_" + _pageRef).subscribe("validateMobileAndEmailNo_"+_pageRef,function(obj)
{
	multipleSubscriberMaint_validateMobileAndEmail();	
});

</script>
</div>