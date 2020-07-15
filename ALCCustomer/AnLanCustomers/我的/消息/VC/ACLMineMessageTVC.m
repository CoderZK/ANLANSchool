//
//  ACLMineMessageTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ACLMineMessageTVC.h"
#import "ALCMessageOneCell.h"
#import "ALCInquiryMessageTVC.h"
@interface ACLMineMessageTVC ()
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)UIView *leftRedV,*rightRedV;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@property(nonatomic,assign)NSInteger logsCnt;
@end

@implementation ACLMineMessageTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    
    
    [self addHeadV];

    [self.tableView registerNib:[UINib nibWithNibName:@"ALCMessageOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 75;
    
    self.dataArray = @[].mutableCopy;

    [self getData];
    [self redMessageAction];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getData];
    }];

    
    
    
}

- (void)redMessageAction {

    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:user_readSystemMessage parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
     
   
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
      
        
    }];
}


- (void)getData {
    if (!isDidLogin) {
           [self gotoLoginVC];
           return;
       }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_findSystemMessageURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.dataArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"messages"]];
            self.logsCnt = [responseObject[@"data"][@"cnt"] integerValue];
            if (self.logsCnt > 0) {
                self.leftRedV.hidden = NO;
            }else {
                self.leftRedV.hidden = YES;
            }
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}





- (void)addHeadV {
    
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 125)];
    
    UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW/2 - 80 - 20, 10, 80, 100)];
    [self.headV addSubview:button1];
    [button1 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag = 100;
    UIImageView * imgV1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 50, 50)];
    imgV1.backgroundColor = [UIColor redColor];
    [button1 addSubview:imgV1];
    imgV1.layer.cornerRadius = 5;
     imgV1.image = [UIImage imageNamed:@"jkgl29"];
    imgV1.clipsToBounds = YES;
    [button1 addSubview:imgV1];
    
//    self.leftRedV = [[UIView alloc] initWithFrame:CGRectMake(58, 7, 10, 10)];
//    self.leftRedV.backgroundColor = [UIColor redColor];
//    self.leftRedV.layer.cornerRadius = 5;
//    self.leftRedV.clipsToBounds = YES;
//    [button1 addSubview:self.leftRedV];
    
    UILabel * lb1 =[[UILabel alloc] initWithFrame:CGRectMake(0, 70 , 80, 20)];
    lb1.font =[UIFont systemFontOfSize:15];
    lb1.textColor = CharacterColor50;
    [button1 addSubview:lb1];
    lb1.text = @"新朋友";
    lb1.textAlignment = NSTextAlignmentCenter;
    
    
    UIButton * button2 = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW/2 + 20, 10, 80, 100)];
    [self.headV addSubview:button2];
    [button2 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = 101;
    UIImageView * imgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 50, 50)];
    imgV2.backgroundColor = [UIColor redColor];
    [button2 addSubview:imgV2];
    imgV2.layer.cornerRadius = 5;
     imgV2.image = [UIImage imageNamed:@"jkgl30"];
    imgV2.clipsToBounds = YES;
    [button2 addSubview:imgV2];
    
    self.rightRedV = [[UIView alloc] initWithFrame:CGRectMake(58, 7, 10, 10)];
    self.rightRedV.backgroundColor = [UIColor redColor];
    self.rightRedV.layer.cornerRadius = 5;
    self.rightRedV.clipsToBounds = YES;
    self.rightRedV.hidden = YES;
    [button2 addSubview:self.rightRedV];
    
    UILabel * lb2 =[[UILabel alloc] initWithFrame:CGRectMake(0, 70 , 80, 20)];
    lb2.font =[UIFont systemFontOfSize:15];
    lb2.textColor = CharacterColor50;
    lb2.text = @"问诊消息";
    lb2.textAlignment = NSTextAlignmentCenter;
    [button2 addSubview:lb2];
    
    self.tableView.tableHeaderView = self.headV;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 75;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCMessageOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ALMessageModel * model = self.dataArray[indexPath.row];
    cell.timeLB.text = model.createTime;
    cell.leftOne.text = model.title;
    cell.leftTwoLB.text = model.content;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)clickAction:(UIButton *)button {
    ALCInquiryMessageTVC * vc =[[ALCInquiryMessageTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    if (button.tag == 100) {
        vc.isNewFriend = YES;
    }else {
        vc.isNewFriend = NO;
    }
     [self.navigationController pushViewController:vc animated:YES];
    
}

@end
