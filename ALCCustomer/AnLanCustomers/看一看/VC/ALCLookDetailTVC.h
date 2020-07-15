//
//  ALCLookDetailTVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALCLookDetailTVC : BaseTableViewController
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,copy)void(^isNoCollectBlock)(void);
@end

NS_ASSUME_NONNULL_END
