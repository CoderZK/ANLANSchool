//
//  ALCTiXingDetailTVC.h
//  AnLanBB
//
//  Created by zk on 2020/3/31.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALCTiXingDetailTVC : BaseTableViewController
@property(nonatomic,strong)ALMessageModel *dataModel;
@property(nonatomic,strong)NSString *ID;
@end

NS_ASSUME_NONNULL_END
