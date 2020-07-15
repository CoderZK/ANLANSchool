//
//  XMCalendarView.m
//  日历
//
//  Created by RenXiangDong on 17/3/27.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//


#import "XMCalendarView.h"
#import "XMCalendarCell.h"
#import "XMCalendarTool.h"

@interface XMCalendarView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end
@implementation XMCalendarView


-(instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"XMCalendarView" owner:self options:nil] lastObject];
        self.frame = frame;
        self.dataSourceModel = [self.calendarManager currentMonth];
        for (XMCalendarModel *model in self.dataSourceModel.dataSource) {
            NSDateFormatter * df = [[NSDateFormatter alloc]init];
//                        model.isAllReady = YES;
            [df setDateFormat:@"yyyy-MM-dd"];
            NSString * selectDateStr = [df stringFromDate:model.date];
            NSString * currentDateStr = [df stringFromDate: [NSDate date]];
            if ([selectDateStr compare:currentDateStr]  == NSOrderedSame){
                if (!model.isEmpty) {
                    model.isSelect = YES;
                }
            }
        }
        self.dataSourceModel = self.dataSourceModel;
        [self.collectionView registerNib:[UINib nibWithNibName:@"XMCalendarCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"XMCalendarCell"];
        self.collectionView.scrollEnabled = NO;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.collectionViewLayout = self.layout;
        NSIndexPath *todayIndexPath = [self.calendarManager currentDayIndexPath];
        [self.collectionView selectItemAtIndexPath:todayIndexPath animated:YES scrollPosition:(UICollectionViewScrollPositionTop)];
    }
    return self;
}

- (void)setIsShowOneWeek:(BOOL)isShowOneWeek {
    _isShowOneWeek = isShowOneWeek;
    if (isShowOneWeek) {
        
        NSMutableArray<XMCalendarModel*>  * arr = @[].mutableCopy;
        
        NSMutableArray<XMCalendarModel*>  * arrP = @[].mutableCopy;
        NSMutableArray<XMCalendarModel*>  * arrC = @[].mutableCopy;
        NSMutableArray<XMCalendarModel*>  * arrN = @[].mutableCopy;
        
        XMCalendarDataSource * pModel   = [self.calendarManager preMonth];
        XMCalendarDataSource * curModel = [self.calendarManager currentMonth];
        XMCalendarDataSource * nModel   = [self.calendarManager nextMonth];
        
        for (XMCalendarModel *model in pModel.dataSource) {
            if (model.date != nil){
                [arrP addObject:model];
            }
        }
        
        [arr addObjectsFromArray:arrP];
        
        for (XMCalendarModel *model in curModel.dataSource) {
            if (model.date != nil){
                [arrC addObject:model];
            }
        }
        [arr addObjectsFromArray:arrC];
        for (XMCalendarModel *model in nModel.dataSource) {
            if (model.date != nil){
                [arrN addObject:model];
            }
        }
        [arr addObjectsFromArray:arrN];
        
        
        
        //        self.dataSourceModel.dataSource = [self.dataSourceModel.dataSource subarrayWithRange:NSMakeRange(0, 7)];
        
        NSInteger allDay = [[[XMCalendarTool alloc] init] getCurrentMonthForDays];//这个月的总天数
        NSInteger suday = [[[XMCalendarTool alloc] init] getWeakForDate:[NSDate date]];//今天星期几 周日 1
        NSInteger toDay = [[[XMCalendarTool alloc] init] getdayIndate:[NSDate date]]; //今天是第多少天
        
        //取前面的数组
        NSMutableArray<XMCalendarModel*> * arrTwo = @[].mutableCopy;
        for (int i = 1 ; i<= 7; i++) {
            [arrTwo addObject:arr[arrP.count + toDay - 1 - suday + i]];
            
            
        }
        self.dataSourceModel.dataSource = arrTwo;
        
        for (XMCalendarModel *model in self.dataSourceModel.dataSource) {
            NSDateFormatter * df = [[NSDateFormatter alloc]init];
            model.isAllReady = YES;
            [df setDateFormat:@"yyyy-MM-dd"];
            NSString * selectDateStr = [df stringFromDate:model.date];
            NSString * currentDateStr = [df stringFromDate: [NSDate date]];
            if ([selectDateStr compare:currentDateStr]  == NSOrderedSame){
                if (!model.isEmpty) {
                    model.isSelect = YES;
                }
            }
        }
        self.dataSourceModel = self.dataSourceModel;
        
        
        [self.collectionView reloadData];
    }
    
    
}


