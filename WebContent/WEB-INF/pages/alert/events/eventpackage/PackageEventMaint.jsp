<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@taglib prefix="pt" uri="/path-toolbar-tags"%>

<ps:hidden id="iv_crud_${_pageRef}" name="iv_crud" />
<ps:hidden id="changetags_${_pageRef}" name="changetags" />
<ps:hidden id="eventInPackage_${_pageRef}" name="eventInPackage" />
<ps:form useHiddenProps="true" id="packageEventMainFormId_${_pageRef}"
	namespace="/path/alert/events/eventpackage">
<ps:hidden id="DATE_UPDATED_${_pageRef}" name="packageEventCO.alrtPkgVO.DATE_UPDATED" />	
	<fieldset class="ui-widget-content ui-corner-all" title="">
		<table border="0">
			<tr>
				<td colspan="1" class="fldLabelView"><ps:label
						key="package_id_key" id="lbl_pkgId_${_pageRef}"
						for="pkgId_${_pageRef}" maxlength="5" /></td>
				<td colspan="2" class="fldDataEdit right"><ps:textfield
						id="pkgId_${_pageRef}" name="packageEventCO.alrtPkgVO.PKG_ID"
						mode="number" readonly="true" tabindex="1" maxlength="16" /></td>
				<td width="50%" class="fldLabelView" />
				<td colspan="1" class="fldLabelView"><ps:label key="Status_key"
						id="lbl_status_${_pageRef}" for="status_${_pageRef}" maxlength="5" />
				</td>
				<td colspan="1" class="fldDataEdit right"><ps:textfield
						id="status_${_pageRef}" name="packageEventCO.alrtPkgVO.STATUS"
						readonly="true" tabindex="1" maxlength="100" /></td>
				</td>
				<td colspan="2" align="right"><psj:a button="true"
						buttonIcon="ui-icon-triangle-2-s"
						onclick="showPkgEvtStatus()">
						<ps:text name='status_key' />
					</psj:a></td>
			</tr>
			<tr>
				<td height="5"></td>
			</tr>
			<tr>
				<td colspan="12" bgcolor="#E1E1E1"></td>
			</tr>
			<tr>
				<td height="5"></td>
			</tr>
			<tr>
				<td colspan="1" class="fldLabelView"><ps:label
						key="brief_desc_alrt_eng_key" id="lbl_brief_desc_eng_${_pageRef}"
						for="briefDescEng_${_pageRef}" maxlength="5" /></td>
				<td colspan="3" class="fldDataEdit right"><ps:textfield
						id="briefDescEng_${_pageRef}"
						name="packageEventCO.alrtPkgVO.BRIEF_DESC_ENG" required="true"
						readonly="false" tabindex="1" maxlength="50" /></td>
			</tr>

			<tr>
				<td colspan="1" class="fldLabelView"><ps:label
						key="long_desc_alrt_eng_key" id="lbl_long_desc_eng_${_pageRef}"
						for="longDescEng_${_pageRef}" maxlength="5" /></td>
				<td colspan="3" class="fldDataEdit right"><ps:textfield
						id="longDescEng_${_pageRef}"
						name="packageEventCO.alrtPkgVO.LONG_DESC_ENG" required="false"
						readonly="false" tabindex="2" maxlength="100" /></td>
			</tr>

			<tr>
				<td colspan="2" class="fldDataEdit left"></td>
				<td colspan="8" class="fldDataEdit left"><ps:textfield
						id="briefDescAra_${_pageRef}"
						name="packageEventCO.alrtPkgVO.BRIEF_DESC_ARAB"
						readonly="false" tabindex="3" maxlength="50" dir="rtl" onlyArabic="true" /></td>
				<td colspan="1" class="fldLabelView"><ps:label
						key="brief_desc_alrt_arab_key" id="lbl_brief_ara_eng_${_pageRef}"
						for="briefDescAra_${_pageRef}" /></td>
			</tr>
			<tr>
				<td colspan="2" class="fldDataEdit left"></td>
				<td colspan="8" class="fldDataEdit left"><ps:textfield
						id="longDescAra_${_pageRef}"
						name="packageEventCO.alrtPkgVO.LONG_DESC_ARAB" required="false"
						readonly="false" tabindex="4" maxlength="100" dir="rtl" onlyArabic="true" /></td>
				<td colspan="1" class="fldLabelView"><ps:label
						key="long_desc_alrt_arab_key" id="lbl_long_desc_ara_${_pageRef}"
						for="longDescAra_${_pageRef}" /></td>
			</tr>

			<tr>
				<td height="5"></td>
			</tr>
			<tr>
				<td colspan="12" bgcolor="#E1E1E1"></td>
			</tr>
			<tr>
				<td height="5"></td>
			</tr>


		<table width="100%">
			<tr>
				<td width="8%"></td>
				<td width="44%"></td>
				<td width="48%"></td>
			</tr>
			<tr>
				<td nowrap="nowrap" class="fldLabelView">
					<ps:label
						key="include_all_events_key" 
						id="lbl_include_all_events_${_pageRef}"						
						for="include_all_events_${_pageRef}"  />
				</td>
				<td nowrap="nowrap" class="fldLabelView">
					<ps:checkbox id="include_all_events_${_pageRef}"
						name="packageEventCO.alrtPkgVO.INCLUDE_ALL_EVT_YN" tabindex="5"
						cssClass="ui-widget-content checkboxheight" 
						valOpt="Y:N"
						parameter="packageEventCO.alrtPkgVO.INCLUDE_ALL_EVT_YN:include_all_events_${_pageRef}"
						dependencySrc="${pageContext.request.contextPath}/path/alert/events/eventpackage/PackageEventMaintAction_applyDisplaySettingByIncludeAllEvents"
						dependency="include_all_events_${_pageRef}:packageEventCO.alrtPkgVO.INCLUDE_ALL_EVT_YN,
						changetags_${_pageRef}:'1',eventInPackage_${_pageRef}:''"
						/>
				</td>
			</tr>	
 			<tr>
				<td  nowrap="nowrap" class="fldLabelView" >
					<ps:label
						key="include_specific_events_key" 
						id="lbl_package_event_${_pageRef}"							
						for="lookuptxt_package_event_${_pageRef}"  />
				</td>
				<td >
					<psj:livesearch id="package_event_${_pageRef}" 
						name="package_event" mode="text"
						tabindex="5"
						required="false"
						multiSelect="%{_pageRef !='PKG00P'}"
						multiResultInput="eventInPackage_${_pageRef}"
						selectColumn="EVT_ID,EVT_TYPE,DESCRIPTION,STATUS"
						resultList="allSelectedRow:lookuptxt_package_event_${_pageRef}"										
						actionName="${pageContext.request.contextPath}/path/alert/events/eventpackage/EventPackageLookupAction_constructEventPackage"
						paramList="progRef:_pageRef,pkgId:pkgId_${_pageRef},packageId:pkgId_${_pageRef}"											
						searchElement="EVT_ID">
					</psj:livesearch>
				</td>
				<td></td>
			</tr>
		</table>
	</table>

		<ps:hidden id="createdBy_${_pageRef}"
			name="packageEventCO.alrtPkgVO.CREATED_BY" 
			readonly="false" maxlength="35" />

		<ps:hidden id="dateCreated_${_pageRef}"
			name="packageEventCO.alrtPkgVO.DATE_CREATED"
			readonly="false" />

		<ps:hidden id="modifiedBy_${_pageRef}"
			name="packageEventCO.alrtPkgVO.MODIFIED_BY"
			readonly="false" maxlength="35" />

		<ps:hidden id="dateModified_${_pageRef}"
			name="packageEventCO.alrtPkgVO.DATE_MODIFIED"
			readonly="false" />

		<ps:hidden id="deletedBy_${_pageRef}"
			name="packageEventCO.alrtPkgVO.DELETED_BY"
			readonly="false" maxlength="35" />

		<ps:hidden id="dateDeleted_${_pageRef}"
			name="packageEventCO.alrtPkgVO.DATE_DELETED"
			readonly="false" buttonImageOnly="true" />
	</fieldset>

	<pt:toolBar id="eventPackageToolBar_${_pageRef}" hideInAlert="true">

		<psj:submit button="true" buttonIcon="ui-icon-disk"
			id="pkgEvtSave_${_pageRef}">
			<ps:label key="btn.save" for="pkgEvtSave_${_pageRef}" tabindex="9"/>
		</psj:submit>
		<psj:submit button="true" type="button"
			onclick="packageEventMaint_conformApprove()" id="pkgEvtApp_${_pageRef}">
			<ps:label key="Approve" for="pkgEvtApp_${_pageRef}" tabindex="10"/>
		</psj:submit>
		<psj:submit button="true" type="button" buttonIcon="ui-icon-trash"
			onclick="packageEventMaint_conform()" id="pkgEvtDel_${_pageRef}">
			<ps:label key="btn.del" for="pkgEvtDel_${_pageRef}" tabindex="11"/>
		</psj:submit>

	</pt:toolBar>
