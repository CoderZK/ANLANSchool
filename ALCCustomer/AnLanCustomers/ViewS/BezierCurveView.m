//
//  BezierCurveView.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BezierCurveView.h"

#define XX           30   // 坐标轴与画布间距
#define YY           20   // y轴每一个值的间隔数



@interface BezierCurveView ()

@end

@implementation BezierCurveView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        //        BezierCurveView *bezierCurveView = [[BezierCurveView alloc]init];
        //         bezierCurveView.frame = frame;
        
        //背景视图
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //        backView.backgroundColor = [UIColor greenColor];
        [self addSubview:backView];
        
        self.myFrame = frame;
        
        
    }
    return self;
}


////初始化画布
//+(instancetype)initWithFrame:(CGRect)frame{
//
//    BezierCurveView *bezierCurveView = [[BezierCurveView alloc]init];
//    bezierCurveView.frame = frame;
//
//    //背景视图
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//    //    backView.backgroundColor = [UIColor greenColor];
//    [bezierCurveView addSubview:backView];
//
//    myFrame = frame;
//    return bezierCurveView;
//}

- (void)setDorwColor:(UIColor *)dorwColor {
    _dorwColor = dorwColor;
}

/**
 *  画坐标轴
 */
-(void)drawXYLine:(NSMutableArray *)x_names{
    [self.subviews[0].layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //1.Y轴、X轴的直线
    [path moveToPoint:CGPointMake(MARGIN, CGRectGetHeight(self.myFrame)-MARGIN)];
    [path addLineToPoint:CGPointMake(MARGIN, MARGIN)];
    
    [path moveToPoint:CGPointMake(MARGIN, CGRectGetHeight(self.myFrame)-MARGIN)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.myFrame), CGRectGetHeight(self.myFrame)-MARGIN)];
    
    //    //2.添加箭头
    //    [path moveToPoint:CGPointMake(MARGIN, MARGIN)];
    //    [path addLineToPoint:CGPointMake(MARGIN-5, MARGIN+5)];
    //    [path moveToPoint:CGPointMake(MARGIN, MARGIN)];
    //    [path addLineToPoint:CGPointMake(MARGIN+5, MARGIN+5)];
    //
    //    [path moveToPoint:CGPointMake(CGRectGetWidth(self.myFrame), CGRectGetHeight(self.myFrame)-MARGIN)];
    //    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.myFrame)-5, CGRectGetHeight(self.myFrame)-MARGIN-5)];
    //    [path moveToPoint:CGPointMake(CGRectGetWidth(self.myFrame), CGRectGetHeight(self.myFrame)-MARGIN)];
    //    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.myFrame)-5, CGRectGetHeight(self.myFrame)-MARGIN+5)];
    
    //3.添加索引格
    //X轴
    for (int i=0; i<x_names.count; i++) {
        CGFloat X = MARGIN + (CGRectGetWidth(self.myFrame)-30)/x_names.count*(i+1)-(CGRectGetWidth(self.myFrame)-30)/x_names.count/2.0;
        CGPoint point = CGPointMake(X,CGRectGetHeight(self.myFrame)-MARGIN);
        [path moveToPoint:point];
        [path addLineToPoint:CGPointMake(point.x, point.y-3)];
    }
    //Y轴（实际长度为200,此处比例缩小一倍使用）
    for (int i=0; i<11; i++) {
        CGFloat Y = CGRectGetHeight(self.myFrame)-MARGIN-Y_EVERY_MARGIN*i;
        CGPoint point = CGPointMake(MARGIN,Y);
        [path moveToPoint:point];
        [path addLineToPoint:CGPointMake(point.x+3, point.y)];
    }
    
    //4.添加索引格文字
    //X轴
    for (int i=0; i<x_names.count; i++) {
        CGFloat X = MARGIN + (CGRectGetWidth(self.myFrame)-30)/x_names.count/2.0 + (CGRectGetWidth(self.myFrame)-30)/x_names.count*i-(CGRectGetWidth(self.myFrame)-30)/x_names.count/2.0;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(X, CGRectGetHeight(self.myFrame)-MARGIN, (CGRectGetWidth(self.myFrame)-60)/x_names.count, 20)];
        textLabel.text = x_names[i];
        textLabel.font = [UIFont systemFontOfSize:10];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor blueColor];
        [self addSubview:textLabel];
    }
    //Y轴
    for (int i=0; i<11; i++) {
        CGFloat Y = CGRectGetHeight(self.myFrame)-MARGIN-Y_EVERY_MARGIN*i;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Y-5, MARGIN, 10)];
        textLabel.text = [NSString stringWithFormat:@"%d",10*i];
        textLabel.font = [UIFont systemFontOfSize:10];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor redColor];
        [self addSubview:textLabel];
    }
    //5.渲染路径
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.borderWidth = 2.0;
    [self.subviews[0].layer addSublayer:shapeLayer];
}

