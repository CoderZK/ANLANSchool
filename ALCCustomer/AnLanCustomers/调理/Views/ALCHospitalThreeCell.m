//
//  ALCHospitalThreeCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCHospitalThreeCell.h"

@implementation ALCHospitalThreeCell

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
}

- (void)setModel:(ALMessageModel *)model {
    _model = model;
    [self.imgV sd_setImageWithURL:[model.picture getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.leftLB1.text = model.name;
    self.leftLB2.text = [NSString stringWithFormat:@"%@分钟",model.duration];
    self.leftLB3.text = [NSString stringWithFormat:@"￥%0.2f",model.price];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
