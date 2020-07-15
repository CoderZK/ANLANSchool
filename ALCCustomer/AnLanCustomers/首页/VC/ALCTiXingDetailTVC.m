//
//  ALCTiXingDetailTVC.m
//  AnLanBB
//
//  Created by zk on 2020/3/31.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCTiXingDetailTVC.h"
#import "ALCFaceBackCell.h"
#import "TongYongOneCell.h"
#import "ALCSendPeopleTVC.h"
@interface ALCTiXingDetailTVC ()

@end

@implementation ALCTiXingDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提醒详情";
    [self.tableView registerClass:[TongYongOneCell class] forCellReuseIdentifier:@"cell"];
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCFaceBackCell" bundle:nil] forCellReuseIdentifier:@"ALCFaceBackCell"];
    if (self.dataModel == nil && self.ID.length > 0) {
        [self getData];
    }

}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"calenderDeatilId"] = self.ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_getCalenderDetailURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {

            self.dataModel = [ALMessageModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self.tableView reloadData];

        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        if (self.dataModel.remindTime.length == 0) {
            return 0;
        }else {
            return 50;
        }
    }else {
        CGFloat hh = [self.dataModel.content getHeigtWithFontSize:14 lineSpace:3 width:ScreenW - 30];
        return 30 + hh;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        ALCFaceBackCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCFaceBackCell" forIndexPath:indexPath];
        if (self.dataModel.isFinish) {
            cell.imgV.image = [UIImage imageNamed:@"jkgl42"];
        }else{
            cell.imgV.image = [UIImage imageNamed:@"jkgl34"];
        }
        cell.nameLB.text = self.dataModel.remindTime;
        cell.nameLB.textColor = GreenColor;
        cell.clipsToBounds = YES;
        return cell;
    }else {
        TongYongOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.leftLB.attributedText = [self.dataModel.content getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterBlack100];
        cell.leftLB.mj_x = 15;
        cell.leftLB.mj_y = 15;
        cell.leftLB.numberOfLines = 0;
        cell.mj_w = ScreenW - 30;
        cell.lineV.hidden = cell.moreImgV.hidden = YES;
        CGFloat hh = [self.dataModel.content getHeigtWithFontSize:14 lineSpace:3 width:ScreenW - 30];
        cell.leftLB.mj_h = hh;
        
        return cell;
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}





@end
