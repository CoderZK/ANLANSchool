//
//  ALCLoginOneVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCLoginOneVC.h"
#import "ALCRegisterVC.h"
#import "ALCForgetPasswordVC.h"
#import "ALCAgreementVC.h"
#import "ALCUserGuideOneVC.h"
#import "ALCbindPhoneVC.h"
#import "TDTouchID.h"
@interface ALCLoginOneVC()
@property (weak, nonatomic) IBOutlet UIImageView *imgVTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imgVOne;
@property (weak, nonatomic) IBOutlet UIImageView *imgVTh;
@property (weak, nonatomic) IBOutlet UITextField *TF;
@property (weak, nonatomic) IBOutlet UITextField *TFTwo;
@property (weak, nonatomic) IBOutlet UIView *viewOne;
@property(nonatomic,assign)BOOL isVerLogin;

@property (weak, nonatomic) IBOutlet UILabel *otherLB;
@property (weak, nonatomic) IBOutlet UIButton *weiChatBt;
@property (weak, nonatomic) IBOutlet UIButton *QQBt;

@end

@implementation ALCLoginOneVC

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

    
       self.otherLB.hidden = self.QQBt.hidden = self.weiChatBt.hidden = [zkSignleTool shareTool].isUp;
    
    if ([zkSignleTool shareTool].telphone.length > 0) {
        
       TDTouchIDSupperType type = [[TDTouchID sharedInstance] td_canSupperBiometrics];
        if (type == TDTouchIDSupperTypeFaceID || type == TDTouchIDSupperTypeTouchID) {
          
            
            [self touchVerification];
            
            
        }
     

    }
    self.TFTwo.secureTextEntry = YES;
    self.imgVOne.layer.cornerRadius = self.imgVTwo.layer.cornerRadius = self.viewOne.layer.cornerRadius =22.5;
    self.viewOne.clipsToBounds = self.imgVTwo.clipsToBounds = self.imgVOne.clipsToBounds = YES;
    self.imgVTwo.backgroundColor =  self.imgVOne.backgroundColor =[UIColor colorWithWhite:0.6 alpha:0.4];
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
}


/**
 验证 TouchID
 */
- (void)touchVerification {
    
    [[TDTouchID sharedInstance] td_showTouchIDWithDescribe:@"通过Home键验证已有指纹" FaceIDDescribe:@"通过已有面容ID验证" BlockState:^(TDTouchIDState state, NSError *error) {
        if (state == TDTouchIDStateNotSupport) {    //不支持TouchID/FaceID
            
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"当前设备不支持生物验证" message:@"请输入密码来验证" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alertview.alertViewStyle = UIAlertViewStyleSecureTextInput;
            [alertview show];
            
        } else if (state == TDTouchIDStateSuccess) {    //TouchID/FaceID验证成功
            
            self.isVerLogin = YES;
            [self loginAction];
            
        } else if (state == TDTouchIDStateInputPassword) { //用户选择手动输入密码
            
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"请输入密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alertview.alertViewStyle = UIAlertViewStyleSecureTextInput;
            [alertview show];
            
        }
        
        // ps:以上的状态处理并没有写完全!
        // 在使用中你需要根据回调的状态进行处理,需要处理什么就处理什么
        
    }];
    
}



- (IBAction)action:(UIButton *)button  {
    if (button.tag == 100) {
        //注册
        ALCRegisterVC * vc =[[ALCRegisterVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
     
        
    }else if (button.tag == 101) {
        //电话区域
    }else if (button.tag == 102) {
        //确定
        if  (self.TF.text.length != 11) {
            [SVProgressHUD showErrorWithStatus:@"请输入11位手机号"];
            return;
        }
        if (self.TFTwo.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
            return;
        }
        [self loginAction];

    }else if (button.tag == 103) {
        //忘记密码
        ALCForgetPasswordVC * vc =[[ALCForgetPasswordVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 104) {
        //微信
         [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
        
        
    }else if (button.tag == 105) {
         //qq
        [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
               
        
        
    }else if (button.tag == 106) {
        //勾选
    }else if (button.tag == 107) {
        //协议
        ALCAgreementVC * vc =[[ALCAgreementVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }

}


- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"授权失败"];
        }else {
            UMSocialUserInfoResponse *resp = result;
            NSLog(@"\n\n%@\n\n%@\n\n%@\n%@",resp.openid,resp.accessToken,resp.refreshToken,resp.name);
            
            if (platformType == UMSocialPlatformType_WechatSession) {
                [self thirdLoginWithType:1 nameStr:resp.name threeId:resp.openid];
            }else {
                [self thirdLoginWithType:2 nameStr:resp.name threeId:resp.openid];
            }

//            self.resp= resp;
//            if (self.isBind) {
//                [self bindWebChatWithOpenid:resp.openid];
//            }else {
//                [self loginWhitWebXinwithOpenId:resp.openid];
//
//            }
            
        }
        
        
    }];
}


// 1 微信  2 qq
- (void)thirdLoginWithType:(NSInteger )type nameStr:(NSString *)threeName threeId:(NSString *)threeId{
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"threeId"] = threeId;
    dict[@"type"] = @(type);
    dict[@"threeName"] = @"klkl";
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_thirdLoginURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
    
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            NSString * str = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"isRegister"]];
            if ([str isEqualToString:@"0"]) {
                ALCbindPhoneVC * vc =[[ALCbindPhoneVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.thredID = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"threeAccountId"]];
                [self.navigationController pushViewController:vc animated:YES];
            }else {

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
                
            }
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
}



- (void)loginAction {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    dict[@"phone"] = self.TF.text;
    dict[@"password"] = self.TFTwo.text;
    if (self.isVerLogin) {
        dict[@"phone"] = [zkSignleTool shareTool].telphone;
        dict[@"password"] = [zkSignleTool shareTool].password;
    }
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_loginURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
      
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            if (!self.isVerLogin) {
                [zkSignleTool shareTool].telphone = self.TF.text;
                [zkSignleTool shareTool].password = self.TFTwo.text;
            }
            [zkSignleTool shareTool].session_token = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"token"]];;
            [zkSignleTool shareTool].isLogin = YES;
            [[zkSignleTool shareTool] uploadDeviceToken];
            if ([responseObject[@"data"][@"isComplete"] integerValue] == 0) {
                
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

- (IBAction)sourceAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.TFTwo.secureTextEntry = !sender.selected;
}

- (IBAction)diss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
