//
//  QYZJURLDefineTool.m
//  QYZJAPP
//
//  Created by zk on 2019/11/1.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJURLDefineTool.h"



@implementation QYZJURLDefineTool

/**上传文件*/
+ (NSString * )upload_file_to_qiniuURL {
    
    return [NSString stringWithFormat:@"%@%@",URLOne,@"upload_file_to_qiniu"];
}
/** 登录 */
+ (NSString * )app_loginURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_login"];
}
/**第三方登录 */
+ (NSString * )user_bindingThreeURL{
      return [NSString stringWithFormat:@"%@%@",URLOne,@"user_bindingThree"];
}

/** 上传推送token */
+(NSString *)user_upUmengURL{
      return [NSString stringWithFormat:@"%@%@",URLOne,@"user_upUmeng"];
}
/**  修改用户资料 */
+ (NSString * )user_editUserInfoURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_editUserInfo"];
}
/** 修改密码 */
+ (NSString * )user_editLoginPasswordURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_editLoginPassword"];
}
///** 退出登录 */
+ (NSString * )user_app_logoutURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_logout"];
}
/** 获取个人信息 */
+ (NSString * )user_personInfoURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_personInfo"];
}
/** 发送验证码*/
+ (NSString * )app_sendVerificationCodeURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_sendVerificationCode"];
}
/** 验证码验证 */
+ (NSString * )app_validateCodeURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_validateCode"];
}
/** 注册 */
+ (NSString * )app_registerURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_register"];
}
/**三方登录*/
+ (NSString * )app_thirdLoginURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_thirdLogin"];
}
/**三方登录绑定手机号*/
+ (NSString * )app_thirdLoginBindPhoneURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_thirdLoginBindPhone"];
}
/** 注册引导 */
+ (NSString * )app_addInterestURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_addInterest"];
}
/** 用户协议 */
+ (NSString * )app_getBaseInfoURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_getBaseInfo"];
}
/**兴趣列表*/
+ (NSString * )app_interestURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_interest"];
}
/** 忘记密码*/
+ (NSString * )app_forgetPasswordURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_forgetPassword"];
}
/** 医院列表*/
+ (NSString * )app_findInstitutionListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_findInstitutionList"];
}
/** 医生列表 */
+ (NSString * )app_findDoctorListURL {
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_findDoctorList"];
}
/** 医院主页*/
+ (NSString * )app_getInstitutionIndexPageURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_getInstitutionIndexPage"];
}
/** 医院概况*/
+ (NSString * )user_getInstitutionDetailURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_getInstitutionDetail"];
}
/** 医院下的医生列表 */
+ (NSString * )app_findDoctorUnderInstitutionURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_findDoctorUnderInstitution"];
}
/** 医生详情 */
+ (NSString * )user_getDoctorIndexPageURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_getDoctorIndexPage"];
}
/** 项目列表*/
+ (NSString * )app_findAllRecommendProjectListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_findAllRecommendProjectList"];
}
/** 医院下的所有项目*/
+ (NSString * )app_getAllProjectURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_getAllProject"];
}
/**项目详情 */
+ (NSString * )app_getProjectDetailURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_getProjectDetail"];
}
/** 机构词典*/
+(NSString *)app_findInstitutionDictionaryURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_findInstitutionDictionary"];
}
/** 地区列表 */
+(NSString *)app_findAreaListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_findAreaList"];
}
/** 文章列表 */
+(NSString *)user_findArticleListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_findArticleList"];
}
/**文章详情*/
+(NSString *)user_getArticleDetailURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_getArticleDetail"];
}

/** 文章评论*/
+ (NSString * )user_doArticleCommentURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_doArticleComment"];
}
/** 首页数据*/
+ (NSString * )user_findIndexDataURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_findIndexData"];
}
/**体重记录*/
+ (NSString * )user_findWeightRecordListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_findWeightRecordList"];
}
/** 记录体重 */
+ (NSString * )user_recordWeightURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_recordWeight"];
}

/**心率记录表*/
+ (NSString * )user_findRecordheartrateURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_findRecordheartrate"];
}
/**心率记录*/
+ (NSString * )user_recordHeartrateURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_recordHeartrate"];
}

/**血压记录表*/
+ (NSString * )user_findRecordBloodpressureURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_findRecordBloodpressure"];
}
/**血压记录*/
+ (NSString * )user_recordBloodpressureURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_recordBloodpressure"];
}

 /*步数记录表*/
+ (NSString * )user_findRecordStepnumberURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_findRecordStepnumber"];
}
/**步数记录*/
+ (NSString * )user_recordStepnumberURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_recordStepnumber"];
}


/**经期记录*/
+ (NSString * )user_recordMenstrualURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_recordMenstrual"];
}

/** 健康日志列表*/
+ (NSString * )user_findAllDoctorAppointmentListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_findAllDoctorAppointmentList"];
}
/** 用户问诊详情*/
+ (NSString * )user_findAllVoiceDetailListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_findAllVoiceDetailList"];
}
/**健康日志隐私*/
+(NSString *)user_getVoiceDetailPrivacyURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_getVoiceDetailPrivacy"];
}

/** 预约医生*/
+(NSString *)user_findAppointDoctorsURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_findAppointDoctors"];
}

/** 选择隐私等级*/
+(NSString *)user_setVoiceDetailPrivacyURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"user_setVoiceDetailPrivacy"];
}

/** 预约机构*/
+(NSString *)user_findAppointedInstitutionsURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_findAppointedInstitutions"];
}
/** 系统消息*/
+(NSString *)user_findSystemMessageURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_findSystemMessage"];
}
/** 医生搜索*/
+(NSString *)user_searchDoctorsURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_searchDoctors"];
}
/** 聊天记录*/
+(NSString *)user_findSessionsURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_findSessions"];
}

