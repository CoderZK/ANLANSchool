//
//  ACLMineCollectCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ACLMineCollectCell.h"

@implementation ACLMineCollectCell

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        
        self.backV = [[UIView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width - 10, frame.size.height - 10)];
        [self addSubview:self.backV];
        _backV.backgroundColor = [UIColor redColor];
        
        
        self.backV.backgroundColor = WhiteColor;
        self.backV.layer.cornerRadius = 5;
        self.backV.layer.shadowColor = [UIColor blackColor].CGColor;
        self.backV.layer.shadowOffset = CGSizeMake(0, 0);
        self.backV.layer.shadowRadius = 5;
        self.backV.layer.shadowOpacity = 0.08;
        self.contentView.backgroundColor = [UIColor clearColor];
        
        
        
        FLAnimatedImageView * imgV =[[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, self.backV.width, self.backV.width)];
        imgV.image = [UIImage imageNamed:@"placeholder"];
        self.imgV = imgV;
        [self.backV addSubview:imgV];
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, self.backV.width + 10, self.backV.width - 20, 20)];
        self.titleLB.font = kFont(14);
        self.titleLB.textColor = CharacterColor50;
        self.titleLB.text = @"测试室";
        [self.backV addSubview:self.titleLB];
        
        self.playImageV = [[UIImageView alloc] init];
        self.playImageV.image = [UIImage imageNamed:@"jkgl119"];
        [self.imgV addSubview:self.playImageV];
        [self.playImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@15);
            make.right.equalTo(self.imgV.mas_right).offset(-7);
            make.top.equalTo(self.imgV.mas_top).offset(7);
        }];
        
        
//        self.leftBt = [[UIButton alloc] initWithFrame:CGRectMake(10, self.backV.width + 10 + 20 + 10, 60, 30)];
//        [self.leftBt setTitleColor:CharacterBlack100 forState:UIControlStateNormal];
//        self.leftBt.titleLabel.font = kFont(13);
//         self.leftBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [self.leftBt setTitle:@"人员" forState:UIControlStateNormal];
//        [self.leftBt setImage:[UIImage imageNamed:@"gou3"] forState:UIControlStateNormal];
//        [self.backV addSubview:self.leftBt];
        
//        self.leftImgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.backV.width + 10 + 20 + 10, 30, 30)];
//        self.leftImgV.layer.cornerRadius = 15;
//        self.leftImgV.clipsToBounds = YES;
//        [self.backV addSubview:self.leftImgV];
        
//        self.leftLB = [[UILabel alloc] initWithFrame:CGRectMake(15, self.backV.width + 10 + 20 + 10, self.backV.mj_w - 30, 30)];
//        self.leftLB.font = kFont(13);
//        self.leftLB.textColor = CharacterBlack100;
//        [self.backV addSubview:self.leftLB];
        

        self.rightBt = [[UIButton alloc] initWithFrame:CGRectMake(15, self.backV.width + 10 + 20 + 10, self.backV.mj_w - 30, 30)];
        self.rightBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.rightBt setTitleColor:CharacterBlack100 forState:UIControlStateNormal];
        self.rightBt.titleLabel.font = kFont(13);
        [self.rightBt setTitle:@"5.8万" forState:UIControlStateNormal];
        [self.rightBt setImage:[UIImage imageNamed:@"kan"] forState:UIControlStateNormal];
        [self.backV addSubview:self.rightBt];
        
        
        
        
        
    }
    return self;
}


- (void)setModel:(ALMessageModel *)model {
    _model = model;
   
    self.titleLB.text = model.title;

    
    [self.leftImgV sd_setImageWithURL:[model.avatar getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.leftLB.text = model.nickname;
    
    if ([model.type isEqualToString:@"1"]) {
//        [self.imgV showGifImageWithURL:[NSURL URLWithString:model.video_image]];
        if (model.video_image.length > 0) {
            [self.imgV sd_setImageWithURL:[model.video_image getPicURL]];
        }else {
           [self.imgV sd_setImageWithURL:[model.videoImage getPicURL]];
        }
        
        self.playImageV.hidden = NO;
    }else {
         [self.imgV sd_setImageWithURL:[model.image getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
        self.playImageV.hidden = YES;
      
    }
    if ([model.readCnt intValue] > 10000) {
        [self.rightBt setTitle:[NSString stringWithFormat:@"%0.1f万",[model.readCnt intValue]/10000.0] forState:UIControlStateNormal];
    }else {
        [self.rightBt setTitle:[NSString stringWithFormat:@"%d",[model.readCnt intValue]] forState:UIControlStateNormal];
    }
    [self.rightBt setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
}


@end
