//
//  ALCMineDorTVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALCMineDorTVC : BaseTableViewController
@property(nonatomic,strong)NSArray *allDataArr;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@end

NS_ASSUME_NONNULL_END
