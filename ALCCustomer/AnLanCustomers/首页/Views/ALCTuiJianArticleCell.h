//
//  ALCTuiJianArticleCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/5/8.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCTuiJianArticleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *lineV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *imgV;
@property(nonatomic,strong)ALMessageModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *playImg;
@end

NS_ASSUME_NONNULL_END