</ps:form>

<script type="text/javascript">
	$.struts2_jquery.require("PackageEventMaint.js", null, jQuery.contextPath
			+ "/path/js/alert/events/eventpackage/");
	$("#packageEventMainFormId_" + _pageRef).processAfterValid(
			"packageEventMaint_save", {});
	
	if(_pageRef !="PKG00P" && !(_pageRef=='PKG00MT' && $("#status_"+_pageRef).val()=='Approved')){
		
		$("#evtNotInPkg_${_pageRef}").droppable({
			    tolerance: "pointer"
			  });
		
		$("#evtInPkg_${_pageRef}").droppable({
		    tolerance: "pointer"
		  });
		
		jQuery("#evtInPkg_${_pageRef}").jqGrid("gridDnD",{
			connectWith:'#evtNotInPkg_${_pageRef}',
			droppos:"last",
			ondrop: function (ev, ui, getdata) {
		    	$("#cb_evtNotInPkg_${_pageRef}").prop('checked', false);
		    	$("#cb_evtInPkg_${_pageRef}").prop('checked', false);
		    	}
		});
		
	    jQuery("#evtNotInPkg_${_pageRef}").jqGrid("gridDnD",{
		    connectWith:'#evtInPkg_${_pageRef}',
		    droppos:"last",
		    ondrop: function (ev, ui, getdata) {
		    	$("#cb_evtNotInPkg_${_pageRef}").prop('checked', false);
		    	$("#cb_evtInPkg_${_pageRef}").prop('checked', false);
		    	}
	    });
	    }
</script>
