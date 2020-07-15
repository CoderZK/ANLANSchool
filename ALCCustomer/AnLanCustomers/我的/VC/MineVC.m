//
//  MineVC.m
//  AnLanCustomers
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "MineVC.h"
#import "ALCMineViewOne.h"
#import "ALCJianKangDangAnTVC.h"
#import "ALCEditMineJianKangTVC.h"
#import "ACLMineAppointVC.h"
#import "ALCMineReferTVC.h"
#import "ACLMineColletFarterVC.h"
#import "ACLMineMessageTVC.h"
#import "ALCSettingTVC.h"
#import "ALCLoginOneVC.h"
#import "ALCEditMineZiLiaoVC.h"
#import "ALCMineHeathTVC.h"
#import "ALCMineFamilyTVC.h"

@interface MineVC ()<ALCMineViewOneDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)UIButton *headBt;
@property(nonatomic,strong)UILabel *phoneLB;
@property(nonatomic,strong)UIButton *leftBt,*editBt;
@property(nonatomic,strong)UIPageControl *pageControl;

@property(nonatomic,strong)UIView *footV;
@property(nonatomic,strong)UIButton *nameBt;
@property(nonatomic,strong)ALMessageModel *dataModel;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSArray<ALMessageModel *> *mineFailyArr;


@end

@implementation MineVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    if (isDidLogin) {
        [self getData];
        [self getHeathData];
        [self getMessageData];
        self.footV.hidden = NO;
    }else {
        
        [self.nameBt setTitle:@"点击登录" forState:UIControlStateNormal];
        self.footV.hidden = YES;
        
    }
    
    if (!isDidLogin) {
        [self gotoLoginVC];
        return;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH);
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"setting"] forState:(UIControlStateNormal)];
    CGRect frame = CGRectMake(15, sstatusHeight + 7, 30, 30);
    button.frame = frame;
    button.tag = 103;
    [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setImage:[UIImage imageNamed:@"jkgl1"] forState:(UIControlStateNormal)];
    CGRect frame1 = CGRectMake(60, sstatusHeight + 7, 30, 30);
    button1.frame = frame1;
    [button1 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    button1.tag = 102;
    self.leftBt = button1;
    
    [self addheadV];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
        [self getHeathData];
        [self getMessageData];
        self.footV.hidden = NO;
    }];
    
}

- (void)getMessageData {
    if (!isDidLogin) {
        [self gotoLoginVC];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_findSystemMessageURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [self.leftBt setBadge:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"cnt"]] andFont:8];
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (void)getData {
    if (!isDidLogin) {
        [self gotoLoginVC];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_personInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [zkSignleTool shareTool].nick_name = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"nickname"]];
            [zkSignleTool shareTool].avatar =  [NSString stringWithFormat:@"%@",responseObject[@"data"][@"avatar"]];
            [zkSignleTool shareTool].telphone = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"phone"]];
            [self.nameBt setTitle:[zkSignleTool shareTool].nick_name forState:UIControlStateNormal];
            [self.headBt sd_setBackgroundImageWithURL:[[zkSignleTool shareTool].avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        
    }];
}

- (void)getHeathData {
    if (!isDidLogin) {
        [self gotoLoginVC];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_getMyInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self.tableView.mj_header endRefreshing];
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.mineFailyArr = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self setDangAnWithArr:self.mineFailyArr];
            self.pageControl.currentPage = 0;
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        
    }];
}

