//
//  ALCBasicInformationVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/18.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCBasicInformationVC.h"
#import "ALCInterestTVC.h"
#import "ALCHeightAndWeightVC.h"
@interface ALCBasicInformationVC ()<zkPickViewDelelgate>
@property (weak, nonatomic) IBOutlet UIButton *bt;
@property (weak, nonatomic) IBOutlet UIButton *Bt1;
@property (weak, nonatomic) IBOutlet UIButton *bt2;
@property (weak, nonatomic) IBOutlet UIButton *bt3;
@property (weak, nonatomic) IBOutlet UIButton *bt4;
@property (weak, nonatomic) IBOutlet UIButton *bt5;
@property(nonatomic,assign)BOOL isT;
@property(nonatomic,strong)NSMutableArray *tArr;
@property(nonatomic,strong)NSMutableArray *sArr;
@property(nonatomic,strong)NSString *genderStr,*brithdStr;
@end

@implementation ALCBasicInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"基本信息";
    
    
    self.genderStr = @"1";
    self.bt.layer.cornerRadius = 5;
    self.bt.clipsToBounds = YES;
    
    
    self.tArr = @[].mutableCopy;
    self.sArr = @[].mutableCopy;
    for (int i = 200; i<2000; i++) {
        [self.tArr addObject:[NSString stringWithFormat:@"%0.1fkg",i/10.0]];
    }
    for (int i = 200; i<250; i++) {
        [self.tArr addObject:[NSString stringWithFormat:@"%0.1fcm",i/10.0]];
    }
    
}

- (IBAction)action:(UIButton *)button  {
    if (button.tag == 100) {
        //点击的选择男
        self.genderStr = @"1";
        [self.Bt1 setBackgroundImage:[UIImage imageNamed:@"jkgl145"] forState:UIControlStateNormal];
        [self.bt2 setBackgroundImage:[UIImage imageNamed:@"jkgl144"] forState:UIControlStateNormal];
    }else if (button.tag == 101) {
        //点击选择女
        [self.Bt1 setBackgroundImage:[UIImage imageNamed:@"jkgl143"] forState:UIControlStateNormal];
        [self.bt2 setBackgroundImage:[UIImage imageNamed:@"jkgl146"] forState:UIControlStateNormal];
        self.genderStr = @"2";
    }else if (button.tag == 102) {
        //点击出生日期
        
        SelectTimeV *selectTimeV = [[SelectTimeV alloc] init];
        selectTimeV.isCanSelectOld = YES;
        selectTimeV.isCanSelectToday = YES;
        Weak(weakSelf);
        selectTimeV.block = ^(NSString *timeStr) {
            [weakSelf.bt3 setTitle:timeStr forState:UIControlStateNormal];
            weakSelf.brithdStr = timeStr;
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
        
    }else if (button.tag == 103) {
        //点击选择体重
        self.isT = YES;
        zkPickView * picker = [[zkPickView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self;
        picker.arrayType = NormalArray;
        
        
        
        picker.array = self.tArr;
        picker.selectLb.text = @"";
        [picker show];
        
        
    }else if (button.tag == 104) {
        //点击选择身高
        self.isT = NO;
        zkPickView * picker = [[zkPickView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self;
        picker.arrayType = NormalArray;
        picker.array = self.sArr;
        picker.selectLb.text = @"";
        [picker show];
        
    }
    
    
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger)rightIndex {
    if (self.isT) {
        [self.bt4 setTitle:self.tArr[leftIndex] forState:UIControlStateNormal];
    }else {
       [self.bt3 setTitle:self.sArr[leftIndex] forState:UIControlStateNormal];
    }
}

//下一步
- (IBAction)bt:(id)sender {
    
    if (self.brithdStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择生日"];
        return;
    }
    
    
    
    ALCHeightAndWeightVC * vc =[[ALCHeightAndWeightVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.phoneStr = self.phoneStr;
    vc.birthdateStr = self.brithdStr;
    vc.genderStr = self.genderStr;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


@end
