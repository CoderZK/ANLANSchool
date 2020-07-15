//
//  ALCMianAllAppiontmentDocCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/5/6.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCMianAllAppiontmentDocCell : UITableViewCell
@property(nonatomic,strong)ALMessageModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UIImageView *headImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *leaveLB;
@property (weak, nonatomic) IBOutlet UIView *lineV;
@property (weak, nonatomic) IBOutlet UILabel *hosLB;
@end

NS_ASSUME_NONNULL_END