- (void)addheadV {
    
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    
    UIImageView * imgVOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 220)];
    imgVOne.image = [UIImage imageNamed:@"jkgl95"];
    [self.headV addSubview:imgVOne];
    
    UIView * viewTwo = [[UIView alloc] init];;
    viewTwo.backgroundColor = WhiteColor;
    [self.headV addSubview:viewTwo];
    [viewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headV).offset((CGRectGetMaxY(imgVOne.frame)));
        make.bottom.left.right.equalTo(self.headV).offset(0);
        
    }];
    
    self.headV.mj_h =1000;
    self.tableView.tableHeaderView = self.headV;
    
    NSArray * arrone = @[@"我的预约",@"我的咨询",@"我的订单",@"我的收藏"];
    NSArray * arrtwo = @[@"家庭联系人",@"会员专区",@"体检中心",@"保险产品"];
    
    
    ALCMineViewOne * mineOneV = [[ALCMineViewOne alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(imgVOne.frame) - 25, ScreenW - 30, 100)];
    mineOneV.tag = 100;
    mineOneV.imgaArray = @[@"jkgl96",@"jkgl97",@"jkgl98",@"jkgl99"];
    mineOneV.delegate = self;
    mineOneV.nameArray = arrone;
    mineOneV.dataArray = arrone;
    [self.headV addSubview:mineOneV];
    
    
    
    ALCMineViewOne * mineTwoV = [[ALCMineViewOne alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(mineOneV.frame) + 25, ScreenW - 30, 100)];
    mineTwoV.tag = 101;
    mineTwoV.imgaArray =  @[@"jkgl100",@"jkgl101",@"jkgl102",@"jkgl103"];
    mineTwoV.nameArray = arrtwo;
    mineTwoV.delegate = self;
    mineTwoV.dataArray = arrtwo;
    
    [self.headV addSubview:mineTwoV];
    
    
    self.headBt = [[UIButton alloc] initWithFrame:CGRectMake((ScreenW - 45)/2, (220-45)/2, 45, 45)];
    self.headBt.layer.cornerRadius = 22.5;
    self.headBt.clipsToBounds = YES;
    self.headBt.layer.borderColor = WhiteColor.CGColor;
    self.headBt.layer.borderWidth = 1;
    [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
    [self.headV addSubview:self.headBt];
    
    @weakify(self);
    [[self.headBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (isDidLogin) {
            ALCEditMineZiLiaoVC * vc =[[ALCEditMineZiLiaoVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            [self gotoLoginVC];
            
        }
    }];
    
    //    self.phoneLB = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headBt.frame) + 10, ScreenW, 18)];
    //    self.phoneLB.textAlignment = NSTextAlignmentCenter;
    //    self.phoneLB.font = kFont(14);
    //    self.phoneLB.textColor = WhiteColor;
    //    self.phoneLB.text = @"123549632548";
    //    [self.headV addSubview:self.phoneLB];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headBt.frame) + 10, ScreenW, 18)];
    button.titleLabel.font = kFont(14);
    [button setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self.headV addSubview:button];
    self.nameBt = button;
    if (isDidLogin) {
        [self.nameBt setTitle:[zkSignleTool shareTool].nick_name forState:UIControlStateNormal];
    }else {
        [self.nameBt setTitle:@"点击登录" forState:UIControlStateNormal];
    }
    
    [self.nameBt addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(mineTwoV.frame) + 20, ScreenW - 30, 240)];
    
    if ([zkSignleTool shareTool].isUp) {
        self.footV.mj_y = CGRectGetMaxY(mineOneV.frame) + 20;
        mineTwoV.hidden = YES;
    }else {
        self.footV.mj_y = CGRectGetMaxY(mineTwoV.frame) + 20;
        mineTwoV.hidden = NO;
    }
    
    self.footV.backgroundColor = WhiteColor;
    self.footV.layer.cornerRadius = 5;
    self.footV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.footV.layer.shadowOffset = CGSizeMake(0, 0);
    self.footV.layer.shadowRadius = 5;
    self.footV.layer.shadowOpacity = 0.08;
    
    [self.headV addSubview:self.footV];
    
    [self addFootViews];
    
    self.headV.mj_h = CGRectGetMaxY(self.footV.frame) + 30;
    self.tableView.tableHeaderView = self.headV;
    
}

- (void)loginAction {
    if (isDidLogin) {
        return;
    }
    [self gotoLoginVC];
}


- (void)addFootViews {
    
    UILabel * lb  = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, self.footV.mj_w - 120, 44.4)];
    lb.font = kFont(15);
    lb.textColor = CharacterColor50;
    lb.text = @"健康档案";
    lb.textAlignment = NSTextAlignmentCenter;
    [self.footV addSubview:lb];
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, ScreenW - 30, 195)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.footV addSubview:self.scrollView];
    
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.scrollView.frame) - 20, ScreenW - 30 , 20)];
    self.pageControl.numberOfPages = 4;
    self.pageControl.currentPage = 2;
    self.pageControl.pageIndicatorTintColor = RGB(240, 240, 240);
    self.pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.pageControl.userInteractionEnabled = NO;
    [self.footV addSubview:self.pageControl];
    
    //    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    //    button.frame = CGRectMake(self.footV.mj_w - 45, 2.5, 40, 40);
    //    [button setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
    //    [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    //    button.tag = 100;
    //    [self.footV addSubview:button];
    
    UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 44.4, self.footV.mj_w, 0.6)];
    lineV.backgroundColor = lineBackColor;
    [self.footV addSubview:lineV];
    
    
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / (ScreenW - 30);
    self.pageControl.currentPage = index;
}



