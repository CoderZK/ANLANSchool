//
//  ALCChooseAdministrativeTVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALCChooseAdministrativeTVC : BaseTableViewController
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *departmentList;
@property(nonatomic,strong)NSString *hosID;
@end

NS_ASSUME_NONNULL_END
