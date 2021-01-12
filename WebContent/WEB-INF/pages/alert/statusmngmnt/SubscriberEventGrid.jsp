<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp" %>

<ps:url id="urlsubscribereventListGrid" escapeAmp="false" action="StatusMngmntListAction_loadsubscribereventGrid" namespace="/path/statusMngmnt">
   <ps:param name="iv_crud"  value="ivcrud_${_pageRef}"></ps:param>
   <ps:param name="_pageRef" value="_pageRef"></ps:param>
</ps:url>

    <psjg:grid id="subevtGrid_Id_${_pageRef}"
     dataType="json"
 		href="%{urlsubscribereventListGrid}"
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
			  height="350" disableEditableFocus="true"
			   multiselect="true"
			  altRows="false" 
 			addfunc="aaa"
 			delfunc="aaaa" 
 			shrinkToFit="false" autowidth="true"
 			editurl="1234" 
 			onEditInlineBeforeTopics="onRowSelTopic"
 			editinline="true">

    
<%-- 	<psjg:gridColumn id="statuschck_id_${_pageRef}" colType="checkbox" formatter="checkbox"
				edittype="checkbox" align="center" name="statuschck"
				title="%{getText('Select_key')}" index="statuschck" editable="true"
				sortable="true" search="true" editoptions="{value:'Y:N'}" />   --%>
				<psjg:gridColumn id="statuschck" colType="text"   name="statuschck" index="statuschck" title="%{getText('statuschecked_key')}" mode="text" editable="false" sortable="true" search="true"  hidden="true"/>
	<psjg:gridColumn id="statusmodeTypeDesc" colType="text"   name="statusmodeTypeDesc" mode="text" index="statusmodeTypeDesc" title="%{getText('subscription_status_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrt_sub_evtvo.ID" colType="number" name="alrt_sub_evtvo.ID" width="100" index="alrt_sub_evtvo.ID" title="%{getText('subscription_id_key')}" editable="false" sortable="true" search="true" />
    
     <psjg:gridColumn id="alrtSubEvtRelTypeDesc" colType="text" width="250"  name="alrtSubEvtRelTypeDesc" index="alrtSubEvtRelTypeDesc" title="%{getText('subscription_type_key')}" editable="false" hidden="true" sortable="true" search="true" />
    <%--  alrt_subvo.ID --%>
  <psjg:gridColumn id=" alrt_sub_evtvo.SUB_ID" colType="number" name="alrt_sub_evtvo.SUB_ID" width="80" index="alrt_sub_evtvo.SUB_ID" title="%{getText('sub_id_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrtSubTypeDesc" colType="text" name="alrtSubTypeDesc" index="alrtSubTypeDesc" title="%{getText('subscriber_type_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="subDescription" colType="text"  width="300" name="subDescription" index="subDescription" title="%{getText('First_Name_key')}" editable="false" sortable="true" search="true" />
     <psjg:gridColumn id="sublastname" colType="text" width="300" name="sublastname" index="sublastname" title="%{getText('Last Name')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrt_evtvo.EVT_ID" width="100" colType="number" name="alrt_evtvo.EVT_ID" index="alrt_evtvo.EVT_ID" title="%{getText('event id_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrtEvtTypeDesc" colType="text" name="alrtEvtTypeDesc" index="alrtEvtTypeDesc" title="%{getText('event_type_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrtevtModeTypeDesc" width="150" colType="text" name="alrtevtModeTypeDesc" index="alrtevtModeTypeDesc" title="%{getText('event_mode_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrt_evtvo.DESC_ENG" colType="text"  name="alrt_evtvo.DESC_ENG" index="alrt_evtvo.DESC_ENG" title="%{getText('event_description_key')}" editable="false" sortable="true" search="true" />
   
   <psjg:gridColumn id="alrt_sub_evtvo.STATUS" colType="text" hidden="true"  name="alrt_sub_evtvo.STATUS" index="alrt_sub_evtvo.STATUS" title="%{getText('subscription status_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrt_subvo.SUB_TYPE" colType="text" hidden="true"  name="alrt_subvo.SUB_TYPE" index="alrt_subvo.SUB_TYPE" title="%{getText('subtype')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrt_evtvo.EVT_TYPE" colType="text" hidden="true"  name="alrt_evtvo.EVT_TYPE" index="alrt_evtvo.EVT_TYPE" title="%{getText('event_type_key')}" editable="false" sortable="true" search="true" />
    <psjg:gridColumn id="alrt_evtvo.EVT_MODE" colType="text" hidden="true" name="alrt_evtvo.EVT_MODE" index="alrt_evtvo.EVT_MODE" title="%{getText('Event Mode_key')}" editable="false" sortable="true" search="true" />
   <psjg:gridColumn id="alrt_sub_evtvo.REL_TYPE" colType="text" hidden="true" name="alrt_sub_evtvo.REL_TYPE" index="alrt_sub_evtvo.REL_TYPE" title="%{getText('event_mode_key')}" editable="false" sortable="true" search="true" />
   <psjg:gridColumn id="EMAIL_YN"
			name="alrt_sub_evtvo.EMAIL_YN" index="EMAIL_YN"
			title="%{getText('Email')}" 
			colType="checkbox" 
			edittype="checkbox"
			formatter="checkbox"
			editable="true"
			sortable="false" 
			search="true" 
			width="50" 
			editoptions="{value:'Y:N',align:'middle', dataEvents: [{ type: 'click', fn: function(e) { }}]}"
			align="center"
			searchoptions="{sopt:['eq']}"
			formatoptions="{disabled:true}"
	/>	
	
	<psjg:gridColumn id="FILE_YN"
			name="alrt_sub_evtvo.FILE_YN" index="FILE_YN"
			title="%{getText('File')}" 
			colType="checkbox" 
			edittype="checkbox"
			formatter="checkbox"
			editable="true"
			sortable="false" 
			search="true" 
			width="50" 
			editoptions="{value:'Y:N',align:'middle', dataEvents: [{ type: 'click', fn: function(e) { }}]}"
			align="center"
			searchoptions="{sopt:['eq']}"
			formatoptions="{disabled:true}"
	/>	
	
	<psjg:gridColumn id="FACEBOOK_PRIVATE_WALL_YN"
			name="alrt_sub_evtvo.FACEBOOK_PRIVATE_WALL_YN" index="FACEBOOK PRIVATE WALL_YN"
			title="%{getText('Facebook Private Wall')}" 
			colType="checkbox" 
			edittype="checkbox"
			formatter="checkbox"
			editable="true"
			sortable="false" 
			search="true" 
			width="70" 
			editoptions="{value:'Y:N',align:'middle', dataEvents: [{ type: 'click', fn: function(e) { }}]}"
			align="center"
			searchoptions="{sopt:['eq']}"
			formatoptions="{disabled:true}"
	/>	
	
	<psjg:gridColumn id="INBOX_YN"
			name="alrt_sub_evtvo.INBOX_YN" index="INBOX_YN"
			title="%{getText('Inbox')}" 
			colType="checkbox" 
			edittype="checkbox"
			formatter="checkbox"
			editable="true"
			sortable="false" 
			search="true" 
			width="50" 
			editoptions="{value:'Y:N',align:'middle', dataEvents: [{ type: 'click', fn: function(e) {}}]}"
			align="center"
			searchoptions="{sopt:['eq']}"
			formatoptions="{disabled:true}"
	/>	
	
	<psjg:gridColumn id="MOBILE_PUSH_NOTIFICATION_YN"
			name="alrt_sub_evtvo.MOBILE_PUSH_NOTIFICATION_YN" index="MOBILE_PUSH_NOTIFICATION_YN"
			title="%{getText('Mobile Push Notification')}" 
			colType="checkbox" 
			edittype="checkbox"
			formatter="checkbox"
			editable="true"
			sortable="false" 
			search="true" 
			width="70" 
			editoptions="{value:'Y:N',align:'middle', dataEvents: [{ type: 'click', fn: function(e) {}}]}"
			align="center"
			searchoptions="{sopt:['eq']}"
			formatoptions="{disabled:true}"
	/>	
	
	<psjg:gridColumn id="SMS_YN"
			name="alrt_sub_evtvo.SMS_YN" index="SMS_YN"
			title="%{getText('Sms')}" 
			colType="checkbox" 
			edittype="checkbox"
			formatter="checkbox"
			editable="true"
			sortable="false" 
			search="true" 
			width="50" 
			editoptions="{value:'Y:N',align:'middle', dataEvents: [{ type: 'click', fn: function(e) {}}]}"
			align="center"
			searchoptions="{sopt:['eq']}"
			formatoptions="{disabled:true}"
	/>	
	
	<psjg:gridColumn id="TWITTER_DIRECT_MESSAGE_YN"
			name="alrt_sub_evtvo.TWITTER_DIRECT_MESSAGE_YN" index="TWITTER_DIRECT_MESSAGE_YN"
			title="%{getText('Twitter Direct Message')}" 
			colType="checkbox" 
			edittype="checkbox"
			formatter="checkbox"
			editable="true"
			sortable="false" 
			search="true" 
			width="70" 
			editoptions="{value:'Y:N',align:'middle', dataEvents: [{ type: 'click', fn: function(e) {}}]}"
			align="center"
			searchoptions="{sopt:['eq']}"
			formatoptions="{disabled:true}"
	/>	

</psjg:grid>


<script type="text/javascript">
$("#subevtGrid_Id_"+_pageRef).subscribe("onRowSelTopic",function(rowObj)
{
	onSelRow(rowObj);
});
</script>