<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@taglib prefix="pt" uri="/path-toolbar-tags"%>

<fieldset class="ui-widget-content ui-corner-all" title="others_details_key" >
  <legend ><ps:text name="others_details_key"/> </legend>
<ps:form id="IndSubscribtionOthersDet_${_pageRef}" >

<table id="indSubOthersDetailsTab_<ps:property value="_pageRef" escapeHtml="true"/>"  width="75%" border="0"
	cellspacing="0" class="headerPortionContent ui-widget-content">


	<tr>
		<td class="fldLabelView" colspan="2"> 
			<ps:label key="Short_name_eng_key" id="lbl_shortNameEng_${_pageRef}"
				for="shortNameEng_${_pageRef}" />
		</td>
		<td width="40%" class="fldDataEdit">
			<ps:textfield id="shortNameEng_${_pageRef}" tabindex="4"
				name="individualSubscriberCO.alrtSubDetVO.SHORT_NAME_ENG" mode="text"
				size="50" maxlength="40" />

		</td>
	</tr>

	<tr>
		<td class="fldLabelView" colspan="2">
			<ps:label key="Long_Name_eng_key" id="lbl_longNameEng_${_pageRef}"
				for="longNameEng_${_pageRef}" />
		</td>
		<td width="50" class="fldDataEdit left" colspan="2">
			<ps:textfield id="longNameEng_${_pageRef}" tabindex="5"
				name="individualSubscriberCO.alrtSubDetVO.LONG_NAME_ENG" mode="text"
				size="50" maxlength="40" />
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
				name="individualSubscriberCO.alrtSubDetVO.SHORT_NAME_ARAB" mode="text"
				size="50" maxlength="40" cssStyle="direction:rtl" onlyArabic="true"/>
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
				name="individualSubscriberCO.alrtSubDetVO.LONG_NAME_ARAB" mode="text"
				maxlength="40" size="50" cssStyle="direction:rtl" onlyArabic="true" />
		</td>
		<td class="fldLabelView">
			<ps:label key="Long_Name_Arab_key"
				id="lbl_longNameArab_${_pageRef}"
				for="longNameArab_${_pageRef}" />
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
	<ps:textfield id="email_${_pageRef}" maxlength="40" tabindex="8" mode="text"
		name="individualSubscriberCO.alrtSubDetVO.EMAIL_ID" />
</td>
<td colspan="3"><td/>

	<%-- <td class="fldLabelView" colspan="2">
		<ps:label key="language_key" id="lbl_language_${_pageRef}"
			for="language_${_pageRef}" />
	</td>
	<td class="fldDataEdit" colspan="3">
	<div style="margin-bottom: 3px">
	<ps:textfield id="language_${_pageRef}" maxlength="8" tabindex="24" mode="text"
		name="individualSubscriberCO.alrtSubVO.LANG" />
	</td>
 --%>
 <td class="fldLabelView" colspan="2">
		<ps:label key="language_key" id="lbl_language_${_pageRef}"
			for="language_${_pageRef}" />
	</td>
 <td colspan="3" class="fldDataEdit center">
		<ps:select id="language_${_pageRef}"
			name="individualSubscriberCO.alrtSubVO.LANG" list="commonlanguageDropDown"
			listKey="code" listValue="descValue" emptyOption="false"
			tabindex="9"
			disabled="false" 
			parameter="individualSubscriberCO.alrtSubVO.LANG:language_${_pageRef}, pageRef:pageRef_${_pageRef}"
			dependencySrc=""
			dependency="language_${_pageRef}:individualSubscriberCO.alrtSubVO.LANG"
			/>
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
	<ps:textfield id="tel_${_pageRef}" maxlength="255" tabindex="10" mode="text"
		name="individualSubscriberCO.alrtSubDetVO.MOBILE_PHONE" />
</td>
<td colspan="3"><td/>

 <td colspan="2" class="fldLabelView">
	<ps:label key="nbr_free_msgs_key"
	for="nbFreeMsgs_${_pageRef}"
	id="lbl_nbFreeMsgs_${_pageRef}" />
