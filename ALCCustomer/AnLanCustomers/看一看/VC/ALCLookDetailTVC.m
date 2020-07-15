//
//  ALCLookDetailTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCLookDetailTVC.h"
#import "ALCLookHeadView.h"
#import "ALCLookDetailOneCell.h"
#import <AVKit/AVKit.h>

@interface ALCLookDetailTVC ()<UITextFieldDelegate,WKNavigationDelegate>
@property(nonatomic,strong)UIView *whiteView;
@property(nonatomic,strong)UITextField *TF;
@property(nonatomic,strong)ALCLookHeadView *headV;
@property(nonatomic,strong)ALMessageModel *dataModel;
@property(nonatomic,strong)UIButton *rightBt;

@property(nonatomic,strong)UIView *videoV;
@property(nonatomic,strong)AVPlayerViewController *playVC;
@property(nonatomic,strong)AVPlayer * avPlayer;

@end

@implementation ALCLookDetailTVC

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    self.avPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:@""]];
    [self.avPlayer pause];
    [self.avPlayer seekToTime:(CMTimeMake(0, 1))];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.isNoCollectBlock != nil && [self.rightBt.currentImage isEqual:[UIImage imageNamed:@"jkgl48"]]) {
        self.isNoCollectBlock();
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"文章详情";
    
    [self setPingView];
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCLookDetailOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[ACLHeadOrFootView class] forHeaderFooterViewReuseIdentifier:@"head"];
    self.tableView.estimatedRowHeight = 40;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
   
    UIButton * submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 200, 60, 44)];
    submitBtn.layer.cornerRadius = 22;
    submitBtn.layer.masksToBounds = YES;
    //      [submitBtn setTitle:@"搜索" forState:UIControlStateNormal];
    
    [submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitBtn setImage:[UIImage imageNamed:@"jkgl48"] forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBt = submitBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];

    
}

- (void)setvideVWithaudioStr:(NSString *)str {
    
    self.videoV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW * 9/16)];
    self.videoV.clipsToBounds = YES;
    
    NSString *webVideoPath = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
    NSURL *webVideoUrl = [NSURL URLWithString:webVideoPath];
    //步骤2：创建AVPlayer
    AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:webVideoUrl];
    self.avPlayer = avPlayer;
    self.playVC = [[AVPlayerViewController alloc] init];
    [self addChildViewController:self.playVC];
    [self.videoV addSubview:self.playVC.view];
    self.videoV.mj_h = ScreenW * 9/16;
    self.playVC.view.frame = CGRectMake(0, 0, ScreenW, ScreenW * 9/16);
    [self.videoV addSubview:self.playVC.view];
    self.playVC.player = avPlayer;
    [self.view  addSubview: self.videoV];
    self.tableView.contentInset = UIEdgeInsetsMake(ScreenW * 9/16, 0, 0, 0);

}


- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_getArticleDetailURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            if (self.dataModel == nil) {
                self.dataModel = [ALMessageModel mj_objectWithKeyValues:responseObject[@"data"]];

                self.headV = [[ALCLookHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 20)];
                self.headV.webView.navigationDelegate = self;
                [self.headV.webView loadHTMLString:[NSString stringWithFormat:@"%@",self.dataModel.article.content ] baseURL:nil];
                self.tableView.tableHeaderView = self.headV;
                
                self.headV.model = self.dataModel.article;
                if ([self.dataModel.article.type intValue] == 1) {
                    //视频
                    [self setvideVWithaudioStr:self.dataModel.article.video];
                }else {
                    //富文本
                }
            }else {
                
                self.dataModel = [ALMessageModel mj_objectWithKeyValues:responseObject[@"data"]];
                
            }
            
            
            if (!self.dataModel.article.isAllowComment) {
                self.whiteView.hidden = YES;
                self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH );
            }else {
                self.whiteView.hidden = NO;
                if (sstatusHeight > 20) {
                          self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 34 - 60);
                          self.whiteView.mj_y = ScreenH - sstatusHeight - 44 - 34 -60;
                      }else {
                          self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - sstatusHeight - 44);
                          self.whiteView.mj_y = ScreenH - sstatusHeight - 44  - 60 ;
                      }
            }
            
            
            if (self.dataModel.article.isCollection) {
                [self.rightBt setImage:[UIImage imageNamed:@"jkgl47"] forState:UIControlStateNormal];
            }else {
                [self.rightBt setImage:[UIImage imageNamed:@"jkgl48"] forState:UIControlStateNormal];
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

//收藏操作
- (void)submitBtnClick:(UIButton *)button {
    
    if (!isDidLogin) {
           [self gotoLoginVC];
           return;
       }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"articleId"] = self.ID;
    NSString * str = [QYZJURLDefineTool user_delArticCollectionURL];
    if ([button.currentImage isEqual:[UIImage imageNamed:@"jkgl48"]]) {
        //未收藏
        str = [QYZJURLDefineTool user_collectArticleURL];
    }
    
    [zkRequestTool networkingPOST:str parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            if ([button.currentImage isEqual:[UIImage imageNamed:@"jkgl48"]]) {
                //未收藏
                [SVProgressHUD showSuccessWithStatus:@"收藏文章成功"];
                [button setImage:[UIImage imageNamed:@"jkgl47"] forState:UIControlStateNormal];
            }else {
                [SVProgressHUD showSuccessWithStatus:@"取消文章收藏成功"];
                [button setImage:[UIImage imageNamed:@"jkgl48"] forState:UIControlStateNormal];
            }
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"<body>%@</body>",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

}




- (void)setPingView {
    
       self.whiteView = [[UIView alloc] init];
       self.whiteView.backgroundColor = [UIColor groupTableViewBackgroundColor];
       self.whiteView.mj_w = ScreenW ;
       self.whiteView.mj_h = 60;
       self.whiteView.mj_x = 0;
       [self.view addSubview:self.whiteView];

       
       UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(15, 10, ScreenW - 30 - 70, 40)];
       backV.backgroundColor = [UIColor whiteColor];
       [self.view addSubview:backV];
       backV.layer.cornerRadius = 3;
       backV.clipsToBounds = YES;
       [self.whiteView addSubview:backV];
       

       
       self.TF = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, ScreenW - 50-70 , 30)];
       self.TF.font = kFont(14);
       self.TF.placeholder = @"请输入评论";
       self.TF.delegate = self;
       self.TF.returnKeyType = UIReturnKeySend;
       [backV addSubview:self.TF];
       
       UIButton * sendBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW -70, 15, 60, 30)];
        [sendBt setTitle:@"发送" forState:UIControlStateNormal];
        sendBt.titleLabel.font = kFont(14);
        [sendBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        [self.whiteView addSubview:sendBt];
        [sendBt setBackgroundImage:[UIImage imageNamed:@"gback"] forState:UIControlStateNormal];
        sendBt.layer.cornerRadius = 4;
        sendBt.clipsToBounds = YES;
        [sendBt addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];

       if (sstatusHeight > 20) {
           self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 34 - 44 - sstatusHeight - 60);
           self.whiteView.mj_y = ScreenH - sstatusHeight - 44 - 34 -60;
       }else {
           self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - sstatusHeight - 44 -60);
           self.whiteView.mj_y = ScreenH - sstatusHeight - 44  -60;
       }
    
}
- (void)sendAction:(UIButton *)button {
    if (self.TF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        return;
    }
    
    [self textFieldShouldReturn:self.TF];
    
}


//点击发送
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self commentAction];
    
    return YES;
}


- (void)commentAction {
    
    if (!isDidLogin) {
           [self gotoLoginVC];
           return;
       }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"articleId"] = self.ID;
    dict[@"content"] = self.TF.text;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_doArticleCommentURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            ALMessageModel * model = [[ALMessageModel alloc] init];
            model.nickname = [zkSignleTool shareTool].nick_name;
            model.content = self.TF.text;
            model.avatar = [zkSignleTool shareTool].avatar;
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-mm-dd HH:ss:mm"];
            model.createTime = [formatter stringFromDate:[NSDate date]];
            [self.dataModel.commentList insertObject:model atIndex:0];
            [self.tableView reloadData];
            self.TF.text = @"";
            
            
        }else {
             [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
}


- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.dataModel.commentList.count == 0) {
        return 45;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    ACLHeadOrFootView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
//    if (view == nil) {
//        view = [[ACLHeadOrFootView alloc] init];
//    }
    view.clipsToBounds = YES;
  
    view.backgroundColor = WhiteColor;
    return view;
}

- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ACLHeadOrFootView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
//    if (view == nil) {
//           view = [[ACLHeadOrFootView alloc] init];
//       }
    if (section == 0) {
          view.rightBt.hidden = YES;
          view.leftLB.text = @"热门评论";
      }
    view.clipsToBounds = YES;
    view.backgroundColor = WhiteColor;
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModel.commentList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCLookDetailOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ALMessageModel * model = self.dataModel.commentList[indexPath.row];
    [cell.headBt sd_setBackgroundImageWithURL:[model.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    cell.headBt.layer.cornerRadius = 20;
    cell.headBt.clipsToBounds = YES;
    cell.nameLB.text = model.nickname;
    cell.timeLB.text = model.createTime;
    cell.contentLB.text = model.content;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable any, NSError * _Nullable error) {

        NSString *heightStr = [NSString stringWithFormat:@"%@",any];
        self.headV.webView.mj_h = heightStr.floatValue;
        self.headV.mj_h = self.dataModel.article.HHHHHH + heightStr.floatValue + 10;
        self.tableView.tableHeaderView = self.headV;
        
    }];
    
}

@end
