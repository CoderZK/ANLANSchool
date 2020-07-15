//
//  ALCProjectTVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALCProjectTVC : BaseTableViewController
@property(nonatomic,strong)NSString *institutionId;
@property(nonatomic,assign)BOOL isR;//是否是推荐
@end

NS_ASSUME_NONNULL_END
