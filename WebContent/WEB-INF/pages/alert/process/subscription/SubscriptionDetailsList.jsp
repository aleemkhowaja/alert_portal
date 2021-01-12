<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@taglib prefix="pt" uri="/path-toolbar-tags"%>

<ps:url id="subscriptionDetailsGrid" escapeAmp="false"
	action="SelectSubscriptionDetailsGridAction_LoadSubscriptionDetailsGrid" namespace="/path/alert/subscription">
	<ps:param name="subscriptionSC.type"
			value="subscriptionSC.type"></ps:param>
	<ps:param name="subscriptionSC.lineNumber"
			value="subscriptionSC.lineNumber"></ps:param>
	<ps:param name="subscriptionSC.SUB_ID"
			value="subscriptionSC.SUB_ID"></ps:param>
	<ps:param name="subscriptionSC.EVT_ID"
			value="subscriptionSC.EVT_ID"></ps:param>
</ps:url>
<psjg:grid id="subscriptionDetailsGridTbl_Id_${_pageRef}"
			href="%{subscriptionDetailsGrid}" dataType="json" 
	 		filter="false" 
		   gridModel="gridModel"
		   viewrecords="true" 
		   navigator="true" 
		   altRows="true" 
		   navigatorRefresh="false" 
		   pagerButtons="true" 
		   navigatorEdit="false" 
		   navigatorSearch="false" 
		   height="229"
		   navigatorAdd="false" 
		   navigatorDelete="false"
		   addfunc="" 
           sortable="false" 
	       navigatorSearchOptions="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}" 
	       editinline="true" 
	       editurl=""
	       footerrow="false"
	       userDataOnFooter="false"
	       hidegrid="false"
	       shrinkToFit="false" multiselect="false" 
	       disableEditableFocus="true" 
	       onGridCompleteTopics=""
	       pager="true"
	       > <%/* to be checked ondblclick and addfunc */ %>
			
			
		<psjg:gridColumn name="alrtEvtVO.EVT_TYPE" title="" 
		index="EVT_TYPE" colType="text" hidden="true" editable="false" 
		sortable="true" search="true" id="EVT_TYPE_${_pageRef}"/>
		
		<psjg:gridColumn id="Sub_ID_${_pageRef}" colType="number"
		name="alrtSubEvtVO.SUB_ID" index="SUB_ID"
		title="%{getText('sub_id_key')}" editable="false" sortable="true"
		search="true" leadZeros="" width="100" />
		
		<psjg:gridColumn id="Sub_Desc_${_pageRef}" colType="text"
		name="subDesc" index="sub_Desc"
		title="%{getText('subscriber_description_key')}" editable="false" sortable="true"
		search="true" width="300"/>
		
		<psjg:gridColumn id="Event_ID_${_pageRef}" colType="number"
		name="alrtSubEvtVO.EVT_ID" index="EVT_ID"
		title="%{getText('event_id_key')}" editable="" sortable="true"
		search="true" width="100"/>
		
		
		<psjg:gridColumn id="Events_Type_${_pageRef}" colType="text"
		name="alrtEvtVO.DESC_ENG" index="DESC_ENG"
		title="%{getText('event_description_key')}" editable="false" sortable="true"
		search="true" width="300" />
		
		<psjg:gridColumn name="" 
       				    index="" 
       				    title="" 
       				    id="btnId_${_pageRef}"
       				    align="center"
					    colType="text"        
					    editable="false"       
					    sortable="false" 
					    search="false"
					 	formatter="subscriptionDetails_BtnFormatter"
					 	width="90"/>
		
		<psjg:gridColumn name="alrtSubEvtVO.REL_ID" title="" 
		index="REL_ID" colType="number" hidden="true" editable="false" 
		sortable="true" search="true" id="LINE_NO_${_pageRef}"/>
		
		<psjg:gridColumn name="alrtSubEvtVO.REL_TYPE" title="" 
		index="REL_TYPE" colType="text" hidden="true" editable="false" 
		sortable="true" search="true" id="RelType_${_pageRef}"/>
		
		<psjg:gridColumn name="alrtSubEvtVO.ID" title="" 
		index="ID" colType="number" hidden="true" editable="false" 
		sortable="true" search="true" id="ID_${_pageRef}"/>
		
		
		</psjg:grid>
		
		
		
<script type="text/javascript">

var Parameters_key = "<ps:text name='parameters_key'/>";
$.struts2_jquery.require("SubscriptionMaint.js",null,jQuery.contextPath+"/path/js/alert/subscription/");
</script>

