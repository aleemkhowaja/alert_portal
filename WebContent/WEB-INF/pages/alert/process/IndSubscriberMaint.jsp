<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt"  uri="/path-toolbar-tags" %>
<ps:set name="confirm_change_user_details_key" value="%{getEscText('confirm_change_user_details_key')}" />


<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/path/css/alert/subscriber/indSub.css" />

<script type="text/javascript">
var confirm_change_user_details_key   = "${confirm_change_user_details_key}";

	$(document).ready(function() {
		$.struts2_jquery.require("IndividualSubscriberMaint.js", null, jQuery.contextPath+ "/path/js/alert/subscriber/individual/");
		$.struts2_jquery.require("common.js", null, jQuery.contextPath + "/path/js/alert/common/");
		$("#individualSubscriberMainFormId_"+_pageRef).processAfterValid("individualSubscriberMaint_save",{});
	});
	
</script>

<style>
	.disable-link
	{
	    text-decoration: none !important;
	    color: black !important;
	    cursor: default;
	    pointer-events: none;
	}
	
	 #mainTabs{
	 	overflow-x: hidden;
	 }
</style>

<ps:form id="individualSubscriberMainFormId_${_pageRef}" target="_blank"  useHiddenProps="true" applyChangeTrack="true" >
	<!-- Hidden Fields -->
	<ps:hidden name="individualSubscriberCO.jsonOtherLangArray" id="otherLanguagesJson_${_pageRef}"/>
    <ps:hidden name="individualSubscriberCO.jsonOtherLangBodyArray" id="otherLanguagesBodySavedJson_${_pageRef}"/>
    <ps:hidden name="individualSubscriberCO.jsonOtherLangSavedArray" id="otherLanguagesSavedJson_${_pageRef}"/>
    <ps:hidden name="individualSubscriberCO.alrtSubVO.ID" id="individualSubscriberId_${_pageRef}"/>
    <ps:set name="individualSubscriberId_${_pageRef}" value="individualSubscriberCO.alrtSubVO.ID" />
    <ps:set name="individualSubStatus_${_pageRef}" value="individualSubscriberCO.alrtSubVO.STATUS" />
    <ps:set name="ivcrud_${_pageRef}"    value="iv_crud"/>
	<ps:hidden id="iv_crud_${_pageRef}"  name="iv_crud"/>
	<ps:hidden id="emailFieldsCount_${_pageRef}" name="individualSubscriberCO.emailsCount"  />
	<ps:hidden id="mobileNoFieldsCount_${_pageRef}" name="individualSubscriberCO.mobileNosCount"  />
	<ps:hidden id="mobileNos_${_pageRef}" name="individualSubscriberCO.alrtSubVO.MOBILE_PHONE"/>
	<ps:hidden id="emailIds_${_pageRef}" name="individualSubscriberCO.alrtSubVO.EMAIL_ID"  />
	<ps:hidden id="individualSubStatus_${_pageRef}" name="individualSubscriberCO.alrtSubVO.STATUS"  />
	<ps:set name="cifNo_${_pageRef}"    value="individualSubscriberCO.alrtSubVO.CIF_NO"/>
	<%-- <ps:hidden id="cifNoForExcludeAccounts_${_pageRef}" name="individualSubscriberCO.alrtSubVO.CIF_NO"  /> --%>
	<ps:hidden id="subscriberEventsGridData_${_pageRef}" name="subscriberEventsGridData"  />
	<ps:hidden id="subscriberPackagesGridData_${_pageRef}" name="subscriberPackagesGridData"  />
	<ps:hidden id="alrtSubVO_CREATED_BY_${_pageRef}" name="individualSubscriberCO.alrtSubVO.CREATED_BY"  />
	<ps:hidden id="alrtSubVO_MODIFIED_BY_${_pageRef}" name="individualSubscriberCO.alrtSubVO.MODIFIED_BY"  />
	<ps:hidden id="alrtSubVO_DATE_UPDATED_${_pageRef}" name="individualSubscriberCO.alrtSubVO.DATE_UPDATED"  />
	
	
	
	
	<table id="indSubCifDetailsTab_<ps:property value="_pageRef" escapeHtml="true"/>"  border="0" cellpadding="2" cellspacing="1" >
		<tr>
			<td colspan="1" class="fldLabelView">
				<ps:label key="ID_key" id="lbl_subscriberId_${_pageRef}"
					for="subscriberId_${_pageRef}" />
			</td>
			<td colspan="2"  class="fldDataEdit right">
				<ps:textfield id="subscriberId_${_pageRef}"
					name="individualSubscriberCO.alrtSubVO.ID" 
					mode="number" required=""  readonly="true"
				    tabindex="-1" maxlength="16"  />
			</td>
			<td colspan = "5"  style="width: 284px;"></td>
			<td class="fldLabelView">
				<ps:label key="Status_key" id="lbl_status_${_pageRef}"
					for="status${_pageRef}" />
			</td>
			<td class="fldDataEdit left">
				<ps:textfield id="status${_pageRef}"
					name="individualSubscriberCO.statusDesc" mode="text"  maxlength="100"
					tabindex="-1" readonly="true" />
			</td>
			<td colspan="2" align="right">
				<psj:a button="true" buttonIcon="ui-icon-triangle-2-s"
					onclick="individualSubscriberMaint_onStatusClick()">
					<ps:text name='Status_key' />
				</psj:a>
			</td>
		</tr>
		<tr> </tr> <tr> </tr>
	</table>
	<br />
	
	<div id="main_information_form_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px;">
		<div id="main_informationInner_form_${_pageRef}" class="collapsibleContainer" title="<ps:text name='Main_information_key'/>" >
			<table id="mainInformationIndSubTab_<ps:property value="_pageRef" escapeHtml="true"/>"  border="0" cellpadding="2" cellspacing="1">	
			 <tr>
					<td> 
						<ps:label key="brief_name_key" id="lbl_briefNameEng_${_pageRef}" for="briefNameEng_${_pageRef}" />
					</td>
					<td colspan="3">
						<ps:textfield id="briefNameEng_${_pageRef}" tabindex="1"
							name="individualSubscriberCO.alrtSubVO.DEFAULT_BRIEF_NAME" mode="text" required="true"
							size="70" maxlength="100" />
					</td>
					<td>
						<psj:a id="indEventMaint_otherLang_${_pageRef}" 
							button="true"
							onclick="individualSubscriberMaint_openOtherLanguageDialogue()">
							<ps:text name='main_info_other_languages_key' />
						</psj:a>
					</td>
				</tr>
				<tr> </tr>
				<tr>
					<td >
						<ps:label key="Middle_Name_eng_key" id="lbl_middleNameEng_${_pageRef}"
							for="middleNameEng_${_pageRef}" />
					</td>
					<td colspan="3">
						<ps:textfield id="middleNameEng_${_pageRef}" tabindex="2"
							name="individualSubscriberCO.alrtSubVO.DEFAULT_MIDDLE_NAME" mode="text"
							size="70" maxlength="100" />
					</td>
				</tr>
				<tr> </tr>
				<tr>
					<td  >
						<ps:label key="long_name_key" id="lbl_longNameEng_${_pageRef}"
							for="longNameEng_${_pageRef}" />
					</td>
					<td colspan="3">
						<ps:textfield id="longNameEng_${_pageRef}" tabindex="3"
							name="individualSubscriberCO.alrtSubVO.DEFAULT_LONG_NAME" mode="text" required="true"
							size="70" maxlength="100" />
					</td>
				</tr>
				<tr> </tr>
				<tr>
				    <td >
						<ps:label key="address_key" id="lbl_address_${_pageRef}"
							for="address_${_pageRef}" />
					</td>
					<td colspan="3">
						<ps:textarea id="address_${_pageRef}" tabindex="4"
							name="individualSubscriberCO.alrtSubVO.DEFAULT_ADDRESS" mode="text"
							size="70" maxlength="150" rows="5" cols="70" cssStyle="overflow: auto;" />
					</td>
				</tr>
				<tr>
					<td >
						<ps:label key="preferred_language_key" id="lbl_language_${_pageRef}" for="language_${_pageRef}" />
					</td>
					<td colspan="3">
						<ps:select id="language_${_pageRef}"
							name="individualSubscriberCO.alrtSubVO.LANG" list="languageDropDown"
							listKey="code" listValue="descValue" emptyOption="false"
							disabled="false" 
							parameter="individualSubscriberCO.alrtSubVO.LANG:language_${_pageRef}, pageRef:pageRef_${_pageRef}"
							dependencySrc=""
							dependency="language_${_pageRef}:individualSubscriberCO.alrtSubVO.LANG" tabindex="16" cssStyle="width: 90px;" />
					</td>
				</tr>
				<%--<tr>
				<td> </td>
					<td align="left">
						   <ps:checkbox id="chargeable_box_${_pageRef}" key="chargeable_key" name="individualSubscriberCO.alrtSubVO.CHARGEABLE"  tabindex="17"
						   		valOpt="1:0" cssClass="ui-widget-content checkboxheight" onchange="individualSubscriberMaint_isChargeable();" />
					</td>
					<td > 
						<ps:label key="nbr_free_msgs_key" for="nbFreeMsgs_${_pageRef}" id="lbl_nbFreeMsgs_${_pageRef}" />
					</td>
					<td >
						<ps:textfield id="nbFreeMsgs_${_pageRef}" maxlength="9" minValue="0" tabindex="15" mode="number" name="individualSubscriberCO.alrtSubVO.NB_MSG"  />
					</td>
				</tr>--%>
			</table>
		</div>
	</div>
		
	<div id="subscriber_details_form_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px;">
		<div id="subscriber_detailsInner_form_${_pageRef}" class="collapsibleContainer" title="<ps:text name='subscriber_details_key'/>" >
			<table id="subDetailsIndSubTab_<ps:property value="_pageRef" escapeHtml="true"/>"  border="0" cellpadding="2" cellspacing="1">
				<tr>
					<td >
						<ps:label key="cif_number_key" id="lbl_cifNumber_${_pageRef}" for="lookuptxt_cifNumber_${_pageRef}" />
					</td>
					<td>
						<psj:livesearch
							name="individualSubscriberCO.alrtSubVO.CIF_NO"
							id="cifNumber_${_pageRef}" mode="number" leadZeros="8"
							tabindex="6" minValue="0" 
							resultList="cifVO.CIF_NO:lookuptxt_cifNumber_${_pageRef},cifType:cifType_${_pageRef},cifVO.CIF_NO:cifNumberHidden_${_pageRef}"
							actionName="${pageContext.request.contextPath}/path/alert/subscriber/individual/IndividualSubscriberCIFLookupAction_constructCifQueryLookup"
							dependencySrc="${pageContext.request.contextPath}/path/alert/subscriber/individual/IndividualSubscriberDepAction_dependencyByCifNumber"
							dependency="lookuptxt_cifNumber_${_pageRef}:individualSubscriberCO.alrtSubVO.CIF_NO,
								lookuptxt_userId_${_pageRef}:individualSubscriberCO.alrtSubVO.USR_ID,
								usrName_${_pageRef}:individualSubscriberCO.usrVO.FIRST_NAME,
								subscriberEmail_${_pageRef}:individualSubscriberCO.emailId,
								tell_${_pageRef}:individualSubscriberCO.tel"
							parameter="cif:lookuptxt_cifNumber_${_pageRef},individualSubscriberCO.alrtSubVO.CIF_NO:lookuptxt_cifNumber_${_pageRef}"
							searchElement="cifVO.CIF_NO" maxlength="8"
							afterDepEvent="notifyUserChanges()"
							dontLoadData="true"
							>
						</psj:livesearch>
					</td>
					<td>
						<ps:textfield id="cifType_${_pageRef}" name="individualSubscriberCO.cifType" readonly="true" maxlength="50" mode="text" style="width: 242px;"> </ps:textfield>
						<ps:hidden id="cifNumberHidden_${_pageRef}" name="individualSubscriberCO.cifCode"></ps:hidden>
					</td>
				</tr>
				<tr>
					<td>
						<ps:label key="imal_user_key" id="lbl_imalUser_${_pageRef}"
							for="lookuptxt_userId_${_pageRef}" />
					</td>
					<td>
						<psj:livesearch
							name="individualSubscriberCO.alrtSubVO.USR_ID"
							id="userId_${_pageRef}" mode="text"
							tabindex="8"  maxlength="30"
							actionName="${pageContext.request.contextPath}/path/alert/subscriber/individual/IndSubUsrLookupAction_constructLookup"
							searchElement="USER_ID"
							resultList="usrVO.USER_ID:lookuptxt_userId_${_pageRef}"
							dependencySrc="${pageContext.request.contextPath}/path/alert/subscriber/individual/IndividualSubscriberDepAction_dependencyByUserID"
							dependency="lookuptxt_userId_${_pageRef}:individualSubscriberCO.alrtSubVO.USR_ID,
								lookuptxt_cifNumber_${_pageRef}:individualSubscriberCO.alrtSubVO.CIF_NO,
								cifType_${_pageRef}:individualSubscriberCO.cifType,
								cifNumberHidden_${_pageRef}:individualSubscriberCO.cifCode,
								subscriberEmail_${_pageRef}:individualSubscriberCO.emailId,
								tell_${_pageRef}:individualSubscriberCO.tel"
							parameter="userID:lookuptxt_userId_${_pageRef},individualSubscriberCO.alrtSubVO.USR_ID:lookuptxt_userId_${_pageRef}"
							afterDepEvent="notifyImalUserChanges">
						</psj:livesearch>
					</td>
					<td>
						<ps:textfield id="usrName_${_pageRef}" readonly="true" maxlength="50" mode="text" style="width: 242px;"> </ps:textfield>
					</td>
				</tr>
				<tr>
					<td>
						<ps:label key="channel_end_user_key" id="lbl_channelEndUser_${_pageRef}" for="lookuptxt_channelEndUser_${_pageRef}" />
					</td>        
					<td>
						<psj:livesearch
							name="individualSubscriberCO.alrtSubVO.CHANNEL_END_USR_ID"
							id="channelEndUser_${_pageRef}" leadZeros="8"
							tabindex="9" minValue="0" 
							resultList="omniUserVO.USR_ID:lookuptxt_channelEndUser_${_pageRef},omniUserVO.NAME:channelName_${_pageRef}"
							actionName="${pageContext.request.contextPath}/path/alert/subscriber/individual/ChannelEndUserLookupAction_constructOmniChannelUserLookup"
							searchElement="omniUserVO.USR_ID" maxlength="50" readOnlyMode="true">
						</psj:livesearch>
					</td>
					<td>
						<%-- <ps:textfield id="channelName_${_pageRef}" readonly="true" maxlength="50" mode="text" style="width: 242px;"> </ps:textfield> --%>
					</td>
				</tr>		
			</table>
		</div>
	</div>
	
	<div id="contact_details_form_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px;">
		<div id="contact_detailsInner_form_${_pageRef}" class="collapsibleContainer" title="<ps:text name='contact_details_key'/>" >
			<table id="subDetailsIndSubTab_<ps:property value="_pageRef" escapeHtml="true"/>"  border="0" cellpadding="2" cellspacing="1">
				<tr id="lastEmailRow_1${_pageRef}">
					<td>
						<ps:label key="email_address_key"
							for="subscriberEmail_${_pageRef}"
							id="lbl_email_${_pageRef}" />
					</td>
					<td colspan="3">
						<div style="margin-bottom: 3px">
							<ps:textfield id="subscriberEmail_${_pageRef}" maxlength="250" tabindex="11" mode="text" name="individualSubscriberCO.email" size="70" 
								cssClass="accountEmails" onblur="validateEmail(this)"  />
						</div>
					</td>
					<td>
						<psj:a id="addEmailButton_${_pageRef}" 
							button="true"
							onclick="individualSubscriberMaint_addEmailAndMobileDynamicField('email')">
							<ps:text name='+' />
						</psj:a>
					</td>
				</tr>
				<tr id="lastMobileRow_1${_pageRef}">
					<td>
						<ps:label key="Mobile_key" for="tell_${_pageRef}" id="lbl_tel_${_pageRef}" />
					</td>
					<td colspan="3">
						<ps:textfield id="tell_${_pageRef}" maxlength="23" tabindex="13" mode="text"  name="individualSubscriberCO.tel"  size="70" 
							cssClass="accountMobile" onblur="validateMobile(this)"  />
					</td>
					<td>
						<psj:a id="addMobileButton_${_pageRef}" 
							button="true"
							onclick="individualSubscriberMaint_addEmailAndMobileDynamicField('mobile')">
							<ps:text name='+' />
						</psj:a>
					</td>
				</tr>
				<%--
				<tr>
					<td>
						<%-- <ps:label key="facebook_socialId_key" for="FACEBOOK_SOCIAL_ID_${_pageRef}" id="lbl_facebook_${_pageRef}" />  --%><%--
					</td>
					<td>
						<div>
							<label class="switch">
								<ps:checkbox id="FACEBOOK_SOCIAL_ID_${_pageRef}"
								key="facebook_socialId_key"
								name="individualSubscriberCO.facebookSocialId" tabindex="12"
								valOpt="1:0"
								cssClass="ui-widget-content checkboxheight"  > </ps:checkbox>
								<span  class="subscribercontact slider round"></span>
							</label>
						</div>
					</td>
					<td style="width: 1px;">
						<%-- <ps:label key="twitter_socialId_key" for="TWITTER_SOCIAL_ID_${_pageRef}" id="lbl_twitter_${_pageRef}" />  --%><%--
					</td>
					<td>
						<div >
							<label class="switch">
								<ps:checkbox id="TWITTER_SOCIAL_ID_${_pageRef}"
									key="twitter_socialId_key"
									name="individualSubscriberCO.twitterSocialId" tabindex="14"
									valOpt="1:0"
									cssClass="checkboxheight" />
									<span  class="subscribercontact slider round"></span>
							</label>
						</div> 
					</td>
				</tr>--%>
			</table>
		</div>
	</div>

	 <ps:if test='%{#individualSubscriberId_${_pageRef} != null }'>
		<!-- Include Event Grid -->
		<div id="subscriber_events_form_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px;">
			<div id="subscriber_eventsInner_form_${_pageRef}" class="collapsibleContainer" title="<ps:text name='subscriber_events_key'/>" >
				<%@include file="subscription/SubscribersEventsList.jsp"%>
			</div>
		</div>
		
		<!-- Include Package Grid -->
