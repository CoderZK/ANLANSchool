//
//  ALCHeightAndWeightVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/4/27.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCHeightAndWeightVC.h"
#import "ALCInterestTVC.h"
#import "DYScrollRulerView.h"
#import "ALCJiGouTVC.h"
@interface ALCHeightAndWeightVC ()<DYScrollRulerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *bt;
@property (weak, nonatomic) IBOutlet UILabel *LB1;
@property (weak, nonatomic) IBOutlet UILabel *LB2;
@property(nonatomic,strong)DYScrollRulerView *rullerView;
@property(nonatomic,strong)DYScrollRulerView *rullerViewTwo;
@property(nonatomic,strong)NSString *heightStr,*weightStr;
@end

@implementation ALCHeightAndWeightVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bt.layer.cornerRadius = 5;
    self.bt.clipsToBounds = YES;
    
    [self.view addSubview:self.rullerView];
    self.rullerView.backgroundColor = [UIColor whiteColor];
    self.rullerView.layer.cornerRadius = 3;
    self.rullerView.clipsToBounds = YES;
    [self.view addSubview:self.rullerViewTwo];
    self.rullerViewTwo.backgroundColor = [UIColor whiteColor];
    self.rullerViewTwo.layer.cornerRadius = 3;
    self.rullerViewTwo.clipsToBounds = YES;
    self.view.backgroundColor = BackgroundColor;
    
    self.heightStr = @"170.0";
    self.weightStr = @"60.0";
    
}

-(DYScrollRulerView *)rullerView{
    if (!_rullerView) {
        NSString *unitStr = @"cm";
        CGFloat rullerHeight = [DYScrollRulerView rulerViewHeight];
        _rullerView = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.LB1.frame) - 30, ScreenW, rullerHeight) theMinValue:30 theMaxValue:250 theStep:1 theUnit:unitStr theNum:10];
        [_rullerView setDefaultValue:170 animated:YES];
        _rullerView.bgColor = [UIColor groupTableViewBackgroundColor];
//        _rullerView.triangleColor   = [UIColor redColor];
        _rullerView.tag = 100;
        _rullerView.delegate        = self;
        _rullerView.scrollByHand    = YES;
    }
    return _rullerView;
}

- (DYScrollRulerView *)rullerViewTwo {
    if (_rullerViewTwo == nil) {
        NSString *unitStr = @"kg";
        CGFloat rullerHeight = [DYScrollRulerView rulerViewHeight];
        _rullerViewTwo = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.LB2.frame) - 30, ScreenW-20, rullerHeight) theMinValue:20 theMaxValue:200 theStep:0.1 theUnit:unitStr theNum:10];
        [_rullerViewTwo setDefaultValue:60 animated:YES];
        _rullerViewTwo.bgColor = [UIColor groupTableViewBackgroundColor];;
//        _rullerViewTwo.triangleColor   = [UIColor groupTableViewBackgroundColor];
        _rullerViewTwo.tag = 101;
        _rullerViewTwo.delegate        = self;
        _rullerViewTwo.scrollByHand    = YES;
    }
    return _rullerViewTwo;
}

#pragma mark - YKScrollRulerDelegate
-(void)dyScrollRulerView:(DYScrollRulerView *)rulerView valueChange:(float)value{
    
    NSLog(@"value->%.f",value);
    
    if (rulerView.tag == 100) {
        self.heightStr = [NSString stringWithFormat:@"%0.1f",value];
    }else {
        self.weightStr = [NSString stringWithFormat:@"%0.1f",value];
    }
    
    
}



//下一步
- (IBAction)bt:(id)sender {
    
    ALCJiGouTVC * vc =[[ALCJiGouTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.phoneStr = self.phoneStr;
    vc.birthdateStr = self.birthdateStr;
    vc.genderStr = self.genderStr;
    vc.weightStr = self.weightStr;
    vc.heightStr = self.heightStr;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
@end
