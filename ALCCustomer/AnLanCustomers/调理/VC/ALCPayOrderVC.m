//
//  ALCPayOrderVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCPayOrderVC.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "ACLMineAppointVC.h"
@interface ALCPayOrderVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (weak, nonatomic) IBOutlet UIImageView *imgV2;
@property(nonatomic,assign)NSInteger payType; //0 支付宝 1 微信
@property (nonatomic,strong)NSDictionary *payDic;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;

@end

@implementation ALCPayOrderVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WWWWX:) name:@"WXPAY" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ZFBPAY:) name:@"ZFBPAY" object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.payType = 0;
    [self setFootV];
    self.navigationItem.title = @"在线支付";
    self.moneyLB.text = [NSString stringWithFormat:@"%0.2f/次",self.price];
}

- (void)setFootV {
    
    
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"立即支付" andImgaeName:@""];
    Weak(weakSelf);
    view.footViewClickBlock = ^(UIButton *button) {
        
        [weakSelf appiontmentProjectWithType:2 - self.payType];
    };
    [self.view addSubview:view];
}
- (IBAction)payChooseAction:(UIButton *)button  {
    self.payType = button.tag - 100;
    if (button.tag == 100) {
        self.imgV2.image = [UIImage imageNamed:@"jkgl132"];
        self.imgV1.image = [UIImage imageNamed:@"jkgl133"];
    }else {
        self.imgV1.image = [UIImage imageNamed:@"jkgl132"];
        self.imgV2.image = [UIImage imageNamed:@"jkgl133"];
    }
}


- (void)appiontmentProjectWithType:(NSInteger)type {
    
    if (!isDidLogin) {
        [self gotoLoginVC];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    if (self.innerOrderNo.length > 10) {
        dict[@"innerOrderNo"] = self.innerOrderNo;
    }else {
        dict[@"projectId"] = self.projiectID;
        dict[@"appointmentDate"] = self.appointmentDate;
        dict[@"duration"] = @(self.duration);
        dict[@"payWay"] = @(1);
        dict[@"payType"] = @(type);
        dict[@"familyMemberId"] = self.familyMemberId;
    }
    
    
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_doProjectAppointmentURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            self.innerOrderNo = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"innerOrderNo"]];
            if (type == 1) {
                self.payDic = responseObject[@"data"];
                
                [self goWXpay];
            }else {
                self.payDic = responseObject[@"data"];
                [self goZFB];
            }

        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}

//微信支付结果处理
- (void)WXPAY:(NSNotification *)no {
    
    BaseResp * resp = no.object;
    if (resp.errCode==WXSuccess)
    {
        
        [self showPaySucess];
    }
    else if (resp.errCode==WXErrCodeUserCancel)
    {
        [SVProgressHUD showErrorWithStatus:@"用户取消支付"];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"支付失败"];
    }
    
}



#pragma mark -微信、支付宝支付
- (void)goWXpay {
    PayReq * req = [[PayReq alloc]init];
    req.partnerId = [NSString stringWithFormat:@"%@",self.payDic[@"partnerid"]];
    req.prepayId =  [NSString stringWithFormat:@"%@",self.payDic[@"prepayid"]];
    req.nonceStr =  [NSString stringWithFormat:@"%@",self.payDic[@"noncestr"]];
    //注意此处是int 类型
    req.timeStamp = [self.payDic[@"timestamp"] intValue];
    req.package =  [NSString stringWithFormat:@"%@",self.payDic[@"package"]];
    req.sign =  [NSString stringWithFormat:@"%@",self.payDic[@"sign"]];
    
    //发起支付
//    [WXApi sendReq:req];
    
    [WXApi sendReq:req completion:nil];
    
}

//微信支付结果处理
- (void)WWWWX:(NSNotification *)no {
    
    BaseResp * resp = no.object;
    if (resp.errCode==WXSuccess)
    {
        
        [self showPaySucess];
    }
    else if (resp.errCode==WXErrCodeUserCancel)
    {
        [SVProgressHUD showErrorWithStatus:@"用户取消支付"];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"支付失败"];
    }
    
}



//支付宝支付结果处理
- (void)goZFB{
    [[AlipaySDK defaultService] payOrder:self.payDic[@"orderString"] fromScheme:@"com.jkgl.anlanCC.app" callback:^(NSDictionary *resultDic) {
        if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
            //用户取消支付
            [SVProgressHUD showErrorWithStatus:@"用户取消支付"];
        } else if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
            [self showPaySucess];
        } else {
            [SVProgressHUD showErrorWithStatus:@"支付失败"];
        }
    }];
}

- (void)showPaySucess {
    
    [SVProgressHUD showSuccessWithStatus:@"支付成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.innerOrderNo = @"";
        
        
//        if ((self.type == 6 ||self.type == 11 ||  self.type == 1) && self.isBaoBlcok != nil) {
//            self.isBaoBlcok();
//        }
//        if (self.type == 5 || self.type == 6) {
//
//
//
//            if (self.navigationController.childViewControllers.count >= 5) {
//                UIViewController * vc = self.navigationController.childViewControllers[self.navigationController.childViewControllers.count - 5];
//                UIViewController * vcTwo = self.navigationController.childViewControllers[self.navigationController.childViewControllers.count - 3];
//                if ([vc isKindOfClass:[QYZJHomeTwoTVC class]]) {
//                    [self.navigationController popToViewController:vc animated:YES];
//                }
//                if ([vcTwo isKindOfClass:[QYZJMineZhuYeTVC class]]) {
//                    [self.navigationController popToViewController:vcTwo animated:YES];
//                }
//
//            }else if (self.navigationController.childViewControllers.count >= 3) {
//
//                UIViewController * vcTwo = self.navigationController.childViewControllers[self.navigationController.childViewControllers.count - 3];
//                if ([vcTwo isKindOfClass:[QYZJMineZhuYeTVC class]]) {
//                    [self.navigationController popToViewController:vcTwo animated:YES];
//                }
//            }
//        }
   
            ACLMineAppointVC * vc =[[ACLMineAppointVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.isPay = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
   
        
        
    });
    
    
}


//支付宝支付结果处理,此处是app 被杀死之后用的
- (void)ZFBPAY:(NSNotification *)notic {
    NSDictionary *resultDic = notic.object;
    if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
        //用户取消支付
        [SVProgressHUD showErrorWithStatus:@"用户取消支付"];
        
    } else if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
        
        [self showPaySucess];
    } else {
        [SVProgressHUD showErrorWithStatus:@"支付失败"];
    }
    
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
