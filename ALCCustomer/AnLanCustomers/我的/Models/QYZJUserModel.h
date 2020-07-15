//
//  QYZJUserModel.h
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJUserModel : NSObject<NSCoding>
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *avatar;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *salerId; //销售ID
@property(nonatomic,strong)NSString *voiceDetailId; //用户问诊详情表ID
@property(nonatomic,strong)NSString *customerId; //客户ID
@property(nonatomic,strong)NSString *customerName; //客户姓名
@property(nonatomic,strong)NSString *baseId;
@property(nonatomic,strong)NSString *city_name;
@property(nonatomic,strong)NSString *pro_id;
@property(nonatomic,strong)NSString *city_id;
@property(nonatomic,strong)NSString *doctorId;
@property(nonatomic,strong)NSString *doctorName;
@property(nonatomic,strong)NSString *lastSessionTime;
@property(nonatomic,strong)NSString *feedBackDictionaryId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *baseInfoId;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *targetUserId;
//@property(nonatomic,strong)NSString *pic;
//@property(nonatomic,strong)NSString *name;
//@property(nonatomic,strong)NSString *address;
//@property(nonatomic,strong)NSString *level;
//@property(nonatomic,strong)NSString *city_id_server;
//@property(nonatomic,strong)NSString *city_name_server;
//@property(nonatomic,strong)NSString *pro_id_server;
//@property(nonatomic,strong)NSString *pro_name_server;
//@property(nonatomic,strong)NSString *area_name_server;
//@property(nonatomic,strong)NSString *area_id_server;
//
//
//
//
//
@property(nonatomic,assign)BOOL isSelect;
//@property(nonatomic,assign)BOOL is_coach;
//@property(nonatomic,assign)BOOL isNews;
//@property(nonatomic,assign)BOOL is_follow;
//@property(nonatomic,assign)BOOL is_referee;
//@property(nonatomic,assign)BOOL is_bond;
//@property(nonatomic,assign)BOOL is_question;
//@property(nonatomic,assign)BOOL is_appoint;
//@property(nonatomic,assign)BOOL isOpenSm;
//
//
//@property(nonatomic,assign)NSInteger follow_num;
//@property(nonatomic,assign)NSInteger fans_num;
@property(nonatomic,assign)NSInteger countImmediateLog; // 新朋友未读数量
@property(nonatomic,assign)NSInteger countSystem; // 系统消息数量
@property(nonatomic,assign)NSInteger countDetailCalender;  // 问诊数量
@property(nonatomic,assign)NSInteger appoint_num;
//
//@property(nonatomic,assign)CGFloat bond_money;
//@property(nonatomic,assign)CGFloat score;
//@property(nonatomic,assign)CGFloat question_price;
//@property(nonatomic,assign)CGFloat appoint_price;
//@property(nonatomic,assign)CGFloat  sit_price;

@end

NS_ASSUME_NONNULL_END
