
//
//  ALCMineViewOne.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCMineViewOne.h"

@implementation ALCMineViewOne

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WhiteColor;
        self.layer.cornerRadius = 5;
      
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.08;
        
        
        
        
    }
    return self;
}

- (void)setImgaArray:(NSArray *)imgaArray {
    _imgaArray = imgaArray;
}



- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    CGFloat ww = 70;
    CGFloat space = (self.mj_w - 280)/5;
    
    for (int i = 0 ; i < dataArray.count; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(space + (ww + space) * (i%4), 15, ww, ww)];
        button.tag = 100+ i;
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
        UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(12.5, 0, 45, 45)];
        imageV.image = [UIImage imageNamed:self.imgaArray[i]];
        [button addSubview:imageV];

        
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, ww, 20)];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = CharacterBlack100;
        [button addSubview:lb];
        lb.font = kFont(13);
        lb.text = self.nameArray[i];
        
    }
    
    
    
}

- (void)clickAction:(UIButton *)button {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickALCMineViewOne:withIndex:)]) {
        
        [self.delegate didClickALCMineViewOne:self withIndex:button.tag - 100];
        
    }
    
}



@end




