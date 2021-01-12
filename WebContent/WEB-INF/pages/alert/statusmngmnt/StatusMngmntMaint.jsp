<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt" uri="/path-toolbar-tags"%>
<jsp:include page="/WEB-INF/pages/common/login/InfoBar.jsp" />

<ps:form useHiddenProps="true" id="statusMngmntMaintFormId_${_pageRef}"
	namespace="/path/statusMngmnt">

	<ps:hidden name="stmgmtco.statusGridListString"
		id="updateMode_hdn_statusGrid_Id_${_pageRef}" />
	<ps:hidden name="stmgmtco.groupEventListString"
		id="updateMode_hdn_GrpEvtGrid_Id_${_pageRef}" />
	<ps:hidden name="stmgmtco.groupPkgListString"
		id="updateMode_hdn_groupPkgGrid_Id_${_pageRef}" />
	<ps:hidden name="stmgmtco.subPkgListString"
		id="updateMode_hdn_subPkgGrid_Id_${_pageRef}" />
	<ps:hidden name="stmgmtco.subevtListString"
		id="updateMode_hdn_subevtGrid_Id_${_pageRef}" />

	<ps:set name="ivcrud_${_pageRef}" value="iv_crud" />
	<ps:hidden id="status_${_pageRef}" name="stmgmtco.status"></ps:hidden>
	<br>
	<br>
	<table width="100%" cellpadding="0" cellspacing="0">
		<tr>



			<td width="2%"></td>
			<td width="8%"><psj:submit id="Suspend_${_pageRef}"
					button="true" onclick="statusMaint_processSuspend()"
					freezeOnSubmit="true" type="button">
					<ps:text name="Suspend_key"></ps:text>
				</psj:submit></td>

			<td width="8%"><psj:submit id="Reactivate_${_pageRef}"
					button="true" onclick="statusMaint_processApprove()"
					freezeOnSubmit="true" type="button">
					<ps:text name="Reactivate_key"></ps:text>
				</psj:submit></td>

			<td width="5%"><br> <br></td>
			<td width="5%"></td>
			<td width="10%"></td>
			<td width="10%"></td>

			<td width="60%"></td>
		</tr>

	</table>
	<br>


	<div id="trackTabcontent_${_pageRef}">

		

	</div>


</ps:form>



<script type="text/javascript">
 	 $(document).ready(
			function() {

				$.struts2_jquery.require("StatusMngmntMaint.js", null, jQuery.contextPath
						+ "/path/js/alert/statusmngmnt/");
				
				$("#statusMngmntMaintFormId_" + _pageRef).processAfterValid(
						"statusMaint_processFilter", {});
				document.getElementById("infoBarSearchButton_" + _pageRef).style.display = "none";
				
				statusMaint_processFilter();
			});  

</script>