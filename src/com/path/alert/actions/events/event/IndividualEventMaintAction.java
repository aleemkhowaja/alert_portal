package com.path.alert.actions.events.event;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.path.alert.actions.common.AlertBaseAction;
import com.path.alert.bo.base.AlertConstant;
import com.path.alert.bo.common.AlrtCommonConstants;
import com.path.alert.bo.events.event.IndividualEventBO;
import com.path.alert.bo.events.event.IndividualEventConstant;
import com.path.alert.bo.subscription.SubscriptionConstant;
import com.path.alert.vo.events.event.IndFixedParamListCO;
import com.path.alert.vo.events.event.IndividualEventCO;
import com.path.alert.vo.events.event.IndividualEventReportAttachmentCO;
import com.path.alert.vo.events.event.IndividualEventSC;
import com.path.bo.common.ConstantsCommon;
import com.path.bo.common.audit.AuditConstant;
import com.path.dbmaps.vo.ALRT_EVTVO;
import com.path.dbmaps.vo.ALRT_EVT_BATCH_ARG_MAPVO;
import com.path.dbmaps.vo.ALRT_EVT_COMM_MODEVO;
import com.path.dbmaps.vo.ALRT_EVT_COMM_MODE_ARG_MAPVO;
import com.path.dbmaps.vo.ALRT_TAGS_DEFVO;
import com.path.dbmaps.vo.SYS_PARAM_SCREEN_DISPLAYVO;
import com.path.lib.common.exception.BOException;
import com.path.lib.common.exception.BaseException;
import com.path.lib.common.util.NumberUtil;
import com.path.lib.common.util.StringUtil;
import com.path.lib.vo.GridUpdates;
import com.path.vo.common.SessionCO;
import com.path.vo.common.audit.AuditRefCO;
import com.path.vo.common.select.SelectCO;
import com.path.vo.common.select.SelectSC;

/**
 * 
 * @author Alim Khowaja
 *
 */
public class IndividualEventMaintAction extends AlertBaseAction
{

    /**
     * CO, SC Objects
     */
    private IndividualEventCO individualEventCO = new IndividualEventCO();
    private IndividualEventSC individualEventSC = new IndividualEventSC();
    private IndividualEventReportAttachmentCO individualEventReportAttachmentCO = new IndividualEventReportAttachmentCO();

    /**
     * Bo Objects
     */
    private IndividualEventBO individualEventBO;

    /**
     * dropdown list
     */
    private List<SelectCO> messageBodyByList;
    private List<SelectCO> subscriberTypeOptionList;
    private List<SelectCO> batchTypeQueryOptionList;
    private List<SelectCO> fixedEventTypeList;
    private List<SelectCO> otherLanguageTypeList;
    private List<SelectCO> eventTypeList;
    private List<ALRT_TAGS_DEFVO> alrtTagsCOList;
    private List<SelectCO> expressionOptionList;
    private List<SelectCO> sourceOfContact;

    /**
     * form variables
     */
    private String iv_crud;
    private String isEventDescriptionExist, update;

    /**
     * load Event page
     * 
     * @return
     */
    public String loadIndEventPage()
    {

	// String returnScreen = "individualEventList";
	try
	{
	    set_searchGridId("individualEventGridTbl_Id");
	    individualEventCO.getAlrtEvtVO().setEVT_TYPE("D");

	    // call initialize
	    initialize();
	}
	catch(BaseException ex)
	{
	    handleException(ex, null, null);
	    return ERROR_ACTION;
	}
	return "individualEventList";
    }

    /**
     * initialize varaibles like list of dropdown, new button, set readonly
     * fields
     * 
     * @throws BaseException
     */
    public void initialize() throws BaseException
    {
	// load all dropdown
	fillDropDown();
	individualEventCO.setEventStaticEmailOtherLanguageHidden("DF");
	individualEventCO.setEventStaticSmsOtherLanguageHidden("DF");
	individualEventCO.setEventStaticOmniInboxOtherLanguageHidden("DF");
	// Counts for Report Attachment
	individualEventCO.setEmailEventStaticReportAttachCount(new BigDecimal(BigInteger.ONE));
	individualEventCO.setOmniInboxEventStaticReportAttachCount(new BigDecimal(BigInteger.ONE));

	ALRT_EVT_COMM_MODEVO email_EVT_COMM_MODEVO = new ALRT_EVT_COMM_MODEVO();
	email_EVT_COMM_MODEVO.setTEMPLATE_TYPE(IndividualEventConstant.STATIC_TEMPLATE_TYPE);
	individualEventCO.setEmail_EVT_COMM_MODEVO(email_EVT_COMM_MODEVO);

	// enable audit and smart option
	set_enableAudit(true);
	set_showSmartInfoBtn("false");

	if(AlertConstant.CRUD_R.equals(getIv_crud()))
	{
	    set_showNewInfoBtn("true");
	}
	else
	{
	    if(AlertConstant.CRUD_P.equals(getIv_crud()) || AlertConstant.CRUD_F.equals(getIv_crud()))
	    {
		set_recReadOnly("true");
	    }
	    set_showNewInfoBtn("false");
	}
	// disable CIF livesearch based on OMNI flag
	setEnable_omni(AlrtCommonConstants.isOmniInstalled);
    }

