//
//  ALCPayOrderVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALCPayOrderVC : BaseViewController
@property(nonatomic,strong)NSString *appointmentDate,*projiectID;
@property(nonatomic,assign)NSInteger duration;
@property(nonatomic,strong)NSString *innerOrderNo;
@property(nonatomic,assign)CGFloat price;
@property(nonatomic,strong)NSString *familyMemberId;
@end

NS_ASSUME_NONNULL_END
