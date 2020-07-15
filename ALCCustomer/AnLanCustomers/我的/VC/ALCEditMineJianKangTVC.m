//
//  ALCEditMineJianKangTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCEditMineJianKangTVC.h"

@interface ALCEditMineJianKangTVC ()
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)ALCChooseJianKangVIew *v1,*v2,*v3,*v4,*v5,*v6,*v7;
@end

@implementation ALCEditMineJianKangTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"基本健康信息";
    [self setNavigation];
    
    [self setheadVV];
    
    
    
}

- (void)setNavigation {
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 0;
    button.clipsToBounds = YES;
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [self editInfoAction];
        
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

- (void)editInfoAction {
    if (!isDidLogin) {
           [self gotoLoginVC];
           return;
       }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"marriageStatus"] = @(self.v1.selectIndex+1);
    dict[@"birthStatus"] = @(self.v2.selectIndex+1);
    dict[@"operateHurt"] = self.v3.TV.text;
    dict[@"familyHistory"] = self.v4.TV.text;
    dict[@"drugAllergy"] = self.v5.TV.text;
    dict[@"otherAllergy"] = self.v6.TV.text;
    dict[@"habit"] = self.v7.TV.text;
    if (![self.type isEqualToString:@"1"]) {
        //不是自己
       dict[@"familyMemberId"] = self.familyMemberId;
    }
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_saveHealthInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"完善健康资料成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.sucessBlock != nil) {
                     self.sucessBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}

- (void)setheadVV {
    
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    self.headV.backgroundColor = WhiteColor;
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    backV.backgroundColor = BackgroundColor;
    [self.headV addSubview:backV];
    
    UILabel * ll =[[UILabel alloc] initWithFrame:CGRectMake(15, 15 , ScreenW - 30, 20)];
    ll.font =[UIFont systemFontOfSize:14];
    ll.textColor = CharacterColor50;
    [backV addSubview:ll];
    ll.text = @"信息仅供主治医生查看,请认真填写";
    
    ALCChooseJianKangVIew * view1 = [[ALCChooseJianKangVIew alloc] initWithFrame:CGRectMake(0, 50, ScreenW, 20)];
    NSArray * arr = @[@"已婚",@"未婚",@"离异",@"丧偶"];
    NSMutableArray<ALMessageModel *> * arrTwo = @[].mutableCopy;
    for (int i  = 0 ; i < arr.count; i++) {
        ALMessageModel * model = [[ALMessageModel alloc] init];
        model.name = arr[i];
        [arrTwo addObject:model];
    }
   
    view1.dataArray = arrTwo;
    if (self.dataModel.marriageStatus.length > 0) {
           view1.selectIndex = [self.dataModel.marriageStatus integerValue] - 1;
       }
    view1.titleOneStr = @"婚姻状况";
    view1.isOnlySelectOne = YES;
    view1.isShowTV = NO;
    view1.mj_h = view1.hh;
    [self.headV addSubview:view1];
    self.v1 = view1;
    
    
    ALCChooseJianKangVIew * view2 = [[ALCChooseJianKangVIew alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame), ScreenW, 20)];
    NSArray * arr2 = @[@"未生育",@"备孕期",@"怀孕期",@"已生育"];
    NSMutableArray<ALMessageModel *> * arrTwo2 = @[].mutableCopy;
    for (int i  = 0 ; i < arr2.count; i++) {
        ALMessageModel * model = [[ALMessageModel alloc] init];
        model.name = arr2[i];
        [arrTwo2 addObject:model];
    }
  
    view2.dataArray = arrTwo2;
    if (self.dataModel.birthStatus.length > 0) {
          view2.selectIndex = [self.dataModel.birthStatus integerValue] - 1;
      }
    view2.titleOneStr = @"生育状态";
    view2.isShowTV = NO;
    view2.isOnlySelectOne = YES;
    view2.mj_h = view2.hh;
    [self.headV addSubview:view2];
    
    self.v2 = view2;
    
    ALCChooseJianKangVIew * view3 = [[ALCChooseJianKangVIew alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view2.frame), ScreenW, 20)];
    
    view3.dataArray = @[];
    view3.titleOneStr = @"手术活外伤";
    view3.TV.placeholder = @"可输入你的手术和外伤情况";
    view3.isShowTV = YES;
    view3.mj_h = view3.hh;
    view3.TV.text = self.dataModel.operateHurt;
    [self.headV addSubview:view3];
    self.v3 = view3;
    
    
    self.headV.mj_h  = CGRectGetMaxY(view3.frame);
    self.tableView.tableHeaderView = self.headV;
    
    
    ALCChooseJianKangVIew * view4 = [[ALCChooseJianKangVIew alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view3.frame), ScreenW, 20)];
    
    view4.dataArray = @[];
    view4.titleOneStr = @"家族病史";
    view4.TV.placeholder = @"可输入你的家族病史情况";
    view4.isShowTV = YES;
    view4.mj_h = view4.hh;
    view4.TV.text = self.dataModel.familyHistory;
    [self.headV addSubview:view4];
    self.v4 = view4;
    
    
    ALCChooseJianKangVIew * view5 = [[ALCChooseJianKangVIew alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view4.frame), ScreenW, 20)];
    
    view5.dataArray = @[];
    view5.titleOneStr = @"药物过敏";
    view5.TV.placeholder = @"可输入你的药物过敏";
    view5.isShowTV = YES;
    view5.mj_h = view5.hh;
    view5.TV.text = self.dataModel.drugAllergy;
    [self.headV addSubview:view5];
    self.v5 = view5;
    
    
    ALCChooseJianKangVIew * view6 = [[ALCChooseJianKangVIew alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view5.frame), ScreenW, 20)];
    
    view6.dataArray =@[];
    view6.titleOneStr = @"食物/接触物过敏";
    view6.TV.placeholder = @"可输入你的食物或物品过敏";
    view6.isShowTV = YES;
    view6.mj_h = view6.hh;
    view6.TV.text = self.dataModel.otherAllergy;
    [self.headV addSubview:view6];
    self.v6 = view6;
    
    
    ALCChooseJianKangVIew * view7 = [[ALCChooseJianKangVIew alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view6.frame), ScreenW, 20)];
    
    view7.dataArray = @[];
    view7.titleOneStr = @"个人习惯";
    view7.TV.placeholder = @"可输入你个人习惯";
    view7.isShowTV = YES;
    view7.mj_h = view7.hh;
    [self.headV addSubview:view7];
    view7.TV.text = self.dataModel.habit;
    self.v7 = view7;
    
    
    
    self.headV.mj_h  = CGRectGetMaxY(view7.frame);
    self.tableView.tableHeaderView = self.headV;
    
    
}


@end
