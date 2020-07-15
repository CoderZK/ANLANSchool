//
//  ALCJianKangRiZhiDetailTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCJianKangRiZhiDetailTVC.h"
#import "ALCJianKangRiZhiDetailCell.h"
#import "ALCJianKangRiZhiDetailOneCell.h"
@interface ALCJianKangRiZhiDetailTVC ()
@property(nonatomic,strong)ALMessageModel *detailModel;
@property(nonatomic,strong)UIView *footView;
@property(nonatomic,strong)UIView *whiteV;
@property(nonatomic,strong)UILabel *contentLB;
@property(nonatomic,strong)ALMessageModel *model;

@end

@implementation ALCJianKangRiZhiDetailTVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"健康日志详情";
    
    [self.tableView registerClass:[ALCJianKangRiZhiDetailOneCell class] forCellReuseIdentifier:@"ALCJianKangRiZhiDetailOneCell"];
    [self.tableView registerClass:[ALCJianKangRiZhiDetailCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//
    [self getData];
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self getData];
//    }];
    

    [self setFootView];
    
}

- (void)setFootView {
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    self.footView.backgroundColor = [UIColor whiteColor];

    self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(100, 0, ScreenW - 115, 1)];
    [self.footView addSubview:self.whiteV];
    
    self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, ScreenW - 115, 20)];
    
    self.contentLB.textColor = CharacterColor50;
    self.contentLB.font = kFont(14);
    self.contentLB.text = @"";
    self.contentLB.numberOfLines = 0;
    [self.footView addSubview:self.contentLB];
    
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 80, 20)];
    lb.numberOfLines = 0;
    lb.textColor = CharacterBlack100;
    lb.font = kFont(14);
    lb.text = @"检验检查";
    lb.numberOfLines = 0;
    [self.footView addSubview:lb];
    
    
}


//设置图片
- (void)setPictArr:(NSArray *)pictArr {
    
    
    if (self.model.content.length == 0) {
        self.whiteV.mj_y = 35 ;
    }else {
        self.contentLB.text = self.model.content;
        CGFloat hh = [self.detailModel.medicine getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-115];
        if (hh > 20) {
            self.contentLB.mj_h = hh;
        }else {
            self.contentLB.mj_h = 20;
        }
        self.whiteV.mj_y = CGRectGetMaxY(self.contentLB.frame) + 5;
    }

    
    [self.whiteV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat ww = (ScreenW - 115 - 20)/3;
    CGFloat hh = ww * 3/4;
    CGFloat space = 10;
    NSMutableArray * arr = @[].mutableCopy;
    if (pictArr.count>0 && self.model.img.length > 0) {
        [arr addObjectsFromArray:pictArr];
    }
    if (arr.count==0) {
        self.whiteV.mj_h = 0;
        self.footView.mj_h = 50;
    }else {
        
        NSInteger number = arr.count / 3 + (arr.count % 3>0?1:0);
        CGFloat imgH = number * (hh + 10);
        self.whiteV.mj_h = imgH;
        self.footView.mj_h = CGRectGetMaxY(self.whiteV.frame) + 15;
        for (int i = 0; i<arr.count; i++) {
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((ww + 10)* (i%3), space +( hh + space) * (i/3), ww, hh)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = i+100;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInView:)];
            tap.cancelsTouchesInView = YES;//设置成N O表示当前控件响应后会传播到其他控件上，默认为YES
            [imageView addGestureRecognizer:tap];
            [self.whiteV addSubview:imageView];
            //无视频
            [imageView sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:arr[i]]]  placeholderImage:[UIImage imageNamed:@"789"]];
        }
        
        
    }
    self.tableView.tableFooterView = self.footView;
}


//点击图片
- (void)tapInView:(UITapGestureRecognizer *)tap {
    UIImageView * imgV = (UIImageView *)tap.view;
    NSInteger tag = imgV.tag - 100;
    
    [[zkPhotoShowVC alloc] initWithArray:[self.model.img componentsSeparatedByString:@"#%#@#%#"] index:tag];
    
  
        //无视频
//        NSArray * arr = self.model.pictures;
//        NSMutableArray * picArr = @[].mutableCopy;
//        for (NSString * str  in arr) {
//            [picArr addObject:[NSString stringWithFormat:@"%@",[QYZJURLDefineTool getImgURLWithStr:str]]];
//        }
//
    
    
}



