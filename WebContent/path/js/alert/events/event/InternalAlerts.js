/**
 * validate the internal Alerts
 * @returns
 */
function internalAlerts_validate()
{
	if($("#communicationModeImalInternalAlrt_"+_pageRef).prop("checked") == true)
    {
		//validate Sender user
//		var sendUsr = $("#lookuptxt_userId_"+_pageRef).val();
//		var sendUsrExp = $("#imalUserExpression_"+_pageRef).val();
//		
//		if(!common_isNotEmpty(sendUsr) && !common_isNotEmpty(sendUsrExp))
//		{
//			_showErrorMsg(missing_sender_user_or_user_expression_key, error_msg_title, 300,100);
//			return false;
//		}
		
		//validate Company
		var comp = $("#lookuptxt_evtInternalComp_"+_pageRef).val();
		var compExp = $("#companyExpression_"+_pageRef).val();
		
		if(!common_isNotEmpty(comp) && !common_isNotEmpty(compExp))
		{
			_showErrorMsg(missing_company_or_company_expression_key, error_msg_title, 300,100);
			return false;
		}
		
		//validate Branch
		var branch = $("#lookuptxt_evtInternalBranch_"+_pageRef).val();
		var branchExp = $("#branchExpression_"+_pageRef).val();
		
		if(!common_isNotEmpty(branch) && !common_isNotEmpty(branchExp))
		{
			_showErrorMsg(missing_branch_or_branch_expression_key, error_msg_title, 300,100);
			return false;
		}
		
		
		//validate Application
		var app = $("#lookuptxt_evtInternalApplication_"+_pageRef).val();
		var appExp = $("#applicationExpression_"+_pageRef).val();
		
		if(!common_isNotEmpty(app) && !common_isNotEmpty(appExp))
		{
			_showErrorMsg(missing_app_or_app_expression_key, error_msg_title, 300,100);
			return false;
		}
		
		var todoAlert =$("#lookuptxt_todoAlert_"+_pageRef).val();
		var todoKey = $("#todoKey_"+_pageRef).val();
		var progRef = $("#lookuptxt_progref_"+_pageRef).val();
		
		if(!common_isNotEmpty(todoAlert) || !common_isNotEmpty(todoKey) || !common_isNotEmpty(progRef))
		{
			_showErrorMsg(fill_all_internal_alert_fields_key, error_msg_title, 300,100);
			return false;
		}
    }
	
	return true;
}

function testInternalAlert()
{
	alert();
}