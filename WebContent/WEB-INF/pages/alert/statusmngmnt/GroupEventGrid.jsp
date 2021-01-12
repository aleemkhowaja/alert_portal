<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp" %>


<ps:url id="urlGroupEvtGrid" escapeAmp="false" action="StatusMngmntListAction_loadGroupEvtGrid" namespace="/path/statusMngmnt">
   <ps:param name="iv_crud"  value="ivcrud_${_pageRef}"></ps:param>
   <ps:param name="_pageRef" value="_pageRef"></ps:param>
</ps:url>

    <psjg:grid id="groupEvtGrid_Id_${_pageRef}"
     dataType="json"
 		href="%{urlGroupEvtGrid}"
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
			 navigatorRefresh="false"
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
	<psjg:gridColumn id="statusmodeTypeDesc" colType="text" name="statusmodeTypeDesc" index="statusmodeTypeDesc" title="%{getText('subscription_status_key')}" editable="false" sortable="true" search="true" />
	<psjg:gridColumn id="alertEvtGrpVO.LINE_NO" colType="number" width="80" name="alertEvtGrpVO.LINE_NO" index="alertEvtGrpVO.LINE_NO" title="%{getText('line_no_key')}" editable="false" sortable="true" search="true" />
	<psjg:gridColumn id="alertGrpVO.GRP_ID" colType="number"  width="80" name="alertGrpVO.GRP_ID" index="alertGrpVO.GRP_ID" title="%{getText('Group_Id_key')}" editable="false" sortable="true" search="true" />
	<psjg:gridColumn id="alertGrpVO.BRIEF_DESC_ENG" colType="text" width="300" name="alertGrpVO.BRIEF_DESC_ENG" index="alertGrpVO.BRIEF_DESC_ENG" title="%{getText('Group_Description_key')}" editable="false" sortable="true" search="true" />
	<psjg:gridColumn id="alrt_evtvo.EVT_ID" colType="number"   width="80" name="alrt_evtvo.EVT_ID"  index="alrt_evtvo.EVT_ID" title="%{getText('evt_id_key')}" editable="false" sortable="true" search="true" />
   	<psjg:gridColumn id=" alrtEvtTypeDesc" colType="text" name="alrtEvtTypeDesc" index="alrtEvtTypeDesc" title="%{getText('evt_type_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alertEvtGrpVO.STATUS" colType="text" name="alertEvtGrpVO.STATUS" index="alertEvtGrpVO.STATUS" title="%{getText('Subscription_status_key')}" editable="false" sortable="true" search="true" hidden="true" />
    <psjg:gridColumn id="alrtevtModeTypeDesc" colType="text" width="80" name="alrtevtModeTypeDesc" index="alrtevtModeTypeDesc" title="%{getText('evt_mode_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrt_evtvo.DESC_ENG" colType="text" width="250"  name="alrt_evtvo.DESC_ENG" index="alrt_evtvo.DESC_ENG" title="%{getText('Description_key')}" editable="false" sortable="true" search="true" />
    <%--  alrt_subvo.ID --%>
  
    
   
     
  
   
   
</psjg:grid>			