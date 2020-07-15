//
//  ALCSearchHospitalView.m
//  AnLanCustomers
//
//  Created by zk on 2020/4/29.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCSearchHospitalView.h"
#import "ALCMineDorterView.h"

@interface ALCSearchHospitalView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *TV;
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)ALCMineDorterView *hospitalV,*levelV;
@property(nonatomic,assign)NSInteger hospitalSelectIndex,levelSelectIndex;
@property(nonatomic,strong)NSArray *dataArray;

@end


@implementation ALCSearchHospitalView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        
        
        UIButton * button = [[UIButton alloc] initWithFrame:self.bounds];
        [self addSubview:button];
        [button addTarget:self action:@selector(dissTwo) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.TV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 1)];
        self.TV.delegate = self;
        self.TV.dataSource = self;
        self.TV.backgroundColor = [UIColor whiteColor];
        [self.TV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
      
        [self addSubview:self.TV];
        
        self.levelSelectIndex = self.hospitalSelectIndex = -1;
        
        self.dataArray = @[@"离我最近",@"医生预约量",@"项目预约量"];
        
        
    }
    return self;
}

- (void)setTypeArr:(NSMutableArray<ALMessageModel *> *)typeArr {
    _typeArr = typeArr;
}

- (void)setLevelArr:(NSMutableArray<ALMessageModel *> *)levelArr {
    _levelArr = levelArr;
    
}


- (void)showWithType:(NSInteger)type {
    self.type = type;
    if (type == 1) {
        self.TV.tableHeaderView = nil;
        self.TV.mj_h = 45*self.dataArray.count;
        [self.TV reloadData];
    }else {
        [self addheadViewData];
        [self.TV reloadData];
    }
    
    
    
    
    
}

- (void)addheadViewData {
    
    [self.headV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.1)];
    UILabel * lb1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, ScreenW - 30, 20)];
    lb1.text = @"医院类型";
    lb1.textColor = CharacterColor50;
    lb1.font = kFont(14);
    [self.headV addSubview:lb1];
    
    self.hospitalV = [[ALCMineDorterView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lb1.frame)+5, ScreenW - 30, 10)];
//    self.hospitalV.isNoSelectOne = YES;
    self.hospitalV.isNomalNOSelectOne = YES;
    self.hospitalV.isNOCanSelectAll = YES;
    self.hospitalV.dataArray = self.typeArr;
    self.hospitalV.mj_h = self.hospitalV.hh;
    Weak(weakSelf);
    self.hospitalV.selectBlock = ^(NSInteger selectIndex) {
        weakSelf.hospitalSelectIndex = selectIndex;
    };
    
    [self.headV addSubview:self.hospitalV];
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.hospitalV.frame) + 5, ScreenW, 0.4)];
    backV.backgroundColor = lineBackColor;
    [self.headV addSubview:backV];
    

    UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(backV.frame) + 15, ScreenW - 30, 20)];
    lb2.text = @"医院等级";
    lb2.textColor = CharacterColor50;
    lb2.font = kFont(14);
    [self.headV addSubview:lb2];
    
    self.levelV = [[ALCMineDorterView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lb2.frame)+5, ScreenW - 30, 10)];
//    self.levelV.isNoSelectOne = YES;
    self.levelV.isNomalNOSelectOne = YES;
    self.levelV.isNOCanSelectAll = YES;
    self.levelV.dataArray = self.levelArr;
    self.levelV.mj_h = self.levelV.hh;
    
    self.levelV.selectBlock = ^(NSInteger selectIndex) {
        weakSelf.levelSelectIndex = selectIndex;
    };
    
    [self.headV addSubview:self.levelV];
    
    
    UIView * backVOne =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.levelV.frame) + 100, ScreenW, 0.4)];
    backVOne.backgroundColor = lineBackColor;
    [self.headV addSubview:backVOne];
    
    UIView * whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(backVOne.frame), ScreenW, 45)];
    [self.headV addSubview:whiteV];
    
    UIButton * leftBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenW/2, 45)];
    [leftBt setTitleColor:CharacterBlack100 forState:UIControlStateNormal];
    leftBt.tag = 100;
    [leftBt setTitle:@"重置" forState:UIControlStateNormal];
    [leftBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [whiteV addSubview:leftBt];
    
    UIButton * rightBt = [[UIButton alloc] initWithFrame:CGRectMake( ScreenW/2, 0, ScreenW/2, 45)];
    [rightBt setTitleColor:WhiteColor forState:UIControlStateNormal];
    rightBt.tag = 101;
    [rightBt setTitle:@"确定" forState:UIControlStateNormal];
    [rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [whiteV addSubview:rightBt];
    [rightBt setBackgroundImage:[UIImage imageNamed:@"gback"] forState:UIControlStateNormal];
    
    self.headV.mj_h = CGRectGetMaxY(whiteV.frame);
    self.TV.tableHeaderView = self.headV;
    self.TV.mj_h = CGRectGetMaxY(whiteV.frame);
    
}


- (void)clickAction:(UIButton *)button {
    
    if (button.tag == 100) {
        self.levelSelectIndex = self.hospitalSelectIndex = -1;
        [self showWithType:2];
    }else {
        
        NSString * hID,*lID = @"";
        if (self.hospitalSelectIndex >= 0) {
            hID = self.typeArr[self.hospitalSelectIndex].ID;
        }
        if (self.levelSelectIndex >=0) {
            lID = self.levelArr[self.levelSelectIndex].ID;
        }
        
        if (self.ConfirmBlock != nil) {
            self.ConfirmBlock(0,hID,lID,NO);
            [self diss];
        }
    }
    
    
    
    
    
    
}

- (void)dissTwo {
    [UIView animateWithDuration:0.2 animations:^{
           self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
       } completion:^(BOOL finished) {
           [self removeFromSuperview];
       }];
    
    if (self.ConfirmBlock != nil) {
        self.ConfirmBlock(0,@"",@"",YES);
    }
    
    
}

- (void)diss {
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.type == 2) {
        return 0;
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = kFont(14);
    cell.textLabel.textColor = CharacterColor50;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.ConfirmBlock != nil) {
        self.ConfirmBlock(indexPath.row,@"",@"",NO);
        [self diss];
    }
    
}

@end
