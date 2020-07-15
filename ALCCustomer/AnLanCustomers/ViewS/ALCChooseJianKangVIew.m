//
//  ALCChooseJianKangVIew.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCChooseJianKangVIew.h"

@interface ALCChooseJianKangVIew()
@property(nonatomic,strong)UIView *whiteView,*headV,*footV,*backV;
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,assign)CGFloat whiteH;
@end


@implementation ALCChooseJianKangVIew

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        
        self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 35)];
        [self addSubview:self.headV];
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, ScreenW - 30, 20)];
        self.titleLB.font = [UIFont systemFontOfSize:15 weight:0.2];
        self.titleLB.textColor = CharacterColor50;
        [self.headV addSubview:self.titleLB];
        
        HQCustomButton * hb  = [[HQCustomButton alloc] initWithFrame:CGRectMake(ScreenW - 50, 10, 40, 30)];
        [self.headV addSubview:hb];
        self.rightBt = hb;
        hb.hidden = YES;
        
        
        
        self.backV = [[UIView alloc] init];
        [self addSubview:self.backV];
        self.backV.backgroundColor = BackgroundColor;
        [self.backV  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self);
            make.height.equalTo(@10);
        }];
        
        self.TV = [[IQTextView alloc] init];
        [self addSubview:self.TV];
        self.TV.layer.borderColor = CharacterColor80.CGColor;
        self.TV.layer.borderWidth = 1;
        self.TV.layer.cornerRadius = 3;
        self.TV.clipsToBounds = YES;
        self.TV.textColor = CharacterBlack100;
        self.TV.placeholderTextColor = CharacterBack150;
        self.TV.font = kFont(14);
        [self.TV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self).offset(-30);
            make.height.equalTo(@(120));
        }];
        
        
        self.whiteView = [[UIView alloc] init];
        [self addSubview:self.whiteView];
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.headV.mas_bottom).offset(15);
            make.bottom.equalTo(self).offset(-165);
        }];
        
        self.backgroundColor = WhiteColor;
        
        
        self.backVTwo = [[UIView alloc] init];
        [self addSubview:self.backVTwo];
        self.backVTwo.backgroundColor = lineBackColor;
        [self.backVTwo  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.height.equalTo(@1);
        }];
        
        
    }
    return self;
}

- (void)setTitleOneStr:(NSString *)titleOneStr {
    _titleOneStr = titleOneStr;
    if (self.titleTwoStr.length == 0) {
        self.titleLB.text = titleOneStr;
    }else {
        NSString * str = [NSString stringWithFormat:@"%@ (%@)",titleOneStr,self.titleTwoStr];
        self.titleLB.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:0 textColor:CharacterColor50 textColorTwo:CharacterBlack100 nsrange:NSMakeRange(str.length - self.titleTwoStr.length-2, self.titleTwoStr.length+2)];
    }
}

- (void)setIsShowTV:(BOOL)isShowTV {
    _isShowTV = isShowTV;
    if (isShowTV) {
        [self.whiteView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-165);
        }];
        self.TV.hidden = self.backV.hidden =  NO;
        self.hh =  35 + 15 +self.whiteH + 165;
        self.backVTwo.hidden = YES;
    }else {
        [self.whiteView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(20);
        }];
        self.TV.hidden = self.backV.hidden =  YES;
        self.hh =  35 + 15 + self.whiteH + 20;
        self.backVTwo.hidden = NO;
    }
    
    
}

- (void)setIsNODefalutSelect:(BOOL)isNODefalutSelect {
    _isNODefalutSelect = isNODefalutSelect;
}

- (void)setDataArray:(NSMutableArray<ALMessageModel *> *)dataArray {
    _dataArray = dataArray;
    [self setHuaTiWithArr:dataArray];
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
    
    if (arr.count == 0) {
        self.hh = 50;
        return;
    }
    
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
        [button setBackgroundImage:[UIImage imageNamed:@"gback"] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"backg"] forState:UIControlStateNormal];
        [button setTitle:str forState:UIControlStateNormal];
        CGFloat width =[str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width;
        
        button.x = totalW;
        button.y = btY0+(number-1) *(btH+spaceH);
        button.height =btH;
        button.width = width+40;
        totalW = button.x + button.width + spaceW;
        
        if(totalW  > ScreenW - 30) {
            totalW = XX;
            number +=1;
            button.x =totalW;
            button.y =btY0+ (number-1) *(btH + spaceH);
            button.height = btH;
            button.width = width+30;
            totalW = button.x + button.width + spaceW;
        }
        if (i+1 == arr.count ) {
            self.whiteH = CGRectGetMaxY(button.frame);
        }
        if (i == 0 && self.isNODefalutSelect == NO) {
            button.selected = YES;
            self.selectIndex = 0;
        }
        [self.whiteView addSubview:button];
        
    }
    
    
    
    
}




- (void)clickNameAction:(UIButton *)button {
    
    if (self.isOnlySelectOne) {
        for (int i = 0 ; i < self.dataArray.count; i++) {
            UIButton * bt = [self.whiteView viewWithTag:100+i];
            if (bt != button) {
                bt.selected = NO;
            }else {
                bt.selected = YES;
            }
        }
        
        if (self.didClickBlcok != nil) {
            self.didClickBlcok(button.tag - 100);
           }
        
        self.selectIndex = button.tag - 100;
    }else {
       button.selected = !button.selected;
    }

}
- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    
   
    
    for (int i = 0 ; i < self.dataArray.count; i++) {
        UIButton * bt = [self.whiteView viewWithTag:100+i];
        if (bt.tag != selectIndex+100) {
            bt.selected = NO;
        }else {
            bt.selected = YES;
        }
    }
    
    
}


@end
