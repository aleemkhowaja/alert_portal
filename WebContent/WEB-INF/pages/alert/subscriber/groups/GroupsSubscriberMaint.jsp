<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@taglib prefix="ptt" uri="/path-toolbar-tags"%>

<ps:hidden id="selSerialNo_${_pageRef}" name="selSerialNo"></ps:hidden>
<ps:hidden id="selSerialNo2_${_pageRef}" name="selSerialNo2"></ps:hidden>
<ps:hidden id="changetags_${_pageRef}" name="changetags" />
<ps:hidden id="iv_crud_${_pageRef}" name="iv_crud" />
<ps:hidden id="SubInGroup_${_pageRef}" name="subcriberInGroup" />
<ps:form useHiddenProps="true"
	id="groupsSubscriberMainFormId_${_pageRef}"
	namespace="/path/alert/subscriber/groups">

	<fieldset class="ui-widget-content ui-corner-all" title="">
		<table>
			<tr>
				<td colspan="1" class="fldLabelView">
					<ps:label
						key="Group_ID_key" 
						id="lbl_grpId_${_pageRef}"
						for="grpId_${_pageRef}" 
						maxlength="5" />
				</td>
				<td colspan="2" class="fldDataEdit right">
					<ps:textfield
						id="grpId_${_pageRef}" 
						name="groupsSubscriberCO.alrtGrpVO.GRP_ID"
						mode="number" 
						readonly="true" 
						tabindex="1" 
						maxlength="16" />
				</td>
				<td width="50%" class="fldLabelView" />
				<td colspan="1" class="fldLabelView">
					<ps:label 
						key="Status_key"
						id="lbl_status_${_pageRef}" 
						for="status_${_pageRef}" 
						maxlength="5" />
				</td>
				<td colspan="1" class="fldDataEdit right">
					<ps:textfield
						id="status_${_pageRef}" 
						name="groupsSubscriberCO.alrtGrpVO.STATUS"
						readonly="true" 
						tabindex="1" 
						maxlength="100" />
				</td>
				<td colspan="2" align="right">
					<psj:a 
						button="true"
						buttonIcon="ui-icon-triangle-2-s"
						onclick="showGrpSubscriberStatus()">
						<ps:text name='status_key' />
					</psj:a>
				</td>
			</tr>
		</table>
		<table cellpadding="2" cellspacing="1" border="0" >
			<tr>
				<td width="10%"> </td>
				<td width="10%"> </td>
				<td width="10%"> </td>
				<td width="10%"> </td>
				<td width="10%"> </td>
				<td width="10%"> </td>
				<td width="10%"> </td>
				<td width="10%"> </td>
				<td width="10%"> </td>
				<td width="10%"> </td>
				<td width="10%"> </td>
				<td width="10%"> </td>
			</tr>
		<tr>
			<tr>
				<td nowrap="nowrap" class="fldLabelView">
					<ps:label
						key="brief_eng_desc_key" 
						id="lbl_brief_desc_eng_${_pageRef}"
						for="briefDescEng_${_pageRef}"  />
				</td>
				<td colspan="5" class="fldDataEdit right">
					<ps:textfield
						id="briefDescEng_${_pageRef}"
						name="groupsSubscriberCO.alrtGrpVO.BRIEF_DESC_ENG" 
						required="true"
						readonly="false" 
						tabindex="1" 
						maxlength="50" />
				</td>
				<td colspan="6"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" class="fldLabelView">
					<ps:label
						key="long_eng_desc_key" 
						id="lbl_long_desc_eng_${_pageRef}"
						for="longDescEng_${_pageRef}" />
				</td>
				<td colspan="5" class="fldDataEdit right">
					<ps:textfield
						id="longDescEng_${_pageRef}"
						name="groupsSubscriberCO.alrtGrpVO.LONG_DESC_ENG" 
						required="false"
						readonly="false" 
						tabindex="2" 
						maxlength="100" />
				</td>
				<td colspan="6"></td>
			</tr>
			<tr>
				<td colspan="5"></td>
				<td colspan="6" class="fldDataEdit left">
					<ps:textfield
						id="briefDescAra_${_pageRef}"
						name="groupsSubscriberCO.alrtGrpVO.BRIEF_DESC_ARAB"
						readonly="false" 
						tabindex="3" 
						maxlength="50"
						onlyArabic="true"  />
				</td>
				<td nowrap="nowrap" class="fldLabelView">
					<ps:label
						key="brief_desc_alrt_arab_key" 
						id="lbl_brief_ara_eng_${_pageRef}"
						for="briefDescAra_${_pageRef}" />
				</td>
			</tr>
			<tr>
				<td colspan="5"></td>
				<td colspan="6" class="fldDataEdit left">
					<ps:textfield
						id="longDescAra_${_pageRef}"
						name="groupsSubscriberCO.alrtGrpVO.LONG_DESC_ARAB"
						onlyArabic="true" 
						required="false" 
						readonly="false" 
						tabindex="4"
						maxlength="100" 
						dir="rtl" />
				</td>
				<td nowrap="nowrap" class="fldLabelView">
					<ps:label
						key="long_desc_alrt_arab_key" 
						id="lbl_long_desc_ara_${_pageRef}"
						for="longDescAra_${_pageRef}" 
					/>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" class="fldLabelView">
					<ps:label
						key="include_all_subscribers_key" 
						id="lbl_include_all_subscribers_${_pageRef}"						
						for="include_all_subscribers_${_pageRef}"  />
				</td>
				<td nowrap="nowrap" class="fldLabelView">
					<ps:checkbox id="include_all_subscribers_${_pageRef}"
						name="groupsSubscriberCO.alrtGrpVO.INCLUDE_ALL_SUB_YN" tabindex="5"
						cssClass="ui-widget-content checkboxheight" 
						valOpt="Y:N"
						parameter="groupsSubscriberCO.alrtGrpVO.INCLUDE_ALL_SUB_YN:include_all_subscribers_${_pageRef}"
						dependencySrc="${pageContext.request.contextPath}/path/alert/subscriber/groups/GroupsMaintAction_applyDisplaySettingByIncludeAllSub"
						dependency="include_all_subscribers_${_pageRef}:groupsSubscriberCO.alrtGrpVO.INCLUDE_ALL_SUB_YN,
						changetags_${_pageRef}:'1',SubInGroup_${_pageRef}:''"
						/>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" class="fldLabelView">
					<ps:label
						key="include_specific_subscribers_key" 
						id="lbl_group_subscribers_${_pageRef}"						
						for="lookuptxt_group_subscribers_${_pageRef}"  />
				</td>
				<td colspan="5" >					
						<psj:livesearch id="group_subscribers_${_pageRef}" 
										name="group_subscribers" mode="text"
										tabindex="5"
										multiSelect="%{_pageRef !='GRP00P'}"
										multiResultInput="SubInGroup_${_pageRef}"
										selectColumn="alertSubVO.ID,alertSubLangVO.BRIEF_NAME,alertSubVO.CIF_NO,CIF_TYPE,alertSubVO.USR_ID,alertSubVO.CHANNEL_END_USR_ID,STATUS"
										resultList="allSelectedRow:lookuptxt_all_subscriber_${_pageRef}"										
										actionName="${pageContext.request.contextPath}/path/alert/subscriber/groups/GroupSubscriberLookupAction_constructSubGroup"
										paramList="progRef:_pageRef,groupId:grpId_${_pageRef}"
										searchElement="alertSubVO.ID">
						</psj:livesearch>					
				</td>
				
				<td colspan="6"></td>
			</tr>						
			
		</table>

		<ps:hidden id="createdBy_${_pageRef}"
			name="groupsSubscriberCO.alrtGrpVO.CREATED_BY" readonly="false"
			maxlength="35" />

		<ps:hidden id="dateCreated_${_pageRef}"
			name="groupsSubscriberCO.alrtGrpVO.DATE_CREATED" readonly="false" />

		<ps:hidden id="modifiedBy_${_pageRef}"
			name="groupsSubscriberCO.alrtGrpVO.MODIFIED_BY" readonly="false"
			maxlength="35" />

		<ps:hidden id="dateModified_${_pageRef}"
			name="groupsSubscriberCO.alrtGrpVO.DATE_MODIFIED" readonly="false"
			buttonImageOnly="true" />

		<ps:hidden id="deletedBy_${_pageRef}"
			name="groupsSubscriberCO.alrtGrpVO.DELETED_BY" readonly="false"
			maxlength="35" />

		<ps:hidden id="dateDeleted_${_pageRef}"
			name="groupsSubscriberCO.alrtGrpVO.DATE_DELETED" readonly="false"
			buttonImageOnly="true" />

		<ps:hidden id="dateUpdated_${_pageRef}"
			name="groupsSubscriberCO.alrtGrpVO.DATE_UPDATED" readonly="false" />

