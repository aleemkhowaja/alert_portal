<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt"  uri="/path-toolbar-tags" %>

<ps:set name="msg_file_type_not_allowed_key"
	value="%{getEscText('msg_file_type_not_allowed_key')}" />
<ps:set name="Please_choose_file_key"
	value="%{getEscText('Please_choose_file_key')}" />
	
<ps:set name="ivcrud_${_pageRef}" value="iv_crud" />
<ps:set name="emailTemplateStatus_${_pageRef}" value="emailtemplateCO.emailTemplateVO.STATUS" />

<script type="text/javascript">
	var msg_file_type_not_allowed_key = "${msg_file_type_not_allowed_key}";
	var Please_choose_file_key = "${Please_choose_file_key}";
	$(document).ready(
		function() 
		{
			$.struts2_jquery.require("EmailTemplateMaint.js", null,jQuery.contextPath + "/path/js/alert/emailtemplate/");
			$("#emailTemplateMaintFormId_" + _pageRef).processAfterValid("emailTemplateMaint_processSubmit", {});
		});
</script>

<ps:form useHiddenProps="true" id="emailTemplateMaintFormId_${_pageRef}"  namespace="/path/emailTemplate">
	<ps:hidden id="emailTemplateStatus_${_pageRef}" name="emailtemplateCO.emailTemplateVO.STATUS" />
	<ps:hidden id="DATE_UPDATED_${_pageRef}" name="emailtemplateCO.emailTemplateVO.DATE_UPDATED" />
	<ps:set name="ivcrud_${_pageRef}" value="iv_crud" />
	<table width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<td width="10%"></td>
			<td width="5%"></td>
			<td width="5%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
		</tr>
		<tr>
			<td colspan="2">
				<ps:label value="%{getText('TEMPLATE_ID_key')}" for="emailTempId_${_pageRef}"/>
			</td>
			<td colspan="1">
				<ps:textfield name="emailtemplateCO.emailTemplateVO.TEMPLATE_ID"
				id="emailTempId_${_pageRef}" readonly="true">
				</ps:textfield>
			</td>
			<td colspan="5"></td>
			<td colspan="1">
				<ps:textfield name="emailtemplateCO.statusDesc"
				id="statusDesc_${_pageRef}" readonly="true"
				cssStyle="text-align:center">
				</ps:textfield>
			</td>
			<td colspan="1"><psj:a button="true" href="#"
					buttonIcon="ui-icon-triangle-2-s"
					onclick="emailtemplate_onStatusClicked()">
					<ps:text name='status_key' />
				</psj:a>
			</td>
		</tr>
		<tr>
			<td colspan="2"><ps:label value="%{getText('Description_key')}" for="queryLkpName_${_pageRef}"/></td>
			<td colspan="2">
				<ps:textfield name="emailtemplateCO.emailTemplateVO.TEMPLATE_DESC"
				id="queryLkpName_${_pageRef}"
				maxlength="50"
				size="55">
				</ps:textfield>
			</td>
		</tr>
	</table>
	<table width="100%" cellpadding="0" cellspacing="0">	
		<tr>
			<td width="10%"></td>
			<td width="5%"></td>
			<td width="5%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
		</tr>
		<tr>
			<td colspan="2"><ps:label value="%{getText('FILE_NAME_key')}" for="fileName_${_pageRef}"/></td>
			<td colspan="1">
				<ps:textfield name="emailtemplateCO.emailTemplateVO.TEMPLATE_FILE_NAME"
				id="fileName_${_pageRef}"
				maxlength="100"
				size="15"
				readonly="true">
				</ps:textfield>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<ps:label id="uploadFile_${_pageRef}" key="upload_file_key"
					for="uploadTemplateFile_${_pageRef}">
				</ps:label>
			</td>
			<td>  
	       		<ps:file name="uploadTemplateFile" id="uploadTemplateFile_${_pageRef}" size="60" tabindex="3" onchange="emailTemplateMaint_uploadTemplateFile();"/>
	       	</td>
		</tr>
	</table>
	<ptt:toolBar id="emailTemplateMaintToolBar_${_pageRef}"	hideInAlert="true">
		<ps:if test='%{#ivcrud_${_pageRef}=="R"}'>
			<ps:if test='%{#emailTemplateStatus_${_pageRef}==null || #emailTemplateStatus_${_pageRef}=="N"}'>
				<psj:submit id="emailTemplateMaint_save_${_pageRef}" button="true"
					freezeOnSubmit="true">
					<ps:label key="Save_key" for="emailTemplateMaint_save_${_pageRef}" />
				</psj:submit>
			</ps:if>
			<ps:if test='%{#emailTemplateStatus_${_pageRef}=="N"}'>
				<psj:submit id="emailTemplateMaint_delete_${_pageRef}" button="true"
					type="button" freezeOnSubmit="true"
					onclick="emailTemplateMaint_onDelClicked()">
					<ps:label key="Delete_key"
						for="emailTemplateMaint_delete_${_pageRef}" />
				</psj:submit>
			</ps:if>
		</ps:if>
		<ps:if test='%{#ivcrud_${_pageRef}=="P"}'>
			<psj:submit id="emailTemplateMaint_approve_${_pageRef}" button="true"
				freezeOnSubmit="true" onclick="emailTemplateMaint_onApproveClicked()">
				<ps:label key="approve_key"
					for="emailTemplateMaint_approve_${_pageRef}" />
			</psj:submit>
		</ps:if>
		<ps:if test='%{#ivcrud_${_pageRef}=="UP"}'>
			<psj:submit id="emailTemplateMaint_UpdateAfterApprove_${_pageRef}"
				button="true" freezeOnSubmit="true">
				<ps:label key="Update_After_Approve_key"
					for="emailTemplateMaint_UpdateAfterApprove_${_pageRef}" />
			</psj:submit>
		</ps:if>
	</ptt:toolBar>
</ps:form>
