//
//  QYZJURLDefineTool.h
//  QYZJAPP
//
//  Created by zk on 2019/11/1.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


//正式
//#define URLOne @"http://mobile.qunyanzhujia.com:8098/qyzj/"
//测试
//#define URLOne @"http://192.168.0.38/jkgl/"
#define URLOne @"http://47.101.212.182/jkgl/"

////图片地址
#define QiNiuImgURL @"http://web.qunyanzhujia.com/"
////视频地址地址
#define QiNiuVideoURL @"http://media.qunyanzhujia.com/"
//骑牛云的上传地址
#define QiNiuYunUploadURL @"http://upload.qiniup.com/"


////测试本地映射
//#define URL @"http://jgcbxt.natappfree.cc"
////图片映射
//#define ImgURL @"http://jgcbxt.natappfree.cc:80/upload"

@interface QYZJURLDefineTool : NSObject

/**上传文件*/
+ (NSString * )upload_file_to_qiniuURL;

/** 登录 */
+ (NSString * )app_loginURL;
/**第三方登录 */
+ (NSString * )user_bindingThreeURL;
/** 上传推送token */
+ (NSString * )user_upUmengURL;
/**  修改用户资料 */
+ (NSString * )user_editUserInfoURL;
/** 修改密码 */
+ (NSString * )user_editLoginPasswordURL;
///** 退出登录 */
+ (NSString * )user_logoutURL;
/** 获取个人信息 */
+ (NSString * )user_personInfoURL;
/** 发送验证码*/
+ (NSString * )app_sendVerificationCodeURL;
/** 验证码验证 */
+ (NSString * )app_validateCodeURL;
/** 注册 */
+ (NSString * )app_registerURL;
/**三方登录*/
+ (NSString * )app_thirdLoginURL;
/**三方登录绑定手机号*/
+ (NSString * )app_thirdLoginBindPhoneURL;
/** 注册引导 */
+ (NSString * )app_addInterestURL;
/** 用户协议 */
+ (NSString * )app_getBaseInfoURL;
/**兴趣列表*/
+ (NSString * )app_interestURL;
/** 忘记密码*/
+ (NSString * )app_forgetPasswordURL;
/** 医院列表*/
+ (NSString * )app_findInstitutionListURL;
/** 医生列表 */
+ (NSString * )app_findDoctorListURL;
/** 医院主页*/
+ (NSString * )app_getInstitutionIndexPageURL;
/** 医院概况*/
+ (NSString * )user_getInstitutionDetailURL;
/** 医院下的医生列表 */
+ (NSString * )app_findDoctorUnderInstitutionURL;
/** 医生详情 */
+ (NSString * )user_getDoctorIndexPageURL;
/** 项目列表*/
+ (NSString * )app_findAllRecommendProjectListURL;
/**项目详情 */
+ (NSString * )app_getProjectDetailURL;
/** 机构词典*/
+(NSString *)app_findInstitutionDictionaryURL;
/** 地区列表 */
+(NSString *)app_findAreaListURL;
/** 文章列表 */
+(NSString *)user_findArticleListURL;
/**文章详情*/
+(NSString *)user_getArticleDetailURL;
/** 文章评论*/
+ (NSString * )user_doArticleCommentURL;
/** 首页数据*/
+ (NSString * )user_findIndexDataURL;
/**体重记录表*/
+ (NSString * )user_findWeightRecordListURL;
/** 记录体重 */
+ (NSString * )user_recordWeightURL;
/**心率记录表*/
+ (NSString * )user_findRecordheartrateURL;
/**心率记录*/
+ (NSString * )user_recordHeartrateURL;
/**血压记录表*/
+ (NSString * )user_findRecordBloodpressureURL;
/**血压记录*/
+ (NSString * )user_recordBloodpressureURL;

 /*步数记录表*/
+ (NSString * )user_findRecordStepnumberURL;
/**步数记录*/
+ (NSString * )user_recordStepnumberURL;

/**经期记录*/
+ (NSString * )user_recordMenstrualURL;
/** 健康日志列表*/
+ (NSString * )user_findAllDoctorAppointmentListURL;


/*我的预约医生*/
+(NSString *)user_findMyAllDoctorAppointmentURL;
/** 健康日志*/
+(NSString *)user_findAppointDoctorsURL;
/** 用户问诊详情*/
+ (NSString * )user_findAllVoiceDetailListURL;
/**健康日志隐私*/
+(NSString *)user_getVoiceDetailPrivacyURL;

