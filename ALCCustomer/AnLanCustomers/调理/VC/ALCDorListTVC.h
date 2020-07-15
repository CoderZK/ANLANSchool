//
//  ALCDorListTVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCDorListTVC : BaseTableViewController
@property(nonatomic,assign)BOOL isComeFromHospital;
@property(nonatomic,strong)NSString *HosId,*departId;
@property(nonatomic,assign)BOOL isComeSearch;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@property(nonatomic,assign)BOOL isComeHome;
@end

NS_ASSUME_NONNULL_END
