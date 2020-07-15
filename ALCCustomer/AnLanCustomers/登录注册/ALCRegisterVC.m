//
//  ALCRegisterVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/17.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCRegisterVC.h"
#import "ALCLoginVC.h"
#import "ALCCodeVC.h"
@interface ALCRegisterVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgVTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imgVOne;
@property (weak, nonatomic) IBOutlet UIImageView *imgVTh;
@property (weak, nonatomic) IBOutlet UITextField *TF;
@property(nonatomic,strong)NSTimer *timer;
/** 注释 */
@property(nonatomic,assign)NSInteger number;
@property (weak, nonatomic) IBOutlet UIButton *codeBt;
@property (weak, nonatomic) IBOutlet UILabel *otherLB;
@property (weak, nonatomic) IBOutlet UIButton *weiChatBt;
@property (weak, nonatomic) IBOutlet UIButton *QQBt;

@end

@implementation ALCRegisterVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (IBAction)action:(UIButton *)button  {
    if (button.tag == 100) {
        //登录
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if (button.tag == 101) {
        //电话区域
    }else if (button.tag == 102) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        //注册
    }else if (button.tag == 103) {
        //发送验证码
        
//        ALCCodeVC * vc =[[ALCCodeVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
        
        if (self.TF.text.length != 11) {
            [SVProgressHUD showSuccessWithStatus:@"请输入正确的手机号"];
            return;
        }
        [self sendCodeAction:button];
        
        
       
    }
    
    
    
    
    
}

//发送验证码
- (void)sendCodeAction:(UIButton *)button  {

    button.userInteractionEnabled = NO;
    NSMutableDictionary * dataDict = @{@"phone":self.TF.text ,@"type":@"1"}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_sendVerificationCodeURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        button.userInteractionEnabled = YES;
        if ([responseObject[@"key"] intValue]== 1) {
             [SVProgressHUD showSuccessWithStatus:@"发送验证码成功"];
            ALCCodeVC * vc =[[ALCCodeVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.phoneStr = self.TF.text;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
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




- (void)viewDidLoad {
    [super viewDidLoad];
    self.imgVOne.layer.cornerRadius = self.imgVTwo.layer.cornerRadius = 22.5;
    self.imgVTwo.clipsToBounds = self.imgVOne.clipsToBounds = YES;
    self.imgVOne.backgroundColor =[UIColor colorWithWhite:0.6 alpha:0.4];
    self.imgVTwo.backgroundColor = [UIColor colorWithRed:0/255.0 green:221/255.0 blue:183/255.0 alpha:0.6];
    
//    [self.TF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
    NSFontAttributeName:[UIFont systemFontOfSize:15]
    }];
    self.TF.attributedPlaceholder = attrString;
    
    self.otherLB.hidden = self.QQBt.hidden = self.weiChatBt.hidden = [zkSignleTool shareTool].isUp;
    
    
}



@end
