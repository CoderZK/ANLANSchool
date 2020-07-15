//
//  ALCHospitalTwoCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALCHospitalTwoCell;
@protocol ALCHospitalTwoCellDelegate <NSObject>

- (void)clickALCHospitalTwoCell:(ALCHospitalTwoCell *)cell withIndex:(NSInteger )index;

@end


@interface ALCHospitalTwoCell : UITableViewCell
@property(nonatomic,strong)NSArray<ALMessageModel *> *dataArray;
@property(nonatomic,assign)id<ALCHospitalTwoCellDelegate> delegate;


@end

@interface ALCHospitalTwoCellNeiView : UIView
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)UIButton *clickBt;
@end
