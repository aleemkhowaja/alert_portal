function showSubscriptionListById(){
		var from = $("#listFrom_" + _pageRef).val();
	 	var to = $("#listTo_" + _pageRef).val();
	 	var repId = "SBT00ML"
	 	var printParams = from + "~#~"+ to + "~#~";
	 	openPreviewAdviceWithId(repId, printParams, 0,null);
}
