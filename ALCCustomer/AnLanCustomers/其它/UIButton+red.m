//
//  UIButton+red.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "UIButton+red.h"

@implementation UIButton (red)

- (void)showViewWithColor:(UIColor *)color {
    
    CGFloat x = CGRectGetMaxX(self.imageView.frame);
    CGFloat y = CGRectGetMinY(self.imageView.frame);
    UIView * view = [self viewWithTag:1000];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(x-4, y-4, 8, 8)];
        view.layer.cornerRadius = 4;
        view.clipsToBounds = YES;
        view.backgroundColor = color;
        [self addSubview:view];
    }else {
        view.hidden = NO;
    }
    
    
}

- (void)dissView {
       UIView * view = [self viewWithTag:1000];
       if (view != nil) {
           view.hidden = YES;
       }
    
}

@end
