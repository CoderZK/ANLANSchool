//
//  ALCMineDorterView.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCMineDorterView.h"

@interface ALCMineDorterView()
@property(nonatomic,strong)UIView *whiteView;
@end

@implementation ALCMineDorterView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.whiteView = [[UIView alloc] init];
        [self addSubview:self.whiteView];
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(15);
            make.bottom.equalTo(self).offset(-15);
        }];
        
        self.backgroundColor = WhiteColor;
    }
    return self;
}
- (void)setDataArray:(NSMutableArray<ALMessageModel *> *)dataArray {
    _dataArray = dataArray;
    [self setHuaTiWithArr:dataArray];
}

- (void)setIsNoSelectOne:(BOOL)isNoSelectOne {
    _isNoSelectOne = isNoSelectOne;
}

- (void)setIsContainSelectImage:(BOOL)isContainSelectImage {
    _isContainSelectImage = isContainSelectImage;
}

- (void)setHuaTiWithArr:(NSArray<ALMessageModel *> *)arr {
    CGFloat XX = 15;
    CGFloat totalW = XX;
    NSInteger number = 1;
    CGFloat btH = 35;
    CGFloat spaceW = 10;
    CGFloat spaceH = 10;
    CGFloat btY0 = 0;
    [self.whiteView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0 ; i < arr.count; i++) {
        UIButton * button = (UIButton *)[self.whiteView viewWithTag:100+i];
        if (button==nil) {
            button =[UIButton new];
        }
        button.tag = 100+i;
        [button setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font =[UIFont systemFontOfSize:14];
        button.layer.cornerRadius = 17.5;
        button.clipsToBounds = YES;
        
        [button addTarget:self action:@selector(clickNameAction:) forControlEvents:UIControlEventTouchUpInside];
        NSString * str = [NSString stringWithFormat:@"%@",arr[i].name];
        [button setTitleColor:WhiteColor forState:UIControlStateSelected];
        
        [button setTitle:str forState:UIControlStateNormal];
        CGFloat width =[str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width;
//        button.backgroundColor = [UIColor redColor];
        button.x = totalW;
        button.y = btY0+(number-1) *(btH+spaceH);
        button.height =btH;
        
        
        
        if (i == 0 ) {
            if (self.isNoSelectOne) {
                button.userInteractionEnabled = button.selected = NO;
                button.titleLabel.font = kFont(16);
                button.width = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}].width;
                [button setTitleColor:CharacterColor50 forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"wback"] forState:UIControlStateNormal];
            }else {
                
                if (self.isNomalNOSelectOne) {
                   button.selected = NO;
                }else {
                   button.selected = YES;
                }
                [button setBackgroundImage:[UIImage imageNamed:@"gback"] forState:UIControlStateSelected];
                [button setBackgroundImage:[UIImage imageNamed:@"backg"] forState:UIControlStateNormal];
                button.width = width+10;
                
            }
        }else {
            [button setBackgroundImage:[UIImage imageNamed:@"gback"] forState:UIControlStateSelected];
            [button setBackgroundImage:[UIImage imageNamed:@"backg"] forState:UIControlStateNormal];
             button.width = width+40;
        }
//        if (!self.isContainSelectImage) {
//            [button setBackgroundImage:[UIImage imageNamed:@"gback"] forState:UIControlStateSelected];
//            [button setBackgroundImage:[UIImage imageNamed:@"backg"] forState:UIControlStateNormal];
//
//
//            button.width = width+40;
//
//        }else {
//            if (i == 0) {
//                button.selected = NO;
//            }
//
//            [button setImage:[UIImage imageNamed:@"jkgl26"] forState:UIControlStateSelected];
//            [button setImage:[UIImage imageNamed:@"jkgl25"] forState:UIControlStateNormal];
//            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
//            [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
//            [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//            [button setTitleColor:CharacterColor50 forState:UIControlStateSelected];
//            button.layer.cornerRadius = 0;
//            button.width = width  + 25 + 10 ;
//        }
        
        totalW = button.x + button.width + spaceW;
        
        if(totalW  > self.frame.size.width - 30) {
            totalW = XX;
            number +=1;
            button.x =totalW;
            button.y =btY0+ (number-1) *(btH + spaceH);
            button.height = btH;
            button.width = width+30;
            totalW = button.x + button.width + spaceW;
        }
        if (i+1 == arr.count ) {
            self.hh = self.height = CGRectGetMaxY(button.frame)+30;
        }
        
        [self.whiteView addSubview:button];
        
    }
    
    
}

- (void)clickNameAction:(UIButton *)button {
    
    if (self.isNOCanSelectAll) {
        
        for (int i = 0 ; i < self.dataArray.count; i++) {
            UIButton * buttonNei = (UIButton *)[self.whiteView viewWithTag:i+100];
            if (buttonNei != button) {
                buttonNei.selected = NO;
            }else {
                buttonNei.selected = YES;
                if (self.selectBlock != nil) {
                       self.selectBlock(button.tag-100);
                   }
            }
        }
        
        
    }else {
        
        button.selected = !button.selected;
        
    }
    
    
   
}


@end
