//
//  ALCMineBodyinformationcell.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCMineBodyinformationcell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *leftTopLB;
@property (weak, nonatomic) IBOutlet UILabel *leftBottomLB;
@property (weak, nonatomic) IBOutlet UILabel *centerTopLB;
@property (weak, nonatomic) IBOutlet UILabel *nodataLB;
@property (weak, nonatomic) IBOutlet UIButton *jiluBt;
@property (weak, nonatomic) IBOutlet UILabel *centerBottomLB;
@property (weak, nonatomic) IBOutlet UILabel *rightTopLB;
@property (weak, nonatomic) IBOutlet UILabel *rightBottomLB;
@property (weak, nonatomic) IBOutlet UIView *backV;
@property (weak, nonatomic) IBOutlet UIButton *moreBt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCon1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCon2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCon3;
@property (weak, nonatomic) IBOutlet UIView *lineV;
@property(nonatomic,assign)NSInteger showNumber;
@property (weak, nonatomic) IBOutlet UILabel *moreLB;
@property (weak, nonatomic) IBOutlet UIImageView *moreImgV;
@end

NS_ASSUME_NONNULL_END
