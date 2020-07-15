//
//  ALMessageModel.h
//  AnLanBB
//
//  Created by zk on 2020/4/23.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALMessageModel : NSObject
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *pkgId;
@property(nonatomic,strong)NSString *pic;
@property(nonatomic,strong)NSString *fromUserId;//发送ID
@property(nonatomic,strong)NSString *toAvatar;
@property(nonatomic,strong)NSString *readTime;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *video;
@property(nonatomic,strong)NSString *immediateLogId;//对方ID
@property(nonatomic,strong)NSString *toUserId; //对方ID
@property(nonatomic,strong)NSString *content; //
@property(nonatomic,strong)NSString *messageType; //消息类型1文字2图片3语音4视频
@property(nonatomic,strong)NSString *createTime; //创建时间
@property(nonatomic,strong)NSString *deleteTime;//删除时间
@property(nonatomic,strong)NSString *toName;//对方姓名
@property(nonatomic,strong)NSString *fromName;//发送方姓名
@property(nonatomic,strong)NSString *audio;//音频
@property(nonatomic,strong)NSString *fromAvatar;//发送方头像
@property(nonatomic,strong)NSString *qiniu_url;
@property(nonatomic,strong)NSString *duration;
@property(nonatomic,strong)NSString *uploadId;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *batch;
@property(nonatomic,strong)NSString *customerName;
@property(nonatomic,strong)NSString *voiceMessageId;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *week;
@property(nonatomic,strong)NSString *remindTime;
@property(nonatomic,strong)NSString *scheduleDate;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *calendarId;
@property(nonatomic,strong)NSString *targetUserId;
@property(nonatomic,strong)NSString *doctorName;
@property(nonatomic,strong)NSString *doctorDescription;
@property(nonatomic,strong)NSString *level;
@property(nonatomic,strong)NSString *depaName;
@property(nonatomic,strong)NSString *instName;
@property(nonatomic,strong)NSString *goodArea;
@property(nonatomic,strong)NSString *doctorAdvice;
@property(nonatomic,strong)NSString *des;
@property(nonatomic,strong)NSString *checkInfo;
@property(nonatomic,strong)NSString *medicine;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *readCnt;
@property(nonatomic,strong)NSString *publishTime;
@property(nonatomic,strong)NSString *avatar;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *createrName;
@property(nonatomic,strong)NSString *institutionName;
@property(nonatomic,strong)NSString *departmentName;
@property(nonatomic,strong)NSString *appointmentDate;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *dailyAppointmentLimit;
@property(nonatomic,strong)NSString *appointmentCnt;
@property(nonatomic,strong)NSString *consultationCnt;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *pictures;
@property(nonatomic,strong)NSString *biu_institution_department;
@property(nonatomic,strong)NSString *provinceImportantDepartment;
@property(nonatomic,strong)NSString *route;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *cityImportantDepartment;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *institution_id;
@property(nonatomic,strong)NSString *scheduleId;
@property(nonatomic,strong)NSString *highRate;
@property(nonatomic,strong)NSString *lowRate;
@property(nonatomic,strong)NSString *averageRate;
@property(nonatomic,strong)NSString *weight;
@property(nonatomic,strong)NSString *systolic;//收缩压
@property(nonatomic,strong)NSString *diastolic;//舒畅
@property(nonatomic,strong)NSString *stepnumber;
@property(nonatomic,strong)NSString *lastday;
@property(nonatomic,strong)NSString *length;
@property(nonatomic,strong)NSString *period;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *low_rate;
@property(nonatomic,strong)NSString *average_rate;
@property(nonatomic,strong)NSString *high_rate;
@property(nonatomic,strong)NSString *record_date;
@property(nonatomic,strong)NSString *recordDate;
@property(nonatomic,strong)NSString *lastSessionTime;
@property(nonatomic,strong)NSString *toNickname;
@property(nonatomic,strong)NSString *doctorCnt;
@property(nonatomic,strong)NSString *fromNickname;
@property(nonatomic,strong)NSString *healthInfoRate;
@property(nonatomic,strong)NSString *gender;
@property(nonatomic,strong)NSString *age;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *marriageStatus;
@property(nonatomic,strong)NSString *birthStatus;
@property(nonatomic,strong)NSString *operateHurt;
@property(nonatomic,strong)NSString *familyHistory;
@property(nonatomic,strong)NSString *drugAllergy;
@property(nonatomic,strong)NSString *otherAllergy;
@property(nonatomic,strong)NSString *habit;
@property(nonatomic,strong)NSString *birthdate;
@property(nonatomic,strong)NSString *height;
@property(nonatomic,strong)NSString *orderNo;
@property(nonatomic,strong)NSString *doctorId;
@property(nonatomic,strong)NSString *check_info;
@property(nonatomic,strong)NSString *doctor_advice;
@property(nonatomic,strong)NSString *projectName;
@property(nonatomic,strong)NSString *bmi;
@property(nonatomic,strong)NSString *patientName;
@property(nonatomic,strong)NSString *projectId;
@property(nonatomic,strong)NSString *appiontmentId;
@property(nonatomic,strong)NSString *video_image;
@property(nonatomic,strong)NSString *IDcard;
@property(nonatomic,strong)NSString *baseId;
@property(nonatomic,strong)NSString *videoImage;
//@property(nonatomic,strong)NSString *checkInfo;
//@property(nonatomic,strong)NSString *medicine;
//@property(nonatomic,strong)NSString *name;
//@property(nonatomic,strong)NSString *readCnt;
//@property(nonatomic,strong)NSString *publishTime;
//转化成模型
@property(nonatomic,strong)ALMessageModel *article;
@property(nonatomic,strong)ALMessageModel *info;
@property(nonatomic,strong)ALMessageModel *projectDetail;
@property(nonatomic,strong)ALMessageModel *heartrate;
@property(nonatomic,strong)ALMessageModel *weightData;
@property(nonatomic,strong)ALMessageModel *bloodpressure;
@property(nonatomic,strong)ALMessageModel *stepnumberData;
@property(nonatomic,strong)ALMessageModel *menstrual;
@property(nonatomic,strong)ALMessageModel *userInfo;
@property(nonatomic,strong)ALMessageModel *healthdata;
//@property(nonatomic,strong)ALMessageModel *stepnumberData;
//@property(nonatomic,strong)ALMessageModel *menstrual;


