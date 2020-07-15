//
//  ACLHeadOrFootView.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ACLHeadOrFootView.h"

@implementation ACLHeadOrFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
   if (self=[super initWithReuseIdentifier:reuseIdentifier])
    {
    
        self.leftLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 150, 25)];
        self.leftLB.font = [UIFont systemFontOfSize:15 weight:0.2];
        self.leftLB.textColor = CharacterColor50;
        [self addSubview:self.leftLB];
        
        self.rightBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 50, 2.5, 40, 40)];
        [self.rightBt setImage:[UIImage imageNamed:@"you"] forState:UIControlStateNormal];
        self.rightBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self addSubview:self.rightBt];
        
        self.lineV = [[UIView alloc] init];
        [self addSubview:self.lineV];
        [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@(0.6));
        }];
        self.lineV.backgroundColor = lineBackColor;
        self.lineV.hidden = YES;
        
    }
    self.contentView.backgroundColor = WhiteColor;
    self.backgroundColor = WhiteColor;
    return self;
    
    
}
@end
