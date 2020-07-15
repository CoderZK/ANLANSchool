//
//  ALCHomeJianKangCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BezierCurveView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ALCHomeJianKangCell : UITableViewCell
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)BezierCurveView *bezierView;
@end

NS_ASSUME_NONNULL_END
