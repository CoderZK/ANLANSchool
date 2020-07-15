//
//  BezierCurveView.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>


#define MARGIN            30   // 坐标轴与画布间距
#define Y_EVERY_MARGIN    20   // y轴每一个值的间隔数

#import <UIKit/UIKit.h>
// 线条类型
typedef NS_ENUM(NSInteger, LineType) {
    LineType_Straight, // 折线
    LineType_Curve     // 曲线
};
@interface BezierCurveView : UIView
@property(nonatomic,assign)CGRect myFrame;
//初始化画布
+(instancetype)initWithFrame:(CGRect)frame;
@property(nonatomic,strong)UIColor *dorwColor;
//画多根折线图
-(void)drawMoreLineChartViewWithX_Value_Names:(NSMutableArray *)x_names TargetValues:(NSMutableArray *)targetValues LineType:(LineType) lineType;

-(void)drawMoreLineChartViewWithTargetValues:(NSMutableArray *)targetValues LineType:(LineType) lineType;

- (void)drawMoreLineChartViewWithTargerYNames:(NSArray *)YNames targetXNames:(NSArray *)Xnames  whitTargetValues:(NSArray *)targetValues withMaxY:(CGFloat )MaxY;


- (void)drawMoreLineChartViewWithTargerYNames:(NSArray *)YNames targetXNames:(NSArray *)Xnames  whitTargetValues:(NSArray *)targetValues  withMaxY:(CGFloat )MaxY colors:(NSArray <UIColor *>*)colors;

@end
