//
//  ALCMessageOneCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCMessageOneCell.h"

@implementation ALCMessageOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgV.layer.cornerRadius = 22.5;
    self.imgV.clipsToBounds = YES;
    self.lineV.backgroundColor = lineBackColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
