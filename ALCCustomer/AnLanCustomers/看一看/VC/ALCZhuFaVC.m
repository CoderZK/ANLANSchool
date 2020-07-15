//
//  ALCZhuFaVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/6/15.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCZhuFaVC.h"
#import "GuanZhuVC.h"
@interface ALCZhuFaVC ()<UIScrollViewDelegate,UITextFieldDelegate>
/** 三个按钮的View buttonView */
@property(nonatomic , strong)UIView *buttonView;
/** 下面的红色指示剂 */
@property(nonatomic , strong)UIView *alertView;
/** 滚动视图 */
@property(nonatomic , strong)UIScrollView *scrollview;
/** 选中的button */
@property(nonatomic , strong)UIButton *selectBt;
@property(nonatomic,strong)UIButton *editBt;

@end

@implementation ALCZhuFaVC

- (void)viewDidLoad {
    [super viewDidLoad];
   

   
    
    

       //设置下面的三个按钮
    [self setupHeaderView];
       //添加字控制器
    [self addChildsVC];
       //添加滚动视图
    [self addScrollview];
    
    [self setHeadView];
}


- (void)setHeadView {

    ALCSearchView * searchTitleView = [[ALCSearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 70, 44)];
    searchTitleView.searchTF.delegate = self;
    searchTitleView.isPush = YES;
    self.navigationItem.titleView = searchTitleView;
//    @weakify(self);
//    [[[searchTitleView.searchTF rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
//        @strongify(self);
//        if (value.length > 0) {
//            return YES;
//        }else {
//            return NO;
//        }
//    }] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"======\n%@",x);
//    }];


    @weakify(self);
    [[searchTitleView.clickBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           @strongify(self);
           ALCMineSearchTVC * vc =[[ALCMineSearchTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
           vc.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:vc animated:YES];

       }];

    self.navigationItem.titleView = searchTitleView;
    UIButton * submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 200, 44, 44)];
//    submitBtn.layer.cornerRadius = 22;
//    submitBtn.layer.masksToBounds = YES;
    // [submitBtn setTitle:@"搜索" forState:UIControlStateNormal];

    [submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitBtn setImage:[UIImage imageNamed:@"jkgl1"] forState:UIControlStateNormal];
    submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [submitBtn showViewWithColor:[UIColor redColor]];

    [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.editBt = submitBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];

    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:nil];


}

- (void)submitBtnClick:(UIButton *)button {
     if (!isDidLogin) {
         [self gotoLoginVC];
         return;
     }
     ACLMineMessageTVC * vc =[[ACLMineMessageTVC alloc] init];
     vc.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:vc animated:YES];
}



//添加滚动视图
- (void)addScrollview {
    //不需要调整inset
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollview =[[UIScrollView alloc] init];
    self.scrollview.frame = CGRectMake(0, 35 , ScreenW, ScreenH  - 35 - 49 - sstatusHeight - 44);
    if (sstatusHeight > 20) {
        self.scrollview.frame = CGRectMake(0, 35 , ScreenW, ScreenH  - 35 - 49 - 34 -  sstatusHeight - 44);
    }
    
    self.scrollview.backgroundColor =[UIColor whiteColor];
    
    self.scrollview.contentSize = CGSizeMake(self.childViewControllers.count * ScreenW, 0);
    self.scrollview.delegate = self;
    self.scrollview.pagingEnabled = YES;
    [self.view insertSubview:_scrollview atIndex:1];
    self.scrollview.showsHorizontalScrollIndicator = NO;
    self.scrollview.scrollEnabled = YES;
    
    //调用动画结束时,使第一个界面有数据.
    [self scrollViewDidEndScrollingAnimation:_scrollview];
    

    
    
}




//设置三个按钮
- (void)setupHeaderView {
    NSArray *array = @[@"热点",@"推荐",@"视频",@"文章"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 35)];
    
    self.buttonView = view;
//    self.buttonView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_1"]];
    self.buttonView.backgroundColor = WhiteColor;
    [self.view addSubview:self.buttonView];
    
    self.alertView =[[UIView alloc] init];
    self.alertView.backgroundColor = GreenColor;
    self.alertView.height = 2;
    self.alertView.y = 35 - 3;
    
    for (int i = 0 ; i < array.count; i ++ ) {
        UIButton * button =[UIButton new];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        //不可以点击时时红色
        [button setTitleColor:GreenColor forState:UIControlStateDisabled];
        button.tag =i;
        CGFloat ww = 70;
        button.width = ww;
        button.height = 35;
        button.x = i * ww;
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [self.buttonView addSubview:button];
        [button addTarget:self action:@selector(clickbutton:) forControlEvents:UIControlEventTouchUpInside];

        if (i == 0 ) {
            [button layoutIfNeeded];
            [button.titleLabel sizeToFit];
            button.enabled = NO;
            
            self.selectBt = button;
            self.alertView.width = button.titleLabel.width;
            self.alertView.centerX = button.centerX;
        }
        
    }
    [self.buttonView addSubview:self.alertView];
    
}

//点击上面分类按钮
- (void)clickbutton:(UIButton *)button {
    //设置当前的button 的选中状态
    self.selectBt.enabled = YES;
    button.enabled = NO;
    self.selectBt = button;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.alertView.width = button.titleLabel.width;
        self.alertView.centerX = button.centerX;
        
    }];
    
    CGPoint Offset = self.scrollview.contentOffset;
    Offset.x = button.tag * self.scrollview.width;
    //设置偏移量,可以移动
    [self.scrollview setContentOffset:Offset animated:YES];
    
    GuanZhuVC * vc = self.childViewControllers[button.tag];
    switch (self.selectBt.tag) {
        case 0:{
            vc.type = 3;
           
            break;
        }
        case 1:{
            vc.type =2;
           
            break;
        }
        case 2:{
            vc.type =1;
            break;
        }
        case 3:{
            vc.type =0;
           
            break;
        }
        case 4:{
            vc.type =4;
            break;
        }
        default:
            break;
    }
    
    
    
    
}

//添加子控制器
- (void)addChildsVC {
   
    for (int i = 0 ; i < 4; i++) {
        GuanZhuVC * vc = [[GuanZhuVC alloc] init];
        vc.type = 3-i;
        [self addChildViewController:vc];
    }
    
    
    
    
}
//滚动停止时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //调用动画结束时的方法.
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index =scrollView.contentOffset.x / scrollView.width;
    [self clickbutton:self.buttonView.subviews[index]];
    
    
    
    
    
}

//动画结束时的方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    BaseViewController * vc = self.childViewControllers[index];
    //要设置fram 不然系统会自动去掉状态栏高度
    vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, _scrollview.width, _scrollview.height);
    // vc.view.x = scrollView.contentOffset.x;
    // vc.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
//    vc.tableView.scrollIndicatorInsets = vc.collectionView.contentInset;
    [scrollView addSubview:vc.view];
    
    
}




@end
