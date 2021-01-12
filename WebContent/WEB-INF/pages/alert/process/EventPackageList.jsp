<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
   <%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@include file="/WEB-INF/pages/alert/common/AlertAppTrans.jsp"%>
<%@taglib prefix="pt" uri="/path-toolbar-tags"%>

 <script type="text/javascript">
$.struts2_jquery.require("EventPackageList.js", null, jQuery.contextPath
		+ "/path/js/alert/events/eventPackage/");
</script>

<table id="EventPackageList_<ps:property value="_pageRef" escapeHtml="true"/>"  width="60%" border="0"
	cellspacing="0">
	<tr>
	<td colspan="1" class="fldLabelView">
	<ps:label key="ra_from" id="lbl_listFrom_${_pageRef}"
		for="listFrom_${_pageRef}" />
	</td>
	<td colspan="2"  class="fldDataEdit right">
		<ps:textfield id="listFrom_${_pageRef}"
		name="fromId"
		mode="number" required="false"  readonly="false"
	    tabindex="1"/>
	</td>
	
	<td colspan="1" class="fldLabelView">
	<ps:label key="ra_to" id="lbl_listFrom_${_pageRef}"
		for="listTo_${_pageRef}" />
	</td>
	<td colspan="2"  class="fldDataEdit right">
		<ps:textfield id="listTo_${_pageRef}"
		name="toId" 
		mode="number" required="true"  readonly="false"
	    tabindex="1"/>
	</td>
	<td colspan="2" align="right">
		<psj:a button="true" onclick="showPackageEventListById()">
		<ps:text name='Retrieve' />
		</psj:a>
	</td>
	</tr>
</table>
