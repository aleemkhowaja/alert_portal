<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp" %>
<div style="padding: 7px">
	<table  width="100%" border ="0">
		<tr>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
		</tr>
		<tr>
			<td><ps:label 
					id="commment_${_pageRef}" key="expression_key"/>
			</td>
		</tr>
		<tr>
			<td colspan="3" valign="top">
				<ps:textarea id="expressionId_${_pageRef}" name="individualEventCO.alrtEvtVO.ALRT_EVT_EXPR" onkeydown="fixEventdetails_expressionShowHideData(this)" maxlength="1000" cols="80" rows="30"/>
			</td>
			<td valign="top">
				<ps:url id="urlFixedEventCustomExpressionGrid" escapeAmp="false" action="IndividualEventListAction_retFixedAdditionalTags" namespace="/path/alert/events/event">
					<ps:param name="_pageRef" value="_pageRef"></ps:param>
					<ps:param name="fixedEventId" value="individualEventSC.fixedEventId"></ps:param>
				</ps:url>
				
				<psjg:grid id="customExpressionGridId_${_pageRef}" 
					caption=""
					rownumbers="false" 
					href="%{urlFixedEventCustomExpressionGrid}"
					dataType="json" 
					pager="false" 
					filter="false"
					gridModel="gridModel" 
					rowNum="50" rowList="5,10,15,20"
					viewrecords="true" 
					navigator="true" 
					height="370" 
					width="210"
					multiselect="false" 
					autowidth="false"
					altRows="true" navigatorRefresh="false" 
					pagerButtons="false"
					navigatorEdit="false" 
					navigatorSearch="false"
					shrinkToFit="true"
					navigatorAdd="false" 
					navigatorDelete="false"
					ondblclick ="fixedEventCustomExpression_addTagsInTextArea()">
				    
					<psjg:gridColumn 
							name="TAG_NAME" 
							colType="text" 
							sortable="true" 
							id="TAG_NAME" 
							index="TAG_NAME"
							title="%{getText('Tag Name')}" />
							
				</psjg:grid>
			</td>
		</tr>
	</table>
</div>
