<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt"  uri="/path-toolbar-tags" %>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    


<ps:hidden name="individualEventCO.alrt_EVT_COMM_INTRNLVO.EVT_COMM_INTRNL_ID" id="commInternalAlrtId_${_pageRef}"></ps:hidden>

<table cellpadding="2" cellspacing="2">
	<tr>
		<td width="5%"> </td>
		<td width="3%"> </td>
		<td width="10%"> </td>
		<td width="5%"> </td>
		<td width="30%"> </td>
	</tr>

	<tr>
		<td valign="top" nowrap="nowrap"><ps:label key="sender_user_key"
				id="lbl_imalUser_${_pageRef}" for="lookuptxt_userId_${_pageRef}" /></td>
		<td valign="top" nowrap="nowrap"><psj:livesearch
				name="individualEventCO.alrt_EVT_COMM_INTRNLVO.SENDER_USR_ID"
				id="userId_${_pageRef}" mode="text" maxlength="8"
				actionName="${pageContext.request.contextPath}/path/alert/subscriber/individual/IndSubUsrLookupAction_constructLookup"
				searchElement="USER_ID"
				resultList="usrVO.USER_ID:lookuptxt_userId_${_pageRef},_pageRef:_pageRef"
				dependencySrc="${pageContext.request.contextPath}/path/alert/subscriber/individual/IndividualSubscriberDepAction_dependencyByUserID"
				dependency="lookuptxt_userId_${_pageRef}:individualSubscriberCO.alrtSubVO.USR_ID, 
							imalUserExpression_${_pageRef}:individualEventCO.alrt_EVT_COMM_INTRNLVO.SENDER_USR_EXPR"
				parameter="userID:lookuptxt_userId_${_pageRef},
						   individualSubscriberCO.alrtSubVO.USR_ID:lookuptxt_userId_${_pageRef},
						   _pageRef:_pageRef">
			</psj:livesearch></td>
		<td valign="top" nowrap="nowrap"></td>

	</tr>
	
	<tr>
		<td valign="top" nowrap="nowrap"><ps:label key="imal_user_expression_key"
				id="lbl_imalUserExpression_${_pageRef}"
				for="imalUserExpression_${_pageRef}" /></td>
		<td colspan="2"><ps:textarea id="imalUserExpression_${_pageRef}"
				name="individualEventCO.alrt_EVT_COMM_INTRNLVO.SENDER_USR_EXPR"
				mode="text" rows="4" cols="70" maxlength="500"
				onclick="individualEventComm_getId(this);" /></td>
	</tr>

	<tr>
		<td valign="top" nowrap="nowrap"><ps:label key="company_key" id="lbl_evtInternalComp_${_pageRef}"
				for="lookuptxt_evtInternalComp_${_pageRef}" /></td>
		<td  valign="top" nowrap="nowrap"><psj:livesearch
				name="individualEventCO.alrt_EVT_COMM_INTRNLVO.COMP_CODE"
				id="evtInternalComp_${_pageRef}" mode="number" maxlength="4"
				actionName="${pageContext.request.contextPath}/path/alert/lookup/CompaniesLookupAction_constructLookup"
				searchElement="COMP_CODE"
				paramList="userId:lookuptxt_userId_${_pageRef}"
				resultList="COMP_CODE:lookuptxt_evtInternalComp_${_pageRef}"
				dependencySrc="${pageContext.request.contextPath}/path/alert/lookup/CompaniesDependencyAction_dependencyByCompanyCode"
				dependency="lookuptxt_evtInternalComp_${_pageRef}:companiesVO.COMP_CODE,
				compDescription_${_pageRef}:companiesVO.BRIEF_DESC_ENG,
				lookuptxt_evtInternalBranch_${_pageRef}:'',branchDescription_${_pageRef}:'',
				companyExpression_${_pageRef}:individualEventCO.alrt_EVT_COMM_INTRNLVO.COMP_CODE_EXPR"
				parameter="userId:lookuptxt_userId_${_pageRef},compCode:lookuptxt_evtInternalComp_${_pageRef}">
			</psj:livesearch></td>
		<td  valign="top" nowrap="nowrap"><ps:textfield id="compDescription_${_pageRef}" readonly="true" name="individualEventCO.alrt_EVT_COMM_INTRNLVO.COMP_DESC"
				maxlength="50" mode="text">
			</ps:textfield></td>
	</tr>
	<tr>		
		<td valign="top" nowrap="nowrap"><ps:label key="company_expression_key"
				id="lbl_companyExpression_${_pageRef}"
				for="companyExpression_${_pageRef}" /></td>
	
		<td colspan="2"><ps:textarea id="companyExpression_${_pageRef}"
				name="individualEventCO.alrt_EVT_COMM_INTRNLVO.COMP_CODE_EXPR"
				mode="text" rows="4" cols="70" maxlength="500"
				onclick="individualEventComm_getId(this);" /></td>
	</tr>
	
	<tr>
		<td valign="top"  nowrap="nowrap"><ps:label key="branch_key" id="lbl_evtInternalBranch_${_pageRef}"
				for="lookuptxt_evtInternalBranch_${_pageRef}" /></td>
		<td  valign="top" nowrap="nowrap"><psj:livesearch
				name="individualEventCO.alrt_EVT_COMM_INTRNLVO.BRANCH_CODE"
				id="evtInternalBranch_${_pageRef}" mode="number" maxlength="4"
				actionName="${pageContext.request.contextPath}/path/alert/lookup/BranchesLookupAction_constructLookup"
				searchElement="branchCode"
				paramList="userId:lookuptxt_userId_${_pageRef},compCode:lookuptxt_evtInternalComp_${_pageRef}"
				resultList="branchCode:lookuptxt_evtInternalBranch_${_pageRef}"
				dependencySrc="${pageContext.request.contextPath}/path/alert/lookup/BranchesDependencyAction_dependencyByBranchCode"
				dependency="lookuptxt_evtInternalBranch_${_pageRef}:branchCO.branchCode,
				branchDescription_${_pageRef}:branchCO.briefNameEnglish, branchExpression_${_pageRef}:individualEventCO.alrt_EVT_COMM_INTRNLVO.BRANCH_CODE_EXPR"
				parameter="userId:lookuptxt_userId_${_pageRef},compCode:lookuptxt_evtInternalComp_${_pageRef}, branchCode:lookuptxt_evtInternalBranch_${_pageRef}">
			</psj:livesearch></td>
		<td  valign="top" nowrap="nowrap"><ps:textfield id="branchDescription_${_pageRef}" readonly="true" name="individualEventCO.alrt_EVT_COMM_INTRNLVO.BRANCH_DESC"
				maxlength="50" mode="text" >
			</ps:textfield></td>
	</tr>
	<tr>
		<td valign="top" nowrap="nowrap" ><ps:label key="branch_expression_key" id="lbl_branchExpression_${_pageRef}"
				for="branchExpression_${_pageRef}" /></td>

		<td colspan="2"><ps:textarea id="branchExpression_${_pageRef}"
				name="individualEventCO.alrt_EVT_COMM_INTRNLVO.BRANCH_CODE_EXPR"
				mode="text" rows="4" cols="70" maxlength="500"
				onclick="individualEventComm_getId(this);" /></td>
	</tr>

	<tr>
		<td valign="top" nowrap="nowrap"><ps:label key="appliation_key"
				id="lbl_evtInternalApplication_${_pageRef}"
				for="lookuptxt_evtInternalApplication_${_pageRef}" /></td>
		<td valign="top" nowrap="nowrap"><psj:livesearch
				name="individualEventCO.alrt_EVT_COMM_INTRNLVO.APP_NAME"
				id="evtInternalApplication_${_pageRef}" mode="text" maxlength="4"
				actionName="${pageContext.request.contextPath}/path/alert/lookup/ApplicationsLookupAction_constructLookup"
				searchElement="APP_NAME"
				resultList="APP_NAME:lookuptxt_evtInternalApplication_${_pageRef},LONG_DESC:applicationDescription_${_pageRef}"
				parameter="appName:lookuptxt_evtInternalApplication_${_pageRef}"
				dependencySrc="${pageContext.request.contextPath}/path/alert/lookup/ApplicationsDependencyAction_dependencyByAppName"
				dependency="lookuptxt_todoAlert_${_pageRef}:'',lookuptxt_progref_${_pageRef}:'', todoAlertDescription_${_pageRef}:'', progDescription_${_pageRef}:''
				, applicationExpression_${_pageRef}:individualEventCO.alrt_EVT_COMM_INTRNLVO.APP_NAME_EXPR">
			</psj:livesearch></td>
		<td valign="top" nowrap="nowrap"></td>
	</tr>
	<tr>
		<td valign="top" nowrap="nowrap"><ps:label
				key="app_expression_key" id="lbl_applicationExpression_${_pageRef}"
				for="applicationExpression_${_pageRef}" /></td>

		<td colspan="2"><ps:textarea id="applicationExpression_${_pageRef}"
				name="individualEventCO.alrt_EVT_COMM_INTRNLVO.APP_NAME_EXPR"
				mode="text" rows="4" cols="70" maxlength="500"
				onclick="individualEventComm_getId(this);" /></td>
	</tr>

	<tr>
		<td nowrap="nowrap"><ps:label key="todo_alert_key"
				id="lbl_todoAlrt_${_pageRef}" for="todoAlert_${_pageRef}" /></td>
				
		<td  valign="top" nowrap="nowrap"><psj:livesearch
				name="individualEventCO.alrt_EVT_COMM_INTRNLVO.TODO_ALRT"
				id="todoAlert_${_pageRef}" mode="text" maxlength="6"
				actionName="${pageContext.request.contextPath}/path/alert/lookup/TodoAlertLookupAction_constructLookup"
				searchElement="TODO_ALERT"
				paramList="appName:lookuptxt_evtInternalApplication_${_pageRef}"
				resultList="TODO_ALERT:lookuptxt_todoAlert_${_pageRef}"
				dependencySrc="${pageContext.request.contextPath}/path/alert/lookup/TodoAlertDependencyAction_dependencyByTodoAlert"
				dependency="lookuptxt_todoAlert_${_pageRef}:alert_TYPEVO.TODO_ALERT,
				todoAlertDescription_${_pageRef}:alert_TYPEVO.BRIEF_DESC_ENG"
				parameter="appName:lookuptxt_evtInternalApplication_${_pageRef},todoAlert:lookuptxt_todoAlert_${_pageRef}">
			</psj:livesearch></td>
			
		<td  valign="top" nowrap="nowrap"><ps:textfield id="todoAlertDescription_${_pageRef}" readonly="true"
		 name="individualEventCO.alrt_EVT_COMM_INTRNLVO.TODO_ALRT_DESC"
				maxlength="150" mode="text">
			</ps:textfield></td>
			
	</tr>
	
	<tr>
		<td valign="top" nowrap="nowrap"><ps:label key="todokey_key"
				id="lbl_todoKey_${_pageRef}" for="todoKey_${_pageRef}" /></td>
				
		<td colspan="2"><ps:textarea id="todoKey_${_pageRef}"
				name="individualEventCO.alrt_EVT_COMM_INTRNLVO.TODO_KEY"
				mode="text" rows="4" cols="70" maxlength="500"
				onclick="individualEventComm_getId(this);" /></td>
	</tr>

	<tr>
		<td nowrap="nowrap"><ps:label key="progref_key"
				id="lbl_progref_${_pageRef}" for="progref_${_pageRef}" /></td>
	
		<td  valign="top" nowrap="nowrap"><psj:livesearch
				name="individualEventCO.alrt_EVT_COMM_INTRNLVO.TODO_PROG_REF"
				id="progref_${_pageRef}" mode="text" maxlength="15"
				actionName="${pageContext.request.contextPath}/path/alert/lookup/ProgRefLookupAction_constructLookup"
				searchElement="PROG_REF"
				paramList="appName:lookuptxt_evtInternalApplication_${_pageRef}"
				resultList="PROG_REF:lookuptxt_progref_${_pageRef}"
				dependencySrc="${pageContext.request.contextPath}/path/alert/lookup/ProgRefDependencyAction_dependencyByProgRef"
				dependency="lookuptxt_progref_${_pageRef}:optvo.PROG_REF,
				progDescription_${_pageRef}:optvo.PROG_DESC"
				parameter="appName:lookuptxt_evtInternalApplication_${_pageRef},
						   progRef:lookuptxt_progref_${_pageRef}">
			</psj:livesearch></td>
		
		<td  valign="top" nowrap="nowrap"><ps:textfield id="progDescription_${_pageRef}" readonly="true"
		 name="individualEventCO.alrt_EVT_COMM_INTRNLVO.TODO_PROG_REF_DESC"
				maxlength="50" mode="text">
			</ps:textfield></td>
	</tr>

</table>