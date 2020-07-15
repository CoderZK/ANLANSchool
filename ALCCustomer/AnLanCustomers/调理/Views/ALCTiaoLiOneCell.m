//
//  ALCTiaoLiOneCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCTiaoLiOneCell.h"

@implementation ALCTiaoLiOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
   self.backV.backgroundColor = WhiteColor;
    self.backV.layer.cornerRadius = 5;
    self.backV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backV.layer.shadowOffset = CGSizeMake(0, 0);
    self.backV.layer.shadowRadius = 5;
    self.backV.layer.shadowOpacity = 0.08;
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.imgV.layer.cornerRadius = 4;
    self.imgV.clipsToBounds = YES;
    self.lineV.backgroundColor = lineBackColor;
    self.lineV.hidden = YES;
    
}

- (void)setModel:(ALMessageModel *)model {
    _model = model;
    
    [self.imgV sd_setImageWithURL:[model.pictures getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:(SDWebImageRetryFailed)];
    self.leftLB1.text = model.name;
    self.leftLB2.text = [NSString stringWithFormat:@"%@ %@",model.type,model.level];
    if (model.distance > 100) {
        self.rightLB.text = [NSString stringWithFormat:@"%0.1fkm",model.distance/1000.0];
    }else {
        self.rightLB.text = [NSString stringWithFormat:@"%0.1fm",model.distance];
    }
    if (model.distance == -1) {
        self.rightLB.text = @"";
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
