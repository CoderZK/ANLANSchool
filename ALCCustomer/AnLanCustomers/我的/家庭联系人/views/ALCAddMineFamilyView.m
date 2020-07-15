//
//  ALCAddMineFamilyView.m
//  AnLanCustomers
//
//  Created by zk on 2020/6/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCAddMineFamilyView.h"

@implementation ALCAddMineFamilyView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (UILabel *)leftLB {
    if (_leftLB == nil) {
        _leftLB = [[UILabel alloc] init];
        _leftLB.font = kFont(14);
        _leftLB.textColor = CharacterColor50;
    }
    return _leftLB;
}


@end
