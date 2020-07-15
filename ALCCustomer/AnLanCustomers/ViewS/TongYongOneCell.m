//
//  TongYongOneCell.m
//  AnLanBB
//
//  Created by zk on 2020/3/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "TongYongOneCell.h"

@implementation TongYongOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.leftImgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 16, 18, 18)];
        [self addSubview:self.leftImgV];
        
        self.leftLB = [[UILabel alloc] initWithFrame:CGRectMake(38, 15, ScreenW - 38-15, 20)];
        self.leftLB.font = kFont(15);
        self.leftLB.textColor = CharacterColor50;
        [self addSubview:self.leftLB];
        
        
        
        self.moreImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW - 35, 15, 20, 20)];
        [self addSubview:self.moreImgV];
        self.moreImgV.image = [UIImage imageNamed:@"you"];
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(15, 49.4, ScreenW-30, 0.6)];
        backV.backgroundColor = lineBackColor;
        [self addSubview:backV];
        self.lineV = backV;
        
        
        
        self.rightLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 60, 15, 50, 20)];
        self.rightLB.font = kFont(14);
        self.rightLB.hidden = YES;
        self.rightLB.textAlignment = NSTextAlignmentCenter;
        self.rightLB.backgroundColor = GreenColor;
        self.rightLB.textColor = WhiteColor;
        [self addSubview:self.rightLB];
        
        
        
        
        
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
