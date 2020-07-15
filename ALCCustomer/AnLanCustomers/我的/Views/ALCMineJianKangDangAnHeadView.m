//
//  ALCMineJianKangDangAnHeadView.m
//  AnLanCustomers
//
//  Created by zk on 2020/4/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCMineJianKangDangAnHeadView.h"

@interface ALCMineJianKangDangAnHeadView()<UIScrollViewDelegate>
@property(nonatomic,strong)UIImageView *moreImageV;
@end

@implementation ALCMineJianKangDangAnHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
 
        UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, sstatusHeight + 44 + 135)];
        [self addSubview:imgV];
        imgV.image = [UIImage imageNamed:@"jkgl105"];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, sstatusHeight + 44, ScreenW, 100)];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.bounces = NO;
        self.scrollView.delegate = self;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.scrollView.frame) - 20, ScreenW - 30 , 20)];
        self.pageControl.numberOfPages = 4;
        self.pageControl.currentPage = 2;
        self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        self.pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.pageControl.userInteractionEnabled = NO;
        [self addSubview:self.pageControl];
        
        self.headViewTwo = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.scrollView.frame), ScreenW - 30, 70)];
        self.headViewTwo.backgroundColor = WhiteColor;
        self.headViewTwo.layer.cornerRadius = 5;
        self.headViewTwo.layer.shadowColor = [UIColor blackColor].CGColor;
        self.headViewTwo.layer.shadowOffset = CGSizeMake(0, 0);
        self.headViewTwo.layer.shadowRadius = 5;
        self.headViewTwo.layer.shadowOpacity = 0.08;
        [self addSubview:self.headViewTwo];
        
        
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, ScreenW, 70);
        button.tag = 100;
        self.peopleBt = button;
        [self.headViewTwo addSubview:button];
        
        UILabel * LB1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, 70, 20)];
        LB1.font = kFont(15);
        LB1.textColor = CharacterColor50;
        LB1.text = @"我的医生";
        [self.headViewTwo addSubview:LB1];
        
        self.numberLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(LB1.frame), 25, 150, 20)];
        self.numberLB.font = kFont(14);
        self.numberLB.textColor = CharacterBack150;
        [self.headViewTwo addSubview:self.numberLB];
        self.numberLB.text = @"(共5人)";
        
        self.docImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW - 50 - 30-30, 10, 50, 50)];
        self.docImgV.layer.cornerRadius = 25;
        self.docImgV.clipsToBounds = YES;
        [self.headViewTwo addSubview:self.docImgV];
        
        UIImageView * moreImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW -30- 18-10, 26, 18, 18)];
        moreImgV.image = [UIImage imageNamed:@"you"];
        [self.headViewTwo addSubview:moreImgV];
        self.backgroundColor = WhiteColor;
        self.moreImageV = moreImgV;
    }
    return self;
}

- (void)setDataDocArray:(NSMutableArray<ALMessageModel *> *)dataDocArray {
    _dataDocArray = dataDocArray;
    self.numberLB.text = [NSString stringWithFormat:@"(共%ld人)",dataDocArray.count];
    if (dataDocArray.count > 0) {
        self.docImgV.hidden = self.moreImageV.hidden=NO;
        [self.docImgV sd_setImageWithURL:[dataDocArray[0].avatar getPicURL] placeholderImage:[UIImage imageNamed:@"369"]];
    }else {
        self.docImgV.hidden =self.moreImageV.hidden= YES;
    }
}


- (void)setDataArray:(NSMutableArray<ALMessageModel *> *)dataArray {
   
    _dataArray = dataArray;
    self.scrollView.contentSize = CGSizeMake(ScreenW * dataArray.count, 100);
    if (dataArray.count > 0) {
        self.pageControl.numberOfPages = dataArray.count;
        self.pageControl.currentPage = 0;
    }else {
        self.pageControl.numberOfPages = dataArray.count;
    }
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0;i<dataArray.count;i++) {
        
        UILabel * nameLB  = [[UILabel alloc] initWithFrame:CGRectMake(15 + i * ScreenW , 30, ScreenW - 120, 30)];
        nameLB.text = [NSString stringWithFormat:@"%@",self.dataArray[i].name.length > 0 ? self.dataArray[i].name:self.dataArray[i].nickname];
        nameLB.font = [UIFont systemFontOfSize:16 weight:0.2];
        nameLB.textColor = WhiteColor;
        [self.scrollView addSubview:nameLB];
        
        UILabel * genderLb  = [[UILabel alloc] initWithFrame:CGRectMake(15 + i * ScreenW , CGRectGetMaxY(nameLB.frame) + 5, 120, 30)];
        if ([self.dataArray[i].gender isEqualToString:@"2"]) {
            genderLb.text = [NSString stringWithFormat:@"女 %@岁",self.dataArray[i].age];;
        }else {
            genderLb.text = [NSString stringWithFormat:@"男 %@岁",self.dataArray[i].age];
        }
        genderLb.font = [UIFont systemFontOfSize:14 weight:0.2];
        genderLb.textColor = WhiteColor;
        [self.scrollView addSubview:genderLb];
        
        
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW-85 + i * ScreenW, 30, 70, 30)];
        button.tag = i+100;
        [button setTitle:@"健康信息>" forState:UIControlStateNormal];
        button.titleLabel.font = kFont(14);
        [button setTitleColor:WhiteColor forState:UIControlStateNormal];
        [self.scrollView addSubview:button];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

- (void)clickAction:(UIButton *)button {
    
    if (self.buttonClickBlock != nil) {
        self.buttonClickBlock(button.tag-100);
    }
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / ScreenW;
    self.pageControl.currentPage = index;
    
    if (self.scrollBlock != nil) {
        self.scrollBlock(index);
    }
    
}


@end
