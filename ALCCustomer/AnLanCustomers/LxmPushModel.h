//
//  LxmPushModel.h
//  huishou
//
//  Created by kunzhang on 2020/5/26.
//  Copyright © 2020 李晓满. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LxmPushModel : NSObject
@property (nonatomic, strong) NSString *d;/** 友盟id */

@property (nonatomic, strong) NSString *p;/** 0 */

@property (nonatomic, strong) NSString *eventType;//q1 问诊消息 2 日称消息 3 系统消息 4 聊天

@property (nonatomic, strong) NSString *infoUrl;/** 系统通知跳转的url */

@property (nonatomic, strong) NSString *secondType;/**  */

@property (nonatomic, strong) NSString *objectId;/** 跳转到的id */
@end

NS_ASSUME_NONNULL_END
