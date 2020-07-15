//
//  ALCCityListVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/4/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCCityListVC.h"
#import "ALCCityCell.h"
#import "QYZJLocationTool.h"
#import "ALCCityModel.h"
@interface ALCCityListVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *leftTV,*rightTV;
@property(nonatomic,strong)UIButton *leftBt,*rightBt;
@property(nonatomic,strong)QYZJLocationTool *tool;

@property(nonatomic,strong)NSMutableArray<ALCCityModel *> *leftArr;
@property(nonatomic,strong)NSMutableArray<ALCCityModel *> *rightArr;
@property(nonatomic,strong)NSString *prnviceStr,*cityStr,*prnviceID,*cityID;
@end

@implementation ALCCityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"地区选择";
    
    self.tool = [[QYZJLocationTool alloc] init];
     [self.tool locationAction];
     Weak(weakSelf);
     self.tool.locationBlock = ^(NSString * _Nonnull cityStr, NSString * _Nonnull cityID,NSString * procince , CGFloat la ,CGFloat lo) {
         weakSelf.prnviceStr = procince;
         weakSelf.cityStr = cityStr;
         weakSelf.cityID = cityID;
         [weakSelf.leftBt setTitle:cityStr forState:UIControlStateNormal];
     };
    self.leftArr = @[].mutableCopy;
    self.rightArr = @[].mutableCopy;
    
    [self addView];
    [self addTableView];
    [self getDataWithType:1 withId:nil];
    
    
}

- (void)getDataWithType:(NSInteger )type withId:(NSString *)idStr{
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @(type);
    dict[@"id"] = idStr;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_findAreaListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
      
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            if (type == 1) {
                self.leftArr = [ALCCityModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
                [self.leftTV reloadData];
            }else {
                self.rightArr = [ALCCityModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
                [self.rightTV reloadData];
            }
            
        }else {
             [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
}


- (void)addView {
    
    UIView * whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    whiteV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteV];
    
    self.leftBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 10,150, 30)];
    [self.leftBt setTitle:@"当前城市" forState:UIControlStateNormal];
    self.leftBt.titleLabel.font = kFont(14);
    self.leftBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.leftBt setTitleColor:CharacterBlack100 forState:UIControlStateNormal];
    [whiteV addSubview:self.leftBt];
    self.leftBt.tag = 100;
    [self.leftBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 115, 10, 100, 30)];
    [self.rightBt setTitle:@"全国搜索" forState:UIControlStateNormal];
    self.rightBt.titleLabel.font = kFont(14);
    self.rightBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.rightBt setTitleColor:CharacterBlack100 forState:UIControlStateNormal];
    if (!self.isComeAddFamily) {
        [whiteV addSubview:self.rightBt];
    }
    self.rightBt.tag = 101;
    [self.rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 49.6, ScreenW, 0.4)];
    backV.backgroundColor = lineBackColor;
    [whiteV addSubview:backV];
    

    
    
    
}

- (void)addTableView {
    
    self.leftTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenW/2, ScreenH - 50 -sstatusHeight - 44)];
    if (sstatusHeight > 20) {
        self.leftTV.frame = CGRectMake(0, 50, ScreenW/2, ScreenH - 50 -sstatusHeight - 44 - 34);
    }
    self.leftTV.dataSource = self;
    self.leftTV.delegate = self;
    self.leftTV.backgroundColor = BackgroundColor;
    [self.view addSubview:self.leftTV];
    
    self.rightTV = [[UITableView alloc] initWithFrame:CGRectMake(ScreenW/2, 50, ScreenW/2, ScreenH - 50 -sstatusHeight - 44)];
    if (sstatusHeight > 20) {
        self.rightTV.frame = CGRectMake(ScreenW/2, 50, ScreenW/2, ScreenH - 50 -sstatusHeight - 44 - 34);
    }
    self.rightTV.dataSource = self;
    self.rightTV.delegate = self;
    self.rightTV.backgroundColor = WhiteColor;
    [self.view addSubview:self.rightTV];
    
    [self.leftTV registerClass:[ALCCityCell class] forCellReuseIdentifier:@"cellLeft"];
    [self.rightTV registerClass:[ALCCityCell class] forCellReuseIdentifier:@"cellRight"];
    self.leftTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTV) {
        return self.leftArr.count;
    }else {
        return self.rightArr.count;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTV) {
        ALCCityCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellLeft" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = BackgroundColor;
        cell.leftLB.text = self.leftArr[indexPath.row].areaname;
        return cell;
    }else {
        ALCCityCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellRight" forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WhiteColor;
        cell.leftLB.text = self.rightArr[indexPath.row].areaname;
        return cell;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.rightTV) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
         self.cityStr = self.rightArr[indexPath.row].areaname;
        self.cityID = self.rightArr[indexPath.row].areaid;
        if (self.cityBlock != nil) {
            self.cityBlock(self.prnviceStr, self.cityStr,self.prnviceID,self.cityID);
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }else {
        [self getDataWithType:2 withId:self.leftArr[indexPath.row].areaid];
        
        self.prnviceStr = self.leftArr[indexPath.row].areaname;
        self.prnviceID = self.leftArr[indexPath.row].areaid;
    }
    
    
}

//点击当前定位点,或者全国
- (void)clickAction:(UIButton *)button {
    if (button.tag == 101) {
        if (self.cityBlock != nil) {
            self.cityBlock(@"", @"全国",@"",@"");
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }else {
        if ([button.titleLabel.text isEqualToString:@"当前城市"]) {
            return;
        }
        if (self.cityBlock != nil) {
            self.cityBlock(self.prnviceStr, self.cityStr,@"",self.cityID);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    
}


@end