/**
 *  画多根折线图
 */
-(void)drawMoreLineChartViewWithX_Value_Names:(NSMutableArray *)x_names TargetValues:(NSMutableArray *)targetValues LineType:(LineType) lineType{
    [self.subviews[0].layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    //1.画坐标轴
    [self drawXYLine:x_names];
    [self.subviews[0].layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    for (int j=0; j<targetValues.count; j++) {
        //2.获取目标值点坐标
        NSMutableArray *allPoints = [NSMutableArray array];
        for (int i=0; i<[targetValues[j] count]; i++) {
            CGFloat doubleValue = 2*[targetValues[j][i] floatValue]; //目标值放大两倍
            CGFloat X = MARGIN + (CGRectGetWidth(self.myFrame)-30)/x_names.count*(i+1)-(CGRectGetWidth(self.myFrame)-30)/x_names.count/2.0;
            CGFloat Y = CGRectGetHeight(self.myFrame)-MARGIN-doubleValue;
            CGPoint point = CGPointMake(X,Y);
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(point.x-1, point.y-1, 2.5, 2.5) cornerRadius:2.5];
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.strokeColor = [UIColor purpleColor].CGColor;
            layer.fillColor = [UIColor purpleColor].CGColor;
            layer.path = path.CGPath;
            [self.subviews[0].layer addSublayer:layer];
            [allPoints addObject:[NSValue valueWithCGPoint:point]];
        }
        
        //3.坐标连线
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:[allPoints[0] CGPointValue]];
        
        CGPoint PrePonit;
        switch (lineType) {
            case LineType_Straight: //直线
                for (int i =1; i<allPoints.count; i++) {
                    CGPoint point = [allPoints[i] CGPointValue];
                    [path addLineToPoint:point];
                }
                break;
            case LineType_Curve:   //曲线
                for (int i =0; i<allPoints.count; i++) {
                    if (i==0) {
                        PrePonit = [allPoints[0] CGPointValue];
                    }else{
                        CGPoint NowPoint = [allPoints[i] CGPointValue];
                        [path addCurveToPoint:NowPoint controlPoint1:CGPointMake((PrePonit.x+NowPoint.x)/2, PrePonit.y) controlPoint2:CGPointMake((PrePonit.x+NowPoint.x)/2, NowPoint.y)]; //三次曲线
                        PrePonit = NowPoint;
                    }
                }
                break;
        }
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = self.dorwColor.CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.borderWidth = 2.0;
        [self.subviews[0].layer addSublayer:shapeLayer];
    }
}

