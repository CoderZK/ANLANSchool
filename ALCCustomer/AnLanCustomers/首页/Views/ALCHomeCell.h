//
//  ALCHomeCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ALCHomeCell;

@protocol ALCHomeCellDelegate <NSObject>

- (void)didClickALCHomeCell:(ALCHomeCell *)cell withIndex:(NSInteger)index isClickHead:(BOOL)isClickHead;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ALCHomeCell : UITableViewCell
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,assign)NSInteger typeCell; // 0 身体数据cell ,1 健康数据cell 2推荐医生cell 3 为你推荐 4 曾经急诊的机构

@property(nonatomic,assign)BOOL isHiddenMoreImagV;

@property(nonatomic,assign)id<ALCHomeCellDelegate>delegate;

@property(nonatomic,strong)ALMessageModel *model;

@property(nonatomic,strong)ALMessageModel *lineDateModel;

@end

NS_ASSUME_NONNULL_END
