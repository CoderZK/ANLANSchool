//
//  ALCMineViewOne.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALCMineViewOne;
@protocol ALCMineViewOneDelegate <NSObject>

- (void)didClickALCMineViewOne:(ALCMineViewOne *)viewOne withIndex:(NSInteger)index;

@end


@interface ALCMineViewOne : UIView

@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSArray *imgaArray;
@property(nonatomic,strong)NSArray *nameArray;

@property(nonatomic,assign)id<ALCMineViewOneDelegate>delegate;

@end

