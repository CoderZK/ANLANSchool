//
//  ALCChartMessageCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/5/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCChartMessageCell.h"

@implementation ALCChartMessageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.timeLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, ScreenW, 20)];
        self.timeLB.font =  kFont(13);
        self.timeLB.textColor = CharacterBlack100;
        self.timeLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.timeLB];
        
        self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
        self.headBt.layer.cornerRadius = 20;
        self.headBt.clipsToBounds = YES;
        [self addSubview:self.headBt];
        
//        self.nameLB = [[UILabel alloc] initWithFrame:CGRectMake(80, 15, ScreenW - 95, 17)];
//        self.nameLB.font = kFont(14);
//        self.nameLB.textColor = CharacterBlack100;
//        [self addSubview:self.nameLB];
        
        self.backV = [[UIView alloc] initWithFrame:CGRectMake(70, 15, ScreenW - 120, 40)];
        self.backV.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.backV];
        
        
        
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenW - 120 - 20, 20)];
        self.contentLB.font = kFont(14);
        self.contentLB.textColor = CharacterColor50;
        self.contentLB.numberOfLines = 0;
        self.contentLB.backgroundColor = WhiteColor;
        [self.backV addSubview:self.contentLB];
        
        
        
        
        self.contentView.backgroundColor = self.backgroundColor = [UIColor clearColor];
        
        
        
        
        self.imagV = [[UIImageView alloc] initWithFrame:CGRectMake(80, 45, 120, 90)];
        [self addSubview:self.imagV];
        self.imagV.userInteractionEnabled = YES;
               UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpHomeVc:)];
        [self.imagV addGestureRecognizer:tap];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        
    }
    return self;
}

- (void)jumpHomeVc:(UITapGestureRecognizer *)tap{
    [[zkPhotoShowVC alloc] initWithArray:@[[self.model.image getFirstPicStr]] index:0];
}



- (void)setModel:(ALMessageModel *)model {
    _model = model;
    
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
    
    [self.headBt sd_setBackgroundImageWithURL:[model.fromAvatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    self.nameLB.text = model.fromNickname;
    if ([model.messageType isEqualToString:@"1"]) {
        self.imagV.hidden = YES;
        self.backV.hidden = NO;
        self.contentLB.attributedText = [model.content getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterColor50];
        
        self.contentLB.mj_h = [model.content getHeigtWithFontSize:14 lineSpace:3 width:ScreenW - 120 - 20] ;
        self.backV.mj_h = CGRectGetHeight(self.contentLB.frame) + 20;
        
        CGFloat ww = [model.content getWidhtWithFontSize:14];
        if (ww > ScreenW - 140) {
            self.backV.mj_w = ScreenW - 120;
            self.contentLB.mj_w = ScreenW - 140;
        }else {
            self.backV.mj_w = ww+20;
            self.contentLB.mj_w = ww;
        }
        
        
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.backV.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopRight  | UIRectCornerBottomRight  cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        [shape setPath:rounded.CGPath];
        self.backV.layer.mask = shape;
        
        
        if (isShowTime) {
            self.backV.mj_y = 30;
            self.headBt.mj_y = 30;
        }else {
            self.backV.mj_y = 8;
            self.headBt.mj_y = 8;
            
        }
        if (self.backV.mj_h < 40) {
            model.HHHHHH =  CGRectGetMaxY(self.headBt.frame)+8;
        }else {
           model.HHHHHH = CGRectGetMaxY(self.backV.frame)+8;
        }
        
        
        
        
        NSLog(@"%@",@"123456");
        
        
    }else {
        self.imagV.hidden = NO;
        self.backV.hidden = YES;
        
        if (isShowTime) {
            self.headBt.mj_y = 30;
        }else {
            self.headBt.mj_y = 8;
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
