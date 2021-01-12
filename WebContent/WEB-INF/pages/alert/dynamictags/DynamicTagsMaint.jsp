<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt"  uri="/path-toolbar-tags" %>
<%@page import="com.path.alert.bo.base.AlertConstant"%>

<ps:set name="mandatory_existing_dyn_in_the_tag" value="%{getEscText('mandatory_existing_dyn_in_the_tag')}" />
<ps:set name="invalid_fixed_event_id" value="%{getEscText('invalid_fixed_event_id')}" />

 <script type="text/javascript">

	var mandatory_existing_dyn_in_the_tag = "${mandatory_existing_dyn_in_the_tag}";
	var invalid_fixed_event_id = "${invalid_fixed_event_id}";
  	var type_S = '<%=AlertConstant.TYPE_S%>';
	var type_C = '<%=AlertConstant.TYPE_C%>';  
	$(document).ready(
			function()
			{
				 $.struts2_jquery.require("DynamicTagsList.js,DynamicTagsMaint.js", null,
						jQuery.contextPath
								+ "/path/js/alert/dynamictags/"); 
				 $("#dynamicTagsMaintFormId_"+_pageRef).processAfterValid("DynamicTagsMaint_processSubmit", {})
				dynamicTags_ShowHideFixedEventId();
				 //@todo , handle this at the jsp level
				dynamicTags_showHideDeleteButton();
			});
</script>



<ps:form useHiddenProps="true" id="dynamicTagsMaintFormId_${_pageRef}"  namespace="/path/dynamicTags">

<ps:set name="ivcrud_${_pageRef}" value="iv_crud" />
<ps:hidden id="tagID_${_pageRef}" name="dynamicTagsCO.alrtTagsVO.TAG_ID"/>  

<table  cellpadding="2" cellspacing="3" border="0">


 	<tr>
		<td colspan ="20"></td>
		<td align	="left"><ps:label id="lbl_dynamicTagsName_${_pageRef}" key="tag_name_key" for="dynamicTagsName_${_pageRef}"></ps:label></td>
		<td align   ="left"><ps:textfield id="dynamicTagsName_${_pageRef}" name="dynamicTagsCO.alrtTagsVO.TAG_NAME"
							maxlength="50" mode="text" required="true"  tabindex="1" cssStyle="text-transform:uppercase;width: 295px;"
							onchange="dynamicTags_checkTagName();"> 
				           </ps:textfield>
	    </td>
	</tr> 
	
	
	 <tr>
		<td colspan ="20"></td>
		<td align	="left"><ps:label id="lbl_dynamicTagsDescription_${_pageRef}" key="tag_description_key" for="dynamicTagsDescription_${_pageRef}"></ps:label></td>
		<td align   ="left"><ps:textfield id="dynamicTagsDescription_${_pageRef}" name="dynamicTagsCO.alrtTagsVO.TAG_DESCRIPTION"
							maxlength="255" mode="text" required="true" tabindex="2"  cssStyle="width: 295px;"> 
				            </ps:textfield>
	    </td>
	</tr> 
	
	
	<tr>
	<td colspan ="20"></td>
		<td align	="left"><ps:label id="lbl_dynamicTagsType_${_pageRef}" key="tag_type_key" ></ps:label></td>
		<td>
        <ps:select list="fillTagTypeList" 
		 			listKey="code"
					listValue="descValue" 
					name="dynamicTagsCO.alrtTagsVO.TAG_TYPE"
					required="true"
					tabindex="3"
					style="width: 295px;"
					onchange="dynamicTags_ShowHideFixedEventId(this.value)"
				    id="dynamicTagsType_${_pageRef}"/>
		</td> 
	</tr>
	
	
 	<tr>
		<td colspan ="20"></td>
		<td align	="left"><ps:label id="lbl_dynamicTagsFixedEventId_${_pageRef}" key="fixed_event_id_key" for="dynamicTagsFixedEventId_${_pageRef}"></ps:label></td>
		<td align   ="left">
				<psj:livesearch
							name="dynamicTagsCO.alrtTagsVO.FIXED_EVT_ID"
							id="fixedEventid_${_pageRef}"
							mode="number" 
							tabindex="4"
							minValue="0"
							resultList="ID:lookuptxt_fixedEventid_${_pageRef}"
							parameter="criteria.alrtEvtVO.FIXED_EVENT_ID:lookuptxt_fixedEventid_${_pageRef}"
							actionName="${pageContext.request.contextPath}/path/alert/events/event/FixedEvtIdLookupAction_constructFixedEventQueryLookup"
							dependencySrc="${pageContext.request.contextPath}/path/alert/events/event/IndividualEventDepAction_dependencyByFixedEvtId"
							dependency="lookuptxt_fixedEventid_${_pageRef}:criteria.alrtEvtVO.FIXED_EVENT_ID,briefdesceng_${_pageRef}:individualEventCO.briefDescEng,
							invalidfixedevtid_${_pageRef}:individualEventCO.invalidfixedevtid"
							searchElement="FIXED_EVENT_ID" 
							maxlength="8"
							afterDepEvent="DynamicTagsMaint_CheckValidityOfeventType()"
							cssStyle="width: 295px;">
				</psj:livesearch>
	   </td>
		<td colspan ="20"> <ps:textfield
					id="briefdesceng_${_pageRef}" 
					name="dynamicTagsCO.FIXED_EVT_DESC"
					mode="string" 
					required="" 
					readonly="true" 
					tabindex="5"
					size="35"
					maxlength="100" />
		</td>
	</tr>
	<tr>
		<td colspan="1" class="fldDataEdit right"><ps:textfield
					id="invalidfixedevtid_${_pageRef}"
					name="individualEventCO.invalidfixedevtid" mode="text"
					required="false" tabindex="6" maxlength="1" hidden="true" /></td>
	
	</tr>
</table>

<ptt:toolBar id="dynamicTagsMaintToolBar_${_pageRef}" hideInAlert="true">
    <psj:submit id="dynamicTagsMaint_save_${_pageRef}" button="true" freezeOnSubmit="true">
    	<ps:label key="Save_key" for="dynamicTagsMaint_save_${_pageRef}"/>
    </psj:submit>

	<psj:submit id="dynamicTagsMaint_del_${_pageRef}" button="true" freezeOnSubmit="true"  onclick="dynamicTagsMaint_onDeleteClicked()">
	    	<ps:label key="Delete_key" for="dynamicTagsMaint_del_${_pageRef}"/>
	</psj:submit>		
   
</ptt:toolBar>
</ps:form>
