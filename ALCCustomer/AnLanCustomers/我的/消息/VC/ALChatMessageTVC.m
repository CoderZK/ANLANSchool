//
//  ALChatMessageTVC.m
//  AnLanBB
//
//  Created by zk on 2020/4/23.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALChatMessageTVC.h"
#import "ALCChartMessageCell.h"
#import "ALCChartMessageTwoCell.h"
#import "ALCChartMessageThreeCell.h"
@interface ALChatMessageTVC ()<UITextFieldDelegate>
@property(nonatomic,strong)UIView *whiteView;
@property(nonatomic,strong)UITextField *TF;

@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@property(nonatomic,strong)NSMutableArray *picArr;
@property(nonatomic,assign)NSInteger messagetype;
@property(nonatomic,strong)NSString *getIn;


@end

@implementation ALChatMessageTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addPingLunView];
    self.page = 1;
    self.dataArray = @[].mutableCopy;
    self.picArr = @[].mutableCopy;
    self.messagetype = 1;
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page++;
        [self getData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    
    self.navigationItem.title = @"聊天消息";
    
    [self.tableView registerClass:[ALCChartMessageCell class] forCellReuseIdentifier:@"ALCChartMessageCell"];
    [self.tableView registerClass:[ALCChartMessageTwoCell class] forCellReuseIdentifier:@"ALCChartMessageTwoCell"];
    [self.tableView registerClass:[ALCChartMessageThreeCell class] forCellReuseIdentifier:@"ALCChartMessageThreeCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.getIn = @"ture";
    
}


- (void)getData {
    
    if (!isDidLogin) {
        [self gotoLoginVC];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(20);
    dict[@"toUserId"] = self.toUserId;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_findLogsURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            NSArray<ALMessageModel *>*arr = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"logs"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            
            [self.tableView reloadData];
            
            
            if (self.page == 1 && self.dataArray.count > 0) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count -1 inSection:0] atScrollPosition:(UITableViewScrollPositionBottom) animated:NO];
                });
            }
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
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count == 0) {
        return 0;
    }
    return self.dataArray[self.dataArray.count - indexPath.row - 1].HHHHHH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataArray.count == 0) {
        return nil;
    }
    ALMessageModel * model = self.dataArray[self.dataArray.count - indexPath.row - 1];
    
    if ([model.messageType isEqualToString:@"-1"]) {
        ALCChartMessageThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCChartMessageThreeCell" forIndexPath:indexPath];
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (!model.isSelf) {
        ALCChartMessageCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCChartMessageCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.timeStr = @"";
        }else {
            cell.timeStr = self.dataArray[self.dataArray.count - indexPath.row].createTime;
        }
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else {
        ALCChartMessageTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCChartMessageTwoCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.timeStr = @"";
        }else {
            cell.timeStr = self.dataArray[self.dataArray.count - indexPath.row].createTime;
        }
        cell.model = model;
        return cell;
        
    }
    
    
}

//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//
////    if (indexPath.row == [self numberOfRowsInSection:0]-1 && !self.isLoadTableView) {
////
////        self.isLoadTableView = YES;
////
////        [self scrollToRowAtIndexPath:indexPathatScrollPosition:UITableViewScrollPositionBottom animated:NO];
////
////    }
////    if (self.dataArray.count == 0) {
////        return;
////    }
////    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//    
//
//     [self scrollViewToBottom:NO];
//    
//}

//- (void)scrollViewToBottom:(BOOL)animated
//
//{
//
//    if (self.tableView.contentSize.height > self.tableView.frame.size.height)
//
//    {
//
//        CGPoint offset = CGPointMake(0, self.tableView.contentSize.height -self.tableView.frame.size.height);
//
//        [self.tableView setContentOffset:offset animated:animated];
//
//    }
//
//}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //    ALMessageModel * model = self.dataArray[self.dataArray.count - 1-indexPath.row];
    //    if ([model.type intValue] == 2) {
    //
    //        [[zkPhotoShowVC alloc] initWithArray:@[model.image] index:0];
    //
    //    }
    
}

- (void)addPingLunView {
    
    self.whiteView = [[UIView alloc] init];
    self.whiteView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.whiteView.mj_w = ScreenW ;
    self.whiteView.mj_h = 60;
    self.whiteView.mj_x = 0;
    [self.view addSubview:self.whiteView];
    
    UIView * backVOne =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.3)];
    backVOne.backgroundColor = CharacterColor180;
    [self.whiteView addSubview:backVOne];
    
    
    
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(15, 10, ScreenW - 30 - 70-40, 40)];
    backV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backV];
    backV.layer.cornerRadius = 3;
    backV.clipsToBounds = YES;
    [self.whiteView addSubview:backV];
    
    
    
    self.TF = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, ScreenW - 50-70 - 40  , 30)];
    self.TF.font = kFont(14);
    self.TF.placeholder = @"请输入评论";
    self.TF.delegate = self;
    self.TF.returnKeyType = UIReturnKeySend;
    [backV addSubview:self.TF];
    
    
    UIButton * picBt = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(backV.frame) + 10, 15, 30, 30)];
    [self.whiteView addSubview:picBt];
    [picBt setBackgroundImage:[UIImage imageNamed:@"jkgl122-1"] forState:UIControlStateNormal];
    [picBt addTarget:self action:@selector(picAction:) forControlEvents:UIControlEventTouchUpInside];
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
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 34 - 60);
        self.whiteView.mj_y = ScreenH - sstatusHeight - 44 - 34 -60;
    }else {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  -60);
        self.whiteView.mj_y = ScreenH - sstatusHeight - 44  -60;
    }
    
}




