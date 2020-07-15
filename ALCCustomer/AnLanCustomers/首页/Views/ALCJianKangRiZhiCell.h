//
//  ALCJianKangRiZhiCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCJianKangRiZhiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backV;
@property (weak, nonatomic) IBOutlet UILabel *rightLB1;
@property (weak, nonatomic) IBOutlet UILabel *rightLB2;
@property (weak, nonatomic) IBOutlet UIView *lineV;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCOns;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightCons;

@property(nonatomic,strong)ALMessageModel *model;


@end

NS_ASSUME_NONNULL_END
