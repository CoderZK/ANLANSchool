//
//  ButtonView.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ButtonView.h"

@implementation ButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
    
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.button.layer.cornerRadius = frame.size.width/2;
        self.button.clipsToBounds = YES;
        [self addSubview:self.button];
        
        self.redV = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width * 3 / 4+5, 0.3 * frame.size.width/2, 8, 8)];
        self.redV.backgroundColor = [UIColor redColor];
        self.redV.layer.cornerRadius = 4;
        self.redV.clipsToBounds = YES;
        [self addSubview:self.redV];
        
        
        
    }
    return self;
}

@end
