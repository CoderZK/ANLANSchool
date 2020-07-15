//
//  ALCMineBodyinformationcell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCMineBodyinformationcell.h"

@implementation ALCMineBodyinformationcell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backV.backgroundColor = WhiteColor;
    self.backV.layer.cornerRadius = 5;
    self.backV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backV.layer.shadowOffset = CGSizeMake(0, 0);
    self.backV.layer.shadowRadius = 5;
    self.backV.layer.shadowOpacity = 0.08;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.jiluBt.layer.cornerRadius = 17.5;
    self.jiluBt.clipsToBounds = YES;
    [self.jiluBt setTitle:@"立即记录" forState:UIControlStateNormal];
    [self.jiluBt setTitleColor:GreenColor forState:UIControlStateNormal];
    self.jiluBt.layer.borderColor = GreenColor.CGColor;
    self.jiluBt.layer.borderWidth = 1;
    
    self.lineV.backgroundColor = lineBackColor;
}

- (void)setShowNumber:(NSInteger)showNumber {
    _showNumber = showNumber;
    if (showNumber == 0) {
        self.jiluBt.hidden = self.nodataLB.hidden = NO;
        self.leftBottomLB.hidden = self.leftTopLB.hidden = self.centerBottomLB.hidden= self.centerTopLB.hidden = self.rightTopLB.hidden = self.rightBottomLB.hidden = YES;
    }else if (showNumber == 1) {
        self.jiluBt.hidden = self.nodataLB.hidden = YES;
        self.leftBottomLB.hidden = self.leftTopLB.hidden = self.rightTopLB.hidden = self.rightBottomLB.hidden = YES;
        self.centerBottomLB.hidden= self.centerTopLB.hidden = NO;
        self.leftCon.constant = self.leftCon1.constant = self.leftCon2.constant = self.leftCon3.constant = 5;
    }else if (showNumber == 2) {
        self.jiluBt.hidden = self.nodataLB.hidden = YES;
        self.leftBottomLB.hidden = self.leftTopLB.hidden = self.rightTopLB.hidden = self.rightBottomLB.hidden = NO;
        self.centerBottomLB.hidden= self.centerTopLB.hidden = YES;
        
        self.leftCon.constant = self.leftCon1.constant = self.leftCon2.constant = self.leftCon3.constant = 30;
    }else if (showNumber == 3) {
        self.jiluBt.hidden = self.nodataLB.hidden = YES;
        self.leftBottomLB.hidden = self.leftTopLB.hidden = self.rightTopLB.hidden = self.rightBottomLB.hidden = NO;
        self.centerBottomLB.hidden= self.centerTopLB.hidden = NO;
        self.leftCon.constant = self.leftCon1.constant = self.leftCon2.constant = self.leftCon3.constant = 5;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
