//
//  ALCJianKangRiZhiDetailOneCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCJianKangRiZhiDetailOneCell.h"

@implementation ALCJianKangRiZhiDetailOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
 
        
        self.leftLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 80, 20)];
        self.leftLB.textColor = CharacterBlack100;
        self.leftLB.font = kFont(14);
        [self addSubview:self.leftLB];
        self.leftLB.text = @"病情主诉";
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, ScreenW - 115, 20)];
        self.titleLB.textColor = CharacterColor50;
        self.titleLB.font = kFont(14);
        self.titleLB.text = @"";
        self.titleLB.numberOfLines = 0;
        [self addSubview:self.titleLB];
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(15, 49.4, ScreenW-30, 0.6)];
        backV.backgroundColor = lineBackColor;
        [self addSubview:backV];
        
        self.symptomLB = [[UILabel alloc] initWithFrame:CGRectMake(100, 65, ScreenW - 115, 20)];
        self.symptomLB.textColor = CharacterBlack100;
        self.symptomLB.font = kFont(14);
        self.symptomLB.text = @"过敏";
        [self addSubview:self.symptomLB];
        
        
        self.desLB = [[UILabel alloc] initWithFrame:CGRectMake(100, 95, ScreenW - 115, 20)];
        self.desLB.textColor = CharacterColor50;
        self.desLB.font = kFont(14);
        self.desLB.text = @"全身红疹过敏,痒";
        [self addSubview:self.desLB];
        
        
        //130
        
    }
    return self;
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
