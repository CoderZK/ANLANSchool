//
//  ALCMineFamilyTVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/6/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALCMineFamilyTVC : BaseTableViewController
@property(nonatomic,assign)BOOL isComeDP;//是否是从预约界面过来
@property(nonatomic,copy)void(^sendPeopleNameIDBlock)(NSString *name,NSString*pID);

@end

NS_ASSUME_NONNULL_END
