//
//  GuanZhuVC.m
//  AnLanCustomers
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "GuanZhuVC.h"
#import "XMGWaterflowLayout.h"
#import "ACLMineCollectCell.h"
#import "ALCLookDetailTVC.h"
@interface GuanZhuVC ()<XMGWaterflowLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UIButton *editBt;
/**  */
@property(nonatomic , strong)XMGWaterflowLayout *layout;
/** 数据数组 */
//@property(nonatomic , strong)NSMutableArray *dataArray;
@property(nonatomic , strong)UICollectionView *collectionView;

@property(nonatomic,assign)NSInteger page;


@end

@implementation GuanZhuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.layout =[[XMGWaterflowLayout alloc] init];
    self.layout.delegate = self;
    
    
    self.collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - sstatusHeight - 44 - 40 ) collectionViewLayout:self.layout];
    
    [self.collectionView registerClass:[ACLMineCollectCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //           self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor =[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    if (self.isSearch) {
        
        
        [self.collectionView reloadData];
        self.navigationItem.title = @"文章列表";
        
    }else {
        [self setHeadView];
           self.page = 1;
           self.dataArray = @[].mutableCopy;
           [self getData];
           self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
               self.page = 1;
               [self getData];
           }];
           self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
               self.page++;
               [self getData];
           }];
    }
    
   
}

- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    dict[@"type"] = @(self.type);
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_findArticleListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            NSArray<ALMessageModel *>*arr = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            
            [self.collectionView reloadData];

        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
    
    
    
}


- (void)setHeadView {
    
    ALCSearchView * searchTitleView = [[ALCSearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 70, 44)];
    searchTitleView.searchTF.delegate = self;
    searchTitleView.isPush = YES;
    self.navigationItem.titleView = searchTitleView;
//    @weakify(self);
//    [[[searchTitleView.searchTF rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
//        @strongify(self);
//        if (value.length > 0) {
//            return YES;
//        }else {
//            return NO;
//        }
//    }] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"======\n%@",x);
//    }];
    
    
    @weakify(self);
    [[searchTitleView.clickBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           @strongify(self);
           ALCMineSearchTVC * vc =[[ALCMineSearchTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
           vc.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:vc animated:YES];
           
       }];
    
    self.navigationItem.titleView = searchTitleView;
    UIButton * submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 200, 44, 44)];
//    submitBtn.layer.cornerRadius = 22;
//    submitBtn.layer.masksToBounds = YES;
    // [submitBtn setTitle:@"搜索" forState:UIControlStateNormal];
    
    [submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitBtn setImage:[UIImage imageNamed:@"jkgl1"] forState:UIControlStateNormal];
    submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [submitBtn showViewWithColor:[UIColor redColor]];

    [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.editBt = submitBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:nil];
    
    
}


//- (void)setDataArray:(NSMutableArray *)dataArray {
//
//    _dataArray = dataArray;
//    [self.collectionView reloadData];
//
//    //CGFloat HH = _layout.collectionViewContentSize.height;
//
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 9;
        return self.dataArray.count;
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
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)submitBtnClick:(UIButton *)button {
     if (!isDidLogin) {
         [self gotoLoginVC];
         return;
     }
     ACLMineMessageTVC * vc =[[ACLMineMessageTVC alloc] init];
     vc.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:vc animated:YES];
}


@end
