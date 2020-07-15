//
//  ALCMessageOneCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCMessageOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *leftOne;
@property (weak, nonatomic) IBOutlet UILabel *leftTwoLB;
@property (weak, nonatomic) IBOutlet UIView *lineV;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;

@end

NS_ASSUME_NONNULL_END
