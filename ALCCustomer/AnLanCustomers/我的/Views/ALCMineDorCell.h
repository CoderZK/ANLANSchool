//
//  ALCMineDorCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCMineDorCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UIButton *lianXiBt;
@property (weak, nonatomic) IBOutlet UILabel *LB;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *dLB;
@property (weak, nonatomic) IBOutlet UILabel *dengLB;
@property (weak, nonatomic) IBOutlet UILabel *keshiLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property(nonatomic,strong)ALMessageModel *model;
@property (weak, nonatomic) IBOutlet UILabel *timeTwoLB;

@end

NS_ASSUME_NONNULL_END
