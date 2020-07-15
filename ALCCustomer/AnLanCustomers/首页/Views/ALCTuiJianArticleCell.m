//
//  ALCTuiJianArticleCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/5/8.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCTuiJianArticleCell.h"

@implementation ALCTuiJianArticleCell

- (void)setModel:(ALMessageModel *)model {
    _model = model;
    
    self.titleLB.text = model.title;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:[model.image getFirstPicStr]] placeholderImage:[UIImage imageNamed:@"369"]];
    if (model.type.intValue == 1) {
        self.playImg.hidden = NO;
        [self.imgV showGifImageWithURL:[model.video_image getPicURL]];
    }else {
        self.playImg.hidden = YES;
    }
    if ([model.readCnt intValue] > 10000) {
        self.numberLB.text = [NSString stringWithFormat:@"阅读量:%0.1f万",[model.readCnt intValue]/10000.0];
    }else {
       self.numberLB.text = [NSString stringWithFormat:@"阅读量:%@",model.readCnt];
    }
    self.lineV.backgroundColor = lineBackColor;
    self.imgV.layer.cornerRadius = 5;
    self.imgV.clipsToBounds = YES;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