//点击图片
- (void)picAction:(UIButton *)button {
    
    
    [self addPict];
    
}

- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isCanUsePhotos]) {
            
            
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                self.picArr = @[image].mutableCopy;
                [self updateImgsToQiNiuYun];
                
                //                    [self.picsArr addObject:image];
                //                    [self addPicsWithArr:self.picsArr];
                //                    [self updateImgsToQiNiuYun];
            }];
            
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePicture]) {
            [self showMXPickerWithMaximumPhotosAllow:9 completion:^(NSArray *assets) {
                
                [self.picArr removeAllObjects];
                for (int i = 0 ; i<assets.count; i++) {
                    
                    ALAsset *asset = assets[i];
                    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
                    CGImageRef imgRef = [assetRep fullResolutionImage];
                    UIImage *image = [[UIImage alloc] initWithCGImage:imgRef
                                                                scale:assetRep.scale
                                                          orientation:(UIImageOrientation)assetRep.orientation];
                    
                    if (!image) {
                        image = [[UIImage alloc] initWithCGImage:[[asset defaultRepresentation] fullScreenImage]
                                                           scale:assetRep.scale
                                                     orientation:(UIImageOrientation)assetRep.orientation];
                        
                    }
                    if (!image) {
                        CGImageRef thum = [asset aspectRatioThumbnail];
                        image = [UIImage imageWithCGImage:thum];
                    }
                    [self.picArr addObject:image];
                    
                }
                
                if (self.picArr.count > 0) {
                    [self updateImgsToQiNiuYun];
                }
                
                
            }];
            
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
    //    UIAlertAction * action4 = [UIAlertAction actionWithTitle:@"看大图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
    //
    //        NSString * str = [zkSignleTool shareTool].avatar;
    //        if (str.length > 0) {
    //            [[zkPhotoShowVC alloc] initWithArray:@[[zkSignleTool shareTool].avatar] index:0];
    //        }
    //    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:action1];
    [ac addAction:action2];
    //    [ac addAction:action4];
    [ac addAction:action3];
    
    [self.navigationController presentViewController:ac animated:YES completion:nil];
    
}


- (void)updateImgsToQiNiuYun {
    
    [zkRequestTool NetWorkingUpLoad:[QYZJURLDefineTool upload_file_to_qiniuURL] images:self.picArr name:@"file" parameters:@{@"type":@1} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"key"] intValue]== 1) {
            
            if (!isDidLogin) {
                [self gotoLoginVC];
                return ;
            }
            NSArray<ALMessageModel *> * arr = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            NSMutableArray * arrTwo = @[].mutableCopy;
            
            for (ALMessageModel * model  in arr) {
                
                [arrTwo addObject: [NSString stringWithFormat:@"http://%@",model.qiniu_url]];
                
                
            }
            [self sentMessageWith:[arrTwo componentsJoinedByString:@","] withType:@"2"];
            [self.picArr removeAllObjects];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
}




- (void)sendAction:(UIButton *)button {
    if (self.TF.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        return;
    }
    
    [self textFieldShouldReturn:self.TF];
    
}


//点击发送
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (!isDidLogin) {
        [self gotoLoginVC];
        return YES;
    }
    [self sentMessageWith:textField.text withType:@"1"];
    return YES;
}
- (void)sentMessageWith:(NSString *)str withType:(NSString *)type {
    if (!isDidLogin) {
        [self gotoLoginVC];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"toUserId"] = self.toUserId;
    dict[@"type"] = type;
    dict[@"content"] = str;
    dict[@"aimUserId"] = self.aimUserId;
    dict[@"aimtype"] = self.aimtype;
    dict[@"getIn"] = self.getIn;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_sendLogURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            self.getIn = @"false";
            if ([type isEqualToString:@"1"]) {
                ALMessageModel * model = [[ALMessageModel alloc] init];
                model.fromUserId = [zkSignleTool shareTool].session_uid;
                model.fromAvatar = [zkSignleTool shareTool].avatar;
                model.fromName = [zkSignleTool shareTool].nick_name;
                model.toUserId = self.toUserId;
                model.messageType = type;
                model.isSelf = YES;
                model.content = str;
                model.image = str;
                [self.dataArray insertObject:model atIndex:0];
                [self.tableView reloadData];
                self.TF.text = @"";
            }else {
                NSArray * picArr = [str componentsSeparatedByString:@","];
                for (int i = 0 ; i < picArr.count ; i++) {
                    ALMessageModel * model = [[ALMessageModel alloc] init];
                    model.fromUserId = [zkSignleTool shareTool].session_uid;
                    model.fromAvatar = [zkSignleTool shareTool].avatar;
                    model.fromName = [zkSignleTool shareTool].nick_name;
                    model.toUserId = self.toUserId;
                    model.messageType = type;
                    model.isSelf = YES;
                    model.content = @"";
                    model.image = picArr[i];
                    [self.dataArray insertObject:model atIndex:0];
                    [self.tableView reloadData];
                }
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count -1 inSection:0] atScrollPosition:(UITableViewScrollPositionBottom) animated:NO];
                });
            });
            
            
        }else {
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


@end
