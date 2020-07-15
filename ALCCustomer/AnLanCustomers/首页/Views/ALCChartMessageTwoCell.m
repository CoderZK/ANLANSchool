//
//  ALCChartMessageTwoCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/5/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCChartMessageTwoCell.h"

@implementation ALCChartMessageTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.timeLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, ScreenW, 20)];
        self.timeLB.font =  kFont(13);
        self.timeLB.textColor = CharacterBlack100;
        self.timeLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.timeLB];
        
//        self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 65, 15, 50, 50)];
//        self.headBt.layer.cornerRadius = 25;
//        self.headBt.clipsToBounds = YES;
//        [self addSubview:self.headBt];
        
//        self.nameLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, ScreenW - 30, 17)];
//        self.nameLB.font = kFont(14);
//        self.nameLB.textColor = CharacterBlack100;
//        self.nameLB.textAlignment = NSTextAlignmentRight;
//        [self addSubview:self.nameLB];
        
        self.backV = [[UIView alloc] initWithFrame:CGRectMake(60, 10, ScreenW - 75, 40)];
        self.backV.backgroundColor = WhiteColor;
        
        [self addSubview:self.backV];
        
        
        
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenW - 95, 20)];
        self.contentLB.font = kFont(14);
        self.contentLB.textColor = CharacterBlack100;
        self.contentLB.numberOfLines = 0;
        self.contentLB.backgroundColor = [UIColor clearColor];
     
        
       
        
        [self addSubview:self.backV];
        [self.backV addSubview:self.contentLB];
        
        
        self.imagV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW - 135, 10, 120, 90)];
        [self addSubview:self.imagV];
        self.imagV.userInteractionEnabled = YES;
               UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpHomeVc:)];
        [self.imagV addGestureRecognizer:tap];
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        self.contentView.backgroundColor = self.backgroundColor = [UIColor clearColor];
        
        
    }
    return self;
}


- (void)jumpHomeVc:(UITapGestureRecognizer *)tap{
    [[zkPhotoShowVC alloc] initWithArray:@[[self.model.image getFirstPicStr]] index:0];
}

- (void)setModel:(ALMessageModel *)model {
    _model = model;
    
//    [self.headBt sd_setBackgroundImageWithURL:[model.fromAvatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
//    self.nameLB.text = model.fromNickname;
    BOOL isShowTime = NO;
    if (self.timeStr.length > 0) {
        NSInteger  times = [NSString pleaseInsertStarTime:self.timeStr andInsertEndTime:model.createTime];
        if (times >120) {
            isShowTime = YES;
        }else {
            isShowTime = NO;
        }
    }else {
        isShowTime = YES;
        
    }
    self.timeLB.hidden = !isShowTime;
    self.timeLB.text = model.createTime;
    
    if ([model.messageType isEqualToString:@"1"]) {
        self.backV.hidden = NO;
        self.imagV.hidden = YES;
        self.contentLB.hidden = NO;
        self.contentLB.attributedText = [model.content getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterBlack100];
        self.contentLB.mj_h = [model.content getHeigtWithFontSize:14 lineSpace:3 width:ScreenW - 95] ;
        CGFloat ww = [model.content getWidhtWithFontSize:14];
        if (ww > ScreenW - 95) {
            self.backV.mj_w = ScreenW - 75;
            self.contentLB.mj_w = ScreenW - 95;
            self.backV.mj_x = 60;
        }else {
            self.backV.mj_w = ww+20;
            self.backV.mj_x = ScreenW - 15 - (ww+20);
            self.contentLB.mj_w = ww;
        }
        self.contentLB.textAlignment = NSTextAlignmentRight;
        
        self.backV.mj_h = CGRectGetHeight(self.contentLB.frame) + 20;
        
        if (isShowTime) {
            self.backV.mj_y = 30;
        }else {
            self.backV.mj_y = 8;
        }
        model.HHHHHH = CGRectGetMaxY(self.backV.frame)+8;
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.backV.bounds byRoundingCorners:UIRectCornerTopLeft| UIRectCornerBottomLeft | UIRectCornerBottomRight  cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        [shape setPath:rounded.CGPath];
        self.backV.layer.mask = shape;
        
        
    }else {
        self.backV.hidden = YES;
        self.imagV.hidden = NO;
        self.contentLB.hidden = YES;
        if (isShowTime) {
            
            self.imagV.mj_y = 30;
        }else {
            self.imagV.mj_y = 8;
        }
        model.HHHHHH = CGRectGetMaxY(self.imagV.frame) + 8;
        [self.imagV sd_setImageWithURL:[model.image getPicURL] placeholderImage:[UIImage imageNamed:@"369"]];
    }
    
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
