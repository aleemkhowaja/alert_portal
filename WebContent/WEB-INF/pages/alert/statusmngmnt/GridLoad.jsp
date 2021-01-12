<%@include file="/WEB-INF/pages/common/Encoding.jsp"%>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt" uri="/path-toolbar-tags"%>



	<ps:set name="ivcrud_${_pageRef}" value="iv_crud" />

	
	<ps:if test='%{criteria.relType=="A"}'> 

	<%@include file="StatusMngmntGrid.jsp"%>

	 </ps:if> 
	
	
	
	<ps:if test="%{criteria.relType=='SE'}">

	<%@include file="SubscriberEventGrid.jsp"%>

	</ps:if>
	<ps:if test="%{criteria.relType=='GP'}">
	
	<%@include file="GroupPackageGrid.jsp"%>
	
	</ps:if>
	
	
	
	<ps:if test="%{criteria.relType=='EG'}">
	
	<%@include file="GroupEventGrid.jsp"%>
	
	</ps:if>
	
	<ps:if test="%{criteria.relType=='SP'}">
	
	<%@include file="SubscriberPackageGrid.jsp"%>
	
	</ps:if>
