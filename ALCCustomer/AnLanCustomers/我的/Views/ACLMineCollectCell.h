//
//  ACLMineCollectCell.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ACLMineCollectCell : UICollectionViewCell
@property(nonatomic,strong)UIView *backV;
@property(nonatomic,strong)FLAnimatedImageView *imgV;
@property(nonatomic,strong)UIImageView *leftImgV,*rightImgV;
@property(nonatomic,strong)UILabel *titleLB,*leftLB,*rightLB;
@property(nonatomic,strong)UIButton *rightBt;
@property(nonatomic,strong)ALMessageModel *model;
@property(nonatomic,strong)UIImageView *playImageV;
@end

NS_ASSUME_NONNULL_END
