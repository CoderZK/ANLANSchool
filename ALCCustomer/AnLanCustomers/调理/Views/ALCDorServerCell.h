//
//  ALCDorServerCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCDorServerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (weak, nonatomic) IBOutlet UIButton *leftBt;
@property (weak, nonatomic) IBOutlet UIButton *rightBt;
@property (weak, nonatomic) IBOutlet UILabel *rightNumberLB;
@property(nonatomic,strong)ALMessageModel *model;
@end

NS_ASSUME_NONNULL_END
