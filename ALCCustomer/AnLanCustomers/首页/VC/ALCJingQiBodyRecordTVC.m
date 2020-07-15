//
//  ALCJingQiBodyRecordTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/5/6.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCJingQiBodyRecordTVC.h"

@interface ALCJingQiBodyRecordTVC ()<zkPickViewDelelgate>
@property(nonatomic,strong)NSArray *leftTitleArr,*rightPlaceholdArr;
@property(nonatomic,strong)NSMutableArray *numberArr;
@property(nonatomic,strong)NSIndexPath *selectIndexPath;
@property(nonatomic,strong)NSString *timeStr,*timeTwoStr,*timeThreeStr;
@end

@implementation ALCJingQiBodyRecordTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"经期记录";
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTitleArr = @[@"末次月经时间",@"月经长度",@"月经周期"];
    self.rightPlaceholdArr = @[@"最近一次月经哪天来的",@"来大姨妈的实际天数",@"两次月经第一天的时间间隔天数"];
    
    [self setFootV];
    self.numberArr = @[].mutableCopy;
    for (int i = 1 ; i <= 31; i++) {
        [self.numberArr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    
}

- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"保存" andImgaeName:@""];
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
    
    
    if (self.timeStr.length== 0 ||  self.timeTwoStr.length == 0 || self.timeThreeStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"信息填写不完整"];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    NSString * url = [QYZJURLDefineTool user_recordMenstrualURL];
 
    dict[@"lastday"] = self.timeStr;
    dict[@"length"] = self.timeTwoStr;
    dict[@"period"] = self.timeThreeStr;
    
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    dict[@"recordDate"] = [formatter stringFromDate:date];
    
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        

        
    }];
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leftTitleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.mj_w = 150;
    cell.TF.mj_x = 165;
    cell.TF.mj_w = ScreenW - 165 - 35;
    cell.TF.textAlignment = NSTextAlignmentRight;
    cell.TF.userInteractionEnabled = NO;
    cell.rightLB.highlighted = YES;
    cell.leftLB.text = self.leftTitleArr[indexPath.row];
    cell.TF.placeholder = self.rightPlaceholdArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.TF.text = self.timeStr;
    }else if (indexPath.row == 1) {
        cell.TF.text = self.timeTwoStr;
    }else {
        cell.TF.text = self.timeThreeStr;
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectIndexPath = indexPath;
    if (indexPath.row  == 0) {
        
        SelectTimeV *selectTimeV = [[SelectTimeV alloc] init];
         
        selectTimeV.isCanSelectOld = YES;
        selectTimeV.isCanSelectToday = YES;
        Weak(weakSelf);
        selectTimeV.block = ^(NSString *timeStr) {
            weakSelf.timeStr = timeStr;
            [weakSelf.tableView reloadData];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
        
        
    }else if (indexPath.row == 1) {
        
        zkPickView * picker = [[zkPickView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self;
        picker.arrayType = titleArray;
        picker.array = self.numberArr;
        picker.selectLb.text = @"";
        [picker show];
        
        
    }else if (indexPath.row == 2) {
        
        zkPickView * picker = [[zkPickView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self;
        picker.arrayType = titleArray;
        picker.array = self.numberArr;
        picker.selectLb.text = @"";
        [picker show];
        
    }
    
    
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex {
    
    if (self.selectIndexPath.row == 1) {
        self.timeTwoStr = [NSString stringWithFormat:@"%d",leftIndex+1];
    }else {
        self.timeThreeStr = [NSString stringWithFormat:@"%d",leftIndex+1];
    }
    [self.tableView reloadData];
    
}


@end
