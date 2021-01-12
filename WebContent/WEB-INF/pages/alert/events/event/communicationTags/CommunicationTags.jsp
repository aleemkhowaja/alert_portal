<%@include file="/WEB-INF/pages/common/Encoding.jsp" %>
<%@include file="/WEB-INF/pages/common/TLDImport.jsp"%>
<%@ taglib prefix="ptt"  uri="/path-toolbar-tags" %>


<script type="text/javascript">
	$(document).ready(function(){
		//Grid of Fixed Event tags to be hidden base on OMNI flag
		if($('#enable_omni').val() == 'true')
		{
			$('#fixedEventTagsDetails_'+_pageRef).css('display', 'none');
		}
	});
</script>
	<ps:set name="ivcrud_${_pageRef}"    value="iv_crud"/>
	<table>
		<tr>
			<td style="vertical-align: top; width:10%" >
		 		<div id="emailStaticCustomTagsDetails_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px;">
						<div id="emailStaticCustomTagsDetails_Inner_${_pageRef}" class="collapsibleContainer" title="<ps:text name='custom_tags_key'/>">
							<ps:url id="urlEventEmailStaticCustomTagsGrid" escapeAmp="false" action="AlrtTagsAction_returnAlertCustomTags" namespace="/path/alert/events/event">
								<ps:param name="_pageRef" value="_pageRef"></ps:param>
								<ps:param name="individualEventSC.isCustomYN" value="'Y'"></ps:param>
								<ps:param name="individualEventSC.eventID" value="individualEventCO.alrtEvtVO.EVT_ID"></ps:param>
							</ps:url>
			
							<psjg:grid 	
								id               		="eventEmailStaticCustomTagsGridId_${_pageRef}"
								href             		="%{urlEventEmailStaticCustomTagsGrid}"
								dataType         		="json"
								caption					=""
								pager            		="false"
								sortable         		="true"
								filter           		="false"
								gridModel        		="gridModel"
								rowNum           		="5"
								rowList          		="5,10,15,20"
								viewrecords      		="false"
								navigator       	 	="true"
								navigatorDelete 	    ="true"
								navigatorEdit    		="false"
								navigatorRefresh 		="false"
								navigatorAdd     		="true"
								navigatorSearch  		="false"
								editurl			 		=" " 
								editinline		 		="true" 
								altRows          		="true"
								ondblclick       		="individualAlertTag_addTagsInTextArea('Custom', 'Email')"
								autowidth				="false"
								width 					="300"
								shrinkToFit				="false"
								addfunc					="individualEvents_addNewCustomTagRow('Email')"
								delfunc					="individualEvents_deleteNewCustomTagRow('Email')"
								onSelectRowTopics		="onRowSelTopic"
								>
		
									<psjg:gridColumn 
										search="false" 
										searchoptions="{sopt:['eq','ne','bw','bn','ew','en','cn','nc']}" 
										name="TAG_NAME" 
										sortable="true" 
										id="tagName" 
										title="%{getText('tag_name_key')}" 
										colType="text" 
										editable="true"
										width="280"
										editoptions="{maxlength: '50'}"
										/>
										
									<psjg:gridColumn 
										name="IS_NEW" 
										colType="text" 
										hidden="true"
										sortable="false" 
										id="tagName" 
										title="%{getText('is_new')}"  />
									
									<psjg:gridColumn 
										name="ALRT_TAGS_DEF_ID" 
										colType="text" 
										hidden="true"
										sortable="false" 
										id="ALRT_TAGS_DEF_ID" 
										title="%{getText('ALRT_TAGS_DEF_ID')}"  />
							</psjg:grid>
					</div>
				</div>
			</td >
		</tr>
		<tr>
			<td style="vertical-align: top; width:10%">
				<div id="emailStaticDefaultTagsDetails_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px;">
						<div id="emailStaticDefaultTagsDetails_Inner_${_pageRef}" class="collapsibleContainer" title="<ps:text name='default_tags_key'/>">
				
							<ps:url id="urlEventEmailStaticDefaultTagsGrid" escapeAmp="false" action="AlrtTagsAction_returnAlertDefaultTags" namespace="/path/alert/events/event">
								<ps:param name="_pageRef" value="_pageRef"></ps:param>
								<ps:param name="individualEventSC.isCustomYN" value="'N'"></ps:param>
							</ps:url>
		
							<psjg:grid 	
								id               		="eventEmailStaticDefaultTagsGridId_${_pageRef}"
								href             		="%{urlEventEmailStaticDefaultTagsGrid}"
								dataType         		="json"
								pager            		="false"
								sortable         		="false"
								filter           		="false"
								gridModel        		="gridModel"
								rowNum           		="5"
								rowList          		="5,10,15,20"
								viewrecords      		="true"
								navigator       	 	="false"
								navigatorDelete 	    ="false"
								navigatorEdit    		="false"
								navigatorRefresh 		="false"
								navigatorAdd     		="false"
								navigatorSearch  		="false"
								editurl			 		=" " 
								editinline		 		="false" 
								navigatorSearchOptions	="{closeOnEscape: true,closeAfterSearch: true, multipleSearch: true,sopt:['eq','ne','lt','gt','le','ge']}"
								altRows          		="true"
								ondblclick       		="individualAlertTag_addTagsInTextArea('Default', '')"
								autowidth				="false"
								height					="200"
								width 					="300"
								shrinkToFit				="false">
		
								<psjg:gridColumn 
									search="true" 
									searchoptions="{sopt:['eq','ne','bw','bn','ew','en','cn','nc']}" 
									name="TAG_NAME" 
									sortable="true" 
									id="tagName" 
									title="%{getText('tag_name_key')}" 
									colType="text" 
									editable="true"
									width="280" />
							</psjg:grid>
						</div>
					</div>
			</td>
		</tr>
		<tr>
			<td>
				<div id="fixedEventTagsDetails_${_pageRef}" class="connectedSortable ui-helper-reset" style="margin-bottom: 5px; margin-top: 3px;">
					<div id="fixedEventTagsDetails_Inner_${_pageRef}" class="collapsibleContainer" title="<ps:text name='fixed_events_tags_key'/>">
						<ps:url id="urlFixedEventCustomExpressionGrid" escapeAmp="false" action="IndividualEventListAction_retFixedAdditionalTags" namespace="/path/alert/events/event">
							<ps:param name="_pageRef" value="_pageRef"></ps:param>
							<ps:param name="indEventSC.fixedEventId" value="individualEventCO.alrtEvtVO.FIXED_EVENT_ID"></ps:param>
						</ps:url>
						
						<psjg:grid 
							id				="eventEmailStaticFixedEvtTagsGridId_${_pageRef}" 
							caption			=""
							rownumbers		="false" 
							href			="%{urlFixedEventCustomExpressionGrid}"
							dataType		="json" 
							pager			="false" 
							filter			="false"
							gridModel		="gridModel" 
							rowNum			="50" 
							rowList			="5,10,15,20"
							viewrecords		="true" 
							navigator		="true" 
							height			="200"
							width 			="300"
							multiselect		="false" 
							autowidth		="false"
							altRows			="true" 
							navigatorRefresh="false" 
							pagerButtons	="false"
							navigatorEdit	="false" 
							navigatorSearch	="false"
							shrinkToFit		="false"
							navigatorAdd	="false" 
							navigatorDelete	="false"
							ondblclick 		="individualAlertTag_addTagsInTextArea('FixedEvt', '')">
						    
							<psjg:gridColumn 
									name="TAG_NAME" 
									colType="text" 
									sortable="true" 
									id="TAG_NAME" 
									index="TAG_NAME"
									title="%{getText('tag_name_key')}"
									width="280" />
									
						</psjg:grid>
					</div>
				</div>
			</td>
		</tr>
	</table>
	
	<script type="text/javascript">
		$("#eventEmailStaticCustomTagsGridId_"+_pageRef).subscribe("onRowSelTopic",function(rowObj)
		{
			individualEventMaint_disableCustomColumnCell('Email');			
		});

		
		$.subscribe('setEmailGridLayout', function(event, data) 
		{
			indEvent_setLayout("eventEmailStaticCustomTagsGridId");
			indEvent_setLayout("eventEmailStaticDefaultTagsGridId");
			indEvent_setLayout("eventEmailStaticQueryTagsGridId");
			 
		});
		
		function indEvent_setLayout(id)
	    {
			 $("#gbox_"+id+"_"+_pageRef).removeAttr("style");
			 //$(".ui-jqgrid-btable").removeAttr("style");
			 $("#"+id+"_"+_pageRef+"_pager").removeAttr("style");
			 $("#gview_"+id+"_"+_pageRef).find('.ui-jqgrid-hdiv').removeAttr("style");
			 $("#gview_"+id+"_"+_pageRef).removeAttr("style");
			 $("#gview_"+id+"_"+_pageRef).find('.ui-jqgrid-bdiv').css('width', '');
	    }

		</script>