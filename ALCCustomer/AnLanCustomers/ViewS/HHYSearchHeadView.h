//
//  HHYSearchHeadView.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HHYSearchHeadView;

@protocol HHYSearchHeadViewDelegate <NSObject>

- (void)didClickIndex:(NSInteger )index withIsShow:(BOOL)isShow;

@end
@interface HHYSearchHeadView : UIView
@property(nonatomic,assign)id<HHYSearchHeadViewDelegate>delegate;
- (void)cancel;
@property(nonatomic,strong)NSString *leftStr,*centerStr,*rightStr;
@end

NS_ASSUME_NONNULL_END