</td>
<td class="fldDataEdit" colspan="3">
	<div style="margin-bottom: 3px">
	<ps:textfield id="nbFreeMsgs_${_pageRef}" maxlength="8" tabindex="11" mode="number"
		name="individualSubscriberCO.alrtSubVO.NB_MSG" />
</td> 




</tr>
<tr>

<td colspan="2" class="fldLabelView">
	<ps:label key="tel_number1_key"
	for="telNumber1_${_pageRef}"
	id="lbl_telNumber1_${_pageRef}" />
</td>
<td class="fldDataEdit" colspan="3">
	<div style="margin-bottom: 3px">
	<ps:textfield id="telNumber1_${_pageRef}" maxlength="8" tabindex="12" mode="text"
		name="individualSubscriberCO.alrtSubDetVO.TEL1_NUM" />
</td>

<td colspan="8"><td/>

<td colspan="7">
	<div class="left">
	  <ps:checkbox id="chargeable_box_${_pageRef}"
		key="chargeable_key"
		name="individualSubscriberCO.alrtSubVO.CHARGEABLE" tabindex="13"
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
<td colspan="2" class="fldLabelView">
	<ps:label key="tel_number2_key"
	for="telNumber2_${_pageRef}"
	id="lbl_telNumber2_${_pageRef}" />
</td>
<td class="fldDataEdit" colspan="3">
	<div style="margin-bottom: 3px">
	<ps:textfield id="telNumber2_${_pageRef}" maxlength="8" tabindex="14" mode="text"
		name="individualSubscriberCO.alrtSubDetVO.TEL2_NUM" />
</td>

<td colspan="8"><td/>

<td colspan="7">
	<div class="left">
		  <ps:checkbox id="suspend_all_subscriptions_${_pageRef}"
			key="suspend_all_subscription_key"
			name="individualSubscriberCO.alrtSubVO.SUSPEND_ALL_SUBSCRIPTIONS" tabindex="1"
			valOpt="1:0"
			cssClass="ui-widget-content checkboxheight" 
		    parameter="individualSubscriberCO.alrtSubVO.SUSPEND_ALL_SUBSCRIPTIONS:suspend_all_subscriptions_${_pageRef}"
			dependency=""
			
		/>
	      </div>
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
	<ps:textfield id="ADDRESS1_ENG_${_pageRef}" maxlength="50" tabindex="15"
		name="individualSubscriberCO.alrtSubDetVO.ADDRESS1_ENG" />
</div>
<div style="margin-bottom: 3px">
	<ps:textfield id="ADDRESS2_ENG_${_pageRef}" maxlength="50" tabindex="16"
		name="individualSubscriberCO.alrtSubDetVO.ADDRESS2_ENG" />
</div>
<div style="margin-bottom: 3px">
	<ps:textfield id="ADDRESS3_ENG_${_pageRef}" maxlength="50" tabindex="17"
		name="individualSubscriberCO.alrtSubDetVO.ADDRESS3_ENG" />
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
	<ps:textfield id="ADDRESS1_ARAB_${_pageRef}" maxlength="50" tabindex="18"
		name="individualSubscriberCO.alrtSubDetVO.ADDRESS1_ARAB" 
		cssStyle="direction:rtl" onlyArabic="true" />
</div>
<div style="margin-bottom: 5px">
	<ps:textfield id="ADDRESS2_ARAB_${_pageRef}" maxlength="50" tabindex="19"
		name="individualSubscriberCO.alrtSubDetVO.ADDRESS2_ARAB"
		cssStyle="direction:rtl" onlyArabic="true"/>
</div>
<div style="margin-bottom: 5px">
	<ps:textfield id="ADDRESS3_ARAB_${_pageRef}" maxlength="50" tabindex="20"
		name="individualSubscriberCO.alrtSubDetVO.ADDRESS3_ARAB"
		cssStyle="direction:rtl" onlyArabic="true"/>
	</div>

</td>

<td class="fldLabelView">
	<ps:label key="Address_Arb_key"
	for="ADDRESS1_ARAB_${_pageRef}"
	id="lbl_ADDRESS3_ARAB_${_pageRef}" />
</td>
</tr>

</table>


</ps:form>
</fieldset>