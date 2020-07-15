//
//  ALCHospitalDeatilTwoCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCHospitalDeatilTwoCell : UITableViewCell
@property(nonatomic,strong)ALCMineDorterView *dorView;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@property(nonatomic,assign)CGFloat HHHHHH;

- (CGFloat )getHeightWithArr:(NSArray<ALMessageModel *> *)dataArray;

@end

NS_ASSUME_NONNULL_END
