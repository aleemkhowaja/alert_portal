<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@include file="/WEB-INF/pages/alert/common/AlertAppTrans.jsp"%>

<ps:set name="ivcrud_${_pageRef}" value="iv_crud" />
<ps:hidden id="iv_crud_${_pageRef}" name="iv_crud" />
<jsp:include page="/WEB-INF/pages/common/login/InfoBar.jsp" />

 <ps:url id="individualSubscriberGrid" escapeAmp="false" action="IndividualSubscriberListAction_loadData" namespace="/path/alert/subscriber/individual">
	<ps:param name="iv_crud" value="ivcrud_${_pageRef}"></ps:param>
    <ps:param name="_pageRef" value="_pageRef"></ps:param>
</ps:url> 

<div class="data-grid">
	<psjg:grid 
		id="individualSubscriberGridTbl_Id_${_pageRef}"
		href="%{individualSubscriberGrid}" 
		dataType="json" 
		caption = " "
		hiddengrid='%{iv_crud== "R"}' 
		pager="true" sortable="true"
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
		ondblclick="individualSubscriberList_onDbClickedEvent()"
		addfunc="IndividualSubscriber_AddFunc" 
		height="125" 
		sortname="ID"
		sortorder="DESC">
	
		<psjg:gridColumn id="CompCode_${_pageRef}"
			name="pmstradeVO.COMP_CODE" colType="number" title="hidden col"
			hidden="true" />
			
		<psjg:gridColumn id="ID_${_pageRef}" colType="number"
			name="ID" index="ID"
			title="%{getText('ID_key')}" editable="false" sortable="true"
			search="true" leadZeros="" width="20" />
			
		<psjg:gridColumn id="CIF_NO_${_pageRef}" colType="number"
			name="CIF_NO" index="CIF_NO"
			title="%{getText('cif_number_key')}" editable="false"
			sortable="true" search="true" width="20" />
			
	    <psjg:gridColumn id="USR_ID_${_pageRef}" colType="text"
			name="USR_ID" index="USR_ID" title="%{getText('user_id_key')}"
			editable="false" sortable="true" search="true" width="30" />
			
		<psjg:gridColumn id="BRIEF_NAME_${_pageRef}" colType="text"
			name="BRIEF_NAME" index="BRIEF_NAME"
			title="%{getText('brief_name_key')}" editable="false"
			sortable="true" search="true" width="40"  />
			
		<psjg:gridColumn id="CHANNEL_END_USR_ID_${_pageRef}" colType="text"
			name="CHANNEL_END_USR_ID" index="CHANNEL_END_USR_ID"
			title="%{getText('channel_end_user_key')}" editable="false"
			sortable="true" search="true" width="30" />
	
		<psjg:gridColumn id="STATUS_${_pageRef}" colType="text"
			name="STATUS_DESC" index="STATUS_DESC" title="%{getText('Status_key')}"
			editable="false" sortable="true" search="true" width="20" />
	</psjg:grid>
</div>

<div id="individualSubscriberMaintPage_id_<ps:property value="_pageRef" escapeHtml="true"/>"  style="width: 100%;"></div>




<script type="text/javascript">

$("#gview_individualSubscriberGridTbl_Id_${_pageRef} div.ui-jqgrid-titlebar").hide();
$.struts2_jquery.require("IndividualSubscriberList.js", null, jQuery.contextPath+ "/path/js/alert/subscriber/individual/");
</script>

<ps:if test='iv_crud == "R"'>
<script>
	$(document).ready(function() 
	{
		initIndividualSubscriberPage();
	});
	
	
</script>
</ps:if>