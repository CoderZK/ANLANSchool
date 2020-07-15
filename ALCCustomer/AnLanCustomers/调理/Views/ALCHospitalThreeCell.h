//
//  ALCHospitalThreeCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCHospitalThreeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backV;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *leftLB1;
@property (weak, nonatomic) IBOutlet UILabel *leftLB2;
@property (weak, nonatomic) IBOutlet UILabel *leftLB3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightCons;
@property(nonatomic,strong)ALMessageModel *model;
@end

NS_ASSUME_NONNULL_END
