//
//  ALCMineFamilyOneCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/6/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCMineFamilyOneCell.h"

@implementation ALCMineFamilyOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lineV.backgroundColor = lineBackColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ALMessageModel *)model {
    _model = model;
    NSString * mr = @"";
    if (model.is_default_patient) {
        mr = @"[默认]";
    }else {
        mr = @"";
    }
    NSString * gender = model.gender.intValue == 1 ? @"男":@"女";
    self.leftOntLB.text = [NSString stringWithFormat:@"%@ %@ %@岁 %@",model.name,gender,model.age,mr];
    
    if (model.IDcard.length < 4 || model.phone.length < 4) {
        return;
    }
    NSString * carstr = [NSString stringWithFormat:@"%@****%@",[model.IDcard substringToIndex:3],[model.IDcard substringFromIndex:model.IDcard.length - 4]];
    NSString *phoneStr = [NSString stringWithFormat:@"%@****%@",[model.phone substringToIndex:3],[model.phone substringFromIndex:model.phone.length - 4]];
    
    self.leftTwoLB.text = [NSString stringWithFormat:@"身份证 %@    %@",carstr,phoneStr];
    
    if (!self.isBlack) {
        self.leftTwoLB.textColor = self.leftOntLB.textColor = WhiteColor;
        self.backgroundColor = self.backgroundView.backgroundColor = RGB(82, 81, 102);
    }else {
        self.leftTwoLB.textColor = self.leftOntLB.textColor = CharacterBlack100;
        self.backgroundColor = self.backgroundView.backgroundColor = WhiteColor;
    }
    
}


@end
