//
//  ALCSearchHospitalView.h
//  AnLanCustomers
//
//  Created by zk on 2020/4/29.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCSearchHospitalView : UIView
- (void)showWithType:(NSInteger )type; // 1 为列表 2 为头视图展示;
- (void)diss;
//@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *listArr;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *typeArr;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *levelArr;

@property(nonatomic,copy)void(^ConfirmBlock)(NSInteger row,NSString *hospitalStr,NSString *levelStr,BOOL isDiss);


@end

NS_ASSUME_NONNULL_END
