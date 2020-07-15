//
//  ALCMineBodyRecordVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/4/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCMineBodyRecordVC.h"
#import "DYScrollRulerView.h"
@interface ALCMineBodyRecordVC ()<DYScrollRulerDelegate>
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSString *danweiNameStr;
@property(nonatomic,assign)CGFloat min,max,scale;
//@property(nonatomic,strong)NSArray *danweiNameArr;
//@property(nonatomic,strong)NSArray *minMaxArr;
//@property(nonatomic,strong)NSArray *danweiArr;
@property(nonatomic,strong)NSString *str1,*str2;

@end

@implementation ALCMineBodyRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    if (self.type == 0) {
        self.titleArr = @[@"步数"];
        self.danweiNameStr = @"步";
        self.min = 0;
        self.max = 500000;
        self.scale = 1;
        self.navigationItem.title = @"心率记录";
        
        
        
    } else if (self.type == 1) {
        self.titleArr = @[@"平均"];
        self.danweiNameStr = @"次/分钟";
        self.min = 40;
        self.max = 200;
        self.scale = 1;
        self.navigationItem.title = @"心率记录";
//        self.danweiNameArr = @[@"次/分钟",@"次分钟"]
    }else if (self.type == 2) {
        self.titleArr = @[@"体重"];
        self.danweiNameStr = @"kg";
        self.min = 30;
        self.max = 200;
        self.scale = 0.1;
        self.navigationItem.title = @"体重记录";
    }else if (self.type == 3) {
        self.titleArr = @[@"收缩压",@"舒张压"];
        self.danweiNameStr = @"mmHg";
        self.min = 60;
        self.max = 200;
        self.scale = 1;
        self.navigationItem.title = @"血压记录";
    }else if (self.type == 4) {
        self.titleArr = @[@"收缩压",@"舒张压"];
        self.danweiNameStr = @"mmHg";
        self.min = 60;
        self.max = 200;
        self.scale = 1;
    }
    self.str1 = self.str2 = @"70";
    [self setViews];
    
    [self setFootV];
    
}

- (void)setFootV {
 
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"确定" andImgaeName:@""];
    Weak(weakSelf);
    view.footViewClickBlock = ^(UIButton *button) {
        [weakSelf updateBodyRecord];
    };
    [self.view addSubview:view];
}

- (void)updateBodyRecord {
    if (!isDidLogin) {
           [self gotoLoginVC];
           return;
       }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    NSString * url = [QYZJURLDefineTool user_recordWeightURL];
    if (self.type == 1) {
        url = [QYZJURLDefineTool user_recordHeartrateURL];
    }else if (self.type ==3) {
        url =  [QYZJURLDefineTool user_recordBloodpressureURL];
    }else if (self.type == 0) {
        url = [QYZJURLDefineTool user_recordStepnumberURL];
    }
    dict[@"weight"] = self.str1;
    dict[@"setDateFormat"] = self.str1;
    dict[@"systolic"] = self.str1;
    dict[@"diastolic"] = self.str2;
    dict[@"dataFrom"] = @"1";
    dict[@"averageRate"] = self.str1;
    dict[@"step"] = self.str1;
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    dict[@"recordDate"] = [formatter stringFromDate:date];
    
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"记录成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
                
            });
            
            
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        

        
    }];
    
    
}



- (void)setViews {
    //130 + 20
    CGFloat space = 60;
    CGFloat hh = 150;
    
    for (int i = 0 ; i < self.titleArr.count; i++) {
        
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 100+ (space+hh)*i, ScreenW, 20)];
        lb.text = [NSString stringWithFormat:@"  %@",self.titleArr[i]];;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = kFont(16);
        lb.textColor = CharacterColor50;
        [self.view addSubview:lb];
        NSString *unitStr = self.danweiNameStr;
        CGFloat rullerHeight = [DYScrollRulerView rulerViewHeight];
        DYScrollRulerView * DYV = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lb.frame), ScreenW, rullerHeight) theMinValue:self.min theMaxValue:self.max theStep:self.scale theUnit:unitStr theNum:10];
        [DYV setDefaultValue:70 animated:YES];
        DYV.bgColor = [UIColor groupTableViewBackgroundColor];
        DYV.tag = 100+i;
        DYV.delegate        = self;
        DYV.scrollByHand    = YES;
        
        [self.view addSubview:DYV];
        
    }
    
    
}

-(void)dyScrollRulerView:(DYScrollRulerView *)rulerView valueChange:(float)value{
    
    if (self.type == 1) {
           self.str1 = [NSString stringWithFormat:@"%d",(int)value];
    }else if (self.type == 3) {
        if (rulerView.tag == 100) {
            self.str1 = [NSString stringWithFormat:@"%d",(int)value];
        }else {
            self.str2 = [NSString stringWithFormat:@"%d",(int)value];
        }
    }else if (self.type == 2) {
          self.str1 = [NSString stringWithFormat:@"%0.1f",value];
    }else if (self.type == 0) {
         self.str1 = [NSString stringWithFormat:@"%d",(int)value];
    }
    
}

@end
