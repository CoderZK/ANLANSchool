//
//  ALCMineAllAppiontmentDocTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/5/6.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCMineAllAppiontmentDocTVC.h"
#import "ALCMianAllAppiontmentDocCell.h"
@interface ALCMineAllAppiontmentDocTVC ()<UITextFieldDelegate>
@property(nonatomic,strong)NSMutableDictionary *dataDict;
@property(nonatomic,strong)NSMutableArray *rightDataArr;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *searchArr;
@property(nonatomic,strong)ALCSearchView *searchTitleView;
@property(nonatomic,assign)BOOL isSearch;
@end

@implementation ALCMineAllAppiontmentDocTVC

- (NSMutableDictionary *)dataDict {
    if (_dataDict == nil) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}

- (NSMutableArray *)rightDataArr {
    if (_rightDataArr == nil) {
        _rightDataArr = [NSMutableArray array];
    }
    return _rightDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[].mutableCopy;
    self.searchArr = @[].mutableCopy;
 
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCMianAllAppiontmentDocCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(ScreenW - 60 - 15, sstatusHeight + 7, 60, 30);
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"ggback"] forState:UIControlStateNormal];
    button.layer.cornerRadius = 4;
    button.clipsToBounds = YES;
    
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        [self navBtnClick:button];
        
        
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    [self getData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    
    [self setHeadView];
    
    
}

- (void)comfirmaction {
    NSMutableArray * titleArr = @[].mutableCopy;
    NSMutableArray * idsArr = @[].mutableCopy;
    if(self.isSearch) {
        for (ALMessageModel * model  in self.searchArr) {
            if (model.isSelect) {
                [titleArr addObject:model.doctorName];
                [idsArr addObject:model.ID];
            }
        }
    }else {
       for (ALMessageModel * model  in self.dataArray) {
            if (model.isSelect) {
                [titleArr addObject:model.doctorName];
                [idsArr addObject:model.ID];
            }
        }
    }
    NSString * titelStr = [titleArr componentsJoinedByString:@","];
    NSString * idsStr = [idsArr componentsJoinedByString:@","];
    if (self.sendFriendsBlock != nil) {
        self.sendFriendsBlock(titelStr, idsStr);
    }
    
    
    
}

- (void)setHeadView {
    
    UIView * vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 60)];
    
    ALCSearchView * searchTitleView = [[ALCSearchView alloc] initWithFrame:CGRectMake(30, 8, ScreenW - 70, 44)];
    searchTitleView.searchTF.delegate = self;
    searchTitleView.isPush = NO;
    searchTitleView.searchTF.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.5];
    //    self.navigationItem.titleView = searchTitleView;
    @weakify(self);
    [[[searchTitleView.searchTF rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
        @strongify(self);
        if (value.length == 0) {
            return YES;
        }else {
            return NO;
        }
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"======\n%@",x);
        self.isSearch = NO;
        [self.tableView reloadData];
        
    }];
    
    [self.view addSubview:vv];
    [vv addSubview:searchTitleView];
    
    self.tableView.frame = CGRectMake(0, 60 , ScreenW, ScreenH -  60);
    self.navigationItem.title = @"从咨询过的医生内选择";
}




- (void)navBtnClick:(UIButton *)button {
    
    NSMutableArray * nameArr = @[].mutableCopy;
    NSMutableArray * idArr = @[].mutableCopy;
    for (int i = 0 ; i < self.rightDataArr.count; i++) {
        
        for (ALMessageModel * model  in self.dataDict[self.rightDataArr[i]]) {
            if (model.isSelect) {
                [nameArr addObject:model.doctorName];
                [idArr addObject:model.doctorId];
            }
        }
        
        
    }
    
    if (self.sendFriendsBlock != nil) {
        self.sendFriendsBlock([nameArr componentsJoinedByString:@","], [idArr componentsJoinedByString:@","]);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


//排序
- (void)paiXunAction {
    
    for (int i = 0 ; i < self.dataArray.count; i++) {
        
        if (self.dataArray[i]) {
            //将取出的名字转换成字母
            NSMutableString *pinyin = [self.dataArray[i].doctorName mutableCopy];
            CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
            CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
            
            /*多音字处理*/
            NSString * firstStr = [self.dataArray[i].doctorName substringToIndex:1];
            if ([firstStr compare:@"长"] == NSOrderedSame)
            {
                if (pinyin.length>=5)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
                }
            }
            else if ([firstStr compare:@"沈"] == NSOrderedSame)
            {
                if (pinyin.length>=4)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 4) withString:@"shen"];
                }
            }
            else if ([firstStr compare:@"厦"] == NSOrderedSame)
            {
                if (pinyin.length>=3)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 3) withString:@"xia"];
                }
            }
            else if ([firstStr compare:@"地"] == NSOrderedSame)
            {
                if (pinyin.length>=3)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 3) withString:@"di"];
                }
            }
            else if ([firstStr compare:@"重"] == NSOrderedSame)
            {
                if (pinyin.length>=5)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
                }
            }
            
            //将拼音转换成大写拼音
            NSString * upPinyin = [pinyin uppercaseString];
            //取出第一个首字母当做字典的key
            NSString * firstChar = [upPinyin substringToIndex:1];
            
            NSMutableArray * arr = [self.dataDict objectForKey:firstChar];
            if (!arr)
            {
                arr = [NSMutableArray array];
                [_dataDict setObject:arr forKey:firstChar];
            }
            if ([self.arr containsObject:self.dataArray[i].ID]) {
                self.dataArray[i].isSelect = YES;
            }
            [arr addObject:self.dataArray[i]];
        }
        else
        {
            NSMutableArray * arr = [self.dataDict objectForKey:@"#"];
            if (!arr)
            {
                arr = [NSMutableArray array];
                [self.dataDict setObject:arr forKey:@"#"];
            }
            if ([self.arr containsObject:self.dataArray[i].ID]) {
                self.dataArray[i].isSelect = YES;
            }
            [arr addObject:self.dataArray[i]];
        }
        
        
        
    }
    
    self.rightDataArr = [self paixuArrWithArr:self.dataDict.allKeys].mutableCopy;
    if (self.rightDataArr.count > 0 && [[self.rightDataArr firstObject] isEqualToString:@"#"]) {
        [self.rightDataArr removeObjectAtIndex:0];
        [self.rightDataArr addObject:@"#"];
    }
    [self.tableView reloadData];
    
}

