//
//  ALCMineHeathTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/6/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCMineHeathTVC.h"

@interface ALCMineHeathTVC ()
@property(nonatomic,strong)UIView *headV;
@end

@implementation ALCMineHeathTVC


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH+sstatusHeight);
    
    
    [self setHV];
    
}

- (void)setHV {
    
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    
   
    
    UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 250)];
    imgV.image = [UIImage imageNamed:@"jkgl157"];
    [self.headV addSubview:imgV];
    
    UIButton * backBt = [[UIButton alloc] initWithFrame:CGRectMake(10, sstatusHeight, 44, 44)];
    [backBt setImage:[UIImage imageNamed:@"youfan"] forState:UIControlStateNormal];
    [self.headV addSubview:backBt];
    [backBt addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLB = [[UILabel alloc] initWithFrame:CGRectMake(50, sstatusHeight , ScreenW - 100, 44)];
    titleLB.font = kFont(18);
    titleLB.textAlignment = NSTextAlignmentCenter;
    titleLB.textColor = WhiteColor;
    titleLB.text = @"健康信息";
    [self.headV addSubview:titleLB];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(15, sstatusHeight + 44 , ScreenW - 30, 900)];
    view.backgroundColor = WhiteColor;
    [self.headV addSubview:view];
    
    UILabel * lb1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, ScreenW - 60, 20)];
    lb1.textColor = CharacterColor50;
    lb1.font = [UIFont systemFontOfSize:16 weight:0.2];
    lb1.text = @"基本信息";
    [view addSubview:lb1];
    
    //头像
    UIImageView * headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(lb1.frame), CGRectGetMaxY(lb1.frame) + 15, 45, 45)];
    headImgV.layer.cornerRadius = 22.5;
    headImgV.clipsToBounds = YES;
    [view addSubview:headImgV];
    
    //性别
    UIImageView * sexImgV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImgV.frame) - 15, CGRectGetMaxY(headImgV.frame) - 15, 15, 15)];
    [view addSubview:sexImgV];
    
    //姓名
    UILabel * nameLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImgV.frame)+10, CGRectGetMinY(headImgV.frame) - 5 , 60, 20)];
    nameLb.textColor = CharacterColor50;
    nameLb.font = [UIFont systemFontOfSize:15 weight:0.2];
    [view addSubview:nameLb];
    
    //是否是vip
    UIImageView * vipImgV = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMinY(nameLb.frame), 70, 20)];
    [view addSubview:vipImgV];
    
    //病史
    
    NSArray * arr = @[@"年龄",@"出生日期",@"曾就诊机构",@"曾就诊项目"];
    
    UILabel * lb11 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(lb1.frame), CGRectGetMaxY(headImgV.frame) + 15, 60, 17)];
    lb11.text = @"年龄: ";
    lb11.textColor = CharacterBack150;
    lb11.mj_w = [lb11.text getWidhtWithFontSize:14];
    lb11.font = kFont(14);
    [view addSubview:lb11];
    
    UILabel * lb112 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lb11.frame) + 10, lb11.mj_y, ScreenW - 60 - lb11.mj_w - 10, 17)];
    lb112.textColor = CharacterBlack100;
    lb112.font = kFont(14);
    lb112.text = @"32岁";
    [view addSubview:lb112];
    
    
    UILabel * lb22 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(lb1.frame), CGRectGetMaxY(lb11.frame) + 10, 60, 17)];
    lb22.text = @"出生日期: ";
    lb22.textColor = CharacterBack150;
    lb22.mj_w = [lb22.text getWidhtWithFontSize:14];
    lb22.font = kFont(14);
    [view addSubview:lb22];
    
    UILabel * lb222 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lb22.frame) + 10, lb22.mj_y, ScreenW - 60 - lb22.mj_w - 10, 17)];
    lb222.textColor = CharacterBlack100;
    lb222.font = kFont(14);
    lb222.text = @"1990.6.3";
    [view addSubview:lb222];
    
    
    UILabel * lb33 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(lb1.frame), CGRectGetMaxY(lb22.frame) + 10, 60, 17)];
    lb33.text = @"曾就诊机构: ";
    lb33.textColor = CharacterBack150;
    lb33.mj_w = [lb33.text getWidhtWithFontSize:14];
    lb33.font = kFont(14);
    
    [view addSubview:lb33];
    
    UILabel * lb332 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lb33.frame) + 10, lb33.mj_y, ScreenW - 60 - lb33.mj_w - 10, 17)];
    lb332.textColor = CharacterBlack100;
    lb332.font = kFont(14);
    lb332.text = @"星空医疗";
    [view addSubview:lb332];
    
    UILabel * lb44 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(lb1.frame), CGRectGetMaxY(lb33.frame) + 10, 60, 17)];
    lb44.text = @"曾就诊项目: ";
    lb44.textColor = CharacterBack150;
    lb44.mj_w = [lb44.text getWidhtWithFontSize:14];
    lb44.font = kFont(14);
    [view addSubview:lb44];
    
    UILabel * lb442 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lb44.frame) + 10, lb44.mj_y, ScreenW - 60 - lb44.mj_w - 10, 17)];
    lb442.textColor = CharacterBlack100;
    lb442.font = kFont(14);
    [view addSubview:lb442];
    
    UIView * BMIView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lb442.frame) + 20 , ScreenW - 30, 200)];
    [view addSubview:BMIView];
    UILabel * bmL = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 60, 20)];
    bmL.textColor = CharacterColor50;
    bmL.text = @"BMI";
    bmL.font = [UIFont systemFontOfSize:16 weight:0.2];
    [BMIView addSubview:bmL];
    
    UIView * ggV = [[UIView alloc] initWithFrame:CGRectMake(15, 45 , ScreenW - 60, 6)];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)RGB(98, 235, 213).CGColor, (__bridge id)RGB(0, 217, 177).CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = ggV.bounds;
    [ggV.layer addSublayer:gradientLayer];
    ggV.layer.cornerRadius = 3;
    ggV.clipsToBounds = YES;
    
    [BMIView addSubview:ggV];
    NSArray * bmArr = @[@"偏瘦",@"正常",@"超重",@"肥胖"];
    for (int i = 0 ; i< bmArr.count; i++) {
        
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake( 15 + i * (ScreenW - 60 - 3) / 4 + i*1, CGRectGetMaxY(ggV.frame), (ScreenW - 60 - 3) / 4, 17)];
        lb.font = kFont(13);
        lb.textColor = CharacterBlack100;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = bmArr[i];
        [BMIView addSubview:lb];
        
        if (i > 0) {
            UIView * wV = [[UIView alloc] initWithFrame:CGRectMake(i * (ScreenW - 60 - 3) / 4 + (i -1)*1, 0, 1, ggV.mj_h)];
            wV.backgroundColor = WhiteColor;
            [ggV addSubview:wV];
        }
        
        
    }
    
    ALCMineHeathNumberView * numberViewOne = [[ALCMineHeathNumberView alloc] initWithFrame:CGRectMake(100, 20, [@"20.1" getWidhtWithFontSize:13] + 10, 23)];
    numberViewOne.titleLB.text = @"20.1";
    [BMIView addSubview:numberViewOne];


    UILabel * TZL = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(ggV.frame) + 40, ScreenW - 60, 20)];
    TZL.textColor = CharacterColor50;
    TZL.text = @"体重";
    TZL.font = [UIFont systemFontOfSize:16 weight:0.2];
    [BMIView addSubview:TZL];

    UIView * ggVTwo = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(TZL.frame) + 25 , ScreenW - 60, 6)];
    [BMIView addSubview:ggVTwo];
    ggVTwo.backgroundColor = [UIColor groupTableViewBackgroundColor];
    ggVTwo.layer.cornerRadius = 3;
    ggVTwo.clipsToBounds = YES;

    

    ALCMineHeathNumberView * numberViewTwo = [[ALCMineHeathNumberView alloc] initWithFrame:CGRectMake(150, ggVTwo.mj_y - 25, [@"60.1kg" getWidhtWithFontSize:13] + 10, 23)];
    numberViewTwo.titleLB.text = @"60.1kg";
    [BMIView addSubview:numberViewTwo];
    
    BMIView.mj_h = CGRectGetMaxY(numberViewTwo.frame) + 40;
    
    view.mj_h = CGRectGetMaxY(BMIView.frame);

    
    
    
    
    
    
    UIView * viewTwo = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(view.frame), ScreenW -30, 200)];
    viewTwo.backgroundColor = [UIColor whiteColor];
    [self.headV addSubview:viewTwo];
    UIImageView * imgVTwo = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
    [viewTwo addSubview:imgVTwo];
    
    
    UILabel * CPL = [[UILabel alloc] initWithFrame:CGRectMake(35, 15, ScreenW - 60, 20)];
    CPL.textColor = CharacterColor50;
    CPL.text = @"测评结果";
    CPL.font = [UIFont systemFontOfSize:16 weight:0.2];
    [viewTwo addSubview:CPL];

    UIView * viewThree = [[UIView alloc] initWithFrame:CGRectMake(15, 50, ScreenW - 60, 50)];
    viewThree.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [viewTwo addSubview:viewThree];
    
    UILabel * cpLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, ScreenW - 90, 20)];
    [viewThree addSubview:cpLb];
    
    cpLb.text = @"and发脾气何润锋青海人发";
    
    
    viewTwo.mj_h = CGRectGetMaxY(viewThree.frame) + 20;
    
    self.headV.mj_h = CGRectGetMaxY(viewTwo.frame);
    
    
    
    
    
    self.tableView.tableHeaderView = self.headV;
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
    
    
}


@end


@implementation  ALCMineHeathNumberView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 5)];
        self.titleLB.font = kFont(13);
        self.titleLB.textColor = WhiteColor;
        self.titleLB.textAlignment = NSTextAlignmentCenter;
        self.titleLB.layer.cornerRadius = (frame.size.height - 5)/2.0;
        self.titleLB.backgroundColor = RGB(0, 217, 177);
        self.titleLB.clipsToBounds = YES;
        [self addSubview:self.titleLB];
        
        self.jianTouImgV = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-3, CGRectGetMaxY(self.titleLB.frame) - 1, 6, 6)];
        self.jianTouImgV.image = [UIImage imageNamed:@"gjian"];
        [self addSubview:self.jianTouImgV];
        
        
        
        
    }
    return self;
}

@end