<%-- 		<table border="0">

			<tr>
				<td colspan="7" width="45%" class="fldDataEdit left" tabindex="5">
				<%@include file="/WEB-INF/pages/alert/subscriber/groups/NotInGroupsSubsciberList.jsp"%>
				</td>
				<td colspan="1" width="3.5%" />
				<td colspan="1" width="3.5%">
				
				</td>
				<td colspan="1" width="3.5%" />
				<td colspan="7" width="50%" class="fldDataEdit left" tabindex="8">
				<%@include file="/WEB-INF/pages/alert/subscriber/groups/InGroupsSubsciberList.jsp"%>
				</td>
				<td colspan="1" width="3.5%" />
			</tr>
		</table> --%>
	</fieldset>


	<div id="groupsSubDetails_<ps:property value="_pageRef" escapeHtml="true"/>"></div>

	<ptt:toolBar id="groupsSubscriberToolBar_${_pageRef}"
		hideInAlert="true">

		<psj:submit button="true" buttonIcon="ui-icon-disk"
			id="grpSubSave_${_pageRef}">
			<ps:label key="btn.save" for="grpSubSave_${_pageRef}" tabindex="9" />
		</psj:submit>
		
		<psj:submit button="true" type="button"
			onclick="groupSubscriberMaint_conformApprove()" id="grpSubApp_${_pageRef}">
			<ps:label key="Approve" for="grpSubApp_${_pageRef}" tabindex="10" />
		</psj:submit>
		
		<psj:submit button="true" type="button" buttonIcon="ui-icon-trash"
			onclick="groupSubscriberMaint_conformDelete()" id="grpSubDel_${_pageRef}">
			<ps:label key="btn.del" for="grpSubDel_${_pageRef}" tabindex="11" />
		</psj:submit>

	</ptt:toolBar>
