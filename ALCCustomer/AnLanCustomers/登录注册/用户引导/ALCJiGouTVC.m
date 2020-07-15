//
//  ALCJiGouTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/4/3.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCJiGouTVC.h"
#import "ALCInterestTVC.h"
@interface ALCJiGouTVC ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) UIPickerView *pickerView;
@end

@implementation ALCJiGouTVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"选择机构";
    
    
    [self setheadV];
    self.dataArray = @[].mutableCopy;
    
    [self setFootV];
    [self getData];
    
}


- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(1);
    dict[@"pageSize"] = @(10000);
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    dict[@"sortType"] = @"3";
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_findInstitutionListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            NSArray<ALMessageModel *>*arr = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            [self.dataArray addObjectsFromArray:arr];
            [self.pickerView reloadAllComponents];
            if (self.dataArray.count > 0) {
                [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
            }
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}


- (void)setheadV {
    
    UIView * headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW , ScreenH)];
    headV.backgroundColor = WhiteColor;
    
    UILabel * lb1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, ScreenW - 20, 20)];
    lb1.textAlignment = NSTextAlignmentCenter;
    lb1.textColor = CharacterColor50;
    lb1.font = [UIFont systemFontOfSize:16 weight:0.2];
    lb1.text = @"您曾经就诊过的机构是？";
    [headV addSubview:lb1];
    
    UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lb1.frame) + 5, ScreenW - 20, 20)];
    lb2.textAlignment = NSTextAlignmentCenter;
    lb2.textColor = CharacterBlack100;
    lb2.font = kFont(14);
    lb2.text = @"方便我们推荐相关机构信息，请正确选择。";
    [headV addSubview:lb2];
    
    
    
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(lb2.frame) + 20 , ScreenW - 80 ,150)];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    _pickerView.backgroundColor = [UIColor whiteColor];
    [headV addSubview:_pickerView];
    
   
    UILabel * lb3 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.pickerView.frame) + 20, ScreenW - 20, 20)];
    lb3.textAlignment = NSTextAlignmentCenter;
    lb3.textColor = CharacterColor50;
    lb3.font = [UIFont systemFontOfSize:16 weight:0.2];
    lb3.text = @"您曾经就这过的项目是";
    [headV addSubview:lb3];
    
    UILabel * lb4 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lb3.frame) + 5, ScreenW - 20, 20)];
    lb4.textAlignment = NSTextAlignmentCenter;
    lb4.textColor = CharacterBlack100;
    lb4.font = kFont(14);
    lb4.text = @"方便我们推荐相关项目信息，可多选。";
    [headV addSubview:lb4];
    
    
    NSArray * arr = @[@"面部轮廓",@"眼部",@"鼻部",@"胸部",@"口腔齿科"];
    NSMutableArray<ALMessageModel *> * arrTwo = @[].mutableCopy;
    for (int i  = 0 ; i < arr.count; i++) {
        ALMessageModel * model = [[ALMessageModel alloc] init];
        model.name = arr[i];
        [arrTwo addObject:model];
    }
    ALCMineDorterView * dortV = [[ALCMineDorterView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lb4.frame) +15, ScreenW, 10)];
    dortV.isNoSelectOne = NO;
    dortV.dataArray = arrTwo;
    dortV.mj_h = dortV.hh;
    
    [headV addSubview:dortV];
    
    UITextField * tf = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(dortV.frame) + 10 , ScreenW - 30, 30)];
    tf.placeholder = @"请填写具体项目名称";
    tf.font = kFont(14);
    UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(tf.frame)+2, ScreenW - 30, 0.6)];
    lineV.backgroundColor = lineBackColor;
    [headV addSubview:tf];
    [headV addSubview:lineV];
    
    headV.mj_h = CGRectGetMaxY(lineV.frame) + 20;
    
    self.tableView.tableHeaderView = headV;
    
    
    
    
}

- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"下一步" andImgaeName:@""];
    Weak(weakSelf);
    view.footViewClickBlock = ^(UIButton *button) {
        
         ALCInterestTVC * vc =[[ALCInterestTVC alloc] init];
         vc.hidesBottomBarWhenPushed = YES;
         vc.phoneStr = weakSelf.phoneStr;
         vc.birthdateStr = weakSelf.birthdateStr;
         vc.genderStr = weakSelf.genderStr;
         vc.weightStr = weakSelf.weightStr;
         vc.heightStr = weakSelf.heightStr;
         vc.institutionVisitedIds = weakSelf.institutionVisitedIds;
         [weakSelf.navigationController pushViewController:vc animated:YES];
        
        
    };
    [self.view addSubview:view];
    

}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    
    [self.pickerView reloadAllComponents];
    if (self.dataArray.count > 0) {
        [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component API_UNAVAILABLE(tvos) {
    return 50;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArray.count;

}

// 滚动UIPickerView就会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
        label.textColor = GreenColor;
        label.font = kFont(16);
        self.institutionVisitedIds = self.dataArray[row].ID;
        
//    });
    
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
        //设置分割线的颜色
        for(UIView *singleLine in pickerView.subviews)
        {
            if (singleLine.frame.size.height < 1)
            {
                singleLine.backgroundColor = BackgroundColor;
            }
        }
    
    //设置文字的属性
    UILabel *genderLabel = [[UILabel alloc] init];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    genderLabel.textColor = CharacterBlack100;
    genderLabel.font = kFont(14);
    if (component == 0) {
        
        genderLabel.text = self.dataArray[row].name;
        
    }
    
    return genderLabel;
}



@end
