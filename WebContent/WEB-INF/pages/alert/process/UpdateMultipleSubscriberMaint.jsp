<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@include file="/WEB-INF/pages/alert/common/AlertAppTrans.jsp"%>
<%@taglib prefix="ptt" uri="/path-toolbar-tags"%>
	
	<ps:url id="individualSubscriberGrid" escapeAmp="false" action="MultipleSubscriberListAction_returnMultiSubscriberListForGrid" namespace="/path/alert/subscriber/multiple">
		<ps:param name="iv_crud" value="ivcrud_${_pageRef}"></ps:param>
    	<ps:param name="_pageRef" value="_pageRef"></ps:param>
	</ps:url> 
	
	<div class="data-grid">
		<psjg:grid 
			id="createMultipleSubscriberGridTbl_Id_${_pageRef}"
			href="%{individualSubscriberGrid}" 
			dataType="json" 
			pager="true" 
			sortable="true"
			filter="true" 
			gridModel="gridModel" 
			rowNum="5" 
			rowList="5,10,15,20"
			viewrecords="true" 
			navigator="true" 
			navigatorDelete="false"
			navigatorEdit="false" 
			navigatorRefresh="false" 
			navigatorAdd="false"
			navigatorSearch="true" 
			navigatorSearchOptions="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
			altRows="true" 
			addfunc="multipleSubscriberMaint_addRow"
			delfunc="multipleSubscriberMaint_conformDelete"
			height="150"
			editinline="true"
			editurl=" "
			multiselect="%{_pageRef =='MIN00P'}"
			shrinkToFit="false"
			onSelectRowTopics="onMultipleSubscriberRowSelTopic"
			onBeforeTopics="onMultipleSubscriberBeforeTopic"
			onGridCompleteTopics="onMultipleSubscriberGridCompleteTopic_${_pageRef}"
			onSelectAllTopics="onMultipleSubscriberSelectAllTopic_${_pageRef}"
			onPagingTopics="onPageChangeRowSelTopic"
			autowidth="false"
			width="1000"
			loadonce="false">
		
		<psjg:gridColumn 
			id="ID_${_pageRef}" 
			colType="text"
			name="alrtSubVO.ID"
			title="%{getText('id_key')}" 
			editable="false"
			hidden="false"
			width="100"
			search="true"
			sortable="%{_pageRef =='MIN00P'}" />
			
		<psjg:gridColumn 
			id="BRIEF_NAME_${_pageRef}" 
			colType="text"
			name="alrtSubVO.DEFAULT_BRIEF_NAME"
			editoptions="{maxlength: '100'}"
			title="%{getText('brief_name_key')}"
			editable="true" 
			width="150"
			search="true"
			required="true"
			sortable="%{_pageRef =='MIN00P'}" />
			
		<psjg:gridColumn 
			id="MIDDLE_NAME_${_pageRef}" 
			colType="text"
			name="alrtSubVO.DEFAULT_MIDDLE_NAME" 
			editoptions="{maxlength: '100'}"
			title="%{getText('Middle_Name_eng_key')}" 
			editable="true" 
			width="150"
			search="true"
			sortable="%{_pageRef =='MIN00P'}"  />
			
	    <psjg:gridColumn 
	    	id="LONG_NAME_${_pageRef}" 
	    	colType="text"
			name="alrtSubVO.DEFAULT_LONG_NAME" 
			editoptions="{maxlength: '100'}"
			title="%{getText('long_name_key')}"
			editable="true" 
			width="150"
			search="true"
			required="true"
			sortable="%{_pageRef =='MIN00P'}"  />
				
		<psjg:gridColumn 
			id="ADDRESS_${_pageRef}" 
			colType="text"
			name="alrtSubVO.DEFAULT_ADDRESS"
			editoptions="{maxlength: '150'}"
			title="%{getText('address_key')}" 
			editable="true" 
			edittype="textarea"
			width="250"
			search="true"
			sortable="%{_pageRef =='MIN00P'}"  />
		
		<psjg:gridColumn 
	    	id="STATUS_${_pageRef}" 
	    	colType="text"
			name="alrtSubVO.STATUS" 
			title="%{getText('status_key')}"
			editable="false"
			hidden="true" 
			width="150"
			search="true"
			required="true" />
			
		<psjg:gridColumn 
	    	id="STATUS_DESC_${_pageRef}" 
	    	colType="text"
			name="statusDesc" 
			title="%{getText('status_key')}"
			editable="false" 
			width="150"
			search="true"
			required="true"
			sortable="%{_pageRef =='MIN00P'}"  />
			
		<psjg:gridColumn 
			name="alrtSubVO.LANG" 
			id="PREFERED_LANG_${_pageRef}" 
			title="%{getText('preferred_language_key')}"
			editable='true' 
			formatter="select"
			colType="select" 
			edittype="select" 
			editoptions="{ value:function() {return loadCombo('${pageContext.request.contextPath}/path/alert/subscriber/multiple/MultipleSubscriberMaintAction_fillPreferedLanguageDropDown.action','languageDropDownList', 'code', 'descValue');}
						, dataEvents: [{ type: 'change', fn: function(e) {individualEventMaint_enableAndDisableStaticValueColumn();}}]}"
			align="center"  
			width="150"
			search="false"
			sortable="false" />
		
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
			individualSubscriberCO.cifVO.SHORT_NAME_ENG:alrtSubVO.DEFAULT_BRIEF_NAME,individualSubscriberCO.cifVO.ADDRESS1_ENG:alrtSubVO.DEFAULT_ADDRESS"
			width="100"
			search="true"
			sortable="%{_pageRef =='MIN00P'}" 
			beforeDepEvent="common_checkDuplicateRecordByProperty('multipleSubscriberGridTbl_Id','alrtSubVO.CIF_NO')"
			editoptions="{maxlength: '8'}"
			dontLoadData="true" />
		
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
			dependency="alrtSubVO.USR_ID_lookuptxt:individualSubscriberCO.alrtSubVO.USR_ID 
			,individualSubscriberCO.usrVO.FIRST_NAME:alrtSubVO.DEFAULT_LONG_NAME,
			individualSubscriberCO.usrVO.LAST_NAME:alrtSubVO.DEFAULT_BRIEF_NAME"
			width="100"
			search="true"
			sortable="%{_pageRef =='MIN00P'}"
			editoptions="{maxlength: '8'}" />
		
		 <psjg:gridColumn 
	    	id="EMAIL_${_pageRef}" 
	    	colType="text"
			name="alrtSubVO.EMAIL_ID"
			editoptions="{maxlength: '1500'}" 
			title="%{getText('email_address_key')}"
			editable="true" 
			width="200"
			search="true"
			required="true"
			sortable="%{_pageRef =='MIN00P'}"  />
			
		 <psjg:gridColumn 
	    	id="MOBILE_${_pageRef}" 
	    	colType="text"
			name="alrtSubVO.MOBILE_PHONE" 
			editoptions="{maxlength: '255'}"
			title="%{getText('Mobile_key')}"
			editable="true" 
			width="150"
			search="true"
			required="true"
			sortable="%{_pageRef =='MIN00P'}"  />
			
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
			search="%{_pageRef =='MIN00P'}"
			sortable="%{_pageRef =='MIN00P'}" />
	</psjg:grid>
