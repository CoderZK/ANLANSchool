//
//  ALCCodeVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/18.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCCodeVC.h"
#import "ALCUserGuideOneVC.h"
#import "ALCLoginVC.h"
@interface ALCCodeVC ()
@property (weak, nonatomic) IBOutlet UIView *viewOne;
@property (weak, nonatomic) IBOutlet UIView *viewTwo;
@property (weak, nonatomic) IBOutlet UIView *viewThree;
@property (weak, nonatomic) IBOutlet UITextField *TF;
@property (weak, nonatomic) IBOutlet UILabel *phoneLB;
@property(nonatomic,strong)NSString *codeStr;

@property(nonatomic,strong)NSTimer *timer;
/** 注释 */
@property(nonatomic,assign)NSInteger number;
@property (weak, nonatomic) IBOutlet UIButton *codeBt;

@end



@implementation ALCCodeVC

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
    
    self.viewOne.layer.cornerRadius = 1;
    self.viewTwo.layer.cornerRadius = 22.5;
    
    self.viewTwo.clipsToBounds = self.viewOne.clipsToBounds = YES;
    self.viewOne.backgroundColor =[UIColor colorWithWhite:0.6 alpha:0.4];
    self.viewTwo.backgroundColor = [UIColor colorWithRed:0/255.0 green:221/255.0 blue:183/255.0 alpha:0.6];
    self.viewThree.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    
    
    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
    cellProperty.cellBgColorNormal = [UIColor colorWithWhite:1 alpha:0.6];
    cellProperty.cellBgColorSelected = [UIColor whiteColor];
    cellProperty.cellCursorColor = [UIColor grayColor];
    cellProperty.cellCursorWidth = 2;
    cellProperty.cellCursorHeight = 30;
    cellProperty.cornerRadius = 4;
    cellProperty.borderWidth = 0;
    cellProperty.cellFont = [UIFont boldSystemFontOfSize:24];
    cellProperty.cellTextColor = WhiteColor;
    cellProperty.configCellShadowBlock = ^(CALayer * _Nonnull layer) {
        layer.shadowColor = [WhiteColor colorWithAlphaComponent:0.2].CGColor;
        layer.shadowOpacity = 1;
        layer.shadowOffset = CGSizeMake(0, 2);
        layer.shadowRadius = 4;
    };
    
    CRBoxInputView *boxInputView = [[CRBoxInputView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.phoneLB.frame), ScreenW - 40, 40)];
    boxInputView.boxFlowLayout.itemSize = CGSizeMake(40, 40);
    boxInputView.customCellProperty = cellProperty;
    boxInputView.codeLength = 6;
    [boxInputView loadAndPrepareViewWithBeginEdit:YES];
    [self.view addSubview:boxInputView];
    
    //字符输入结束时
    Weak(weakSelf);
    boxInputView.textDidChangeblock = ^(NSString *text, BOOL isFinished) {
        NSLog(@"text:%@", text);
        NSLog(@"===%d",isFinished);
        weakSelf.codeStr = text;
    };
    self.phoneLB.text = [NSString stringWithFormat:@"%@%@",@"已经发送6位验证码至+",self.phoneStr];
    [self timeAction];
    
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)action:(UIButton *)button {
    if (button.tag == 100) {
        //点击确定
        if (self.codeStr.length != 6) {
            [SVProgressHUD showErrorWithStatus:@"请输入6位验证码"];
            return;
        }
        [self chackCode];
    }else if (button.tag == 101) {
        //点击重新获取
        [self sendCodeAction:button];
        
    }
    
    
}

- (void)chackCode {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"verificationCode"] = self.codeStr;
    dict[@"phone"] = self.phoneStr;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_validateCodeURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            ALCLoginVC * vc =[[ALCLoginVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.isForgetPassWord = self.isForgetPassWord;
            vc.phoneStr = self.phoneStr;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}


//发送验证码
- (void)sendCodeAction:(UIButton *)button  {
    
    button.userInteractionEnabled = NO;
    NSMutableDictionary * dataDict = @{@"phone":self.phoneStr ,@"type":@"1"}.mutableCopy;
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
