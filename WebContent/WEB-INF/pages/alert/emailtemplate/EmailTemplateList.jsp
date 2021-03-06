<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp" %>
<jsp:include page="/WEB-INF/pages/common/login/InfoBar.jsp" />

<ps:set name="ivcrud_${_pageRef}"    value="iv_crud"/>
<ps:hidden id="iv_crud_${_pageRef}"  name="iv_crud"/>

<ps:url id="urlemailTemplateListGrid" escapeAmp="false" action="EmailTemplateListAction_loadEmailTemplateGrid" namespace="/path/emailTemplate">
   <ps:param name="iv_crud"  value="ivcrud_${_pageRef}"></ps:param>
   <ps:param name="_pageRef" value="_pageRef"></ps:param>
</ps:url>
<psjg:grid
	id               ="emailTemplateListGridTbl_Id_${_pageRef}"
	caption          =" "
    href             ="%{urlemailTemplateListGrid}"
    dataType         ="json"
    hiddengrid       ='%{iv_crud== "R"}'
	pager            ="true"
	sortable         ="true"
	filter           ="true"
	gridModel        ="gridModel"
	rowNum           ="5"
	rowList          ="5,10,15,20"
    viewrecords      ="true"
    navigator        ="true"
    navigatorDelete  ="false"
    navigatorEdit    ="false"
    navigatorRefresh ="false"
    navigatorAdd     ="false"
    navigatorSearch  ="true"
    navigatorSearchOptions="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
    altRows          ="true"
    ondblclick       ="emailTemplateList_onDbClickedEvent()"
    addfunc          ="emailTemplateList_onAddClicked"
    autowidth      ="true" height="125">
    
    <psjg:gridColumn name="emailTemplateVO.TEMPLATE_ID" id="TEMPLATE_ID"
		searchoptions="{sopt:['eq','ne','lt','gt','le','ge']}"
		index="TEMPLATE_ID" colType="number" title="%{getText('TEMPLATE_ID_key')}"
		sortable="true" search="true" key="true" />
	<psjg:gridColumn name="emailTemplateVO.TEMPLATE_DESC" id="TEMPLATE_DESC"
		searchoptions="{sopt:['eq','ne','bw','bn','ew','en','cn','nc']}"
		index="TEMPLATE_DESC" colType="text" title="%{getText('Description_key')}"
		sortable="true" />
	<psjg:gridColumn name="emailTemplateVO.TEMPLATE_FILE_NAME" id="TEMPLATE_FILE_NAME"
		searchoptions="{sopt:['eq','ne','bw','bn','ew','en','cn','nc']}"
		index="TEMPLATE_FILE_NAME" colType="text" title="%{getText('FILE_NAME_key')}"
		sortable="true" />
	<psjg:gridColumn name="statusDesc" id="STATUS_DESC"
		searchoptions="{sopt:['eq','ne','bw','bn','ew','en','cn','nc']}"
		index="STATUS_DESC" colType="text" title="%{getText('Status_key')}"
		sortable="true" />
	<psjg:gridColumn id="STATUS"
		searchoptions="{sopt:['eq','ne','bw','bn','ew','en','cn','nc']}"
		colType="text" name="emailTemplateVO.STATUS" index="STATUS"
		title="%{getText('STATUS_key')}" hidden="true" />
	
</psjg:grid>
<div id="emailTemplateListMaintDiv_id_${_pageRef}" style="width:100%;">
   <ps:if test='iv_crud == "R"'>   
      <%@include file="EmailTemplateMaint.jsp"%>
   </ps:if>     
</div>
<script  type="text/javascript">
    $.struts2_jquery.require("EmailTemplateList.js,EmailTemplateMaint.js" ,null,jQuery.contextPath+"/path/js/alert/emailtemplate/");
    $("#gview_emailTemplateListGridTbl_Id_"+_pageRef+" div.ui-jqgrid-titlebar").hide();
</script>