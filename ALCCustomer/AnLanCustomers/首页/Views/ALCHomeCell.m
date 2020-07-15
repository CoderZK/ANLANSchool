//
//  ALCHomeCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCHomeCell.h"
#import "ALCJianKangRiZhiCell.h"
#import "ALCDorListCell.h"
#import "ALCHomeJianKangCell.h"
#import "ALCTuiJianForYouCell.h"
#import "ALCTiaoLiOneCell.h"
#import "ALCTuiJianArticleCell.h"
@interface ALCHomeCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *backV;
@end

@implementation ALCHomeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.backV = [[UIView alloc] init];
        [self addSubview:self.backV];
        [self.backV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self).offset(15);
            make.bottom.equalTo(self).offset(-10);
            make.right.equalTo(self).offset(-15);
        }];
        self.backV.backgroundColor = WhiteColor;
        self.backV.layer.cornerRadius = 5;
        self.backV.layer.shadowColor = [UIColor blackColor].CGColor;
        self.backV.layer.shadowOffset = CGSizeMake(0, 0);
        self.backV.layer.shadowRadius = 5;
        self.backV.layer.shadowOpacity = 0.08;
        
        self.tableView = [[UITableView alloc] init];
        [self.backV addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.backV);
        }];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[ACLHeadOrFootView class] forHeaderFooterViewReuseIdentifier:@"head"];
        
        [self.tableView registerNib:[UINib nibWithNibName:@"ALCJianKangRiZhiCell" bundle:nil] forCellReuseIdentifier:@"ALCJianKangRiZhiCell"];
        [self.tableView registerNib:[UINib nibWithNibName:@"ALCDorListCell" bundle:nil] forCellReuseIdentifier:@"ALCDorListCell"];
        [self.tableView registerNib:[UINib nibWithNibName:@"ALCTuiJianForYouCell" bundle:nil] forCellReuseIdentifier:@"ALCTuiJianForYouCell"];
        [self.tableView registerNib:[UINib nibWithNibName:@"ALCTiaoLiOneCell" bundle:nil] forCellReuseIdentifier:@"ALCTiaoLiOneCell"];
        
        
        
        [self.tableView registerClass:[ALCHomeJianKangCell class] forCellReuseIdentifier:@"ALCHomeJianKangCell"];
        [self.tableView registerNib:[UINib nibWithNibName:@"ALCTuiJianArticleCell" bundle:nil] forCellReuseIdentifier:@"ALCTuiJianArticleCell"];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.scrollEnabled = NO;
        
        
    }
    return self;
}
- (void)setTypeCell:(NSInteger)typeCell {
    _typeCell = typeCell;
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if  (self.dataArray.count == 0) {
        return 0;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.typeCell == 0) {
        return 80;
    }else if (self.typeCell == 1) {
        return 79;
    }else if (self.typeCell == 2){
        return 134;
    }else if (self.typeCell == 3) {
        return  90;
    }else if (self.typeCell == 4) {
        return 90;
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.typeCell == 0) {
        ALCHomeJianKangCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ALCHomeJianKangCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lineV.backgroundColor = lineBackColor;
        if (indexPath.row + 1 == self.dataArray.count) {
            cell.lineV.hidden = YES;
        }else {
            cell.lineV.hidden = NO;
        }
        if (indexPath.row == 0) {
            if (self.model.stepnumberData == nil) {
                cell.titleLB.text = @"步数: 未记录";
            }else {
                cell.titleLB.text = [NSString stringWithFormat:@"步数: %@",self.model.stepnumberData.stepnumber];
            }
        }else if (indexPath.row == 1) {
            if (self.model.heartrate == nil) {
                cell.titleLB.text = @"心率: 未记录";
            }else {
                cell.titleLB.text = [NSString stringWithFormat:@"心率: %@",self.model.heartrate.averageRate];
            }
        }else if (indexPath.row == 2) {
            if (self.model.weightData == nil) {
                cell.titleLB.text = @"体重: 未记录";
            }else {
                cell.titleLB.text = [NSString stringWithFormat:@"体重: %0.2f",self.model.weightData.weight.floatValue];
            }
        }else if (indexPath.row == 3) {
            if (self.model.bloodpressure == nil) {
                cell.titleLB.text = @"血压: 未记录";
            }else {
                cell.titleLB.text = [NSString stringWithFormat:@"收缩压/舒张压: %@/%@mmHg",self.model.bloodpressure.systolic,self.model.bloodpressure.diastolic];
            }
        }
        cell.bezierView.hidden = NO;
        cell.bezierView.frame = CGRectMake(ScreenW-30-90, 10, 80, 60);
        [cell.bezierView drawMoreLineChartViewWithTargetValues:[self getNumberArrWithType:indexPath.row] LineType:(LineType_Straight)];
//        [cell.bezierView drawMoreLineChartViewWithX_Value_Names:@[@"123"] TargetValues:@[@[@10,@30,@40,@40,@20,@60,@20]] LineType:LineType_Straight];
        cell.imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"jkgl%ld",4+indexPath.row]];
        cell.bezierView.backgroundColor = [UIColor whiteColor];
        return cell;
    }else if (self.typeCell == 1) {
        ALCJianKangRiZhiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ALCJianKangRiZhiCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backV.layer.shadowColor = [UIColor clearColor].CGColor;
        cell.backV.layer.shadowRadius = 0;
        cell.leftCons.constant = cell.bottomCOns.constant = cell.rightCons.constant = cell.topCons.constant = 0;
        cell.lineV.hidden = NO;
        cell.lineV.backgroundColor = lineBackColor;
        if (indexPath.row + 1 == self.dataArray.count) {
            cell.lineV.hidden = YES;
        }else {
            cell.lineV.hidden = NO;
        }
        cell.model = self.dataArray[indexPath.row];
        //        cell.rightLB1.text = self.dataArray[indexPath.row].appointmentDate;
        //        cell.rightLB2.text = self.dataArray[indexPath.row].doctorName;
        return cell;
    }else if (self.typeCell == 2) {
        ALCDorListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ALCDorListCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backV.layer.shadowColor = [UIColor clearColor].CGColor;
        cell.backV.layer.shadowRadius = 0;
        cell.leftCons.constant = cell.bottomCOns.constant = cell.rightCons.constant = cell.topCons.constant = 0;
        cell.lineV.hidden = NO;
        cell.lineV.backgroundColor = lineBackColor;
        if (indexPath.row + 1 == self.dataArray.count) {
            cell.lineV.hidden = YES;
        }else {
            cell.lineV.hidden = NO;
        }
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }else if (self.typeCell == 3){
        
        ALCTiaoLiOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ALCTiaoLiOneCell" forIndexPath:indexPath];
        cell.backV.layer.shadowColor = [UIColor clearColor].CGColor;
        cell.backV.layer.shadowRadius = 0;
        cell.consLeft.constant = cell.consBottom.constant = cell.consRight.constant = cell.consTop.constant = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        ALMessageModel * model = self.dataArray[indexPath.row];
        cell.rightLB.hidden = YES;
        cell.model = model;
    
        if (indexPath.row + 1 == self.dataArray.count) {
            cell.lineV.hidden = YES;
        }else {
            cell.lineV.hidden = NO;
        }
        
        return cell;
        
        //         ALCTuiJianForYouCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ALCTuiJianForYouCell" forIndexPath:indexPath];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        return cell;
    }else {
        
        ALCTuiJianArticleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ALCTuiJianArticleCell" forIndexPath:indexPath];
        if (indexPath.row + 1 == self.dataArray.count) {
            cell.lineV.hidden = YES;
        }else {
            cell.lineV.hidden = NO;
        }
        cell.model = self.dataArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
    
    
    
}

