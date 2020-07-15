//
//  ALCHospitalDetailOneCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCHospitalDetailOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLB;
@property (weak, nonatomic) IBOutlet UILabel *leftLBTwo;
@property (weak, nonatomic) IBOutlet UILabel *leftLBThree;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *leftLBFour;
@property (weak, nonatomic) IBOutlet UIButton *addressbt;
@property (weak, nonatomic) IBOutlet UIButton *daoHangBt;
@property(nonatomic,strong)ALMessageModel *model;
@end

NS_ASSUME_NONNULL_END
