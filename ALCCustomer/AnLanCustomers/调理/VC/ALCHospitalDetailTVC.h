//
//  ALCHospitalDetailTVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALCHospitalDetailTVC : BaseTableViewController
@property(nonatomic,strong)ALMessageModel *dataModel;
@property(nonatomic,copy)void(^sendImageNameBlock)(NSString *imageName);
@end

NS_ASSUME_NONNULL_END
