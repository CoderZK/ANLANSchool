//
//  HHYSearchHeadView.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYSearchHeadView.h"
#import "HQCustomButton.h"

@interface HHYSearchHeadView()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *whiteV;
@property(nonatomic,assign)NSInteger selectTag;
@end

@implementation HHYSearchHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
       // 45 + 78
        CGFloat ww = 80;
        CGFloat space = (ScreenW-3*ww) / 6;
  
        NSArray * arr = @[@"地区",@"排序",@"筛选"];
        for (int i  = 0 ; i < arr.count; i++) {
            
            HQCustomButton * button = [[HQCustomButton alloc] initWithFrame:CGRectMake(space + (space * 2 + ww)*i, 5,ww, 40)];
            [button setImage:[UIImage imageNamed:@"xia"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"shang"] forState:UIControlStateSelected];
            [button setTitle:arr[i] forState:UIControlStateNormal];
//            [button setTitleColor:CharacterColor50 forState:UIControlStateNormal];
            [button setTitleColor:CharacterBlack100 forState:UIControlStateNormal];
            button.titleLabel.font = kFont(14);
//            button.backgroundColor = [UIColor redColor];
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
//            if (i== 0) {
//                button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//                [button setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
//
//            }else if (i == 3) {
//               button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//            }else {
//                button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//            }
            button.tag = 1000+i;
            [button addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        
    }
    return self;
}

- (void)setLeftStr:(NSString *)leftStr {
    _leftStr = leftStr;
    HQCustomButton * button = (HQCustomButton *)[self viewWithTag:1000];
    [button setTitle:leftStr forState:UIControlStateNormal];
    [button layoutIfNeeded];
}


- (void)hitAction:(UIButton *)bt {
    BOOL isShow = NO;
    for (int i = 1000 ; i < 1003 ; i++) {
        HQCustomButton * button = [self viewWithTag:i];
        if (bt == button ) { 
            if (bt.selected == NO) {
                isShow = YES;
                bt.selected = YES;
            }else {
                isShow =  bt.selected = NO;
            }
           
        }else {
            [button setImage:[UIImage imageNamed:@"xia"] forState:UIControlStateNormal];
            button.selected = NO;
        }
    }
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickIndex:withIsShow:)]) {
        [self.delegate didClickIndex:bt.tag - 1000 withIsShow:isShow];
    }
}

- (void)cancel{
    for (int i = 1000 ; i < 1003 ; i++) {
        UIButton * button = [self viewWithTag:i];
        button.selected = NO;
        [button setImage:[UIImage imageNamed:@"xia"] forState:UIControlStateNormal];
    }
    
}



@end
