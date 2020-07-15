//
//  ALCbindPhoneVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/5/9.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCbindPhoneVC.h"
#import "ALCUserGuideOneVC.h"
@interface ALCbindPhoneVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgVTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imgVOne;
@property (weak, nonatomic) IBOutlet UIImageView *imgVTh;
@property (weak, nonatomic) IBOutlet UITextField *TF;
@property (weak, nonatomic) IBOutlet UITextField *TFTwo;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIView *viewOne;
@property (weak, nonatomic) IBOutlet UIView *viewTwo;
@property(nonatomic,strong)NSTimer *timer;
/** 注释 */
@property(nonatomic,assign)NSInteger number;
@property (weak, nonatomic) IBOutlet UIButton *codeBt;

@end

@implementation ALCbindPhoneVC
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
    self.imgVOne.layer.cornerRadius = self.imgVTwo.layer.cornerRadius = self.viewTwo.layer.cornerRadius = self.viewOne.layer.cornerRadius =22.5;
    self.viewTwo.clipsToBounds =  self.viewOne.clipsToBounds = self.imgVTwo.clipsToBounds = self.imgVOne.clipsToBounds = YES;
    self.viewTwo.backgroundColor =   self.imgVTwo.backgroundColor =  self.imgVOne.backgroundColor =[UIColor colorWithWhite:0.6 alpha:0.4];
    self.viewOne.backgroundColor = [UIColor colorWithRed:0/255.0 green:221/255.0 blue:183/255.0 alpha:0.6];;
    
    //    [self.TF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:
                                      @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                        NSFontAttributeName:[UIFont systemFontOfSize:15]
                                      }];
    self.TF.attributedPlaceholder = attrString;
    
    NSAttributedString *attrStringTwo = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:
                                         @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                           NSFontAttributeName:[UIFont systemFontOfSize:15]
                                         }];
    self.TFTwo.attributedPlaceholder = attrStringTwo;
    NSAttributedString *attrStringThree = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:
                                           @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                             NSFontAttributeName:[UIFont systemFontOfSize:15]
                                           }];
    
    self.codeTF.attributedPlaceholder = attrStringThree;
    
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)confirmAction:(id)sender {
    
    if (self.codeTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    [self chackCode];
    
}

- (void)bindAction {
    
    if (self.TF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号"];
        return;
    }
    if (self.TFTwo.text.length != 6) {
        [SVProgressHUD showErrorWithStatus:@"请输入6位数字密码"];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"threeAccountId"] = self.thredID;
    dict[@"phone"] = self.TF.text;
    dict[@"passWord"] = self.TFTwo.text;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_thirdLoginBindPhoneURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            
            [zkSignleTool shareTool].session_token = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"token"]];;
            [zkSignleTool shareTool].isLogin = YES;
            [[zkSignleTool shareTool] uploadDeviceToken];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            if ([[NSString stringWithFormat:@"%@",responseObject[@"data"][@"isComplete"]] integerValue] == 0) {
                
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"个人信息未完善" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"去完善" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    ALCUserGuideOneVC * vc =[[ALCUserGuideOneVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.phoneStr = self.TF.text;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"暂不完善" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                    
                }];
                [ac addAction:action1];
                [ac addAction:action2];
                [self.navigationController presentViewController:ac animated:YES completion:nil];
                
            }else {
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                
            }
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
}

- (void)chackCode {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"verificationCode"] = self.codeTF.text;
    dict[@"phone"] = self.TF.text;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_validateCodeURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [self bindAction];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}


//发送验证码
- (IBAction)sendCodeAction:(UIButton *)button  {
    
    if (self.TF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    button.userInteractionEnabled = NO;
    NSMutableDictionary * dataDict = @{@"phone":self.TF.text ,@"type":@"3"}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_sendVerificationCodeURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        button.userInteractionEnabled = YES;
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"发送验证码成功"];
            [self timeAction];
            
        }else {
            
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"jkgl1"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        button.userInteractionEnabled = YES;
        
    }];
    
}



- (void)timeAction {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStar) userInfo:nil repeats:YES];
    self.codeBt.userInteractionEnabled = NO;
    self.number = 60;
    
    
}

- (void)timerStar {
    _number = _number -1;
    if (self.number > 0) {
        [self.codeBt setTitle:[NSString stringWithFormat:@"%lds后重发",_number] forState:UIControlStateNormal];
    }else {
        [self.codeBt setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        self.codeBt.userInteractionEnabled = YES;
    }
    
    
}


@end
