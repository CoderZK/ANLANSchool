//
//  ALCHospitalOneCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCHospitalOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLB;
@property (weak, nonatomic) IBOutlet UILabel *leftLBTwo;
@property (weak, nonatomic) IBOutlet UILabel *leftLBThree;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *rightLB;
@property(nonatomic,strong)ALMessageModel *model;
@end

NS_ASSUME_NONNULL_END