- (void)getData {
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(1);
    dict[@"pageSize"] = @(10000000);
    NSString * url = [QYZJURLDefineTool user_findAllDoctorAppointmentListURL];
//    NSString * url = [QYZJURLDefineTool app_findDoctorListURL];
    
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"key"] intValue]== 1) {
            
            
            NSArray * arr = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:arr];
            if (self.dataArray.count == 0) {
                [SVProgressHUD showSuccessWithStatus:@"暂无数据"];
            }
            self.dataDict = nil;
            [self paiXunAction];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isSearch) {
        return 1;
    }
    return self.rightDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isSearch) {
        return self.searchArr.count;
    }
    return [self.dataDict[self.rightDataArr[section]] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCMianAllAppiontmentDocCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.isSearch) {
        ALMessageModel * model = self.searchArr[indexPath.row];
        cell.model = model;
    }else {
        ALMessageModel * model = [self.dataDict[self.rightDataArr[indexPath.section]] objectAtIndex:indexPath.row];
        cell.model = model;
    }
    
    if (indexPath.row+1 == [self.dataDict[self.rightDataArr[indexPath.section]] count]) {
        cell.lineV.hidden = YES;
    }else {
        cell.lineV.hidden = NO;
    }
    return cell;
    
}


/**每一组的标题*/
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.isSearch) {
        return @"";
    }
    return self.rightDataArr[section];
}

/** 右侧索引列表*/
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    /*
     索引数组中的"内容"，跟分组无关
     索引数组中的下标，对应的是分组的下标
     return @[@"哇哈哈", @"hello", @"哇哈哈", @"hello", @"哇哈哈", @"hello", @"哇哈哈", @"hello"];
     返回self.carGroup中title的数组
     NSMutableArray *arrayM = [NSMutableArray array];
     for (HMCarGroup *group in self.carGroups) {
     [arrayM addObject:group.title];
     }
     return arrayM;
     KVC是cocoa的大招
     用来间接获取或者修改对象属性的方式
     使用KVC在获取数值时，如果指定对象不包含keyPath的"键名"，会自动进入对象的内部查找
     如果取值的对象是一个数组，同样返回一个数组
     */
    /*例如：
     NSArray *array = [self.carGroups valueForKeyPath:@"cars.name"];
     NSLog(@"%@", array);
     */
    
    if (self.isSearch) {
        return @[];
    }
    
    return self.rightDataArr;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.isSearch) {
        return 0.01;
    }
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        view.backgroundColor = RGB(245, 245, 245);
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 50)];
        lb.font = kFont(15);
        [view addSubview:lb];
        lb.tag = 100;
    }
    
    UILabel * lb = (UILabel *)[view viewWithTag:100];
    lb.text = self.rightDataArr[section];
    view.clipsToBounds = YES;
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.isSearch) {
        ALMessageModel * model = self.searchArr[indexPath.row];
        model.isSelect = !model.isSelect;
        [self.tableView reloadData];
    }else {
        ALMessageModel * model = [self.dataDict[self.rightDataArr[indexPath.section]] objectAtIndex:indexPath.row];
        model.isSelect = !model.isSelect;
        [self.tableView reloadData];
    }
    
   
    
    
    
}



//排序
- (NSArray * )paixuArrWithArr:(NSArray *)arr {
    
    if (arr.count == 0) {
        return arr;
    }
    NSArray *resultkArrSort = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    
    return resultkArrSort;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    
    if (textField.text.length == 0) {
        return YES;
    }
    self.isSearch = YES;
    [self getSearchArrWithStr:textField.text];
    
    return YES;
}

- (void)getSearchArrWithStr:(NSString *)str {
    [self.searchArr removeAllObjects];
    for (ALMessageModel * model  in self.dataArray) {
        if ([model.doctorName containsString:str]) {
            [self.searchArr addObject:model];
        }
    }
    [self.tableView reloadData];
    
}


@end
