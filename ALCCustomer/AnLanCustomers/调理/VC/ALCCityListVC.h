//
//  ALCCityListVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/4/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALCCityListVC : BaseViewController
@property(nonatomic,copy)void(^cityBlock)(NSString *provinceStr,NSString *cityStr ,NSString * proviceId,NSString * cityId);
@property(nonatomic,assign)BOOL isComeAddFamily;
@end

NS_ASSUME_NONNULL_END
