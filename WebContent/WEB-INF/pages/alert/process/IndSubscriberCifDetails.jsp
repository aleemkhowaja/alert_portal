<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@taglib prefix="pt" uri="/path-toolbar-tags"%>

<fieldset class="ui-widget-content ui-corner-all" title="Main_Information_key" >
	<legend ><ps:text name="Main_Information_key"/> </legend>
		<ps:form id="IndSubscribtionCifDet_${_pageRef}" >

			<table id="indSubCifDetailsTab_<ps:property value="_pageRef" escapeHtml="true"/>"  width="75%" border="0"
				cellspacing="0" class="headerPortionContent ui-widget-content">
				
				<tr>
					<td colspan="1" class="fldLabelView">
						<ps:label key="ID_key" id="lbl_subscriberId_${_pageRef}"
							for="subscriberId_${_pageRef}" />
					</td>
					<td colspan="2"  class="fldDataEdit right">
						<ps:textfield id="subscriberId_${_pageRef}"
						name="individualSubscriberCO.alrtSubVO.ID" 
						mode="number" required=""  readonly="true"
					    tabindex="1" maxlength="8"  />
					</td>
					<td colspan = "5"></td>
					<td class="fldLabelView">
						<ps:label key="Status_key" id="lbl_status_${_pageRef}"
						for="status${_pageRef}" />
					</td>
					<td class="fldDataEdit left">
						<ps:textfield id="status${_pageRef}"
						name="individualSubscriberCO.statusDesc" mode="text"  maxlength="8"
						tabindex="-1" readonly="true" />
					</td>
					<td colspan="2" align="right">
						<psj:a button="true" buttonIcon="ui-icon-triangle-2-s"
						onclick="showIndSubscriberStatus()">
						<ps:text name='status_key' />
						</psj:a>
					</td>
				</tr>
				<tr>
					<td class="fldLabelView" colspan="2"> 
						<ps:label key="Brief_Name_Key" id="lbl_briefNameEng_${_pageRef}" for="briefNameEng_${_pageRef}" />
					</td>
					<td width="40%" class="fldDataEdit">
						<ps:textfield id="briefNameEng_${_pageRef}" tabindex="4"
							name="individualSubscriberCO.alrt_SUB_LANGVO.BRIEF_NAME" mode="text"
							size="70" maxlength="100" />
			
					</td>
				</tr>
				<tr>
					<td class="fldLabelView" colspan="2">
						<ps:label key="Middle_Name_eng_key" id="lbl_middleNameEng_${_pageRef}"
							for="middleNameEng_${_pageRef}" />
					</td>
					<td width="60%" class="fldDataEdit left" colspan="2">
						<ps:textfield id="middleNameEng_${_pageRef}" tabindex="5"
							name="individualSubscriberCO.alrt_SUB_LANGVO.MIDDLE_NAME" mode="text"
							size="70" maxlength="100" />
					</td>
				</tr>
				<tr>
					<td class="fldLabelView" colspan="2">
						<ps:label key="long_name_key" id="lbl_longNameEng_${_pageRef}"
							for="longNameEng_${_pageRef}" />
					</td>
					<td width="60%" class="fldDataEdit left" colspan="2">
						<ps:textfield id="longNameEng_${_pageRef}" tabindex="5"
							name="individualSubscriberCO.alrt_SUB_LANGVO.LONG_NAME" mode="text"
							size="70" maxlength="100" />
					</td>
				</tr>
				<tr>
				    <td class="fldLabelView" colspan="2">
						<ps:label key="address_key" id="lbl_address_${_pageRef}"
							for="address_${_pageRef}" />
					</td>
					<td width="60%" class="fldDataEdit left" colspan="2">
						<ps:textarea id="address_${_pageRef}" tabindex="5"
							name="individualSubscriberCO.rifCttVO.ADDRESS" mode="text"
							size="70" maxlength="150" />
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
			<ps:textfield id="shortNameArab_${_pageRef}" tabindex="6"
				name="individualSubscriberCO.cifVO.SHORT_NAME_ARAB" mode="text" onlyArabic="true"
				size="70" maxlength="20" cssStyle="direction:rtl"/>
		</td>

		<td class="fldLabelView " colspan="4">
			<ps:label key="Short_Name_Arab_key"
				id="lbl_shortNameArab_${_pageRef}"
				for="shortNameArab_${_pageRef}" />
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
			<ps:textfield id="longNameArab_${_pageRef}" tabindex="7"
				name="individualSubscriberCO.cifVO.LONG_NAME_ARAB" mode="text"
				maxlength="40" size="70" cssStyle="direction:rtl" onlyArabic="true" />
		</td>
		<td class="fldLabelView">
			<ps:label key="Long_Name_Arab_key"
				id="lbl_longNameArab_${_pageRef}"
				for="longNameArab_${_pageRef}" />
		</td>
	</tr>

