//
//  ALCInquiryMessageCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCInquiryMessageCell : UITableViewCell
@property(nonatomic,strong)ButtonView *headBt;
@property(nonatomic,strong)UILabel *nameLB;
@property(nonatomic,strong)UILabel *desLB;
@property(nonatomic,strong)UILabel *timeLB;
@property(nonatomic,strong)UIButton *rightBt;
@property(nonatomic,strong)ALMessageModel  *model;
@property(nonatomic,assign)BOOL isNewFirend;
@end

NS_ASSUME_NONNULL_END
