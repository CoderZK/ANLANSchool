//
//  ALCChooseJiuZhenRenTVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/6/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALCChooseJiuZhenRenTVC : BaseTableViewController
@property(nonatomic,copy)void(^sendChoosePatientBlock)(NSString *name,NSString*pID);
@property(nonatomic,assign)BOOL isLiaoTian;
@property(nonatomic,strong)NSString *toUserId;
@end

NS_ASSUME_NONNULL_END
