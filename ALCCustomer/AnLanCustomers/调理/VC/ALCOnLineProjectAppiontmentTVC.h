//
//  ALCOnLineProjectAppiontmentTVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/4/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALCOnLineProjectAppiontmentTVC : BaseTableViewController
@property(nonatomic,strong)ALMessageModel *dataModel;
@property(nonatomic,strong)NSString *projectId;
@property(nonatomic,strong)NSString *institutionId;
@end

NS_ASSUME_NONNULL_END
