//
//  ALCDorListCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCDorListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backV;
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *nameTwoLB;
@property (weak, nonatomic) IBOutlet UILabel *typeLB1;
@property (weak, nonatomic) IBOutlet UILabel *typeLB2;
@property (weak, nonatomic) IBOutlet UILabel *addressLB;
@property (weak, nonatomic) IBOutlet UILabel *typeLB3;
@property (weak, nonatomic) IBOutlet UILabel *yuyueLB;
@property (weak, nonatomic) IBOutlet UILabel *zixuanLB;
@property (weak, nonatomic) IBOutlet UILabel *typeLB4;
@property (weak, nonatomic) IBOutlet UILabel *typeLB5;
@property (weak, nonatomic) IBOutlet UILabel *typeLB6;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeCons4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeCons5;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeCons6;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCOns;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightCons;
@property (weak, nonatomic) IBOutlet UIView *lineV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *appCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *appConsW;

@property(nonatomic,strong)ALMessageModel *model;

@end

NS_ASSUME_NONNULL_END
