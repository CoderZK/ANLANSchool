//
//  ALCTuiJianForYouCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/5/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCTuiJianForYouCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *leftBt;
@property (weak, nonatomic) IBOutlet UIButton *rightBt;
@property (weak, nonatomic) IBOutlet UILabel *leftOneLB;
@property (weak, nonatomic) IBOutlet UILabel *leftTwoLB;
@property (weak, nonatomic) IBOutlet UIImageView *leftImgV;
@property (weak, nonatomic) IBOutlet UIView *leftV;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgV;
@property (weak, nonatomic) IBOutlet UILabel *rightOneLB;
@property (weak, nonatomic) IBOutlet UILabel *rightTwoLB;
@property (weak, nonatomic) IBOutlet UIView *rightV;

@end

NS_ASSUME_NONNULL_END