<%-- 		<div id="subscriber_packages_form_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px;">
			<div id="subscriber_packagesInner_form_${_pageRef}" class="collapsibleContainer"  title="<ps:text name='subscriber_packages_key'/>">
					<%@include file="subscription/SubscribersPackageList.jsp"%>
			</div>
		</div> --%>
	</ps:if>
	
	
	<ptt:toolBar id="individualSubscriberToolBar_${_pageRef}">
		<table>
			<tr>
				<ps:if test='%{#ivcrud_${_pageRef} == "R"}'>
					<td>
						<ps:if test='%{#individualSubStatus_${_pageRef} == null || #individualSubStatus_${_pageRef}=="A"}'>
							<psj:submit id="IndividualSubscriberUpdateBtn_${_pageRef}"
								button="true" buttonIcon="ui-icon-disk" tabindex="18" freezeOnSubmit="true">
								<ps:label for="IndividualSubscriberUpdateBtn_${_pageRef}" key="Save_key" />
							</psj:submit>
						</ps:if>	
					</td>
					<td>
						<ps:if test='%{#individualSubStatus_${_pageRef}=="A"}'>
							<psj:submit id="IndividualSubscriberDeleteBtn_${_pageRef}"
								progRef="IND00D" button="true" type="button"
								buttonIcon="ui-icon-trash" tabindex="19"
								onclick="individualSubscriberMaint_processDelete()"
								freezeOnSubmit="true">
								<ps:label for="IndividualSubscriberDeleteBtn_${_pageRef}" key="Delete_key" />
							</psj:submit>
						</ps:if>
					</td>
				</ps:if>
				<ps:if test='%{#ivcrud_${_pageRef}=="P"}'>
					<td>
						<psj:submit button="true" freezeOnSubmit="true"
							onclick="individualSubscriberMaint_processApprove()" tabindex="20" type="button"
							id="subscriber_approve_btn_${_pageRef}">
							<ps:label key="Approve_key" for="subscriber_approve_btn_${_pageRef}" />
						</psj:submit>
					</td>
				</ps:if>
				<ps:if test='%{#ivcrud_${_pageRef}=="F"}'>
					<td>
						<psj:submit id="IndividualSubscriberUpdateBtn_${_pageRef}"
								button="true" buttonIcon="ui-icon-disk" tabindex="18" freezeOnSubmit="true">
								<ps:label for="IndividualSubscriberUpdateBtn_${_pageRef}" key="Update_key" />
							</psj:submit>
							
						<%-- <psj:submit id="IndividualSubscriberUpdateBtn_${_pageRef}"
							progRef="IND00U" button="true" type="button"
							buttonIcon="ui-icon-disk" tabindex="21"
							onclick="individualSubscriberMaint_save()"
							freezeOnSubmit="true">
							<ps:label for="IndividualSubscriberUpdateBtn_${_pageRef}" key="Update_key" />
						</psj:submit> --%>
					</td>
				</ps:if>
			</tr>
		</table>
	</ptt:toolBar>
</ps:form>

<script type="text/javascript">
	$(document).ready(function() 
	{  
		 $("#individualSubscriberMainFormId_"+_pageRef+" .collapsibleContainer").collapsiblePanel();
	});
</script>