</div>

<script type="text/javascript">
    var count = 0;
	//disable rows of grid while status is approve
	$("#createMultipleSubscriberGridTbl_Id_"+_pageRef).subscribe("onMultipleSubscriberRowSelTopic",function(rowObj)
	{
		var isSelectRecordOnPaginition = $("#isSelectRecordOnPaginition_"+_pageRef).val();
		if(isSelectRecordOnPaginition == "false")
		{
			onMultipleSubscriberRowSelTopic(rowObj);			
		}
	});
	
	//While rid Complete that time this event triggered and if there is selected rowss inside hidden
	//field those rows will be selectes
	//Also check if the hidden field allrows_ has value=1 then all rows will be selected
	$("#createMultipleSubscriberGridTbl_Id_" + _pageRef).unsubscribe("onMultipleSubscriberGridCompleteTopic_"+_pageRef);
	$("#createMultipleSubscriberGridTbl_Id_" + _pageRef).subscribe("onMultipleSubscriberGridCompleteTopic_"+_pageRef,function(obj)
	{
		$("#isSelectRecordOnPaginition_"+_pageRef).val("true");
		onMultipleSubscriberGridCompleteTopic(obj);	
		$("#isSelectRecordOnPaginition_"+_pageRef).val("false");
	});
	
	
	//While select all that time set 1 in hidden field
	$("#createMultipleSubscriberGridTbl_Id_" + _pageRef).unsubscribe("onMultipleSubscriberSelectAllTopic_"+_pageRef);
	$("#createMultipleSubscriberGridTbl_Id_" + _pageRef).subscribe("onMultipleSubscriberSelectAllTopic_"+_pageRef,function(obj)
	{
		var allRows =  $("#allrows_"+_pageRef).val();
		if(allRows == "" || typeof allRows == "undefined" || allRows == "0")
		{
			$("#allrows_"+_pageRef).val("1");
		}
		else
		{
			$("#allrows_"+_pageRef).val("0");
			$("#selectedSubscriberIds_"+_pageRef).val("");
		}
		
	});
	
	//While before loading the data set 0 in allrows_ hidden field
	//This is only applicable for approve screen
	$("#createMultipleSubscriberGridTbl_Id_" + _pageRef).unsubscribe("onMultipleSubscriberBeforeTopic");
	$("#createMultipleSubscriberGridTbl_Id_" + _pageRef).subscribe("onMultipleSubscriberBeforeTopic",function(obj)
	{
		var isPagingReload =  $("#isPagingReload_"+_pageRef).val();
		if(_pageRef == "MIN00P" && isPagingReload == "0")
		{
			//$("#allrows_"+_pageRef).val("0");			
		}
		else
		{
			$("#isPagingReload_"+_pageRef).val("0");
		}
		
	});
	
	//On Paging set flag in isPagingReload_ hidden field to ensure the before topic will not execute in this case
	$("#createMultipleSubscriberGridTbl_Id_"+_pageRef).subscribe("onPageChangeRowSelTopic",function(rowObj)
	{
		if(_pageRef == "MIN00P")
		{
			$("#isPagingReload_"+_pageRef).val("1");
		}
	});
	
</script>