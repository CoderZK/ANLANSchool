//
//  ALCAddressCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/23.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UITableViewCell;
@protocol ALCAddressCellDelegete <NSObject>
- (void)didClickALCAddressCell:(UITableViewCell *)cell withTag:(NSInteger)tag;
@end

@interface ALCAddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backV;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *phoneLB;
@property (weak, nonatomic) IBOutlet UILabel *addressLB;
@property(nonatomic,assign)id<ALCAddressCellDelegete>delegate;

@end

