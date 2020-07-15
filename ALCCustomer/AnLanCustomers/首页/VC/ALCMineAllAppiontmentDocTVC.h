//
//  ALCMineAllAppiontmentDocTVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/5/6.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALCMineAllAppiontmentDocTVC : BaseTableViewController
@property(nonatomic,copy)void(^sendFriendsBlock)(NSString * nickNameStr,NSString *idStr);
@property(nonatomic,strong)NSArray *arr;
@end

NS_ASSUME_NONNULL_END
