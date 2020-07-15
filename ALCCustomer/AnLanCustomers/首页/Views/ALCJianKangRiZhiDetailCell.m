//
//  ALCJianKangRiZhiDetailCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCJianKangRiZhiDetailCell.h"

@implementation ALCJianKangRiZhiDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.leftLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 80, 20)];
        self.leftLB.textColor = CharacterBlack100;
        self.leftLB.font = kFont(14);
        [self addSubview:self.leftLB];
        
        self.leftLB.text = @"病情主诉";
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, ScreenW - 115, 20)];
        self.titleLB.numberOfLines = 0;
        self.titleLB.textColor = CharacterColor50;
        self.titleLB.font = kFont(14);
        self.titleLB.text = @"";
        self.titleLB.numberOfLines = 0;
        [self addSubview:self.titleLB];


        
        
        
    }
    return self;
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