</table>
	
<table border="0" width="75%" cellspacing="0" class="headerPortionContent ui-widget-content">


<tr style="vertical-align: top">
<td class="fldLabelView">
	<ps:label key="Address_Eng_key"
	for="ADDRESS1_ENG_${_pageRef}"
	id="lbl_address1Eng_${_pageRef}" />
</td>
<td class="fldDataEdit" width="40%">
	<div style="margin-bottom: 3px">
	<ps:textfield id="ADDRESS1_ENG_${_pageRef}" maxlength="50" tabindex="24"
		name="individualSubscriberCO.cifVO.ADDRESS1_ENG" />
</div>
<div style="margin-bottom: 3px">
	<ps:textfield id="ADDRESS2_ENG_${_pageRef}" maxlength="50" tabindex="25"
		name="individualSubscriberCO.cifVO.ADDRESS2_ENG" />
</div>
<div style="margin-bottom: 3px">
	<ps:textfield id="ADDRESS3_ENG_${_pageRef}" maxlength="50" tabindex="26"
		name="individualSubscriberCO.cifVO.ADDRESS3_ENG" />
		</div>
	</td>
	<td colspan="2"></td>
</tr>

<tr style="vertical-align: top">

<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td width="40%" class="fldDataEdit right">
	<div style="margin-bottom: 5px">
	<ps:textfield id="ADDRESS1_ARAB_${_pageRef}" maxlength="50" tabindex="27"
		name="individualSubscriberCO.cifVO.ADDRESS1_ARAB" onlyArabic="true"
		cssStyle="direction:rtl" />
</div>
<div style="margin-bottom: 5px">
	<ps:textfield id="ADDRESS2_ARAB_${_pageRef}" maxlength="50" tabindex="28"
		name="individualSubscriberCO.cifVO.ADDRESS2_ARAB" onlyArabic="true"
		cssStyle="direction:rtl" />
</div>
<div style="margin-bottom: 5px">
	<ps:textfield id="ADDRESS3_ARAB_${_pageRef}" maxlength="50" tabindex="29"
		name="individualSubscriberCO.cifVO.ADDRESS3_ARAB" onlyArabic="true"
		cssStyle="direction:rtl" />
	</div>

</td>

<td class="fldLabelView">
	<ps:label key="Address_Arb_key"
	for="ADDRESS1_ARAB_${_pageRef}"
	id="lbl_ADDRESS3_ARAB_${_pageRef}" />
</td>
</tr>

</table>	
<table  border="0" width="75%" cellspacing="0" class="headerPortionContent ui-widget-content">
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
		name="individualSubscriberCO.emailId" />
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
	<ps:label key="Mobile_key"
	for="tel_${_pageRef}"
	id="lbl_tel_${_pageRef}" />
</td>
<td class="fldDataEdit" colspan="8">
	<div style="margin-bottom: 3px">
	<ps:textfield id="tel_${_pageRef}" maxlength="255" tabindex="24" mode="text"
		name="individualSubscriberCO.tel" />
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