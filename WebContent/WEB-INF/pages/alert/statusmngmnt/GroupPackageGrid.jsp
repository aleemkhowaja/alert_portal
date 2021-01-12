<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp" %>


<ps:url id="urlGroupPackageGrid" escapeAmp="false" action="StatusMngmntListAction_loadGroupPackageGrid" namespace="/path/statusMngmnt">
   <ps:param name="iv_crud"  value="ivcrud_${_pageRef}"></ps:param>
   <ps:param name="_pageRef" value="_pageRef"></ps:param>
</ps:url>

    <psjg:grid id="groupPackageGrid_Id_${_pageRef}"
     dataType="json"
 		href="%{urlGroupPackageGrid}"
 		 pager="true" 
 		 filter="true"
 		  gridModel="gridModel"
 		rowNum="500"
 		 rowList=""
 		  viewrecords="true"
 		   navigator="false"
			 navigatorAdd="false" 
			 navigatorDelete="false"
			  navigatorEdit="false"
			 navigatorRefresh="true"
			  height="350" 
			   multiselect="true"
			  altRows="false" 
 			addfunc="statusMngmntGridOnAddClicked"
 			delfunc="statusMngmntGridOnDeleteClicked" 
 			shrinkToFit="false" autowidth="true"
 			editurl="1234" 
 			editinline="true">

    
<%-- 	<psjg:gridColumn id="statuschck_id_${_pageRef}" colType="checkbox" formatter="checkbox"
				edittype="checkbox" align="center" name="statuschck"
				title="%{getText('Select_key')}" index="statuschck" editable="true"
				sortable="true" search="true" editoptions="{value:'Y:N'}" />   --%>
	<psjg:gridColumn id="statuschck" colType="text"   name="statuschck" index="statuschck" title="%{getText('statuschecked_key')}" mode="text" editable="false" sortable="true" search="true"  hidden="true"/>
	
	<psjg:gridColumn id="alertGrpPkgVO.STATUS" colType="text" width="250"  name="alertGrpPkgVO.STATUS" index="alertGrpPkgVO.STATUS" title="%{getText('status_key')}" editable="false" sortable="true" search="true" hidden="true" />
     <psjg:gridColumn id="statusmodeTypeDesc" colType="text" width="250"  name="statusmodeTypeDesc" index="statusmodeTypeDesc" title="%{getText('subscribtion_status_key')}" editable="false" sortable="true" search="true" />
    
	
	<psjg:gridColumn id="alertGrpPkgVO.LINE_NO" colType="number"   name="alertGrpPkgVO.LINE_NO"  index="alertGrpPkgVO.LINE_NO" title="%{getText('line_no_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alertGrpPkgVO.GRP_ID" colType="number" name="alertGrpPkgVO.GRP_ID" index="alertGrpPkgVO.GRP_ID" title="%{getText('Group_Id_key')}" editable="false" sortable="true" search="true" />
     <%--  alrt_subvo.ID --%>
      <psjg:gridColumn id="alertGrpVO.BRIEF_DESC_ENG" colType="text" width="500" name="alertGrpVO.BRIEF_DESC_ENG" index="alertGrpVO.BRIEF_DESC_ENG" title="%{getText('Group_Description_key')}" editable="false" sortable="true" search="true" />
  	<psjg:gridColumn id=" alertGrpPkgVO.PKG_ID" colType="text" name="alertGrpPkgVO.PKG_ID" index="alertGrpPkgVO.PKG_ID" title="%{getText('package_id_key')}" editable="false" sortable="true" search="true" />
    
    <psjg:gridColumn id="alertGrpVO.GRP_ID" colType="text"  width="500" name="alertGrpVO.GRP_ID" index="alertGrpVO.GRP_ID" title="%{getText('grp_id_key')}" editable="false" sortable="true" search="true" hidden="true" />
    
    <psjg:gridColumn id="alert_pkgVO.BRIEF_DESC_ENG" colType="text" name="alert_pkgVO.BRIEF_DESC_ENG" index="alert_pkgVO.BRIEF_DESC_ENG" title="%{getText('package_description_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alert_pkgVO.PKG_ID" colType="text" name="alert_pkgVO.PKG_ID" index="alert_pkgVO.PKG_ID" title="%{getText('package_id_key')}" editable="false" sortable="true" search="true"  hidden="true"/>
    
</psjg:grid>