@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *commentList;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *departmentList;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *recommendProjectList;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *province_important_departmentList;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *city_important_departmentList;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *recommendDoctorList;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *doctorList;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *institutionList;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *doctorAppointment;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *calenderSchedule;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *articleList;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *appoinmentHistory;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *doctors;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *doctorAppoints;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *weightNub;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *bloodpressureNub;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *heartrateNub;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *stepNub;

@property(nonatomic,strong)NSArray *times;


@property(nonatomic,assign)BOOL isDelete;
@property(nonatomic,assign)BOOL is_read;
@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,assign)BOOL isFinish;
@property(nonatomic,assign)BOOL isAllowComment;
@property(nonatomic,assign)BOOL isCancel;
@property(nonatomic,assign)BOOL isConsultation;
@property(nonatomic,assign)BOOL isAppointment;
@property(nonatomic,assign)BOOL isCollection;
@property(nonatomic,assign)BOOL isSelf;
@property(nonatomic,assign)BOOL ifFromB;
@property(nonatomic,assign)BOOL is_default_patient;
//@property(nonatomic,assign)BOOL isConsultation;
//@property(nonatomic,assign)BOOL isAppointment;
//@property(nonatomic,assign)BOOL isCollection;
//@property(nonatomic,assign)BOOL isSelf;

//
//
//@property(nonatomic,assign)NSInteger type;//1图片2视频3音频4其它文件
@property(nonatomic,assign)NSInteger payWay; //支付渠道1在线支付2到店支付

 // 状态1支付未回调确认(线下未支付)2支付已确认未消费（线下已支付未消费）3已消费4取消预约进行退款中5退款成功',
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,assign)NSInteger doctorAppointmentCnt;  // 问诊数量
@property(nonatomic,assign)NSInteger projectAppointmentCnt;
@property(nonatomic,assign)NSInteger doctorConsultationCnt;
@property(nonatomic,assign)NSInteger appointment_cnt;
@property(nonatomic,assign)NSInteger restCnt;
@property(nonatomic,assign)NSInteger consult;
//@property(nonatomic,assign)NSInteger appoint_num;
//@property(nonatomic,assign)NSInteger appoint_num;
//@property(nonatomic,assign)NSInteger appoint_num;
//@property(nonatomic,assign)NSInteger appoint_num;
//@property(nonatomic,assign)NSInteger appoint_num;
//@property(nonatomic,assign)NSInteger appoint_num;
//@property(nonatomic,assign)NSInteger appoint_num;


@property(nonatomic,assign)CGFloat price;
@property(nonatomic,assign)CGFloat distance;
@property(nonatomic,assign)CGFloat latitude;
@property(nonatomic,assign)CGFloat longitude;

//@property(nonatomic,assign)CGFloat price;
//@property(nonatomic,assign)CGFloat distance;
//@property(nonatomic,assign)CGFloat latitude;
//@property(nonatomic,assign)CGFloat longitude;

@property(nonatomic,assign)CGFloat  HHHHHH;



@end

NS_ASSUME_NONNULL_END
