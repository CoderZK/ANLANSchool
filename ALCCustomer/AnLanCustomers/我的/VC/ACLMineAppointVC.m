//
//  ACLMineAppointVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ACLMineAppointVC.h"
#import "ALCMineAppointmentTVC.h"
@interface ACLMineAppointVC ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIView *whiteV,*topTitleView;
@property(nonatomic,strong)UIButton *leftBt,*hitClickButton;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)ALCMineAppointmentTVC *neraTV,*hotTV;
@property(nonatomic,assign)NSInteger selectIndex;
@end

@implementation ACLMineAppointVC

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH  - sstatusHeight - 44)];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.selectIndex = 0;
       
       [self settitleView];
       
       [self addSubViews];

           UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
           [button setImage:[UIImage imageNamed:@"youfan"] forState:(UIControlStateNormal)];
           [button setImage:[UIImage imageNamed:@"youfan"] forState:(UIControlStateHighlighted)];
           CGRect frame = CGRectMake(0, 0, 40, 30);
           button.frame = frame;
           button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
           button.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
           [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
           [button setTitleColor:[UIColor redColor] forState:(UIControlStateHighlighted)];
           [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
           self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

}

- (void)back {
    
    if (self.isPay) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


- (void)settitleView {
    
    self.topTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    self.leftBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 44)];
    [self.leftBt setTitle:@"预约医生" forState:UIControlStateNormal];
    self.leftBt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.leftBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leftBt.tag = 100;
    [self.leftBt addTarget:self action:@selector(topTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.topTitleView addSubview:self.leftBt];
    

    
    self.hitClickButton = [[UIButton alloc] initWithFrame:CGRectMake(90, 0, 90, 44)];
    [self.hitClickButton setTitle:@"预约项目" forState:UIControlStateNormal];
    self.hitClickButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.hitClickButton.tag = 101;
    [self.hitClickButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.hitClickButton addTarget:self action:@selector(topTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.topTitleView addSubview:self.hitClickButton];
    
    
    self.whiteV = [[UIView alloc] init];
    self.whiteV.backgroundColor = [UIColor whiteColor];
    self.whiteV.mj_y = 40;
    self.whiteV.mj_w = [@"附近的人" getSizeWithMaxSize:CGSizeMake(1000, 1000) withFontSize:18].width;
    self.whiteV.mj_h = 2;
    self.whiteV.centerX = self.leftBt.centerX;
    [self.topTitleView addSubview:self.whiteV];
    self.navigationItem.titleView = self.topTitleView;
    
}

- (void)topTitleAction:(UIButton *)button {
    
    self.whiteV.width = button.titleLabel.width;
    [UIView animateWithDuration:0.1 animations:^{
        self.whiteV.centerX = button.centerX;
    }];
   
    self.selectIndex = button.tag - 100;
    if (button.tag == 100) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else {
        
        if (self.childViewControllers.count <2) {

            self.hotTV = [[ALCMineAppointmentTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            _hotTV.isHot = YES;
            self.hotTV.view.frame = CGRectMake(ScreenW, 0, ScreenW, self.scrollView.height);
            [self.scrollView addSubview:self.hotTV.view];
            [self addChildViewController:self.hotTV];

        }
        [self.scrollView setContentOffset:CGPointMake(ScreenW, 0) animated:YES];
       
    }
    
    

    
}


- (void)addSubViews {
    self.view.backgroundColor = [UIColor greenColor];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    self.neraTV = [[ALCMineAppointmentTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    _neraTV.isHot = NO;
    self.neraTV.view.frame = CGRectMake(0, 0, ScreenW, self.scrollView.height);
    self.scrollView.contentSize = CGSizeMake(ScreenW * 2, 0);
    [self.scrollView addSubview:self.neraTV.view];
    [self addChildViewController:self.neraTV];
    
    
 

    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    //    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    if (self.childViewControllers.count <2) {
        
        self.hotTV = [[ALCMineAppointmentTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        _hotTV.isHot = YES;
        self.hotTV.view.frame = CGRectMake(ScreenW, 0, ScreenW, self.scrollView.height);
        [self.scrollView addSubview:self.hotTV.view];
        [self addChildViewController:self.hotTV];
        
    }
    
    NSInteger aa = scrollView.contentOffset.x / ScreenW;
    self.selectIndex = aa;
    UIButton * button = [self.topTitleView viewWithTag:100 + aa];
    //    if (button.tag == 100) {
    //        self.touPiaoBt.hidden = NO;
    //    }else {
    //        self.touPiaoBt.hidden = YES;
    //    }
    [UIView animateWithDuration:0.1 animations:^{
        self.whiteV.centerX = button.centerX;
    }];
    
}


@end