- (void)getData {
    if (!isDidLogin) {
        [self gotoLoginVC];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"appointmentId"] = self.ID;
//    dict[@"345"] = @"njrgiu";
//    dict[@"qwefh3oi"] = @"22334";
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_findAllVoiceDetailListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {

            //            self.userInfoModel = [ALMessageModel mj_objectWithKeyValues:responseObject[@"data"][@"userInfoMap"]];
            //            self.detailModel = [ALMessageModel mj_objectWithKeyValues:responseObject[@"data"][@"detailMap"]];

            NSArray<ALMessageModel *> * arr = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (arr.count > 0) {
                self.detailModel = [arr firstObject];
            }

            self.model = [ALMessageModel mj_objectWithKeyValues:[self.detailModel.check_info mj_JSONObject]];
            [self setPictArr:[self.model.img componentsSeparatedByString:@"#%#@#%#"]];

            
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if (indexPath.section == 0) {
    //        return 130;
    //    }

    if (self.detailModel== nil) {
        return 50;
    }
    
    if (indexPath.section == 0) {
        if ([self.detailModel.des getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-115] > 20) {
            return 30+ [self.detailModel.des getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-115];
        }else {
            return 50;
        }
    }else if (indexPath.section == 1) {
        if ([self.detailModel.doctor_advice getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-115] > 20) {
            return 30+ [self.detailModel.doctor_advice getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-115];
        }else {
            return 50;
        }
    }else {
        
        if ([self.detailModel.times count] == 0) {
            if ([self.detailModel.medicine getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-115]  > 20) {
                return 30+ [self.detailModel.medicine getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-115];
            }else {
                return 50;
            }
        }else {
            if ([[NSString stringWithFormat:@"%@\n提醒时间: \n%@",self.detailModel.medicine,[self.detailModel.times componentsJoinedByString:@"\n"]] getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-115]  > 20) {
                return 30+ [[NSString stringWithFormat:@"%@\n提醒时间: \n%@",self.detailModel.medicine,[self.detailModel.times componentsJoinedByString:@"\n"]] getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-115];
            }else {
                return 50;
            }
        }
        
      
    }

    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}


- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return view;
}

- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.01)];
        view.clipsToBounds = YES;
        view.backgroundColor = [UIColor clearColor];
    }
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    ALCJianKangRiZhiDetailCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    if (indexPath.section == 0) {
        cell.leftLB.text = @"病情描述";
        if (self.detailModel != nil) {
            cell.titleLB.attributedText =  [self.detailModel.des getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterColor50];;
                   CGFloat hh = [self.detailModel.des getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-115];
                   if (hh > 20) {
                       cell.titleLB.mj_h = hh;
                   }else {
                       cell.titleLB.mj_h = 20;
                   }
        }
       
    }else if (indexPath.section == 1) {
        cell.leftLB.text = @"医嘱";
        if (self.detailModel != nil) {
            cell.titleLB.attributedText = [self.detailModel.doctor_advice getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterColor50];;
            CGFloat hh = [self.detailModel.doctor_advice getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-115];
            if (hh > 20) {
                cell.titleLB.mj_h = hh;
            }else {
                cell.titleLB.mj_h = 20;
            }
        }
        
    }else {
        cell.leftLB.text = @"用药处方";
        if (self.detailModel != nil) {
            
            CGFloat hh =  20;
            if ([self.detailModel.times count] == 0) {
                cell.titleLB.attributedText = [[NSString stringWithFormat:@"%@",self.detailModel.medicine] getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterColor50];;;
                if ([self.detailModel.medicine getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-115]  > 20) {
                    hh =   [self.detailModel.medicine getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-115];
                }else {
                    hh = 20;
                }
            }else {
                cell.titleLB.attributedText = [[NSString stringWithFormat:@"%@\n提醒时间: \n%@",self.detailModel.medicine,[self.detailModel.times componentsJoinedByString:@"\n"]] getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterColor50];
                if ([[NSString stringWithFormat:@"%@\n提醒时间: \n%@",self.detailModel.medicine,[self.detailModel.times componentsJoinedByString:@"\n"]] getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-115]  > 20) {
                    
                  hh =  [[NSString stringWithFormat:@"%@\n提醒时间: \n%@",self.detailModel.medicine,[self.detailModel.times componentsJoinedByString:@"\n"]] getHeigtWithFontSize:14 lineSpace:3 width:ScreenW-115];
                }else {
                  hh = 20;
                }
            }
            if (hh > 20) {
                cell.titleLB.mj_h = hh;
            }else {
                cell.titleLB.mj_h = 20;
            }
        }
    }
    if (self.detailModel== nil) {
        cell.titleLB.text = @"";
    }
    return cell;

  


}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


@end
