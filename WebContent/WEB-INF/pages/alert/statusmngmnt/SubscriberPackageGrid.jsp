<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp" %>


<ps:url id="urlsubscriberPackageGrid" escapeAmp="false" action="StatusMngmntListAction_loadSubscriberPackageGrid" namespace="/path/statusMngmnt">
   <ps:param name="iv_crud"  value="ivcrud_${_pageRef}"></ps:param>
   <ps:param name="_pageRef" value="_pageRef"></ps:param>
</ps:url>

    <psjg:grid id="subscriberPackageGrid_Id_${_pageRef}"
     dataType="json"
 		href="%{urlsubscriberPackageGrid}"
 		 pager="true" 
 		 filter="true"
 		  gridModel="gridModel"
 		rowNum="500"
 		 rowList="5,10,15,20"
 		  viewrecords="true"
 		   navigator="false"
			 navigatorAdd="false" 
			 navigatorDelete="false"
			  navigatorEdit="false"
			 navigatorRefresh="false"
			  height="350" 
			   multiselect="true"
			  altRows="false" 
			  width="1100"
 			addfunc="statusMngmntGridOnAddClicked"
 			delfunc="statusMngmntGridOnDeleteClicked" 
 			shrinkToFit="false" autowidth="false"
 			editurl="1234" 
 			editinline="true">

    
<%-- 	<psjg:gridColumn id="statuschck_id_${_pageRef}" colType="checkbox" formatter="checkbox"
				edittype="checkbox" align="center" name="statuschck"
				title="%{getText('Select_key')}" index="statuschck" editable="true"
				sortable="true" search="true" editoptions="{value:'Y:N'}" />   --%>
	<psjg:gridColumn id="statuschck" colType="text"   name="statuschck" index="statuschck" title="%{getText('statuschecked_key')}" mode="text" editable="false" sortable="true" search="true"  hidden="true"/>
	
	 <psjg:gridColumn id="alertSubPkgVO.STATUS" colType="text" width="" name="alertSubPkgVO.STATUS" index="alertSubPkgVO.STATUS" title="%{getText('subscription_status_key')}" editable="false" sortable="true" hidden="true" search="true" />
    <psjg:gridColumn id="statusmodeTypeDesc" colType="text"  width="150" name="statusmodeTypeDesc" index="statusmodeTypeDesc" title="%{getText('subscription_status_key')}" editable="false" sortable="true" search="true" />
    
	<psjg:gridColumn id="alertSubPkgVO.LINE_NO" colType="number"  width="80" name="alertSubPkgVO.LINE_NO"  index="alertSubPkgVO.LINE_NO" title="%{getText('line_no_key')}" editable="false" sortable="true" search="true" />
   
     <psjg:gridColumn id="alertSubPkgVO.SUB_ID" colType="number" width="80"  name="alertSubPkgVO.SUB_ID" index="alertSubPkgVO.SUB_ID" title="%{getText('sub_id_key')}" editable="false" sortable="true" search="true" />
    <%--  alrt_subvo.ID --%>
    <psjg:gridColumn id="alrtSubTypeDesc" colType="text"  width="100" name="alrtSubTypeDesc" index="alrtSubTypeDesc" title="%{getText('sub_type_key')}" editable="false" sortable="true" search="true" />
  	<psjg:gridColumn id=" alrt_subvo.SUB_TYPE" colType="text" name="alrt_subvo.SUB_TYPE" index="alrt_subvo.SUB_TYPE" title="%{getText('sub_type_key')}" editable="false" sortable="true" search="true" hidden="true"/>
    
    <psjg:gridColumn id="subDescription" colType="text"  width="400" name="subDescription" index="subDescription" title="%{getText('First_Name_key')}" editable="false" sortable="true" search="true" />
     <psjg:gridColumn id="sublastname" colType="text" width="400" name="sublastname" index="sublastname" title="%{getText('Last Name')}" editable="false" sortable="true" search="true" />
   
    <psjg:gridColumn id="alertSubPkgVO.PKG_ID" width="80" colType="number" name="alertSubPkgVO.PKG_ID" index="alertSubPkgVO.PKG_ID" title="%{getText('package_id_key')}" editable="false" sortable="true" search="true" />
     <psjg:gridColumn id="alert_pkgVO.BRIEF_DESC_ENG" colType="text" name="alert_pkgVO.BRIEF_DESC_ENG" index="alert_pkgVO.BRIEF_DESC_ENG" title="%{getText('package_description_key')}" editable="false" sortable="true" search="true" />
    
</psjg:grid>