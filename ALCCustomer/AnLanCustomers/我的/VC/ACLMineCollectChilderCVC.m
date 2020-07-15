//
//  ACLMineCollectChilderCVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ACLMineCollectChilderCVC.h"
#import "XMGWaterflowLayout.h"
#import "ACLMineCollectCell.h"
#import "ALCDorListCell.h"
#import "ALCTiaoLiOneCell.h"
#import "ALCHospitalHomeTVC.h"
#import "ALCDorDetailOneTVC.h"
#import "ALCLookDetailTVC.h"
@interface ACLMineCollectChilderCVC ()<XMGWaterflowLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource>

/**  */
@property(nonatomic , strong)XMGWaterflowLayout *layout;

@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;

@end

@implementation ACLMineCollectChilderCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (self.type == 1) {
        self.layout =[[XMGWaterflowLayout alloc] init];
        self.layout.delegate = self;
        
        
        self.collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - sstatusHeight - 35 - 44 ) collectionViewLayout:self.layout];
        
        [self.collectionView registerClass:[ACLMineCollectCell class] forCellWithReuseIdentifier:@"cell"];
        
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        //           self.collectionView.scrollEnabled = NO;
        self.collectionView.backgroundColor =[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
        [self.view addSubview:self.collectionView];
    }else {
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        self.tableView.autoresizingMask  =  UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.view addSubview:self.tableView];
        
        [self.tableView registerNib:[UINib nibWithNibName:@"ALCDorListCell" bundle:nil] forCellReuseIdentifier:@"ALCDorListCell"];
        [self.tableView registerNib:[UINib nibWithNibName:@"ALCTiaoLiOneCell" bundle:nil] forCellReuseIdentifier:@"ALCTiaoLiOneCell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    
    
    
    self.page = 1;
    self.dataArray = @[].mutableCopy;
    [self getData];
    if (self.type == 1) {
        self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            [self getData];
        }];
    }else {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            [self getData];
        }];
    }
    
//    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        self.page++;
//        [self getData];
//    }];
    
    
    
}

- (void)getData {
    if (!isDidLogin) {
           [self gotoLoginVC];
           return;
       }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
//    dict[@"page"] = @(self.page);
//    dict[@"pageSize"] = @(10);
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    dict[@"condition"] = @(self.type);
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_myCollectionURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
                        NSArray<ALMessageModel *>*arr = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                        if (self.page == 1) {
                            [self.dataArray removeAllObjects];
                        }
                        [self.dataArray addObjectsFromArray:arr];
            if (self.type == 1) {
               [self.collectionView reloadData];
            }else {
                [self.tableView reloadData];
            }
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}


- (void)setDataArray:(NSMutableArray *)dataArray {
    
    _dataArray = dataArray;
    [self.collectionView reloadData];
    
    //CGFloat HH = _layout.collectionViewContentSize.height;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
    //    return self.dataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    ACLMineCollectCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    ALMessageModel * model = self.dataArray[indexPath.row];
    cell.model = model;
    
    return cell;
}




- (CGFloat)waterflowLayout:(XMGWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth {
    //    zkTouPiaoModel * model = self.dataArray[index];
    //    NSString * imgStr = model.optimg;
    //    if ([imgStr containsString:@"-"]) {
    //
    //        NSString * imgHWStr  = [[imgStr componentsSeparatedByString:@"-"] lastObject];
    //        NSArray * HWArr = [imgHWStr componentsSeparatedByString:@"&"];
    //        CGFloat WW = [[HWArr firstObject] floatValue];
    //        CGFloat HH = [[HWArr lastObject] floatValue];
    //
    //        CGFloat height = itemWidth * HH / WW + 60;
    //
    //        return height;
    //
    //    }
    
    CGFloat ww = (ScreenW - 40) / 2;
    
    return ww   + 85;
    
}

- (CGFloat)columnCountInWaterflowLayout:(XMGWaterflowLayout *)waterflowLayout {
    
    return 2;
    
    
}
- (CGFloat)columnMarginInWaterflowLayout:(XMGWaterflowLayout *)waterflowLayout {
    
    return 10;
    
}
- (CGFloat)rowMarginInWaterflowLayout:(XMGWaterflowLayout *)waterflowLayout {
    
    return 10;
    
}
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(XMGWaterflowLayout *)waterflowLayout {
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
    
}




- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority {
    
    CGFloat HH = self.layout.collectionViewContentSize.height;
    self.collectionView.frame = CGRectMake(0, 0, ScreenW, HH);
    [self.collectionView layoutIfNeeded];
    return self.layout.collectionViewContentSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ALCLookDetailTVC * vc =[[ALCLookDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.ID = self.dataArray[indexPath.row].ID;
    Weak(weakSelf);
    vc.isNoCollectBlock = ^{
        [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 2) {
        return 110;
    }
    return 154;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == 2) {
        ALCTiaoLiOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCTiaoLiOneCell" forIndexPath:indexPath];
        ALMessageModel * model = self.dataArray[indexPath.row];
        cell.model = model;
        return cell;
    }else {
        ALCDorListCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCDorListCell" forIndexPath:indexPath];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.type == 2) {
        ALCHospitalHomeTVC * vc =[[ALCHospitalHomeTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.institutionId = self.dataArray[indexPath.row].ID;
        Weak(weakSelf);
        vc.isNoCollectBlock = ^{
            [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        ALCDorDetailOneTVC * vc =[[ALCDorDetailOneTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.doctorId = self.dataArray[indexPath.row].doctorId;
        Weak(weakSelf);
        vc.isNoCollectBlock = ^{
            [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}


@end
