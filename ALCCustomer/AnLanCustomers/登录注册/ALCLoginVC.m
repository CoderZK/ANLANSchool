//
//  ALCLoginVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/17.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCLoginVC.h"
#import "ALCUserGuideOneVC.h"

@interface ALCLoginVC ()
@property (weak, nonatomic) IBOutlet UIView *viewOne;
@property (weak, nonatomic) IBOutlet UIView *viewTwo;
@property (weak, nonatomic) IBOutlet UIView *viewThree;
@property (weak, nonatomic) IBOutlet UITextField *TF;
@property (weak, nonatomic) IBOutlet UILabel *LB;

@end

@implementation ALCLoginVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (IBAction)action:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.TF.secureTextEntry = sender.selected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewOne.layer.cornerRadius = 2.5;
    self.viewTwo.layer.cornerRadius = 22.5;
    self.viewTwo.clipsToBounds = self.viewOne.clipsToBounds = YES;
    self.viewOne.backgroundColor =[UIColor colorWithWhite:0.6 alpha:0.4];
    self.viewTwo.backgroundColor = [UIColor colorWithRed:0/255.0 green:221/255.0 blue:183/255.0 alpha:0.6];
    self.viewThree.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    
    [self.TF becomeFirstResponder];
    
    self.TF.tintColor = WhiteColor;
    
    
    if (self.isForgetPassWord) {
        self.LB.text = @"重新输入密码";
    }
    
    
}
- (IBAction)comfirmAction:(id)sender {
    
    if (self.TF.text.length != 6) {
        [SVProgressHUD showErrorWithStatus:@"请输入6位数字密码"];
        return;
    }

    [self registerAction];
    
    
}

- (void)registerAction {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"phone"] = self.phoneStr;
    dict[@"password"] = self.TF.text;
    NSString * str = [QYZJURLDefineTool app_registerURL];
    if (self.isForgetPassWord) {
        str = [QYZJURLDefineTool app_forgetPasswordURL];
    }
    [zkRequestTool networkingPOST:str parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [zkSignleTool shareTool].telphone = self.phoneStr;
            [zkSignleTool shareTool].password = self.TF.text;
            
            if (self.isForgetPassWord) {
                
                [SVProgressHUD showSuccessWithStatus:@"修改密码成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            }else {
                [zkSignleTool shareTool].session_token = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"token"]];;
                [zkSignleTool shareTool].isLogin = YES;
                ALCUserGuideOneVC * vc =[[ALCUserGuideOneVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.phoneStr = self.phoneStr;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
       
        
    }];
    
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
