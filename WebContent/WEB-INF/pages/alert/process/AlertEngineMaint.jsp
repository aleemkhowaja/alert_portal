<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt"  uri="/path-toolbar-tags" %>

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/path/css/alert/subscriber/indSub.css" />
<script type="text/javascript">
	$(document).ready(function() {
		 $(".subscribercontact").remove();
		 $('<span class="subscribercontact slider round"></span>').insertAfter("#startStopID_"+_pageRef);
		 }
	);
</script> 

<ps:form id="alertEngineMainFormId_${_pageRef}" target="_blank"  applyChangeTrack="true" >
	<table id="subDetailsIndSubTab_<ps:property value="_pageRef" escapeHtml="true"/>"  border="0" cellpadding="2" cellspacing="1">
		<tr>
			<br/>
		</tr>
		<tr>
			<td>
				<label class="switch">
					<ps:checkbox id="startStopID_${_pageRef}"
					key="start_stop_key"
					name="startStop" tabindex="1"
					valOpt="1:0"
					disabled="false"
					cssClass="ui-widget-content checkboxheight"  > </ps:checkbox>
					<span  class="subscribercontact slider round"></span>
				</label>
			</td>
		</tr>
	</table>
</ps:form>

