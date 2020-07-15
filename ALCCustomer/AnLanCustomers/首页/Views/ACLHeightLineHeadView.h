//
//  ACLHeightLineHeadView.h
//  AnLanCustomers
//
//  Created by zk on 2020/4/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ACLHeightLineHeadView : UIView
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)BezierCurveView *bezierV;
@property(nonatomic,strong)UILabel *titelLB;
@property(nonatomic,assign)CGFloat hh;
@property(nonatomic,strong)UIButton *jiLuBt;
@property(nonatomic,strong)UILabel *leftTopLB,*leftBottomLB,*centerTopLB,*centerBottomLB,*rightTopLB,*rightBottomLB;

@property(nonatomic,assign)NSInteger showNumber;

@end

NS_ASSUME_NONNULL_END