-(void)drawMoreLineChartViewWithTargetValues:(NSMutableArray *)targetValues LineType:(LineType) lineType {
    
    [self.subviews[0].layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    CGFloat max = 0;
    CGFloat min = MAXFLOAT;
    CGFloat average = 0;
    for (int i =  0 ; i< targetValues.count; i++) {
        if (max < [targetValues[i] floatValue]) {
            max = [targetValues[i] floatValue];
        }
        
        if (min > [targetValues[i] floatValue]) {
            min = [targetValues[i] floatValue];
        }
    }
    if  (min + max == 0) {
        average = 1;
    }else {
        average = (max + min) / 2.0;
    }
    
    if  ( min == 0) {
        self.dorwColor = CharacterBack150;
    }else {
        self.dorwColor = GreenColor;
    }
    
    //2.获取目标值点坐标
    NSMutableArray *allPoints = [NSMutableArray array];
    for (int i=0; i<[targetValues count]; i++) {
        CGFloat doubleValue = 1*[targetValues[i] floatValue]; //目标值放大两倍
        CGFloat X = (CGRectGetWidth(self.myFrame)-10)/targetValues.count*(i+1);
        CGFloat Y =  CGRectGetHeight(self.myFrame)/2;
        if (max - min > 0) {
            Y =  CGRectGetHeight(self.myFrame) - (doubleValue -min) * (CGRectGetHeight(self.myFrame)/(max-min));
        }
        CGPoint point = CGPointMake(X,Y);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(point.x-1, point.y-1, 2, 2) cornerRadius:2];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.strokeColor = self.dorwColor.CGColor;
        layer.fillColor = self.dorwColor.CGColor;
        [self.subviews[0].layer addSublayer:layer];
        [allPoints addObject:[NSValue valueWithCGPoint:point]];
    }
    
    
    
    //3.坐标连线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:[allPoints[0] CGPointValue]];
    
    CGPoint PrePonit;
    switch (lineType) {
        case LineType_Straight: //直线
            for (int i =1; i<allPoints.count; i++) {
                CGPoint point = [allPoints[i] CGPointValue];
                [path addLineToPoint:point];
            }
            break;
        case LineType_Curve:   //曲线
            for (int i =0; i<allPoints.count; i++) {
                if (i==0) {
                    PrePonit = [allPoints[0] CGPointValue];
                }else{
                    CGPoint NowPoint = [allPoints[i] CGPointValue];
                    [path addCurveToPoint:NowPoint controlPoint1:CGPointMake((PrePonit.x+NowPoint.x)/2, PrePonit.y) controlPoint2:CGPointMake((PrePonit.x+NowPoint.x)/2, NowPoint.y)]; //三次曲线
                    PrePonit = NowPoint;
                }
            }
            break;
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = self.dorwColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.borderWidth = 2.0;
    [self.subviews[0].layer addSublayer:shapeLayer];
    
}


- (void)drawMoreLineChartViewWithTargerYNames:(NSArray *)YNames targetXNames:(NSArray *)Xnames  whitTargetValues:(NSArray *)targetValues withMaxY:(CGFloat )MaxY{
    
    
    if (YNames.count ==0 || Xnames.count == 0) {
        return;
    }
    
    [self LineWhihtYnames:YNames andXnames:Xnames];
    [self.subviews[0].layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    CGFloat maxH = CGRectGetHeight(self.myFrame) - YY - 2 * YY;
    CGFloat space  = 50;
    CGFloat maxW = CGRectGetWidth(self.myFrame) - space - 30;
    
    
    
    //2.获取目标值点坐标
    NSMutableArray *allPoints = [NSMutableArray array];
    for (int i=0; i<[targetValues count]; i++) {
        CGFloat doubleValue = 1*[targetValues[i] floatValue]; //目标值放大两倍
        CGFloat X = (maxW)/(Xnames.count -1)*(i) + space;
        CGFloat Y =  maxH/2;
        
        Y =CGRectGetHeight(self.myFrame) -  ( 2*YY + (doubleValue * (maxH /MaxY)))+1;
        CGPoint point = CGPointMake(X,Y);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(point.x-1, point.y-1, 2.5, 2.5) cornerRadius:2.5];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.strokeColor = GreenColor.CGColor;
        layer.fillColor = GreenColor.CGColor;
        layer.path = path.CGPath;
        [self.subviews[0].layer addSublayer:layer];
        [allPoints addObject:[NSValue valueWithCGPoint:point]];
    }
    
    //3.坐标连线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:[allPoints[0] CGPointValue]];
    
    for (int i =1; i<allPoints.count; i++) {
        CGPoint point = [allPoints[i] CGPointValue];
        [path addLineToPoint:point];
    }
    
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = self.dorwColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.borderWidth = 2.0;
    [self.subviews[0].layer addSublayer:shapeLayer];
    
    
    
    
    
    
    
    
    
    
    
}


- (void)drawMoreLineChartViewWithTargerYNames:(NSArray *)YNames targetXNames:(NSArray *)Xnames  whitTargetValues:(NSArray *)targetValues  withMaxY:(CGFloat )MaxY colors:(NSArray <UIColor *>*)colors {
    
    if (YNames.count ==0 || Xnames.count == 0) {
        return;
    }
    
    [self LineWhihtYnames:YNames andXnames:Xnames];
    [self.subviews[0].layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    CGFloat maxH = CGRectGetHeight(self.myFrame) - YY - 2 * YY;
    CGFloat space  = 50;
    CGFloat maxW = CGRectGetWidth(self.myFrame) - space - 30;
    
    
    for (int j = 0 ; j < targetValues.count; j++) {
        
        
        //2.获取目标值点坐标
        NSMutableArray *allPoints = [NSMutableArray array];
        for (int i=0; i<[targetValues[j] count]; i++) {
            CGFloat doubleValue = 1*[targetValues[j][i] floatValue]; //目标值放大两倍
            CGFloat X = (maxW)/(Xnames.count -1)*(i) + space;
            CGFloat Y =  maxH/2;
            
            Y =CGRectGetHeight(self.myFrame) -  ( 2*YY + (doubleValue * (maxH /MaxY)))+1;
            CGPoint point = CGPointMake(X,Y);
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(point.x-1, point.y-1, 2.5, 2.5) cornerRadius:2.5];
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.strokeColor = colors[j].CGColor;
            layer.fillColor = colors[j].CGColor;
            layer.path = path.CGPath;
            [self.subviews[0].layer addSublayer:layer];
            [allPoints addObject:[NSValue valueWithCGPoint:point]];
        }
        
        //3.坐标连线
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:[allPoints[0] CGPointValue]];
        
        for (int i =1; i<allPoints.count; i++) {
            CGPoint point = [allPoints[i] CGPointValue];
            [path addLineToPoint:point];
        }
        
        
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor =  colors[j].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.borderWidth = 2.0;
        [self.subviews[0].layer addSublayer:shapeLayer];
        
    }
    
    
}


