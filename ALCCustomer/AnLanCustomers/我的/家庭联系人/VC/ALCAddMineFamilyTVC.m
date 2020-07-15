//
//  ALCAddMineFamilyTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/6/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCAddMineFamilyTVC.h"

@interface ALCAddMineFamilyTVC ()

@end

@implementation ALCAddMineFamilyTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新建家庭联系人";
    
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 0;
    button.clipsToBounds = YES;
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        
        
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}





@end
