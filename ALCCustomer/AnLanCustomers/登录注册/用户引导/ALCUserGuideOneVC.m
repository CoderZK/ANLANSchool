//
//  ALCUserGuideOneVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/18.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCUserGuideOneVC.h"
#import "ALCBasicInformationVC.h"
@interface ALCUserGuideOneVC ()
@property (weak, nonatomic) IBOutlet UIButton *bt;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;

@end

@implementation ALCUserGuideOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户档案引导";
    NSString * str = @"欢迎加入,\n为给您提供专业的健康服务, 将为您建立专属的健康档案。\n只需要1-2分钟完善信息，即可为您推荐适合的健康方案。";
    self.titleLB.numberOfLines = 0;
    self.titleLB.attributedText = [str getMutableAttributeStringWithFont:15 lineSpace:5 textColor:[UIColor blackColor]];
    self.bt.layer.cornerRadius = 5;
    self.bt.clipsToBounds = YES;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //为button设置文字
    //[button setTitle:@"" forState:(UIControlStateNormal)];
    // button.titleLabel.font = [UIFont systemFontOfSize:20];
    
    //为button设置image(和backgroudImage不一样)
    [button setImage:[UIImage imageNamed:@"youfan"] forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:@"youfan"] forState:(UIControlStateHighlighted)];

    CGRect frame = CGRectMake(0, 0, 25, 25);
    
    button.frame = frame;
    
    //[button sizeToFit];使button的大小就是里面内容的大小
    //使button里面的内容进行偏移
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
    
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor redColor] forState:(UIControlStateHighlighted)];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
}

- (void)back {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)bt:(id)sender {
    
    ALCBasicInformationVC * vc =[[ALCBasicInformationVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.phoneStr = self.phoneStr;
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
