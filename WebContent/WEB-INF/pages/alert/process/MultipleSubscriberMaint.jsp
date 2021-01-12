<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@include file="/WEB-INF/pages/alert/common/AlertAppTrans.jsp"%>
<%@taglib prefix="ptt" uri="/path-toolbar-tags"%>
<jsp:include page="/WEB-INF/pages/common/login/InfoBar.jsp" />

<script type="text/javascript">
	$.struts2_jquery.require("MultipleSubscriberMaint.js", null, 
			jQuery.contextPath + "/path/js/alert/subscriber/multiple/");
	$.struts2_jquery.require("common.js", null, 
			jQuery.contextPath + "/path/js/alert/common/");
	$("#multipleSubscriberMainFormId_"+_pageRef).processAfterValid("multipleSubscriberMaint_save",{});
</script>
	
<ps:form useHiddenProps="true" id="multipleSubscriberMainFormId_${_pageRef}" namespace="/path/alert/subscriber/multiple">

	<ps:hidden id="iv_crud_${_pageRef}" name="iv_crud" />
	<ps:set name="ivcrud_${_pageRef}"    value="iv_crud"/>
	<ps:hidden id="multpleSubscribersJson_${_pageRef}" name="multipleSubscriberCO.multpleSubscribersJson" />
	<ps:hidden id="multpleSubscribersidsJson_${_pageRef}" name="multipleSubscriberCO.subscriberIds" />
	<ps:hidden id="selectedRow_${_pageRef}" name="selectedRow" />
	<ps:hidden id="enable_omni" name="enable_omni" />
	<ps:hidden id="selectedSubscriberIds_${_pageRef}" name="selectedSubscriberIds" />
	<ps:hidden id="selectedSubscriberIdsArray_${_pageRef}" name="selectedSubscriberIdsArray" />
	<ps:hidden id="allrows_${_pageRef}" name="multipleSubscriberCO.allrows" />
	<ps:hidden id="excludeIdsFromAllSelectedRows_${_pageRef}" name="multipleSubscriberCO.excludeIdsFromAllSelectedRows" />
	<ps:hidden id="isPagingReload_${_pageRef}" name="multipleSubscriberCO.isPageReload" />
	<ps:hidden id="handleDuplicate_${_pageRef}" name="handleDuplicate" value="1" />
	<ps:hidden id="isSelectRecordOnPaginition_${_pageRef}" name="isSelectRecordOnPaginition" value="false" />
	
	<ps:if test='iv_crud == "P"'>
		<div id="approveMultipleSubscriber_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px;">
			<div id="approveMultpleSubscriberInner_form_${_pageRef}" class="collapsibleContainer" title="<ps:text name='multiple_subscriber_key'/>" >
				<%@include file="/WEB-INF/pages/alert/process/UpdateMultipleSubscriberMaint.jsp"%>	
			</div>
		</div>
	</ps:if>
	
	<ps:if test='iv_crud == "R"'>
		<div id="createMultipleSubscriber_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px;">
			<div id="createMultpleSubscriberInner_form_${_pageRef}" class="collapsibleContainer" title="<ps:text name='create_multiple_subscriber_key'/>" >
				<%@include file="/WEB-INF/pages/alert/process/CreateMultipleSubscriberMaint.jsp"%>	
			</div>
		</div>
	</ps:if>


	<ptt:toolBar id="multipleSubscriberToolBar_${_pageRef}" hideInAlert="true"	>
		<table>
			<tr>
			    
				<ps:if test='%{#ivcrud_${_pageRef} == "R"}'>
					<td>
						<psj:submit id="multipleSubscriberUpdateBtn_${_pageRef}"
							button="true" buttonIcon="ui-icon-disk" tabindex="18" freezeOnSubmit="true">
							<ps:label for="multipleSubscriberUpdateBtn_${_pageRef}" key="Save_key" />
						</psj:submit>
					</td>
				</ps:if>
				<ps:if test='%{#ivcrud_${_pageRef}=="P"}'>
					<td>
						<psj:submit button="true" freezeOnSubmit="true"
							onclick="multipleSubscriberMaint_processApprove()" tabindex="24"
							id="multipleSubscriber_approve_btn_${_pageRef}" buttonIcon="ui-icon-disk"
							>
							<ps:label key="Approve_key" for="multipleSubscriber_approve_btn_${_pageRef}" />
						</psj:submit>
					</td>
				</ps:if>
			</tr>
		</table>
	</ptt:toolBar>
</ps:form>

<script>
	$("#multipleSubscriberMainFormId_"+_pageRef+" .collapsibleContainer").collapsiblePanel();
</script>
