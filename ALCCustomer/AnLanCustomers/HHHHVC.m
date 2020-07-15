//
//  HHHHVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/4/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "HHHHVC.h"
#import "DYScrollRulerView.h"
@interface HHHHVC ()<DYScrollRulerDelegate>
@property(nonatomic,strong)DYScrollRulerView *rullerView;
@end

@implementation HHHHVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.rullerView];
}

-(DYScrollRulerView *)rullerView{
    if (!_rullerView) {
        NSString *unitStr = @"￥";
        CGFloat rullerHeight = [DYScrollRulerView rulerViewHeight];
        _rullerView = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(5, ScreenH/5.0*0.5, ScreenW-20, rullerHeight) theMinValue:0 theMaxValue:1000 theStep:10 theUnit:unitStr theNum:10];
        [_rullerView setDefaultValue:500 animated:YES];
        _rullerView.bgColor = [UIColor lightGrayColor];
        _rullerView.triangleColor   = [UIColor redColor];
        _rullerView.delegate        = self;
        _rullerView.scrollByHand    = YES;
    }
    return _rullerView;
}

#pragma mark - YKScrollRulerDelegate
-(void)dyScrollRulerView:(DYScrollRulerView *)rulerView valueChange:(float)value{
    
    NSLog(@"value->%.f",value);
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
