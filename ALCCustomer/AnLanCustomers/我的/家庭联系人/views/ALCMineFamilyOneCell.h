//
//  ALCMineFamilyOneCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/6/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCMineFamilyOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftOntLB;
@property (weak, nonatomic) IBOutlet UILabel *leftTwoLB;
@property (weak, nonatomic) IBOutlet UIView *lineV;
@property(nonatomic,assign)BOOL isBlack;
@property(nonatomic,strong)ALMessageModel *model;
@end

NS_ASSUME_NONNULL_END