- (void)setDangAnWithArr:(NSArray<ALMessageModel *> *)arr {
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.contentSize = CGSizeMake((arr.count +1) * (ScreenW - 30), 195);
    self.pageControl.numberOfPages = arr.count + 1;
//    self.pageControl.currentPage = 0;
    for (int i = 0 ; i < arr.count + 1; i++) {
        if (i<arr.count) {
            UILabel * nameLB = [[UILabel alloc] initWithFrame:CGRectMake(10 +  (ScreenW - 30) * i , 10, self.footV.mj_w - 20,20)];
            nameLB.textAlignment = NSTextAlignmentCenter;
            nameLB.font = kFont(14);
            nameLB.textColor = CharacterColor50;
            [self.scrollView addSubview:nameLB];
            
            
            UILabel *  dorLB = [[UILabel alloc] initWithFrame:CGRectMake(self.scrollView.mj_w/2 - 70-40 + (ScreenW - 30) * i, CGRectGetMaxY(nameLB.frame) + 20, 70,20)];
            dorLB.textAlignment = NSTextAlignmentCenter;
            dorLB.font = kFont(14);
            dorLB.textColor = CharacterColor50;
            [self.scrollView addSubview:dorLB];
            dorLB.text = @"6";
            
            UILabel * messLB = [[UILabel alloc] initWithFrame:CGRectMake(self.scrollView.mj_w/2 + 40 + (ScreenW - 30) * i, CGRectGetMaxY(nameLB.frame) + 20, 70,20)];
            messLB.textAlignment = NSTextAlignmentCenter;
            messLB.font = kFont(14);
            messLB.textColor = CharacterColor50;
            [self.scrollView addSubview:messLB];
            messLB.text = @"去完善";
            messLB.layer.borderWidth = 1;
            messLB.layer.borderColor = CharacterColor50.CGColor;
            messLB.layer.cornerRadius = 10;
            messLB.clipsToBounds = YES;
            messLB.userInteractionEnabled = YES;
            
            UIButton * editBt = [[UIButton alloc] initWithFrame:messLB.bounds];
            [messLB addSubview:editBt];
            editBt.tag = i+100;
            [editBt addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            UILabel * dorL = [[UILabel alloc] initWithFrame:CGRectMake(self.scrollView.mj_w/2 - 70-40+ (ScreenW - 30) * i, CGRectGetMaxY(dorLB.frame), 70,20)];
            dorL.textColor= CharacterBlack100;
            dorL.textAlignment = NSTextAlignmentCenter;
            dorL.text = @"我的医生";
            dorL.font = kFont(14);
            [self.scrollView addSubview:dorL];
            
            
            UILabel * mesL = [[UILabel alloc] initWithFrame:CGRectMake(self.scrollView.mj_w/2 + 40+ (ScreenW - 30) * i, CGRectGetMaxY(dorLB.frame), 70,20)];
            mesL.textColor= CharacterBlack100;
            mesL.textAlignment = NSTextAlignmentCenter;
            mesL.text = @"健康信息";
            mesL.font = kFont(14);
            [self.scrollView addSubview:mesL];
            
            
            UIButton * lookBt = [[UIButton alloc] initWithFrame:CGRectMake((self.scrollView.mj_w - 120)/2.0 + (ScreenW - 30) * i, self.scrollView.mj_h - 45 - 35, 120, 40)];
            
            lookBt.tag = 100+i;
            [lookBt setTitle:@"查看健康档案" forState:UIControlStateNormal];
            lookBt.titleLabel.font = kFont(15);
            [lookBt setTitleColor:GreenColor forState:UIControlStateNormal];
            lookBt.layer.cornerRadius = 20;
            lookBt.clipsToBounds = YES;
            lookBt.layer.borderWidth = 1;
            lookBt.layer.borderColor = GreenColor.CGColor;
            [lookBt addTarget:self action:@selector(lookAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:lookBt];
            
            ALMessageModel * model = arr[i];
            if ([model.gender isEqualToString:@"2"]) {
                nameLB.text = [NSString stringWithFormat:@"%@ %@岁 女",model.name,model.age];
            }else {
                nameLB.text = [NSString stringWithFormat:@"%@ %@岁 男",model.name,model.age];
            }
            
            if ([model.healthInfoRate isEqualToString:@"0%"]) {
                messLB.text = @"去完善";
                messLB.layer.borderWidth = 1;
                messLB.layer.borderColor = CharacterColor50.CGColor;
                messLB.layer.cornerRadius = 10;
                
            }else {
                messLB.text = model.healthInfoRate;
                messLB.layer.borderWidth = 0;
                messLB.layer.borderColor = CharacterColor50.CGColor;
                messLB.layer.cornerRadius = 0;
            }
            dorLB.text = model.doctorCnt;
        }else {
            UIButton * lookBt = [[UIButton alloc] initWithFrame:CGRectMake((self.scrollView.mj_w - 120)/2.0 + (ScreenW - 30) * i, self.scrollView.mj_h/2 - 20, 120, 40)];
                       
            lookBt.tag = 100+i;
            [lookBt setTitle:@"增加健康档案" forState:UIControlStateNormal];
            lookBt.titleLabel.font = kFont(15);
            [lookBt setTitleColor:GreenColor forState:UIControlStateNormal];
            lookBt.layer.cornerRadius = 20;
            lookBt.clipsToBounds = YES;
            lookBt.layer.borderWidth = 1;
            lookBt.layer.borderColor = GreenColor.CGColor;
            [lookBt addTarget:self action:@selector(lookAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:lookBt];
        }
        
        
        
    }
    
    
    
    
}



- (void)editAction:(UIButton *)button  {
    
    //    ALCMineHeathTVC * vc =[[ALCMineHeathTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    //    vc.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:vc animated:YES];  
    //    return;
    
    ALCEditMineJianKangTVC * vc =[[ALCEditMineJianKangTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.dataModel = self.mineFailyArr[button.tag - 100];
    Weak(weakSelf);
    vc.sucessBlock = ^{
        [weakSelf getHeathData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)clickAction:(UIButton *)button {
    
    if (button.tag == 100) {
        //点击分享
    }else if (button.tag == 101) {
        //点击的是查看档案
        if (self.dataModel == nil) {
            return;
        }
        ALCJianKangDangAnTVC * vc =[[ALCJianKangDangAnTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        //          vc.dataArray = @[self.dataModel].mutableCopy;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (button.tag == 102){
        //点击信息
        
        if (!isDidLogin) {
            [self gotoLoginVC];
            return;
        }
        
        ACLMineMessageTVC * vc =[[ACLMineMessageTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (button.tag == 103){
        //点击设置
        ALCSettingTVC * vc =[[ALCSettingTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

//查看档案
- (void)lookAction:(UIButton *)button {
    
    if (button.tag - 100 == self.mineFailyArr.count) {
        //跳转到我的家人
        ALCMineFamilyTVC * vc =[[ALCMineFamilyTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];

    }else {
        //跳转到健康档案
        ALCJianKangDangAnTVC * vc =[[ALCJianKangDangAnTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
           vc.hidesBottomBarWhenPushed = YES;
           vc.model = self.mineFailyArr[button.tag - 100];
           [self.navigationController pushViewController:vc animated:YES];
    }
    
   
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
}

#pragma mark ------ 点击上面八个模块 -----
- (void)didClickALCMineViewOne:(ALCMineViewOne *)viewOne withIndex:(NSInteger)index {
    if (viewOne.tag == 100) {
        
        if (!isDidLogin) {
            [self gotoLoginVC];
            return;
        }
        
        //点击的是我的预约模块
        if (index == 0) {
            //我的预约
            ACLMineAppointVC * vc =[[ACLMineAppointVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (index == 1) {
            //我的咨询
            ALCMineReferTVC * vc =[[ALCMineReferTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (index == 2) {
            
        }else if (index == 3) {
            //我的收藏
            ACLMineColletFarterVC * vc =[[ACLMineColletFarterVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else {
        if (index == 0) {
            //跳转到我的家人
            ALCMineFamilyTVC * vc =[[ALCMineFamilyTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (index == 1) {
            
        }else if (index == 2) {
            
        }else if (index == 3) {
            
        }
    }
    
    
}

@end
