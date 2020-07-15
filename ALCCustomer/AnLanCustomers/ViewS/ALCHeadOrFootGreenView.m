//
//  ALCHeadOrFootGreenView.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCHeadOrFootGreenView.h"

@implementation ALCHeadOrFootGreenView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
   if (self=[super initWithReuseIdentifier:reuseIdentifier])
    {
    
        self.leftLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 150, 25)];
        self.leftLB.font = [UIFont systemFontOfSize:15 weight:0.2];
        self.leftLB.textColor = CharacterColor50;
        [self addSubview:self.leftLB];
        
        self.greenV = [[UIView alloc] initWithFrame:CGRectMake(0, 14, 5, 17)];
        self.greenV.backgroundColor = GreenColor;
        [self addSubview:self.greenV];
        
       
    }
    self.contentView.backgroundColor = WhiteColor;
    self.backgroundColor = WhiteColor;
    return self;
    
    
}

@end
