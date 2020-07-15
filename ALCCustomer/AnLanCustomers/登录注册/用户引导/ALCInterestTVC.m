//
//  ALCInterestTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/18.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCInterestTVC.h"

@interface ALCInterestTVC ()
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)UIView *TTV;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@end

@implementation ALCInterestTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFootV];
    
 
    
    
    self.dataArray = @[].mutableCopy;
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
 
    
}

- (void)addheadV {
 
    
    
     self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
     UILabel * lb1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, ScreenW, 25)];
     lb1.textColor = [UIColor blackColor];
     lb1.font = [UIFont systemFontOfSize:16 weight:0.2];
     lb1.textAlignment = NSTextAlignmentCenter;
     lb1.text = @"关注感兴趣的话题";
     [self.headV addSubview:lb1];
     
     UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, ScreenW, 25)];
     lb2.textColor = [UIColor darkGrayColor];
     lb2.font = [UIFont systemFontOfSize:14 weight:0];
     lb2.textAlignment = NSTextAlignmentCenter;
     lb2.text = @"为你推荐文章饮食";
     [self.headV addSubview:lb2];
    CGFloat ww = (ScreenW - 50) /3;
              CGFloat hh = 120;
              CGFloat spaceY = 8;
              CGFloat spaceX = 10;
       NSInteger line = 0;
             if (self.dataArray.count %3 == 0) {
                 line = self.dataArray.count /3;
             }else {
                 line = self.dataArray.count /3 +1;
             }
       for (int i = 0 ; i < self.dataArray.count; i++) {
           ALCInterestVV * view = [[ALCInterestVV alloc] initWithFrame:CGRectMake(15+(ww+spaceX) * (i%3), (spaceY + hh) * (i/3) + 100, ww, hh)];
           [self.headV addSubview:view];
           view.tag = i;
           view.LB.text = self.dataArray[i].name;
           if (self.dataArray[i].isSelect) {
               view.imgV.image = [UIImage imageNamed:@"jkgl23"];
           }else {
               view.imgV.image = [UIImage imageNamed:@"jkgl24"];
           }
           [view.clickBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
           view.clickBt.tag = i+300;
           if (i+1==self.dataArray.count) {
               self.headV.mj_h = CGRectGetMaxY(view.frame) + 20;
           }
       }
    
    self.tableView.tableHeaderView = self.headV;
    
}
    

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_interestURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.dataArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self addheadV];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}



- (void)clickAction:(UIButton *)button {
    button.selected = !button.selected;
    self.dataArray[button.tag - 300].isSelect = !self.dataArray[button.tag - 300].isSelect;
    ALCInterestVV * v = (ALCInterestVV *)[button superview];
    UIImageView * imgV = [v viewWithTag:101];
    if (button.isSelected) {
        imgV.image = [UIImage imageNamed:@"jkgl23"];
    }else {
        imgV.image = [UIImage imageNamed:@"jkgl24"];
    }
}

- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }

    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"完成" andImgaeName:@""];
    Weak(weakSelf);
        view.footViewClickBlock = ^(UIButton *button) {
           
            [weakSelf registAction];
           
       };
    [self.view addSubview:view];
}

- (void)registAction {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"phone"] = self.phoneStr;
    dict[@"weight"] = self.weightStr;
    dict[@"height"] = self.heightStr;
    dict[@"birthdate"] = self.birthdateStr;
    dict[@"gender"] = self.genderStr;
    dict[@"institutionVisitedIds"] = self.institutionVisitedIds;
    NSMutableArray * arr = @[].mutableCopy;
    for (ALMessageModel * model  in self.dataArray) {
        if (model.isSelect) {
            NSDictionary * dd = @{@"topicId":model.ID,@"topicName":model.name};
            [arr addObject:dd];
        }
    }
    dict[@"interestedTopics"] = [NSString convertToJsonDataWithDict:arr];
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_addInterestURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
      
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"信息完善成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            });
            
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
 
    
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


@implementation ALCInterestVV

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
 
        self.backgroundColor = WhiteColor;
        
        self.clickBt = [[UIButton alloc] initWithFrame:self.bounds];
        self.clickBt.tag  = 100;
        [self addSubview:self.clickBt];
        
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 18, 18)];
        self.imgV.image = [UIImage imageNamed:@"gou4"];
        self.imgV.tag = 101;
        [self addSubview:self.imgV];
        
        self.LB = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, frame.size.width - 30, 36)];
        self.LB.font = kFont(14);
        self.LB.textColor = [UIColor blackColor];
        self.LB.tag = 102;
        self.LB.numberOfLines = 0;
        self.LB.contentMode = UIViewContentModeTop;
        [self addSubview:self.LB];
        
          self.layer.shadowColor = [UIColor blackColor].CGColor;
          // 设置阴影偏移量
          self.layer.shadowOffset = CGSizeMake(0,0);
          // 设置阴影透明度
          self.layer.shadowOpacity = 0.08;
          // 设置阴影半径
          self.layer.shadowRadius = 5;
        
        
        
    }
    return self;
}




@end
