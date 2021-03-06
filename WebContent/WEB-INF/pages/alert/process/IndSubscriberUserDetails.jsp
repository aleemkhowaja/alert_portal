<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@taglib prefix="pt" uri="/path-toolbar-tags"%>

<fieldset class="ui-widget-content ui-corner-all" title="user_details_key" >
  <legend ><ps:text name="user_details_key"/> </legend>
<ps:form id="IndSubscribtionUserDet_${_pageRef}" >

<table id="indSubUserDetailsTab_<ps:property value="_pageRef" escapeHtml="true"/>"  width="60%" border="0"
	cellspacing="0" class="headerPortionContent ui-widget-content">


	<tr>
		<td class="fldLabelView" colspan="2"> 
			<ps:label key="First_Name_key" id="lbl_firstNameEng_${_pageRef}"
				for="firstNameEng_${_pageRef}" />
		</td>
		<td width="40%" class="fldDataEdit">
			<ps:textfield id="firstNameEng_${_pageRef}" tabindex="4"
				name="individualSubscriberCO.usrVO.FIRST_NAME" mode="text"
				size="50" maxlength="8" />

		</td>
	</tr>

	<tr>
		<td class="fldLabelView" colspan="2">
			<ps:label key="middle_name_key" id="lbl_middleName_${_pageRef}"
				for="middleName_${_pageRef}" />
		</td>
		<td width="60%" class="fldDataEdit left" colspan="2">
			<ps:textfield id="middleName_${_pageRef}" tabindex="5"
				name="individualSubscriberCO.usrVO.MIDDLE_NAME" mode="text"
				size="50" maxlength="8" />
		</td>
	</tr>
	<tr>
		<td class="fldLabelView" colspan="2">
			<ps:label key="Last_Name_key" id="lbl_lastName_${_pageRef}"
				for="lastName_${_pageRef}" />
		</td>
		<td width="60%" class="fldDataEdit left" colspan="2">
			<ps:textfield id="lastName_${_pageRef}" tabindex="5"
				name="individualSubscriberCO.usrVO.LAST_NAME" mode="text"
				size="50" maxlength="8" />
		</td>
	</tr>
	<tr>
		<td class="fldLabelView" colspan="2">
			<ps:label key="home_phone_key" id="lbl_homePhone_${_pageRef}"
				for="homePhone_${_pageRef}" />
		</td>
		<td width="60%" class="fldDataEdit left" colspan="2">
			<ps:textfield id="homePhone_${_pageRef}" tabindex="5"
				name="individualSubscriberCO.usrVO.HOME_PHONE" mode="text"
				size="50" maxlength="20" />
		</td>
	</tr>
	<tr></tr>
	<tr>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td width="60%" class="fldDataEdit right">
			<ps:textfield id="firstNameArab_${_pageRef}" tabindex="6"
				name="individualSubscriberCO.usrVO.FIRST_NAME_ARABIC" mode="text"
				size="50" maxlength="8" cssStyle="direction:rtl"/>
		</td>

		<td class="fldLabelView " colspan="4">
			<ps:label key="first_Name_Arab_key"
				id="lbl_firstNameArab_${_pageRef}"
				for="firstNameArab_${_pageRef}" />
		</td>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		
		<td width="60%" class="fldDataEdit right">
			<ps:textfield id="middleNameArab_${_pageRef}" tabindex="6"
				name="individualSubscriberCO.usrVO.MIDDLE_NAME_ARABIC" mode="text"
				size="50" maxlength="8" cssStyle="direction:rtl"/>
		</td>

		<td class="fldLabelView " colspan="4">
			<ps:label key="middle_Name_Arab_key"
				id="lbl_middleNameArab_${_pageRef}"
				for="middleNameArab_${_pageRef}" />
		</td>
	</tr>
    <tr>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		
		<td width="60%" class="fldDataEdit right">
			<ps:textfield id="lastNameArab_${_pageRef}" tabindex="6"
				name="individualSubscriberCO.usrVO.LAST_NAME_ARABIC" mode="text"
				size="50" maxlength="8" cssStyle="direction:rtl"/>
		</td>

		<td class="fldLabelView " colspan="4">
			<ps:label key="last_name_arab_key"
				id="lbl_lastNameArab_${_pageRef}"
				for="lastNameArab_${_pageRef}" />
		</td>
	</tr>
</table>
	

