//
//  ALCMineDorterView.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCMineDorterView : UIView
@property(nonatomic,strong)NSString *selectImageStr,*nomalImageStr;
@property(nonatomic,strong)UIColor *selectColor,*nomalColor;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@property(nonatomic,assign)CGFloat hh;
@property(nonatomic,assign)BOOL isNoSelectOne; //第一个可以选中 YES 是不选中, NO选中
@property(nonatomic,assign)BOOL isNomalNOSelectOne; //是否默认地选中第一个
@property(nonatomic,assign)BOOL isNOCanSelectAll;
@property(nonatomic,assign)BOOL isContainSelectImage;

@property(nonatomic,copy)void(^selectBlock)(NSInteger selectIndex);

@end

NS_ASSUME_NONNULL_END
