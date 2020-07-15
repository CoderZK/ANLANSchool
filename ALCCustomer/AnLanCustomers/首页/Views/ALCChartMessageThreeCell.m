//
//  ALCChartMessageThreeCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/5/27.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCChartMessageThreeCell.h"

@implementation ALCChartMessageThreeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        self.backV = [[UIView alloc] initWithFrame:CGRectMake(15, 8, ScreenW - 30, 20)];
        self.backV.backgroundColor = RGB(200, 200, 200);
        [self addSubview:self.backV];
        
        self.backV.clipsToBounds = YES;
        self.backV.layer.cornerRadius = ([@"中" getHeigtWithFontSize:13 lineSpace:0 width:100]+10)/2;
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, ScreenW - 50,20)];
        self.titleLB.font = kFont(13);
        self.titleLB.numberOfLines = 0;
        [self.backV addSubview:self.titleLB];
        self.contentView.backgroundColor = self.backgroundColor = [UIColor clearColor];
        
        
    }
    return self;
}


- (void)setModel:(ALMessageModel *)model {
    _model = model;
    
    CGFloat hh = [model.content getHeigtWithFontSize:13 lineSpace:3 width:ScreenW - 50];
    CGFloat ww = [model.content getWidhtWithFontSize:13];
    self.titleLB.attributedText = [model.content getMutableAttributeStringWithFont:13 lineSpace:3 textColor:CharacterColor50];
    self.titleLB.mj_h = hh ;
    self.backV.mj_h = hh + 10;
    if (ww < ScreenW - 50) {
        self.titleLB.mj_w = ww;
        self.backV.mj_w = ww+ 20;
        self.backV.mj_x = (ScreenW - ww -20)/2;
        
    }else {
        self.titleLB.mj_w = ScreenW - 50;
        self.backV.mj_w = ScreenW - 30;
        self.backV.mj_x = 15;
    }
    model.HHHHHH = CGRectGetMaxY(self.backV.frame) + 8;
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    
}

@end