/** 问诊消息*/
+(NSString *)user_inquiryMessageURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_inquiryMessage"];
}


/*历史聊天记录*/
+(NSString *)user_findLogsURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_findLogs"];
}
/**发送消息*/
+(NSString *)user_sendLogURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_sendLog"];
}
/**近期搜索*/
+(NSString *)user_getRecentSearchURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_getRecentSearch"];
}
/**搜搜调理*/
+(NSString *)user_lookAfterSearchURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_lookAfterSearch"];
}
/**预约时间列表*/
+(NSString *)app_findDoctorScheduleURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"app_findDoctorSchedule"];
}
/*在线预约*/
+(NSString *)user_onlineAppointmentURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_onlineAppointment"];
}
/**取消预约*/
+(NSString *)user_cancelOnlineAppointmentURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_cancelOnlineAppointment"];
}
/**取消项目*/
+(NSString *)user_cancelOnlineAppointmentProjectURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_cancelOnlineAppointmentProject"];
}

/** 首页更多  condition 1 医生 2文章*/
+ (NSString * )user_moreDataURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_moreData"];
}
+ (NSString * )user_getCalenderDetailURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_getCalenderDetail"];
}

/**项目预约支付*/
+(NSString *)user_doProjectAppointmentURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_doProjectAppointment"];
}
/**项目退款*/
+(NSString *)user_refundProjectURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_refundProject"];
}
/*健康提醒*/
+(NSString *)user_HealRemindURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_HealRemind"];
}
/*日历详情*/
+(NSString *)user_getUserCalenderDetailURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_getUserCalenderDetail"];
}
/*添加日程*/
+(NSString *)user_doCalenderRecordURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_doCalenderRecord"];
}
/*日历*/
+(NSString *)user_findUserBriefCalenderURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_findUserBriefCalender"];
}
/** 删除案例*/
+(NSString *)user_deleteCaseURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_deleteCase"];
}

#pragma mark ----个人信息部分  -------
/*我的健康日志*/
+(NSString *)user_findMyDoctorAppointmentURL {
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_findMyDoctorAppointment"];
}

/*我的预约医生*/
+(NSString *)user_findMyAllDoctorAppointmentURL {
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_findMyAllDoctorAppointment"];
}

/*预约详情*/
+(NSString *)user_getMyDoctorAppointmentDetailURL {
   return [NSString stringWithFormat:@"%@%@",URLOne,@"user_getMyDoctorAppointmentDetail"];
}
/*预约详情*/
+(NSString *)user_logoutURL {
   return [NSString stringWithFormat:@"%@%@",URLOne,@"user_logout"];
}


/*我的预约项目*/
+(NSString *)user_findMyProjectAppointmentURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_findMyProjectAppointment"];
}
/*我的预约项目详情*/
+(NSString *)user_getProjectAppointmentDetailURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_getProjectAppointmentDetail"];
}
/*我的咨询*/
+(NSString *)user_findMyConsultURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_findMyConsult"];
}
/*去晚上健康信息*/
+(NSString *)user_saveHealthInfoURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_saveHealthInfo"];
}
/*健康信息*/
+(NSString *)user_getHealthInfoURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_getHealthInfo"];
}
/*个人信息*/
+(NSString *)user_getMyInfoURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_getMyInfo"];
}
/*查看健康档案*/
+(NSString *)user_getMyDoctorURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_getMyDoctor"];
}

/*身体健康数据*/
+(NSString *)user_healthDataURL {
      return [NSString stringWithFormat:@"%@%@",URLOne,@"user_healthData"];
}

/*取消预约*/
+(NSString *)user_applyForRefundURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"user_applyForRefund"];
}

/*文章收藏*/
+(NSString *)user_collectArticleURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_collectArticle"];
}
/*取消文章收藏*/
+(NSString *)user_delArticCollectionURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_delArticCollection"];
}
/*医生收藏*/
+(NSString *)user_collectDoctorURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_collectDoctor"];
}
/*取消医生收藏*/
+(NSString *)user_delDoctorCollectionURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_delDoctorCollection"];
}
/*机构收藏*/
+(NSString *)user_collectInstitutionURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_collectInstitution"];
}
/*取消机构收藏*/
+(NSString *)user_delInstitutionCollectionURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_delInstitutionCollection"];
}
/*我的收藏*/
+(NSString *)user_myCollectionURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_myCollection"];
}
/*删除最近搜索*/
+(NSString *)user_delRecentSearchURL {
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_delRecentSearch"];
}

/*配置*/
+(NSString *)app_iosURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"app_ios"];
}

/*操作日志*/
+(NSString *)user_markCalenderURL {
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_markCalender"];
}


//图片地址
+(NSString *)getImgURLWithStr:(NSString * )str{
    
    NSString * picStr = @"";

    if ([[NSString stringWithFormat:@"%@",str] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",str] isEqualToString:@"null"]) {
        return @"";
    }
    
    if (str) {
        if ([str hasPrefix:@"http:"] || [str hasPrefix:@"https:"]) {
            picStr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
        }else{
            picStr = [[NSString stringWithFormat:@"%@%@",QiNiuImgURL,str] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
        }
    }
    return picStr;

}

+(NSString *)getVideoURLWithStr:(NSString * )str {
   
    if ([[NSString stringWithFormat:@"%@",str] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",str] isEqualToString:@"null"]) {
          return @"";
      }
    
   NSString * picStr = @"";
    if (str) {
        if ([str hasPrefix:@"http:"] || [str hasPrefix:@"https:"]) {
            picStr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
        }else{
            picStr = [[NSString stringWithFormat:@"%@%@",QiNiuVideoURL,str] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
        }
    }
    return picStr;
    
}


@end
