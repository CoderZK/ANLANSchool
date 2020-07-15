//
//  ALCCityCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/4/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCCityCell.h"

@implementation ALCCityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.leftLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 11, ScreenW/2-30, 20)];
        self.leftLB.textColor = CharacterColor50;
        self.leftLB.font = kFont(14);
        [self addSubview:self.leftLB];
        
        self.lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 44, ScreenW/2, 0.4)];
        self.lineV.backgroundColor = lineBackColor;
        [self addSubview:self.lineV];
        
        self.backgroundColor = BackgroundColor;
        
        
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
