//
//  ALCSendPeopleCell.m
//  AnLanBB
//
//  Created by zk on 2020/3/31.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCSendPeopleCell.h"

@implementation ALCSendPeopleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImgV.layer.cornerRadius = 22.5;
    self.headImgV.clipsToBounds = YES;
    self.lineV.backgroundColor = lineBackColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