- (NSMutableArray *)getNumberArrWithType:(NSInteger)type {
    NSMutableArray * arr = @[].mutableCopy;
    if (self.lineDateModel == nil) {
       
        arr = @[@0,@0,@0,@0,@0,@0,@0].mutableCopy;
        return arr;
        
    }
    if (type == 0) {
        if (self.lineDateModel.stepNub.count == 0) {
            arr = @[@0,@0,@0,@0,@0,@0,@0].mutableCopy;
        }else {
            for (int i = 0 ; i < 7; i++) {
                if (i<7-self.lineDateModel.stepNub.count) {
                    [arr addObject:[self.lineDateModel.stepNub lastObject].stepnumber];
                }else {
                     [arr addObject:[self.lineDateModel.stepNub objectAtIndex:6-i].stepnumber];
                }
            }
        }
        
        
    }else if (type == 1) {
       if (self.lineDateModel.heartrateNub.count == 0) {
           arr = @[@0,@0,@0,@0,@0,@0,@0].mutableCopy;
       }else {
           for (int i = 0 ; i < 7; i++) {
               if (i<7-self.lineDateModel.heartrateNub.count) {
                   [arr addObject:[self.lineDateModel.heartrateNub lastObject].averageRate];
               }else {
                    [arr addObject:[self.lineDateModel.heartrateNub objectAtIndex:6-i].averageRate];
               }
           }
       }
        
    }else if (type == 2) {
        if (self.lineDateModel.weightNub.count == 0) {
            arr = @[@0,@0,@0,@0,@0,@0,@0].mutableCopy;
        }else {
            for (int i = 0 ; i < 7; i++) {
                if (i<7-self.lineDateModel.weightNub.count) {
                    [arr addObject:[self.lineDateModel.weightNub lastObject].weight];
                }else {
                     [arr addObject:[self.lineDateModel.weightNub objectAtIndex:6-i].weight];
                }
            }
        }
        
    }else if (type == 3) {
        if (self.lineDateModel.bloodpressureNub.count == 0) {
            arr = @[@0,@0,@0,@0,@0,@0,@0].mutableCopy;
        }else {
            for (int i = 0 ; i < 7; i++) {
                if (i<7-self.lineDateModel.bloodpressureNub.count) {
                    [arr addObject:[self.lineDateModel.bloodpressureNub lastObject].diastolic];
                }else {
                     [arr addObject:[self.lineDateModel.bloodpressureNub objectAtIndex:6-i].diastolic];
                }
            }
        }
    }
    return arr;
}


- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 45;
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
    
    view.rightBt.hidden = NO;
    view.rightBt.mj_x = ScreenW - 30 - 200;
    view.rightBt.mj_w = 190;
    view.leftLB.text = self.titleStr;
    view.lineV.hidden = NO;
    view.clipsToBounds = YES;
    view.backgroundColor = WhiteColor;
    //    @weakify(self);
    //    [[view.rightBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
    //        @strongify(self);
    //        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickALCHomeCell:withIndex:isClickHead:)]) {
    //               [self.delegate didClickALCHomeCell:self withIndex:0 isClickHead:YES];
    //           }
    //    }];
    
    [view.rightBt addTarget:self action:@selector(clickHeadAction:) forControlEvents:UIControlEventTouchUpInside];
    //    view.rightBt.backgroundColor = [UIColor redColor];
    view.rightBt.hidden = self.isHiddenMoreImagV;
    return view;
}

- (void)clickHeadAction:(UIButton *)button {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickALCHomeCell:withIndex:isClickHead:)]) {
        [self.delegate didClickALCHomeCell:self withIndex:0 isClickHead:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickALCHomeCell:withIndex:isClickHead:)]) {
        [self.delegate didClickALCHomeCell:self withIndex:indexPath.row isClickHead:NO];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
