<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp" %>


<ps:url id="urlstatusMngmntListGrid" escapeAmp="false" action="StatusMngmntListAction_loadStatusMngmntGrid" namespace="/path/statusMngmnt">
   <ps:param name="iv_crud"  value="ivcrud_${_pageRef}"></ps:param>
   <ps:param name="_pageRef" value="_pageRef"></ps:param>
</ps:url>

    <psjg:grid id="statusGrid_Id_${_pageRef}"
     dataType="json"
 		href="%{urlstatusMngmntListGrid}"
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

    

	<psjg:gridColumn id="statuschck" colType="text"   name="statuschck" index="statuschck" title="%{getText('statuschecked_key')}" mode="text" editable="false" sortable="true" search="true"  hidden="true"/>
	<psjg:gridColumn id="statusmodeTypeDesc" colType="text"   name="statusmodeTypeDesc" mode="text" index="statusmodeTypeDesc" title="%{getText('subscription_status_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrt_sub_evtvo.ID" colType="number" name="alrt_sub_evtvo.ID" index="alrt_sub_evtvo.ID" title="%{getText('subscription_id_key')}" editable="false" sortable="true" search="true" />
    
     <psjg:gridColumn id="alrtSubEvtRelTypeDesc" colType="text" width="250"  name="alrtSubEvtRelTypeDesc" index="alrtSubEvtRelTypeDesc" title="%{getText('subscription_type_key')}" editable="false" sortable="true" search="true" />

  <psjg:gridColumn id=" alrt_sub_evtvo.SUB_ID" colType="number" name="alrt_sub_evtvo.SUB_ID" index="alrt_sub_evtvo.SUB_ID" title="%{getText('sub_id_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrtSubTypeDesc" colType="text" name="alrtSubTypeDesc" index="alrtSubTypeDesc" title="%{getText('subscriber_type_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="subDescription" colType="text"  width="500" name="subDescription" index="subDescription" title="%{getText('First_Name_key')}" editable="false" sortable="true" search="true" />
     <psjg:gridColumn id="sublastname" colType="text" width="500" name="sublastname" index="sublastname" title="%{getText('Last Name')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrt_evtvo.EVT_ID" colType="number" name="alrt_evtvo.EVT_ID" index="alrt_evtvo.EVT_ID" title="%{getText('event_id_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrtEvtTypeDesc" colType="text" name="alrtEvtTypeDesc" index="alrtEvtTypeDesc" title="%{getText('event_type_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrtevtModeTypeDesc" colType="text" name="alrtevtModeTypeDesc" index="alrtevtModeTypeDesc" title="%{getText('event_mode_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrt_evtvo.DESC_ENG" colType="text"  name="alrt_evtvo.DESC_ENG" index="alrt_evtvo.DESC_ENG" title="%{getText('event_description_key')}" editable="false" sortable="true" search="true" />
   
   <psjg:gridColumn id="alrt_sub_evtvo.STATUS" colType="text" hidden="true"  name="alrt_sub_evtvo.STATUS" index="alrt_sub_evtvo.STATUS" title="%{getText('subscription status_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrt_subvo.SUB_TYPE" colType="text" hidden="true"  name="alrt_subvo.SUB_TYPE" index="alrt_subvo.SUB_TYPE" title="%{getText('subtype')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrt_evtvo.EVT_TYPE" colType="text" hidden="true"  name="alrt_evtvo.EVT_TYPE" index="alrt_evtvo.EVT_TYPE" title="%{getText('event_type_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrt_evtvo.EVT_MODE" colType="text" hidden="true" name="alrt_evtvo.EVT_MODE" index="alrt_evtvo.EVT_MODE" title="%{getText('Event Mode_key')}" editable="false" sortable="true" search="true" />
   <psjg:gridColumn id="alrt_sub_evtvo.REL_TYPE" colType="text" hidden="true" name="alrt_sub_evtvo.REL_TYPE" index="alrt_sub_evtvo.REL_TYPE" title="%{getText('event_mode_key')}" editable="false" sortable="true" search="true" />

</psjg:grid>

