//
//  ALCEditMineJianKangTVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALCEditMineJianKangTVC : BaseTableViewController
@property(nonatomic,copy)void(^sucessBlock)();
@property(nonatomic,strong)ALMessageModel *dataModel;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *familyMemberId;

@end

NS_ASSUME_NONNULL_END
