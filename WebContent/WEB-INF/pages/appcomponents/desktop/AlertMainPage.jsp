<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp" %>
<%@include file="/WEB-INF/pages/alert/common/AlertAppTrans.jsp" %>
<meta name="decorator" content="main"/>
<head>
<title><ps:text name="app_main_title_alert_key"/></title>
</head>


<script type="text/javascript"  src="${pageContext.request.contextPath}/common/js/tabs/TabbedPanel.js"></script>

<script type="text/javascript">
	var RTL_DIRECTION = "${isRTL}";

	$(document).ready(function() {
	    intializeMainTabs("mainTabs",{url:jQuery.contextPath+"/path/loadScreen?",reloadAlert:"<ps:text name='reload_contents_key'/>",closeAlert:"<ps:text name='close'/>"});
	});
</script>
<body >

<%/*Added padding top and buttom to overwrite Tabs Padding (.ui-tabs)*/%>
<div id="mainTabs" style=" visibility: hidden;height: 100%; overflow: auto; padding-bottom: 0px; padding-top: 0px;">
    <%/*Required for toolbar positioning*/%>
	<ul></ul>
</div>
</body>
