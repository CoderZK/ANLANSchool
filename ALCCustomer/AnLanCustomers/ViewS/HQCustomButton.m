//
//  HQCustomButton.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "HQCustomButton.h"

@implementation HQCustomButton

 - (void)layoutSubviews  {
     [super layoutSubviews];
     /** 修改 title 的 frame */
     // 1.获取 titleLabel 的 frame
     CGRect titleLabelFrame = self.titleLabel.frame;
     
     // 1.获取 imageView 的 frame
      CGRect imageViewFrame = self.imageView.frame;
     
     // 2.修改 titleLabel 的 frame
     titleLabelFrame.origin.x = (self.frame.size.width - titleLabelFrame.size.width - imageViewFrame.size.width - 5)/2;
     // 3.重新赋值
     self.titleLabel.frame = titleLabelFrame;
     /** 修改 imageView 的 frame */
 
     // 2.修改 imageView 的 frame
     imageViewFrame.origin.x = titleLabelFrame.size.width + 5 + titleLabelFrame.origin.x;
     // 3.重新赋值
     self.imageView.frame = imageViewFrame;
     
 }

@end
