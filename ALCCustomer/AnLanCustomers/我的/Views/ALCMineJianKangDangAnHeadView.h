//
//  ALCMineJianKangDangAnHeadView.h
//  AnLanCustomers
//
//  Created by zk on 2020/4/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCMineJianKangDangAnHeadView : UIView
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)UILabel *nameLB,*sexLB,*numberLB;
@property(nonatomic,strong)UIView *headViewTwo;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UIButton *peopleBt;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataDocArray;
@property(nonatomic,strong)UIImageView *docImgV;
@property(nonatomic,copy)void(^buttonClickBlock)(NSInteger index);

@property(nonatomic,copy)void(^scrollBlock)(NSInteger index);


@end

NS_ASSUME_NONNULL_END
