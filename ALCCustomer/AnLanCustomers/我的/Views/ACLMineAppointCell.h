//
//  ACLMineAppointCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ACLMineAppointCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backV;
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property (weak, nonatomic) IBOutlet UILabel *statusLB;
@property (weak, nonatomic) IBOutlet UILabel *addressLB;
@property (weak, nonatomic) IBOutlet UILabel *bNameLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headBtWidhtCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headBtHeightCons;
@property(nonatomic,assign)BOOL isDoc;
@property(nonatomic,strong)ALMessageModel  *model;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;


@end

NS_ASSUME_NONNULL_END
