//
//  ALCJianKangTiXingHomeCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCJianKangTiXingHomeCell.h"
#import "ALCJianKangTiXingOneCell.h"
#import "ALCJianKangTiXingTwoCell.h"
@interface ALCJianKangTiXingHomeCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *backV;
@end

@implementation ALCJianKangTiXingHomeCell

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
        
        [self.tableView registerNib:[UINib nibWithNibName:@"ALCJianKangTiXingOneCell" bundle:nil] forCellReuseIdentifier:@"ALCJianKangTiXingOneCell"];
        [self.tableView registerNib:[UINib nibWithNibName:@"ALCJianKangTiXingTwoCell" bundle:nil] forCellReuseIdentifier:@"ALCJianKangTiXingTwoCell"];

        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
    }
    return self;
}


- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if  (self.dataArray.count == 0) {
        return 0;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 ) {
        return 40;
    }else {
        return 47;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     if (indexPath.section == 0) {
           ALCJianKangTiXingOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ALCJianKangTiXingOneCell" forIndexPath:indexPath];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
           cell.leftLB.text = self.titleStr;
           return cell;
       }else {
           ALCJianKangTiXingTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ALCJianKangTiXingTwoCell" forIndexPath:indexPath];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
           ALMessageModel * model = self.dataArray[indexPath.row];
           if (model.isFinish) {
               cell.imgV.image = [UIImage imageNamed:@"jkgl42"];
           }else {
               cell.imgV.image = [UIImage imageNamed:@"jkgl34"];
               if (model.ifFromB) {
                   cell.imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"jkgl%d",arc4random() % 3 + 38]];
               }
               
               
           }
           cell.leftLB.text = model.content;
           cell.rightLB.text = model.time;
           if (self.isFinish) {
               cell.leftLB.textColor = cell.rightLB.textColor = CharacterBack150;
           }else {
               cell.leftLB.textColor = cell.rightLB.textColor = CharacterColor50;
           }
           cell.button.tag = 10000+indexPath.row;
           [cell.button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
           return cell;
       }
    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickALCJianKangTiXingHomeCell:withIndex:)]) {
        
        [self.delegate didClickALCJianKangTiXingHomeCell:self withIndex:indexPath.row];
        
    }
    
}

- (void)clickAction:(UIButton *)button {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickALCJianKangTiXingHomeCell:withIndex:)]) {
           
           [self.delegate didClickALCJianKangTiXingHomeCell:self withIndex:
            button.tag];
           
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
