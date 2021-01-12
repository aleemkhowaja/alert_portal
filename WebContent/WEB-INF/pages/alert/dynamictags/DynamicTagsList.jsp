<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp" %>

<jsp:include page="/WEB-INF/pages/common/login/InfoBar.jsp" />
<ps:url id="urldynamicTagsListGrid" escapeAmp="false" action="DynamicTagsListAction_loadDynamicTagsGrid" namespace="/path/dynamicTags">
   <ps:param name="iv_crud"  value="ivcrud_${_pageRef}"></ps:param>
   <ps:param name="_pageRef" value="_pageRef"></ps:param>
</ps:url>
<psjg:grid
	id               ="dynamicTagsListGridTbl_Id_${_pageRef}"
	caption          =" "
    href             ="%{urldynamicTagsListGrid}"
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
    ondblclick       ="dynamicTagsList_onDbClickedEvent()"
    addfunc          ="dynamicTagsList_onAddClicked"
    shrinkToFit      ="true" height="125">
     
     
    <psjg:gridColumn id="TAG_NAME" colType="text" name="alrtTagsVO.TAG_NAME" index="TAG_NAME" title="%{getText('tag_name_key')}" editable="false" sortable="true" search="true" align="left" />
    <psjg:gridColumn id="TAG_DESCRIPTION" colType="text" name="alrtTagsVO.TAG_DESCRIPTION" index="TAG_DESCRIPTION" title="%{getText('tag_description_key')}" editable="false" sortable="true" search="true" align="left" />
     
    <psjg:gridColumn id="TAG_ID" colType="number" name="alrtTagsVO.TAG_ID" index="TAG_ID" title="%{getText('tag_id_key')}" editable="false" sortable="true" search="true"  hidden="true"/>
    <psjg:gridColumn id="TAG_TYPE_DESC" colType="text" name="TAG_TYPE_DESC" index="TAG_TYPE_DESC" title="%{getText('tag_type_key')}" editable="false" sortable="true" search="true" align="left" />
 
     <psjg:gridColumn id="TAG_TYPE" colType="text" name="alrtTagsVO.TAG_TYPE" index="TAG_TYPE" title="%{getText('tag_type_key')}" editable="false" sortable="true" search="true" align="left"  hidden="true"/>
    <psjg:gridColumn id="FIXED_EVT_ID" colType="number" name="alrtTagsVO.FIXED_EVT_ID" index="FIXED_EVT_ID" title="%{getText('fixed_event_id_key')}" editable="false" sortable="true" search="true" align="left" hidden="true" />
    <psjg:gridColumn id="FIXED_EVT_DESC" colType="text" name="FIXED_EVT_DESC" index="FIXED_EVT_DESC" title="%{getText('fixed_event_id_desc_key')}" editable="false" sortable="true" search="true" align="left" />
    
</psjg:grid>

<div id="dynamicTagsListMaintDiv_id_${_pageRef}" style="width:100%;">
      <%@include file="DynamicTagsMaint.jsp"%>
</div>

<script  type="text/javascript">
    $.struts2_jquery.require("DynamicTagsList.js,DynamicTagsMaint.js" ,null,jQuery.contextPath+"/path/js/alert/dynamictags/");
    $("#gview_dynamicTagsListGridTbl_Id_"+_pageRef+" div.ui-jqgrid-titlebar").hide();
</script>