- (void)setIsToday:(BOOL)isToday{
    for (XMCalendarModel *model in self.dataSourceModel.dataSource) {
        NSDateFormatter * df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"yyyy-MM-dd"];
        NSString * selectDateStr = [df stringFromDate:model.date];
        NSString * currentDateStr = [df stringFromDate: [NSDate date]];
        if ([selectDateStr compare:currentDateStr]  == NSOrderedSame){
            
            if (!model.isEmpty) {
                model.isSelect = YES;
            }
        }else{
            if (!model.isEmpty) {
                model.isSelect = NO;
            }
        }
    }
    [self.collectionView reloadData];
}





#pragma mark - CollectionView的代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.dataSourceModel.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XMCalendarModel *model = self.dataSourceModel.dataSource[indexPath.row];
    XMCalendarCell *cell = [XMCalendarCell cellWithCalendarModel:model collectionView:collectionView indexpath:indexPath];
    self.topTitleLabel.text = self.dataSourceModel.topTitle;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for (XMCalendarModel *model in self.dataSourceModel.dataSource) {
        model.isSelect = NO;
    }
    XMCalendarModel *model = self.dataSourceModel.dataSource[indexPath.row];
    if (self.isAddToCalendar) {
        NSDateFormatter * df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"yyyy-MM-dd"];
        //选中日期
        NSString * selectDateStr = [df stringFromDate:model.date];
        //当天日期
        NSString * currentDateStr = [df stringFromDate: [NSDate date]];
        
        if ([selectDateStr compare:currentDateStr]  == NSOrderedSame) {
            model.isSelect = YES;
            self.isSelctToday = YES;
            //选中日期 为当日 晚于 当日
            if ([self.delegate respondsToSelector:@selector(xmCalendarSelectCalendarModel:)]) {
                [self.delegate xmCalendarSelectCalendarModel:model];
            }
        }else if ([selectDateStr compare:currentDateStr]  == NSOrderedDescending) {
            self.isSelctToday = NO;
            if ([self.delegate respondsToSelector:@selector(xmCalendarSelectCalendarModel:)]) {
                [self.delegate xmCalendarSelectCalendarModel:model];
            }
        }  else{
            [SVProgressHUD showErrorWithStatus:@"不能选择今日之前的日期"];
        }
        [self.collectionView reloadData];
    }else{
        model.isSelect = YES;
        if ([self.delegate respondsToSelector:@selector(xmCalendarSelectCalendarModel:)]) {
            [self.delegate xmCalendarSelectCalendarModel:model];
        }
        [self.collectionView reloadData];
    }
}


- (IBAction)preYear:(UIButton *)sender {
    self.dataSourceModel = [self.calendarManager preYear];
    [self.collectionView reloadData];
    self.topTitleLabel.text = self.dataSourceModel.topTitle;
}
- (IBAction)preMonth:(UIButton *)sender {
    self.dataSourceModel = [self.calendarManager preMonth];
    [self.collectionView reloadData];
    self.topTitleLabel.text = self.dataSourceModel.topTitle;
}
- (IBAction)nextMonth:(id)sender {
    self.dataSourceModel = [self.calendarManager nextMonth];
    [self.collectionView reloadData];
    self.topTitleLabel.text = self.dataSourceModel.topTitle;
}
- (IBAction)nextYear:(id)sender {
    self.dataSourceModel = [self.calendarManager nextYear];
    [self.collectionView reloadData];
    self.topTitleLabel.text = self.dataSourceModel.topTitle;
}

#pragma mark - getter & setter
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        _layout.itemSize = CGSizeMake(self.bounds.size.width/7.0, 53);
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _layout;
}

- (XMCalendarManager *)calendarManager {
    if (!_calendarManager) {
        _calendarManager = [[XMCalendarManager alloc] init];
    }
    return _calendarManager;
}


@end
