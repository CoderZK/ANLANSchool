//
//  ALCChooseAppointmentTimeCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCChooseAppointmentTimeCell.h"

@implementation ALCChooseAppointmentTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ALMessageModel *)model {
    _model = model;
    
    NSArray * arr = @[@"",@"上午",@"下午"];
    
    if (model.restCnt == 0) {
        self.leftLB.textColor = CharacterBack150;
        self.leftLB.text = [NSString stringWithFormat:@"%@ %@  已约满",model.scheduleDate,arr[[model.duration intValue]]];
        self.rightImgV.hidden = YES;
    }else {
        self.rightImgV.hidden = NO;
        if (model.isSelect) {
            self.rightImgV.image = [UIImage imageNamed:@"jkgl133"];
        }else {
            self.rightImgV.image = [UIImage imageNamed:@"jkgl132"];
        }
        
        self.leftLB.text = [NSString stringWithFormat:@"%@ %@  余%d",model.scheduleDate,arr[[model.duration intValue]],model.restCnt];
    }
  
}

@end
