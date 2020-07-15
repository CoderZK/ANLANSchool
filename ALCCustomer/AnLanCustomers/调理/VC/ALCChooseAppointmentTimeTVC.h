//
//  ALCChooseAppointmentTimeTVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALCChooseAppointmentTimeTVC : BaseTableViewController
@property(nonatomic,strong)NSString *doctorId;
@property(nonatomic,copy)void(^sendScheduleIdBlcok)(NSString *scheduleId,NSString * titelStr);
@end

NS_ASSUME_NONNULL_END
