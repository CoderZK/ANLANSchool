//
//  ACLHeadOrFootView.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ACLHeadOrFootView : UITableViewHeaderFooterView
@property(nonatomic,strong)UILabel *leftLB;
@property(nonatomic,strong)UIButton *rightBt;
@property(nonatomic,strong)UIView *lineV;
@end

NS_ASSUME_NONNULL_END
