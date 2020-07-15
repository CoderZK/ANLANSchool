//
//  ALCJianKangTiXingTwoCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCJianKangTiXingTwoCell.h"

@implementation ALCJianKangTiXingTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imgV.userInteractionEnabled = YES;
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.imgV.mj_w, self.imgV.mj_h)];
    [self.imgV addSubview:self.button];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