    /**
     * load empty page
     * 
     * @return
     */
    public String clear()
    {
	individualEventCO = new IndividualEventCO();
	// String returnScreen = "individualEventMaint";
	try
	{
	    ALRT_EVT_COMM_MODEVO email_EVT_COMM_MODEVO = new ALRT_EVT_COMM_MODEVO();
	    email_EVT_COMM_MODEVO.setTEMPLATE_TYPE(IndividualEventConstant.STATIC_TEMPLATE_TYPE);
	    individualEventCO.setEmail_EVT_COMM_MODEVO(email_EVT_COMM_MODEVO);

	    // load all dropdown
	    fillDropDown();

	    if(AlertConstant.CRUD_P.equals(getIv_crud()) || AlertConstant.CRUD_F.equals(getIv_crud()))
	    {
		set_recReadOnly("true");
	    }

	    individualEventCO.setEventStaticEmailOtherLanguageHidden("DF");
	    individualEventCO.setEventStaticSmsOtherLanguageHidden("DF");
	    individualEventCO.setEventStaticOmniInboxOtherLanguageHidden("DF");

	    // Counts for Report Attachment
	    individualEventCO.setEmailEventStaticReportAttachCount(new BigDecimal(BigInteger.ONE));
	    individualEventCO.setOmniInboxEventStaticReportAttachCount(new BigDecimal(BigInteger.ONE));
	    // By Default Default Option show in Event Type select
	    individualEventCO.getAlrtEvtVO().setEVT_TYPE("D");
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	    return ERROR_ACTION;
	}
	return "individualEventMaint";
    }

    /**
     * fill event screen dropdowns
     * 
     * @throws BaseException
     */
    private void fillDropDown() throws BaseException
    {
	// fill Message body by
	SessionCO sessionCO = returnSessionObject();
	SelectSC selSC = new SelectSC(IndividualEventConstant.METHOD_BODY_BY_LOV_TYPE);
	selSC.setLanguage(sessionCO.getLanguage());
	selSC.setOrderCriteria("ORDER");
	messageBodyByList = returnLOV(selSC);

	// retrieve other Language type List
	SelectSC sc = new SelectSC();
	sc.setLovTypeId(AlrtCommonConstants.LANGUAGES_LOV_TYPE);
	sc.setLanguage(returnSessionObject().getLanguage());
	sc.setOrderCriteria("ORDER");
	SelectCO selectCO = new SelectCO();
	selectCO.setCode("DF");
	selectCO.setDescValue("Default");
	selSC.setLanguage(sessionCO.getLanguage());
	otherLanguageTypeList = returnLOV(sc);
	otherLanguageTypeList.add(0, selectCO);

	// fill Event Type Drop Down
	SelectSC eventTypeSC = new SelectSC(IndividualEventConstant.EVENT_TYPE_LOV_TYPE);
	eventTypeSC.setLanguage(sessionCO.getLanguage());
	eventTypeSC.setOrderCriteria("ORDER");
	// Event Type dropwDown remove from it Fixed Event option based on OMNI
	// flag
	if(AlrtCommonConstants.isOmniInstalled)
	{
	    eventTypeSC.setLovCodesInlude("'D','B','S'");
	}
	else
	{
	    eventTypeSC.setLovCodesInlude("'D','B','F','S'");
	}
	eventTypeList = returnLOV(eventTypeSC);

	// fill Subscriber Type Drop Down
	SelectSC subscTypeSC = new SelectSC(IndividualEventConstant.SUBSCRIBER_TYPE_LOV_TYPE);
	subscTypeSC.setLanguage(sessionCO.getLanguage());
	subscTypeSC.setOrderCriteria("ORDER");
	subscriberTypeOptionList = returnLOV(subscTypeSC);

	// fill batch Type query Type Drop Down
	SelectSC batchTypeSC = new SelectSC(null);
	batchTypeSC.setLanguage(sessionCO.getLanguage());
	batchTypeSC.setOrderCriteria("ORDER");
	batchTypeQueryOptionList = new ArrayList<SelectCO>();

	// fill Source of Contact Drop Down
	SelectSC srcContactSelSC = new SelectSC(SubscriptionConstant.subscriptionSrcContactLovId);

	if(StringUtil.isNotEmpty(individualEventCO.getAlrtEvtVO().getSKIP_SUBSCRIPTION_YN())
		&& individualEventCO.getAlrtEvtVO().getSKIP_SUBSCRIPTION_YN().equals(IndividualEventConstant.YES))
	{
	    srcContactSelSC.setLovCodesInlude("'D','F','C'");
	}

	// Exclude Account Source of contact while choose Event Type = Batch
	if(individualEventCO.getAlrtEvtVO() != null && individualEventCO.getAlrtEvtVO().getSOURCE_OF_CONTACT() != null)
	{
	    if(individualEventCO.getAlrtEvtVO().getEVT_TYPE().equals(IndividualEventConstant.BATCH_EVT_TYPE))
	    {
		srcContactSelSC.setLovCodesExclude("'C'");
	    }
	}
	srcContactSelSC.setOrderCriteria("ORDER");

	sourceOfContact = returnLOV(srcContactSelSC);

	// fill fix event dropdown
	IndividualEventSC criteria = new IndividualEventSC();
	fixedEventTypeList = individualEventBO.fixedEventListSelectCO(criteria);
	fixedEventTypeList.add(0, null);
    }

