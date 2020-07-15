//
//  ALCChooseAdministrativeTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCChooseAdministrativeTVC.h"
#import "ALCHospitalTwoCell.h"
#import "ALCDorListTVC.h"
@interface ALCChooseAdministrativeTVC ()<ALCHospitalTwoCellDelegate>
@property(nonatomic,strong)NSArray  *dataArray;
@end

@implementation ALCChooseAdministrativeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"科室选择";
   [self.tableView registerClass:[ALCHospitalTwoCell class] forCellReuseIdentifier:@"cell"];
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat space = 10;
    CGFloat ww = (ScreenW - 30-3*space)/4;
    NSInteger lines = self.departmentList.count /4 + (self.departmentList.count % 4 ==0?0:1);
    return ww* lines + lines * space + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCHospitalTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.dataArray = self.departmentList;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark ------ 点击科室 ----

- (void)clickALCHospitalTwoCell:(ALCHospitalTwoCell *)cell withIndex:(NSInteger )index {
    
    
    ALCDorListTVC * vc =[[ALCDorListTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.isComeFromHospital = YES;
    vc.HosId = self.hosID;
    vc.departId = self.departmentList[index].ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