</ps:form>



<script type="text/javascript">
	$.struts2_jquery.require("GroupsSubscriberMaint.js", null,jQuery.contextPath + "/path/js/alert/subscriber/groups/");
	
	$("#groupsSubscriberMainFormId_" + _pageRef).processAfterValid("groupSubscriberMaint_save", {});
	
	if(_pageRef !="GRP00P" && !(_pageRef=='GRP00MT' && $("#status_"+_pageRef).val()=='Approved')){
			$("#subInGrp_${_pageRef}").droppable({
				    tolerance: "pointer"
			});
			
			$("#subNotInGrp_${_pageRef}").droppable({
				tolerance: "pointer"
			});
			
			jQuery("#subNotInGrp_"+_pageRef).jqGrid("gridDnD",
			{
				connectWith:"#subInGrp_"+_pageRef,
				droppos:"last",
				ondrop: function (ev, ui, getdata) {
				    $("#cb_subNotInGrp_"+_pageRef).prop('checked', false);
				    $("#cb_subInGrp_"+_pageRef).prop('checked', false);
				}
			});
				
			jQuery("#subInGrp_"+_pageRef).jqGrid("gridDnD",
			{
				connectWith:"#subNotInGrp_"+_pageRef,
				droppos:"last",
				ondrop: function (ev, ui, data) {
					$("#cb_subInGrp_"+_pageRef).prop('checked', false);
				    $("#cb_subNotInGrp_"+_pageRef).prop('checked', false);
				}
			});
	}
</script>
