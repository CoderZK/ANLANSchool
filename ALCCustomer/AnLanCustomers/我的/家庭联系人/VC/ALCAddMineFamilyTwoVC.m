//
//  ALCAddMineFamilyTwoVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/6/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCAddMineFamilyTwoVC.h"
#import "zkPickView.h"
#import "ALCCityListVC.h"
#import "QYZJLocationTool.h"
@interface ALCAddMineFamilyTwoVC ()<zkPickViewDelelgate>
@property (weak, nonatomic) IBOutlet UITextField *anmeTF;
@property (weak, nonatomic) IBOutlet UITextField *carNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *sexTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UISwitch *swithBt;
@property(nonatomic,strong)NSString *prnvinceStr,*cityStr;

@property(nonatomic,strong)QYZJLocationTool *tool;


@property(nonatomic,strong)NSTimer *timer;
/** 注释 */
@property(nonatomic,assign)NSInteger number;
@property (weak, nonatomic) IBOutlet UIButton *codeBt;
@property(nonatomic,assign)NSInteger gender,age;
@property(nonatomic,assign)BOOL isAge;

@end

@implementation ALCAddMineFamilyTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = @"新建家庭联系人";
    self.gender = self.age = 0;
    
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
          
          [self chackCode];
          
      }];
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    self.tool = [[QYZJLocationTool alloc] init];
    [self.tool locationAction];
    Weak(weakSelf);
    self.tool.locationBlock = ^(NSString * _Nonnull cityStr, NSString * _Nonnull cityID,NSString * procince , CGFloat la ,CGFloat lo) {
        weakSelf.prnvinceStr = procince;
        weakSelf.cityStr = cityStr;
        weakSelf.addressTF.text = [NSString stringWithFormat:@"%@ %@",procince,cityStr];
    };
    
    
  
}

- (IBAction)clickAction:(UIButton *)button {
    [self.view endEditing:YES];
    if (button.tag == 100) {
        self.isAge = NO;
        zkPickView * picker = [[zkPickView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self;
        picker.arrayType = titleArray;
        picker.array = @[@"男",@"女"].mutableCopy;
        picker.selectLb.text = @"";
        [picker show];
    }else if (button.tag == 101) {
        self.isAge = YES;
        NSMutableArray * arr = @[].mutableCopy;;
        for (int i = 1;i<=120; i++) {
            [arr addObject:[NSString stringWithFormat:@"%ld",i]];;
        }
        zkPickView * picker = [[zkPickView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self;
        picker.arrayType = titleArray;
        picker.array = arr;
        picker.selectLb.text = @"";
        [picker show];
    }else if (button.tag == 102) {
     
        ALCCityListVC * vc =[[ALCCityListVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        Weak(weakSelf);
        vc.cityBlock = ^(NSString * _Nonnull provinceStr, NSString * _Nonnull cityStr, NSString * _Nonnull proviceId, NSString * _Nonnull cityId) {
            weakSelf.prnvinceStr = provinceStr;
            weakSelf.cityStr = cityStr;
            weakSelf.addressTF.text = [NSString stringWithFormat:@"%@ %@",provinceStr,cityStr];

        };
        
    }
        
    
    
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex {
    if (self.isAge) {
        self.age = leftIndex+1;
        self.ageTF.text = [NSString stringWithFormat:@"%ld",(long)self.age];
    }else {
        self.gender = leftIndex+1;
        self.sexTF.text = self.gender == 1 ? @"男":@"女";
    }
}

//发送验证码
- (IBAction)sendCodeAction:(UIButton *)button  {
    
    if (self.phoneTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    button.userInteractionEnabled = NO;
    NSMutableDictionary * dataDict = @{@"phone":self.phoneTF.text ,@"type":@"3"}.mutableCopy;
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

- (void)chackCode {
    if (self.codeTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
        
    }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"verificationCode"] = self.codeTF.text;
    dict[@"phone"] = self.phoneTF.text;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_validateCodeURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [self addAction];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}


- (void)addAction {
    
    if (self.anmeTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        return;
    }
    if (self.carNumberTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入身份证号"];
        return;
    }
    if (self.carNumberTF.text.length != 18) {
        [SVProgressHUD showErrorWithStatus:@"请输入18位身份证号"];
        return;
    }
    if(self.gender == 0) {
         [SVProgressHUD showErrorWithStatus:@"请选择性别"];
        return;
    }
    if(self.age == 0) {
            [SVProgressHUD showErrorWithStatus:@"请选择年龄"];
           return;
       }
    if (self.addressTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入地址"];
        return;
    }
    if (self.phoneTF.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (self.phoneTF.text.length !=  11 ) {
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号"];
        return;
    }
    if (self.codeTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }

    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"name"] = self.anmeTF.text;
    dict[@"IDcard"] = self.carNumberTF.text;
    dict[@"gender"] = @(self.gender);
    dict[@"adress"] = self.addressTF.text;
    dict[@"age"] = self.ageTF.text;
    dict[@"phone"] = self.phoneTF.text;
 
    dict[@"isDefultPatient"] = self.swithBt.on ? @"1":@"0";
    [zkRequestTool networkingPOST:user_addMyFamilyMember parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
     
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"添加家庭人员成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
