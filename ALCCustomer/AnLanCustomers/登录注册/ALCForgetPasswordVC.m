//
//  ALCForgetPasswordVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCForgetPasswordVC.h"
#import "ALCCodeVC.h"
@interface ALCForgetPasswordVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgVTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imgVOne;
@property (weak, nonatomic) IBOutlet UIImageView *imgVTh;
@property (weak, nonatomic) IBOutlet UITextField *TF;
@property (weak, nonatomic) IBOutlet UIView *viewOne;
@end

@implementation ALCForgetPasswordVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
         self.imgVOne.layer.cornerRadius = self.imgVTwo.layer.cornerRadius = self.viewOne.layer.cornerRadius =22.5;
        self.viewOne.clipsToBounds = self.imgVTwo.clipsToBounds = self.imgVOne.clipsToBounds = YES;
        self.imgVTwo.backgroundColor =  self.imgVOne.backgroundColor =[UIColor colorWithWhite:0.6 alpha:0.4];
        self.viewOne.backgroundColor =[UIColor colorWithRed:0/255.0 green:221/255.0 blue:183/255.0 alpha:0.6];
        
    //    [self.TF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        
        
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:
        @{NSForegroundColorAttributeName:[UIColor whiteColor],
        NSFontAttributeName:[UIFont systemFontOfSize:15]
        }];
        self.TF.attributedPlaceholder = attrString;
}

- (IBAction)action:(UIButton *)button  {
    if (button.tag == 100) {
        //注册
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if (button.tag == 101) {
        //电话区域
    }else if (button.tag == 102) {
        //下一步

        if (self.TF.text.length != 11) {
            [SVProgressHUD showErrorWithStatus:@"请输入11位手机号"];
            return;
        }
        
        [self sendCodeAction:button];
        
//        //发送验证码
//        ALCCodeVC * vc =[[ALCCodeVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        vc.isForgetPassWord = YES;
//        [self.navigationController pushViewController:vc animated:YES];
        
    }

    
}

//发送验证码
- (void)sendCodeAction:(UIButton *)button  {

    button.userInteractionEnabled = NO;
    NSMutableDictionary * dataDict = @{@"phone":self.TF.text ,@"type":@"2"}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_sendVerificationCodeURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        button.userInteractionEnabled = YES;
        if ([responseObject[@"key"] intValue]== 1) {
             [SVProgressHUD showSuccessWithStatus:@"发送验证码成功"];
            ALCCodeVC * vc =[[ALCCodeVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.phoneStr = self.TF.text;
            vc.isForgetPassWord = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        button.userInteractionEnabled = YES;

    }];
    
}


@end