    /**
     * fill Source of contact
     * 
     * @return
     */
    public String fillSourceOfContact()
    {
	try
	{
	    // fill Source of Contact Drop Down
	    SelectSC srcContactSelSC = new SelectSC(SubscriptionConstant.subscriptionSrcContactLovId);
	    if(StringUtil.isNotEmpty(individualEventCO.getAlrtEvtVO().getSKIP_SUBSCRIPTION_YN()))
	    {
		srcContactSelSC.setLovCodesInlude("'D','F','C'");
	    }

	    // Exclude Account Source of contact while choose Event Type = Batch
	    if(StringUtil.isNotEmpty(individualEventCO.getAlrtEvtVO().getEVT_TYPE())
		    && (individualEventCO.getAlrtEvtVO().getEVT_TYPE().equals(IndividualEventConstant.BATCH_EVT_TYPE)
			    || (individualEventCO.getAlrtEvtVO().getEVT_TYPE()
				    .equals(IndividualEventConstant.IMAL_FIXED_EVT_TYPE))
				    && (individualEventCO.getFixedEventId() != null && individualEventCO
					    .getFixedEventId().equals(IndividualEventConstant.CARD_SMS_SERVICE))))
	    {
		srcContactSelSC.setLovCodesExclude("'C'");
	    }

	    srcContactSelSC.setOrderCriteria("ORDER");
	    sourceOfContact = returnLOV(srcContactSelSC);
	}
	catch(Exception e)
	{
	    e.printStackTrace();
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    /**
     * fill Custom and Default Tag Dropdown
     * 
     * @return
     */
    public String fillMappingtCustomDefaultTagTagsDropDown()
    {
	try
	{
	    ALRT_TAGS_DEFVO alrtTagsDefVO;
	    alrtTagsCOList = new ArrayList<ALRT_TAGS_DEFVO>();
	    individualEventSC.setNbRec(-1);
	    // individualEventCO.setTagDescription("Select Tag");
	    if("B".equals(individualEventSC.getEventType()))
	    {
		alrtTagsDefVO = new ALRT_TAGS_DEFVO();
		alrtTagsDefVO.setTAG_NAME("Comp Code");
		alrtTagsDefVO.setTAG_DESCRIPTION("Company Description");
		alrtTagsCOList.add(0, alrtTagsDefVO);
		alrtTagsDefVO = new ALRT_TAGS_DEFVO();
		alrtTagsDefVO.setTAG_NAME("Sys Date");
		alrtTagsDefVO.setTAG_DESCRIPTION("System Date");
		alrtTagsCOList.add(1, alrtTagsDefVO);
	    }
	    else
	    {
		alrtTagsCOList.addAll(individualEventBO.returnIndEventCustomDefaultTagList(individualEventSC));
	    }
	    // alrtTagsCOList.add(0,individualEventCO);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    /**
     * check Event Description Unique
     * 
     * @return
     */
    public String checkEventDescriptionUnique()
    {
	try
	{
	    Integer rows = individualEventBO.returnCheckIsUniqueEventDescription(individualEventSC);
	    if(rows >= 1)
	    {
		isEventDescriptionExist = "true";
	    }
	    else
	    {
		isEventDescriptionExist = "false";
	    }
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	}
	return SUCCESS;
    }

    /**
     * function that save/updates the subscriber
     * 
     * @return
     */
    public String save()
    {
	try
	{
	    fillSessionData();
	    /**
	     * call the business layer ...
	     */

	    // fill audit
	    fillAudit();

	    // retrieve Email Mapping Params
	    ALRT_EVT_COMM_MODEVO email_EVT_COMM_MODEVO = individualEventCO.getEmail_EVT_COMM_MODEVO();
	    if(email_EVT_COMM_MODEVO.getTEMPLATE_TYPE().equals("S"))
	    {
		if(StringUtil.isNotEmpty(individualEventCO.getEmailQueryParameterListJson()))
		{
		    GridUpdates gu = getGridUpdates(individualEventCO.getEmailQueryParameterListJson(),
			    ALRT_EVT_COMM_MODE_ARG_MAPVO.class, true);
		    individualEventCO.setAllQueryMappingParameterList(gu.getLstAllRec());
		}
	    }
	    else
	    {
		if(StringUtil.isNotEmpty(individualEventCO.getEmailReportParameterListJson()))
		{
		    // return email report mapping parameters
		    GridUpdates gu = getGridUpdates(individualEventCO.getEmailReportParameterListJson(),
			    ALRT_EVT_COMM_MODE_ARG_MAPVO.class, true);
		    individualEventCO.setAllReportMappingParameterList(gu.getLstAllRec());

		    // return email query mapping parameters
		    if(StringUtil.isNotEmpty(individualEventCO.getEmailQueryParameterListJson()))
		    {
			gu = getGridUpdates(individualEventCO.getEmailQueryParameterListJson(),
				ALRT_EVT_COMM_MODE_ARG_MAPVO.class, true);
			individualEventCO.setAllQueryMappingParameterList(gu.getLstAllRec());
		    }
		}
	    }

	    // retrieve Sms Mapping Params
	    if(StringUtil.isNotEmpty(individualEventCO.getSmsQueryParameterListJson()))
	    {
		GridUpdates gu = getGridUpdates(individualEventCO.getSmsQueryParameterListJson(),
			ALRT_EVT_COMM_MODE_ARG_MAPVO.class, true);
		individualEventCO.setAllSmsQueryMappingParameterList(gu.getLstAllRec());
	    }

	    // retrieve Omni Inbox Mapping Params
	    if(StringUtil.isNotEmpty(individualEventCO.getOmniInboxQueryParameterListJson()))
	    {
		GridUpdates gu = getGridUpdates(individualEventCO.getOmniInboxQueryParameterListJson(),
			ALRT_EVT_COMM_MODE_ARG_MAPVO.class, true);
		individualEventCO.setAllOmniInboxQueryMappingParameterList(gu.getLstAllRec());
	    }

	    // parse new Email Custom tags and set into CO
	    if(StringUtil.isNotEmpty(individualEventCO.getEventStatiEmailNewCustomTagsHidden()))
	    {
		GridUpdates gu = getGridUpdates(individualEventCO.getEventStatiEmailNewCustomTagsHidden(),
			ALRT_TAGS_DEFVO.class);
		individualEventCO.setNewEmailCustomTagList(gu.getLstAdd());
		individualEventCO.setDeleteEmailCustomTagList(gu.getLstDelete());
	    }

	    // parse batch
	    if(StringUtil.isNotEmpty(individualEventCO.getBatchQueryParameterListJson()))
	    {
		GridUpdates gu = getGridUpdates(individualEventCO.getBatchQueryParameterListJson(),
			ALRT_EVT_BATCH_ARG_MAPVO.class, true);
		individualEventCO.setNewBatchCustomTagList(gu.getLstAllRec());
	    }

	    /**
	     * Prepare Fixed Events Details
	     */
	    prepareFixedEventList(individualEventCO);

	    // retrieve Report Attach Parameters
	    retrieveReportAttachmentAndParameters();

	    individualEventCO = individualEventBO.save(individualEventCO);
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	}
	return "save";
    }

    /**
     * prepare the Fixed Event List
     * 
     * @param individualEventCO2
     */
    private void prepareFixedEventList(IndividualEventCO individualEventCO)
    {
	// fixed event
	if(AlertConstant.TYPE_EVT_F.equals(individualEventCO.getAlrtEvtVO().getEVT_TYPE()) && (NumberUtil
		.nullToZero(individualEventCO.getAlrtEvtVO().getFIXED_EVENT_ID()).compareTo(BigDecimal.ZERO)) != 0)
	{
	    GridUpdates gridData1 = getGridUpdates(individualEventCO.getFixedParamList(), IndFixedParamListCO.class,
		    true);
	    individualEventCO.setParamList(gridData1.getLstAllRec());
	}
    }

    /**
     * retrieve data from submitted parameter json and convert to List of vos
     */
    private void retrieveReportAttachmentAndParameters()
    {
	// retrieve Email Report Attachment Mapping Params
	if(individualEventCO.getEmailReportAttachementParameterArray() != null
		&& individualEventCO.getEmailReportAttachementParameterArray().length > 0)
	{
	    for(int i = 0; i < individualEventCO.getEmailReportAttachementParameterArray().length; i++)
	    {
		if(StringUtil.isNotEmpty(individualEventCO.getEmailReportAttachementParameterArray()[i]))
		{
		    GridUpdates gu = getGridUpdates(individualEventCO.getEmailReportAttachementParameterArray()[i],
			    ALRT_EVT_COMM_MODE_ARG_MAPVO.class, true);
		    individualEventCO.getAlrt_EVT_COMM_MODE_ARG_MAPVOs().put("emailRA_" + i, gu.getLstAllRec());
		}
	    }
	}

	// retrieve Omni Inbox Report Attachment Mapping Params
	if(individualEventCO.getOmniReportAttachementParameterArray() != null
		&& individualEventCO.getOmniReportAttachementParameterArray().length > 0)
	{
	    for(int i = 0; i < individualEventCO.getOmniReportAttachementParameterArray().length; i++)
	    {
		if(StringUtil.isNotEmpty(individualEventCO.getOmniReportAttachementParameterArray()[i]))
		{
		    GridUpdates gu = getGridUpdates(individualEventCO.getOmniReportAttachementParameterArray()[i],
			    ALRT_EVT_COMM_MODE_ARG_MAPVO.class, true);
		    individualEventCO.getAlrt_EVT_COMM_MODE_ARG_MAPVOs().put("omniInboxRA_" + i, gu.getLstAllRec());
		}
	    }
	}
    }

    /**
     * edit Ind Event Record
     * 
     * @return
     */
    public String edit()
    {
	String returnScreen = "individualEventMaint";
	try
	{

	    // fill session data
	    fillSessionData();
	    individualEventSC.setLovType(AlertConstant.EVENT_STATUS_LOV_TYPE);

	    individualEventSC.setEmailCommunicationType(IndividualEventConstant.EMAIL_COMMUNICATION_TYPE);
	    individualEventSC.setSmsCommunicationType(IndividualEventConstant.SMS_COMMUNICATION_TYPE);
	    individualEventSC.setOmniInboxCommunicationType(IndividualEventConstant.OMNI_INBOX_COMMUNICATION_TYPE);

	    // return EventCo by event Id
	    individualEventCO = individualEventBO.returnIndividualEventByEventId(individualEventSC);

	    // fill all dropdowns
	    fillDropDown();

	    if(AlertConstant.CRUD_P.equals(getIv_crud()) || AlertConstant.CRUD_S.equals(getIv_crud())
		    || AlertConstant.CRUD_RA.equals(getIv_crud()))
	    {
		set_recReadOnly(ConstantsCommon.TRUE);
	    }
	    else if((AlertConstant.STATUS_DELETED).equals(individualEventCO.getAlrtEvtVO().getSTATUS()))
	    {
		set_recReadOnly(ConstantsCommon.TRUE);
	    }
	    else if((AlertConstant.STATUS_ACTIVE.equals(individualEventCO.getAlrtEvtVO().getSTATUS())
		    && AlertConstant.CRUD_R.equals(getIv_crud()))
		    || AlertConstant.CRUD_RA.equals(individualEventCO.getAlrtEvtVO().getSTATUS())
		    || AlertConstant.CRUD_F.equals(getIv_crud()))
	    {
		set_recReadOnly(ConstantsCommon.FALSE);
	    }
	    else
	    {
		set_recReadOnly(ConstantsCommon.TRUE);
	    }

	    // Hide and show Body Text are for email
	    HashMap<String, SYS_PARAM_SCREEN_DISPLAYVO> hm = new HashMap<String, SYS_PARAM_SCREEN_DISPLAYVO>();
	    SYS_PARAM_SCREEN_DISPLAYVO emailTextAreaBuisnessElement = new SYS_PARAM_SCREEN_DISPLAYVO();
	    SYS_PARAM_SCREEN_DISPLAYVO queryParamTextAreaBuisnessElement = new SYS_PARAM_SCREEN_DISPLAYVO();
	    SYS_PARAM_SCREEN_DISPLAYVO eventTypeParamTextAreaBuisnessElement = new SYS_PARAM_SCREEN_DISPLAYVO();
	    SYS_PARAM_SCREEN_DISPLAYVO smsTexttAreaBuisnessElement = new SYS_PARAM_SCREEN_DISPLAYVO();
	    eventTypeParamTextAreaBuisnessElement.setIS_READONLY(BigDecimal.ONE);

	    if(individualEventCO.getEmail_EVT_COMM_MODEVO() != null
		    && individualEventCO.getEmail_EVT_COMM_MODEVO().getREPORT_ID() != null && !individualEventCO
			    .getEmail_EVT_COMM_MODEVO().getREPORT_ID().equals(ConstantsCommon.EMPTY_BIGDECIMAL_VALUE))
	    {
		emailTextAreaBuisnessElement.setIS_READONLY(BigDecimal.ONE);
		queryParamTextAreaBuisnessElement.setIS_READONLY(BigDecimal.ONE);
	    }
	    else
	    {
		emailTextAreaBuisnessElement.setIS_READONLY(BigDecimal.ZERO);
		queryParamTextAreaBuisnessElement.setIS_READONLY(BigDecimal.ZERO);
	    }

	    if(individualEventCO.getSms_EVT_COMM_MODEVO() != null
		    && StringUtil.isNotEmpty(individualEventCO.getSms_EVT_COMM_MODEVO().getDEFAULT_MESSAGE_BODY()))
	    {
		if(individualEventCO.getSms_EVT_COMM_MODEVO().getDEFAULT_MESSAGE_BODY().length() > 160)
		{
		    smsTexttAreaBuisnessElement.setMAX_LENGTH(new BigDecimal(4000));
		    hm.put("eventStaticSmsMessageBodyEng", smsTexttAreaBuisnessElement);
		}
	    }

	    // Email Body Textarea disable while select report
	    hm.put("eventStaticEmailMessageBodyEng", emailTextAreaBuisnessElement);
	    // hm.put("lookuptxt_eventStaticEmailQueryId",
	    // queryTextAreaBuisnessElement);
	    hm.put("eventStaticEmailQueryParameterButton", queryParamTextAreaBuisnessElement);
	    // event type select disable while dbclick the record
	    hm.put("eventType", eventTypeParamTextAreaBuisnessElement);
	    setAdditionalScreenParams(hm);

	    /**
	     * Prepare hashmap of ids and values
	     */
	    HashMap<String, Object> map = new HashMap<String, Object>();
	    map.put("skipSubscription", individualEventCO.getAlrtEvtVO().getEVT_TYPE());
	    map.put("imalUserExpression", individualEventCO.getAlrt_EVT_COMM_INTRNLVO().getSENDER_USR_ID());
	    map.put("applicationExpression", individualEventCO.getAlrt_EVT_COMM_INTRNLVO().getAPP_NAME());
	    map.put("branchExpression", individualEventCO.getAlrt_EVT_COMM_INTRNLVO().getBRANCH_CODE());
	    map.put("companyExpression", individualEventCO.getAlrt_EVT_COMM_INTRNLVO().getCOMP_CODE());
	    individualEventCO.setScreenDisplaySeting(map);
	    setAdditionalScreenParams(individualEventBO.applySysParamSettings(individualEventCO).getElementMap());
	    
	    // apply retrieve Audit
	    applyRetrieveAudit(AuditConstant.ALERT_EVENT_KEY_REF, individualEventCO.getAlrtEvtVO(),
		    individualEventCO.getAlrtEvtVO());

	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return returnScreen;
    }

    /**
     * delete Ind Event Record
     * 
     * @return
     */
    public String delete()
    {
	try
	{
	    // fill session data
	    fillSessionData();

	    // fill Audit data
	    fillAudit();

	    individualEventCO = individualEventBO.delete(individualEventCO);
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	}
	return "delete";
    }

    /**
     * 
     * @return
     */
    public String expressionShowHideData()
    {
	try
	{
	    StringBuffer expressionStr = new StringBuffer("");
	    // StringBuffer alertTagsStr = new StringBuffer("");
	    StringBuffer finalStr = new StringBuffer("");

	    SessionCO sessionCO = returnSessionObject();

	    // fill ExpressionType Drop Down
	    SelectSC expressionTypeSC = new SelectSC(IndividualEventConstant.EXPRESSION_LOV_TYPE);
	    expressionTypeSC.setLanguage(sessionCO.getLanguage());
	    expressionTypeSC.setOrderCriteria("ORDER");
	    expressionTypeSC.setLovCodesExclude(
		    "'first','last','avg','sum','max','min','like','comulativesum','distinct','all','for'");
	    expressionOptionList = returnLOV(expressionTypeSC);
	    for(int i = 0; i < expressionOptionList.size(); i++)
	    {
		expressionStr.append(expressionOptionList.get(i).getDescValue() + "$");
		// expressionStr.append(expressionOptionList.get(i).getDescValue().replaceAll(",",
		// ";") + ",");
	    }

	    /**
	     * Added sqlResult Menually Later on it will move to db level and
	     * add the script
	     */
	    expressionStr.append("sqlResult(stringSqlSyntax)" + "$");

	    finalStr.append(expressionStr);

	    update = finalStr.toString();
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	}
	return SUCCESS;
    }

    /**
     * @description function to approve a record
     * @return
     */
    public String approve()
    {
	// SessionCO sessionCO = returnSessionObject();

	try
	{
	    fillSessionData();
	    AuditRefCO refCO = initAuditRefCO();
	    refCO.setOperationType(AuditConstant.UPDATE);
	    refCO.setKeyRef(AuditConstant.ALERT_EVENT_KEY_REF);
	    // validate if user is allowed to take this action
	    validateMakerChecker(individualEventCO);
	    individualEventCO.setAuditRefCO(refCO);
	    individualEventCO.setAuditObj(returnAuditObject(individualEventCO.getClass()));

	    /**
	     * Prepare Fixed Events Details
	     */
	    prepareFixedEventList(individualEventCO);

	    individualEventBO.approveRecord(individualEventCO, individualEventSC.getLanguage(),
		    individualEventSC.getUserName());
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}

	return SUCCESS;
    }

    /**
     * used to Validate Maker checker
     * 
     * @param IndividualEventCO
     * @throws BaseException
     */
    private void validateMakerChecker(IndividualEventCO individualEventCO) throws BaseException
    {
	int result = returnCommonLibBO().validateMakerChecker(individualEventCO.getAlrtEvtVO().getCREATED_BY(),
		individualEventCO.getAlrtEvtVO().getMODIFIED_BY(), individualEventCO.getUserID());
	if(result > 0)
	{
	    throw new BOException(result);
	}
    }

    /**
     * @description function to prepare an event for suspension
     * @return
     */
    public String toSuspend()
    {
	try
	{
	    fillSessionData();
	    String ivCrud = getIv_crud();

	    /**
	     * Prepare Fixed Events Details
	     */
	    prepareFixedEventList(individualEventCO);

	    individualEventBO.toSuspend(individualEventCO);
	    set_recReadOnly(ConstantsCommon.TRUE);
	    setIv_crud(ivCrud);
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	}
	return SUCCESS;
    }

    /**
     * @description function to suspend and event after being marked to be
     *              suspended
     * @return
     */
    public String suspend()
    {
	try
	{
	    fillSessionData();
	    // String ivCrud = getIv_crud();
	    AuditRefCO refCO = initAuditRefCO();
	    refCO.setOperationType(AuditConstant.UPDATE);
	    refCO.setKeyRef(AuditConstant.ALERT_EVENT_KEY_REF);
	    individualEventCO.setAuditRefCO(refCO);
	    individualEventCO.setAuditObj(returnAuditObject(individualEventCO.getClass()));

	    // validate if user is allowed to take this action
	    int result = returnCommonLibBO().validateMakerChecker(
		    individualEventCO.getAlrtEvtVO().getTOBE_SUSPENDED_BY(), null, individualEventCO.getUserID());
	    if(result > 0)
	    {
		throw new BOException(result);
	    }

	    /**
	     * Prepare Fixed Events Details
	     */
	    prepareFixedEventList(individualEventCO);

	    individualEventBO.suspend(individualEventCO);
	    ALRT_EVTVO alrtEvtVO = new ALRT_EVTVO();
	    individualEventCO.setAlrtEvtVO(alrtEvtVO);
	    set_recReadOnly(ConstantsCommon.TRUE);
	    setIv_crud(getIv_crud());
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	}
	return SUCCESS;
    }

    /**
     * @description function to mark a suspended event for reactivate
     * @return
     */
    public String toReactivate()
    {
	try
	{
	    fillSessionData();
	    // String ivCrud = getIv_crud();

	    /**
	     * Prepare Fixed Events Details
	     */
	    prepareFixedEventList(individualEventCO);

	    individualEventBO.toReactivate(individualEventCO);
	    set_recReadOnly(ConstantsCommon.TRUE);
	    setIv_crud(getIv_crud());

	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	}
	return SUCCESS;
    }

    /**
     * @description function to reactivate a marked suspened record
     * @return
     */
    public String reactivate()
    {
	try
	{
	    fillSessionData();

	    // String ivCrud = getIv_crud();
	    ALRT_EVTVO alrtEvtVO = individualEventCO.getAlrtEvtVO();
	    alrtEvtVO.setREACTIVATED_BY(individualEventCO.getUserID());
	    alrtEvtVO.setDATE_REACTIVATED(individualEventCO.getRunningDate());
	    alrtEvtVO.setSTATUS(AlertConstant.STATUS_APPROVED);
	    AuditRefCO refCO = initAuditRefCO();
	    refCO.setOperationType(AuditConstant.UPDATE);
	    refCO.setKeyRef(AuditConstant.ALERT_EVENT_KEY_REF);
	    // validate if user is allowed to take this action
	    int result = returnCommonLibBO().validateMakerChecker(alrtEvtVO.getTOBE_REACTIVATED_BY(), null,
		    individualEventCO.getUserID());
	    if(result > 0)
	    {
		throw new BOException(result);
	    }
	    individualEventCO.setAuditRefCO(refCO);
	    individualEventCO.setAuditObj(returnAuditObject(individualEventCO.getClass()));

	    /**
	     * Prepare Fixed Events Details
	     */
	    prepareFixedEventList(individualEventCO);

	    individualEventBO.reactivate(individualEventCO);
	    alrtEvtVO = new ALRT_EVTVO();
	    individualEventCO.setAlrtEvtVO(alrtEvtVO);
	    set_recReadOnly(ConstantsCommon.TRUE);
	    setIv_crud(getIv_crud());
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	}
	return SUCCESS;
    }

    /**
     * @description function to reject a suspended or reactivate record
     * @return
     */
    public String reject()
    {
	try
	{
	    String ivCrud = getIv_crud();

	    // fill session data
	    fillSessionData();

	    /**
	     * Prepare Fixed Events Details
	     */
	    prepareFixedEventList(individualEventCO);

	    individualEventBO.reject(individualEventCO);
	    set_recReadOnly(ConstantsCommon.TRUE);
	    setIv_crud(ivCrud);
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	}
	return SUCCESS;
    }

    /**
     * return attach report mapping arguments
     * 
     * @return
     */
    public String returnAttachReportMappingArguments()
    {
	try
	{
	    // fill session data
	    fillSessionData();

	    individualEventCO = individualEventBO.returnAttachReportMappingArgument(individualEventSC);
	}
	catch(Exception ex)
	{
	    handleException(ex, null, null);
	}
	return SUCCESS;
    }

    /**
     * fill session data in Co
     * 
     * @throws BaseException
     */
    private void fillSessionData() throws BaseException
    {
	SessionCO sessionCO = returnSessionObject();
	individualEventCO.setCompCode(sessionCO.getCompanyCode());
	individualEventCO.setBranchCode(sessionCO.getBranchCode());
	individualEventCO.setAppName(sessionCO.getCurrentAppName());
	individualEventCO.setProgRef(get_pageRef());
	individualEventCO.setUserID(sessionCO.getUserName());
	individualEventCO.setRunningDate(returnCommonLibBO().addSystemTimeToDate(sessionCO.getRunningDateRET()));
	individualEventSC.setLangCode(sessionCO.getLanguage());
	individualEventSC.setCompanyCode(sessionCO.getCompanyCode());
	individualEventSC.setCurrAppName(sessionCO.getCurrentAppName());
	individualEventSC.setBranchCode(sessionCO.getBranchCode());
	individualEventSC.setUserId(sessionCO.getUserName());
    }

    /**
     * fill Audit in Co
     * 
     * @param status
     * @return
     */
    private AuditRefCO fillAudit()
    {
	AuditRefCO refCO = initAuditRefCO();
	try
	{
	    refCO.setKeyRef(AuditConstant.ALERT_EVENT_KEY_REF);
	    if(!(ConstantsCommon.EMPTY_BIGDECIMAL_VALUE).equals(individualEventCO.getAlrtEvtVO().getEVT_ID()))
	    {
		ALRT_EVTVO oldAlrt_EVTVO = (ALRT_EVTVO) returnAuditObject(ALRT_EVTVO.class);
		individualEventCO.setAuditObj(oldAlrt_EVTVO);
		refCO.setOperationType(AuditConstant.UPDATE);
	    }
	    else
	    {
		refCO.setOperationType(AuditConstant.CREATED);
	    }

	    individualEventCO.setAuditRefCO(refCO);
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}

	return refCO;
    }

    /**
     * open Custom Expression Dialog
     * 
     * @return String
     */
    public String openCustomExpressionDialog()
    {
	if(AlertConstant.CRUD_P.equals(getIv_crud()) || AlertConstant.CRUD_S.equals(getIv_crud())
		|| AlertConstant.CRUD_RA.equals(getIv_crud()))
	{
	    set_recReadOnly(ConstantsCommon.TRUE);
	}
	else if((AlertConstant.STATUS_DELETED).equals(individualEventCO.getAlrtEvtVO().getSTATUS()))
	{
	    set_recReadOnly(ConstantsCommon.TRUE);
	}
	else if((AlertConstant.STATUS_ACTIVE.equals(individualEventCO.getAlrtEvtVO().getSTATUS())
		|| StringUtil.isEmptyString(individualEventCO.getAlrtEvtVO().getSTATUS())
			&& AlertConstant.CRUD_R.equals(getIv_crud()))
		|| AlertConstant.CRUD_RA.equals(individualEventCO.getAlrtEvtVO().getSTATUS())
		|| AlertConstant.CRUD_F.equals(getIv_crud()))
	{
	    set_recReadOnly(ConstantsCommon.FALSE);
	}
	else
	{
	    set_recReadOnly(ConstantsCommon.TRUE);
	}

	return "individualFixedEventCustomExpressionDialog";
    }

    /**
     * 
     * @return
     */
    public String returnReportAttachmentRow()
    {
	individualEventReportAttachmentCO.setReportAttachmentStatus(IndividualEventConstant.REPORT_ATTACH_STATUS_NEW);
	if(individualEventSC.getCommType().equals("Email"))
	{
	    return "emailReportAttachment";
	}
	else if(individualEventSC.getCommType().equals("OmniInbox"))
	{
	    return "oiReportAttachment";
	}
	return "reportAttachment";
    }

    /**
     * Start Getter/Setter Methods
     */
    public String getIv_crud()
    {
	return iv_crud;
    }

    public void setIv_crud(String iv_crud)
    {
	this.iv_crud = iv_crud;
    }

    public IndividualEventSC getIndividualEventSC()
    {
	return individualEventSC;
    }

    public void setIndividualEventSC(IndividualEventSC individualEventSC)
    {
	this.individualEventSC = individualEventSC;
    }

    public void setIndividualEventBO(IndividualEventBO individualEventBO)
    {
	this.individualEventBO = individualEventBO;
    }

    public IndividualEventCO getIndividualEventCO()
    {
	return individualEventCO;
    }

    public void setIndividualEventCO(IndividualEventCO individualEventCO)
    {
	this.individualEventCO = individualEventCO;
    }

    public List<SelectCO> getMessageBodyByList()
    {
	return messageBodyByList;
    }

    public void setMessageBodyByList(List<SelectCO> messageBodyByList)
    {
	this.messageBodyByList = messageBodyByList;
    }

    public List<SelectCO> getSubscriberTypeOptionList()
    {
	return subscriberTypeOptionList;
    }

    public void setSubscriberTypeOptionList(List<SelectCO> subscriberTypeOptionList)
    {
	this.subscriberTypeOptionList = subscriberTypeOptionList;
    }

    public List<SelectCO> getOtherLanguageTypeList()
    {
	return otherLanguageTypeList;
    }

    public void setOtherLanguageTypeList(List<SelectCO> otherLanguageTypeList)
    {
	this.otherLanguageTypeList = otherLanguageTypeList;
    }

    public List<SelectCO> getEventTypeList()
    {
	return eventTypeList;
    }

    public void setEventTypeList(List<SelectCO> eventTypeList)
    {
	this.eventTypeList = eventTypeList;
    }

    public String getIsEventDescriptionExist()
    {
	return isEventDescriptionExist;
    }

    public void setIsEventDescriptionExist(String isEventDescriptionExist)
    {
	this.isEventDescriptionExist = isEventDescriptionExist;
    }

    public List<SelectCO> getBatchTypeQueryOptionList()
    {
	return batchTypeQueryOptionList;
    }

    public void setBatchTypeQueryOptionList(List<SelectCO> batchTypeQueryOptionList)
    {
	this.batchTypeQueryOptionList = batchTypeQueryOptionList;
    }

    public List<SelectCO> getExpressionOptionList()
    {
	return expressionOptionList;
    }

    public void setExpressionOptionList(List<SelectCO> expressionOptionList)
    {
	this.expressionOptionList = expressionOptionList;
    }

    public String getUpdate()
    {
	return update;
    }

    public void setUpdate(String update)
    {
	this.update = update;
    }

    public List<SelectCO> getSourceOfContact()
    {
	return sourceOfContact;
    }

    public void setSourceOfContact(List<SelectCO> sourceOfContact)
    {
	this.sourceOfContact = sourceOfContact;
    }

    public List<SelectCO> getFixedEventTypeList()
    {
	return fixedEventTypeList;
    }

    public void setFixedEventTypeList(List<SelectCO> fixedEventTypeList)
    {
	this.fixedEventTypeList = fixedEventTypeList;
    }

    public IndividualEventReportAttachmentCO getIndividualEventReportAttachmentCO()
    {
	return individualEventReportAttachmentCO;
    }

    public void setIndividualEventReportAttachmentCO(
	    IndividualEventReportAttachmentCO individualEventReportAttachmentCO)
    {
	this.individualEventReportAttachmentCO = individualEventReportAttachmentCO;
    }

    public String loadRelatedParamForm()
    {
	// String returnScreen = "alrtFixedParam";
	try
	{
	    if(AlertConstant.CRUD_P.equals(getIv_crud()) || AlertConstant.CRUD_S.equals(getIv_crud())
		    || AlertConstant.CRUD_RA.equals(getIv_crud()))
	    {
		set_recReadOnly(ConstantsCommon.TRUE);
	    }
	    else if((AlertConstant.STATUS_DELETED).equals(individualEventCO.getAlrtEvtVO().getSTATUS()))
	    {
		set_recReadOnly(ConstantsCommon.TRUE);
	    }
	    else if((AlertConstant.STATUS_ACTIVE.equals(individualEventCO.getAlrtEvtVO().getSTATUS())
		    && AlertConstant.CRUD_R.equals(getIv_crud()))
		    || AlertConstant.CRUD_RA.equals(individualEventCO.getAlrtEvtVO().getSTATUS())
		    || AlertConstant.CRUD_F.equals(getIv_crud())
		    || StringUtil.isEmptyString(individualEventCO.getAlrtEvtVO().getSTATUS()))
	    {
		set_recReadOnly(ConstantsCommon.FALSE);
	    }
	    else
	    {
		set_recReadOnly(ConstantsCommon.TRUE);
	    }
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	    return ERROR_ACTION;
	}
	return "alrtFixedParam";
    }

    public List<ALRT_TAGS_DEFVO> getAlrtTagsCOList()
    {
	return alrtTagsCOList;
    }

    public void setAlrtTagsCOList(List<ALRT_TAGS_DEFVO> alrtTagsCOList)
    {
	this.alrtTagsCOList = alrtTagsCOList;
    }

    public String openOtherLangDetails() throws Exception
    {
	return "openOtherLangDetailsPopup";
    }

    /**
     * open parameter mapping
     * 
     * @return String
     */
    public String returnIndividualEventQueryParamDialog()
    {
	return "individualEventQueryParamDialog";
    }

    /**
     * open Report Attachments
     * 
     * @return String
     */
    public String returnIndividualEventReportAttachmentDialog()
    {
	return "indEventReportAttachmentDialog";
    }

    /**
     * validate Fixed Events Values
     * 
     * @param individualEventCO
     * @return
     */
    public String validateFixedEventValue()
    {
	try
	{
	    individualEventCO = individualEventBO.validateFixedEventValue(individualEventCO);
	}
	catch(BaseException e)
	{
	    individualEventCO.getIndFixedParamListCO().setPARAM_VALUE("");
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

    /**
     * Display Field by Event Type
     * 
     * @return
     */
    public String applyDisplaySettingFields()
    {
	try
	{
	    /**
	     * Prepare hashmap of ids and values
	     */
	    HashMap<String, Object> map = new HashMap<String, Object>();
	    map.put("skipSubscription", individualEventCO.getAlrtEvtVO().getEVT_TYPE());
	    individualEventCO.setScreenDisplaySeting(map);
	    
	    setAdditionalScreenParams(individualEventBO.applySysParamSettings(individualEventCO).getElementMap());
	}
	catch(Exception e)
	{
	    handleException(e, null, null);
	}
	return SUCCESS;
    }

}
