//
//  ALCMianAllAppiontmentDocCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/5/6.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCMianAllAppiontmentDocCell.h"

@implementation ALCMianAllAppiontmentDocCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lineV.backgroundColor = BackgroundColor;
    self.headImgV.layer.cornerRadius = 25;
    self.headImgV.clipsToBounds = YES;
    
    
}

- (void)setModel:(ALMessageModel *)model  {
    _model = model;
    if (model.isSelect) {
        self.imgV.image = [UIImage imageNamed:@"jkgl23"];
    }else {
        self.imgV.image = [UIImage imageNamed:@"jkgl24"];
    }
    
    [self.headImgV sd_setImageWithURL:[model.avatar getPicURL] placeholderImage: [UIImage imageNamed:@"369"] options:(SDWebImageRetryFailed)];
    self.nameLB.text = model.doctorName;
    self.leaveLB.text = model.level;
    self.hosLB.text = model.institutionName;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