- (void)LineWhihtYnames:(NSArray *)YNames andXnames:(NSArray *)Xnames{
    
    
    for (int i = 200; i < 400; i++) {
        UIView * v = [self viewWithTag:i];
        if (v != nil) {
            [v removeFromSuperview];
        }
    }
    
    
    if (YNames.count == 0) {
        return;
    }
    CGFloat maxH = CGRectGetHeight(self.myFrame) - YY - 2 * YY;
    CGFloat space  = 50;
    CGFloat maxW = CGRectGetWidth(self.myFrame) - space - 30;
    CGFloat mjY = 0;
    for (int i = 0 ; i < YNames.count +  1 ; i++) {
        UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(space, YY + ((maxH)/(YNames.count))*i, maxW, 2)];
        imgV.tag = 200+i;
        UILabel * LB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 15)];
        LB.tag = 250+i;
        LB.textAlignment = NSTextAlignmentCenter;
        LB.centerY = imgV.centerY;
        LB.textColor = CharacterBlack100;
        LB.font = kFont(12);
        [self addSubview:imgV];
        [self addSubview:LB];
        
        if (i == YNames.count) {
            LB.text = @"0";
            imgV.backgroundColor = CharacterBack150;;
            mjY = CGRectGetMaxY(imgV.frame);
            imgV.mj_h = 1;
        }else {
            LB.text = YNames[i];
            [self drawLineByImageView:imgV];
        }
    }
    
    
    if (Xnames.count == 0 ){
        return;
    }
    for (int i = 0 ; i < Xnames.count; i++) {
        UILabel * LB = [[UILabel alloc] initWithFrame:CGRectMake(0, mjY+ 10, 45, 15)];
        LB.textAlignment = NSTextAlignmentCenter;
        LB.centerX = 50 + (maxW/(Xnames.count-1)) * i;
        LB.textColor = CharacterBlack100;
        LB.tag = 300+i;
        LB.font = kFont(12);
        LB.text = Xnames[i];
        [self addSubview:LB];
    }
    
    //    UIImageView * imagVV = [[UIImageView alloc] init];
    //    imagVV.mj_y = 0;
    //    imagVV.mj_w = 0.6;
    //    imagVV.mj_h = CGRectGetHeight(self.myFrame) - 2*YY;
    //    imagVV.centerX = space + (maxW/(Xnames.count-1)) * 3;
    //    imagVV.backgroundColor = CharacterBack150;
    //    [self addSubview:imagVV];
    
    
}





- (void)drawLineByImageView:(UIImageView *)imageView {
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线 划线的frame
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapSquare);
    
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, [UIColor darkGrayColor].CGColor);
    
    
    CGFloat lengths[] = {5,2};//先画4个点再画2个点
    CGContextSetLineDash(line,0, lengths,2);//注意2(count)的值等于lengths数组的长度
    
    CGContextMoveToPoint(line, 0.0, 2.0);    //开始画线
    CGContextAddLineToPoint(line,imageView.frame.size.width,2.0);
    CGContextStrokePath(line);
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    UIImage *image =   UIGraphicsGetImageFromCurrentImageContext();
    imageView.image = image;
}


@end
