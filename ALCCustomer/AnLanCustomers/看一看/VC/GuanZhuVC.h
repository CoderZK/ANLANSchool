//
//  GuanZhuVC.h
//  AnLanCustomers
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

@interface GuanZhuVC : BaseTableViewController
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@property(nonatomic,assign)BOOL isSearch;
@property(nonatomic,assign)NSInteger type;
@end
