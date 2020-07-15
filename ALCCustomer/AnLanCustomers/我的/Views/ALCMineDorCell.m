//
//  ALCMineDorCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCMineDorCell.h"

@implementation ALCMineDorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.LB.layer.cornerRadius = 12.5;
    self.LB.clipsToBounds = YES;
    self.dengLB.layer.cornerRadius = 10;
    self.dengLB.clipsToBounds = YES;
    self.dengLB.textColor = CharacterBack150;
    self.dengLB.layer.borderColor = CharacterBack150.CGColor;;
    self.dengLB.layer.borderWidth = 1;
    self.headBt.layer.cornerRadius = 25;
    self.headBt.clipsToBounds = YES;
    
    self.dengLB.hidden = YES;
 
    
}

- (void)setModel:(ALMessageModel *)model {
    _model = model;
    NSURL * url = [model.avatar getPicURL];
    [self.headBt sd_setBackgroundImageWithURL:[model.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    self.nameLB.text = model.doctorName;
    self.dLB.text = model.level;
    self.keshiLB.text = [NSString stringWithFormat:@"%@ %@",model.institutionName,model.departmentName];
    self.timeTwoLB.text = [NSString stringWithFormat:@"%@",model.lastSessionTime];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