/** 选择隐私等级*/
+(NSString *)user_setVoiceDetailPrivacyURL;
/** 预约机构*/
+(NSString *)user_findAppointedInstitutionsURL;
/** 系统消息*/
+(NSString *)user_findSystemMessageURL;
/** 医生搜索*/
+(NSString *)user_searchDoctorsURL;
/** 聊天记录*/
+(NSString *)user_findSessionsURL;
/** 问诊消息*/
+(NSString *)user_inquiryMessageURL;
/*历史聊天记录*/
+(NSString *)user_findLogsURL;
/**发送消息*/
+(NSString *)user_sendLogURL;
/**近期搜索*/
+(NSString *)user_getRecentSearchURL;
/**搜搜调理*/
+(NSString *)user_lookAfterSearchURL;
/**预约时间列表*/
+(NSString *)app_findDoctorScheduleURL;
/*在线预约*/
+(NSString *)user_onlineAppointmentURL;
/**取消预约*/
+(NSString *)user_cancelOnlineAppointmentURL;
/**项目预约支付*/
+(NSString *)user_doProjectAppointmentURL;
/**项目退款*/
+(NSString *)user_refundProjectURL;
/*健康提醒*/
+(NSString *)user_HealRemindURL;
/*日历详情*/
+(NSString *)user_getUserCalenderDetailURL;
/*天机日程*/
+(NSString *)user_doCalenderRecordURL;
/*日历*/
+(NSString *)user_findUserBriefCalenderURL;
/*回复帖子*/
+(NSString *)app_articleCommentURL;

/**取消项目*/
+(NSString *)user_cancelOnlineAppointmentProjectURL;

#pragma mark ----个人信息部分  -------
/*我的医生预约*/
+(NSString *)user_findMyDoctorAppointmentURL;
/*预约详情*/
+(NSString *)user_getMyDoctorAppointmentDetailURL;
/*我的预约项目*/
+(NSString *)user_findMyProjectAppointmentURL;
/*我的预约项目详情*/
+(NSString *)user_getProjectAppointmentDetailURL;
/*我的咨询*/
+(NSString *)user_findMyConsultURL;
/*去晚上健康信息*/
+(NSString *)user_saveHealthInfoURL;
/*健康信息*/
+(NSString *)user_getHealthInfoURL;
/*个人信息*/
+(NSString *)user_getMyInfoURL;
/*查看健康档案*/
+(NSString *)user_getMyDoctorURL;
/*身体健康数据*/
+(NSString *)user_healthDataURL;
/*取消预约*/
+(NSString *)user_applyForRefundURL;

/*文章收藏*/
+(NSString *)user_collectArticleURL;
/*取消文章收藏*/
+(NSString *)user_delArticCollectionURL;
/*医生收藏*/
+(NSString *)user_collectDoctorURL;
/*取消医生收藏*/
+(NSString *)user_delDoctorCollectionURL;
/*机构收藏*/
+(NSString *)user_collectInstitutionURL;
/*取消机构收藏*/
+(NSString *)user_delInstitutionCollectionURL;
/*我的收藏*/
+(NSString *)user_myCollectionURL;

/*删除最近搜索*/
+(NSString *)user_delRecentSearchURL;
/*操作日志*/
+(NSString *)user_markCalenderURL;
/** 医院下的所有项目*/
+ (NSString * )app_getAllProjectURL;

/** 首页更多  condition 1 医生 2文章*/
+ (NSString * )user_moreDataURL;
+ (NSString * )user_getCalenderDetailURL;

/** 添加家庭联系人 */
#define user_addMyFamilyMember URLOne@"user_addMyFamilyMember"
/** 获取家庭联系人列表 */
#define user_getMyFamilyMember URLOne@"user_getMyFamilyMember"
/** 获取就诊人列表 */
#define user_choosePatient URLOne@"user_choosePatient"

/** 获取首页折线图信息 */
#define user_lineChart URLOne@"user_lineChart"
/** 操作消息为已读 */
#define user_readSystemMessage URLOne@"user_readSystemMessage"

/** 操作消息为已读 */
#define appB_productStatus URLOne@"appB_productStatus"



/** 更新*/
+(NSString *)getIosConfigURL;
+(NSString *)getImgURLWithStr:(NSString * )str;
+(NSString *)getVideoURLWithStr:(NSString * )str;



@end

NS_ASSUME_NONNULL_END
