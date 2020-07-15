//
//  ALCOnLineAppointmentTVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALCOnLineAppointmentTVC : BaseTableViewController
@property(nonatomic,strong)NSString *dorID;
@property(nonatomic,strong)NSString *institutionId;
@property(nonatomic,strong)ALMessageModel *model;
@end

NS_ASSUME_NONNULL_END