<table  border="0" width="60%" cellspacing="0" class="headerPortionContent ui-widget-content">
 <tr>
		<td width="5%"></td>
		<td width="5%"></td>
		<td width="5%"></td>
		<td width="5%"></td>
		<td width="5%"></td>
		<td width="5%"></td>
		<td width="5%"></td>
		<td width="5%"></td>
		<td width="5%"></td>
		<td width="5%"></td>
		<td width="5%"></td>
		<td width="5%"></td>
		<td width="5%"></td>
		<td width="5%"></td>
		<td width="5%"></td>
		<td width="5%"></td>
		<td width="5%"></td>
		<td width="5%"></td>
		<td width="5%"></td>
		<td width="5%"></td>
		
</tr>	
<tr></tr>
<tr>

<td colspan="2" class="fldLabelView">
	<ps:label key="Email_key"
	for="email_${_pageRef}"
	id="lbl_email_${_pageRef}" />
</td>
<td class="fldDataEdit" colspan="8">
	<div style="margin-bottom: 3px">
	<ps:textfield id="email_${_pageRef}" maxlength="40" tabindex="24" mode="text"
		name="individualSubscriberCO.usrVO.EMAIL_ID" />
</td>
<td colspan="3"><td/>

<td colspan="2" class="fldLabelView">
	<ps:label key="nbr_free_msgs_key"
	for="nbFreeMsgs_${_pageRef}"
	id="lbl_nbFreeMsgs_${_pageRef}" />
</td>
<td class="fldDataEdit" colspan="3">
	<div style="margin-bottom: 3px">
	<ps:textfield id="nbFreeMsgs_${_pageRef}" maxlength="8" tabindex="24" mode="number"
		name="individualSubscriberCO.alrtSubVO.NB_MSG" />
</td>


</tr>

<tr>

<td colspan="2" class="fldLabelView">
	<ps:label key="mobile_no_key"
	for="mobile_${_pageRef}"
	id="lbl_mobile_${_pageRef}" />
</td>
<td class="fldDataEdit" colspan="8">
	<div style="margin-bottom: 3px">
	<ps:textfield id="mobile_${_pageRef}" maxlength="255" tabindex="24" mode="text"
		name="individualSubscriberCO.usrVO.MOBILE_PHONE" />
</td>
<td colspan="3"><td/>


<td colspan="7">
	<div class="left">
	  <ps:checkbox id="chargeable_box_${_pageRef}"
		key="chargeable_key"
		name="individualSubscriberCO.alrtSubVO.CHARGEABLE" tabindex="1"
		valOpt="1:0"
		cssClass="ui-widget-content checkboxheight" 
		dependencySrc="${pageContext.request.contextPath}/path/alert/controlrecord/ControlRecordDepAction_dependencyByBoxes"
	    parameter="individualSubscriberCO.alrtSubVO.CHARGEABLE:chargeable_box_${_pageRef}"
		dependency=""
		
	/>
      </div>
</td>

</tr>
<tr>
	<td class="fldLabelView" colspan="2">
		<ps:label key="language_key" id="lbl_language_${_pageRef}"
			for="language_${_pageRef}" />
	</td>
	<%-- <td class="fldDataEdit" colspan="3">
	<div style="margin-bottom: 3px">
	<ps:textfield id="language_${_pageRef}" maxlength="8" tabindex="24" mode="text"
		name="individualSubscriberCO.alrtSubVO.LANG" />
	</td> --%>
	 <td colspan="3" class="fldDataEdit center">
		<ps:select id="language_${_pageRef}"
			name="individualSubscriberCO.alrtSubVO.LANG" list="languageDropDown"
			listKey="code" listValue="descValue" emptyOption="false"
			disabled="false" 
			parameter="individualSubscriberCO.alrtSubVO.LANG:language_${_pageRef}, pageRef:pageRef_${_pageRef}"
			dependencySrc=""
			dependency="language_${_pageRef}:individualSubscriberCO.alrtSubVO.LANG" 
			/>
	</td> 
	
	<td colspan="8"><td/>
	
	<td colspan="7">
		<div class="left">
		  <ps:checkbox id="suspend_all_subscriptions_${_pageRef}"
			key="suspend_all_subscription_key"
			name="individualSubscriberCO.alrtSubVO.SUSPEND_ALL_SUBSCRIPTIONS" tabindex="1"
			valOpt="1:0"
			cssClass="ui-widget-content checkboxheight" 
			dependencySrc="${pageContext.request.contextPath}/path/alert/controlrecord/ControlRecordDepAction_dependencyByBoxes"
		    parameter="individualSubscriberCO.alrtSubVO.SUSPEND_ALL_SUBSCRIPTIONS:suspend_all_subscriptions_${_pageRef}"
			dependency=""
			
		/>
	      </div>
	</td>


</tr>

</table>


</ps:form>
</fieldset>