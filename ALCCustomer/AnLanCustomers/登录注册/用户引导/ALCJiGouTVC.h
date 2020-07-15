//
//  ALCJiGouTVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/4/3.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALCJiGouTVC : BaseTableViewController
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@property(nonatomic,strong)NSString *heightStr,*weightStr,*birthdateStr,*genderStr,*phoneStr,*institutionVisitedIds;
@end

NS_ASSUME_NONNULL_END
