//
//  ALCTiaoLiOneCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCTiaoLiOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backV;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *leftLB1;
@property (weak, nonatomic) IBOutlet UILabel *leftLB2;
@property (weak, nonatomic) IBOutlet UILabel *rightLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consBottom;
@property (weak, nonatomic) IBOutlet UIView *lineV;
@property(nonatomic,strong)ALMessageModel *model;

@end

NS_ASSUME_NONNULL_END
