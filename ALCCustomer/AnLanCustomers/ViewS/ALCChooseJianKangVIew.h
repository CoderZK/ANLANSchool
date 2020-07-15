//
//  ALCChooseJianKangVIew.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HQCustomButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface ALCChooseJianKangVIew : UIView
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@property(nonatomic,assign)CGFloat hh;
@property(nonatomic,strong)IQTextView *TV;
@property(nonatomic,assign)BOOL isShowTV;
@property(nonatomic,assign)BOOL isOnlySelectOne;
@property(nonatomic,assign)BOOL isNODefalutSelect;
@property(nonatomic,strong)NSString *titleOneStr,*titleTwoStr;
@property(nonatomic,strong)HQCustomButton *rightBt;
@property(nonatomic,strong)UIView *backVTwo;

@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,copy)void(^didClickBlcok)(NSInteger index);



@end

NS_ASSUME_NONNULL_END
