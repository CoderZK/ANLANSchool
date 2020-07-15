//
//  ALCHomeJianKangCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCHomeJianKangCell.h"

@implementation ALCHomeJianKangCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
        [self addSubview:self.imgV];
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, ScreenW - 30 - 80- 15 -70, 20)];
        self.titleLB.font = kFont(14);
        self.titleLB.textColor = CharacterColor50;
        [self addSubview:self.titleLB];
        self.titleLB.text = @"52251/100000";
        
        self.bezierView = [[BezierCurveView alloc] initWithFrame:CGRectMake(ScreenW-30-90, 20, 80, 40)];
        [self addSubview:self.bezierView];
        self.bezierView.dorwColor = GreenColor;

        self.lineV = [[UIView alloc] init];
        [self addSubview:self.lineV];
        self.lineV.backgroundColor = lineBackColor;
        [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.height.equalTo(@(0.6));
        }];
        
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
