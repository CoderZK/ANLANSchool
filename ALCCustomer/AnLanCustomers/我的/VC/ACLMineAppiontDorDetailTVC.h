//
//  ACLMineAppiontDorDetailTVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ACLMineAppiontDorDetailTVC : BaseTableViewController
@property(nonatomic,assign)BOOL isHot;//NO 是医生 Yes 是项目
@property(nonatomic,strong)NSString *ID;
@end

NS_ASSUME_NONNULL_END
