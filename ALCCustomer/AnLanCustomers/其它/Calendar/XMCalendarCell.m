//
//  XMCalendarCell.m
//  日历
//
//  Created by RenXiangDong on 17/3/27.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import "XMCalendarCell.h"

@interface XMCalendarCell ()
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *lunarLabel;
@property (weak, nonatomic)XMCalendarModel * linModel;
@end
@implementation XMCalendarCell

+ (instancetype)cellWithCalendarModel:(XMCalendarModel *)model collectionView:(UICollectionView *)collectionVeiw indexpath:(NSIndexPath *)indexPath{
    static NSString *ID = @"XMCalendarCell";
    XMCalendarCell *cell = [collectionVeiw dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.bgImgView.backgroundColor = GreenColor;//[UIColor colorWithRed:225/255.0 green:225/255.0 blue:255/255.0 alpha:1];
    cell.bgImgView.layer.cornerRadius = 43*0.5;
    cell.bgImgView.layer.masksToBounds = YES;
    cell.dianImgView.backgroundColor = BlueColor;
    cell.dianImgView.layer.cornerRadius = 3;
    cell.dianImgView.layer.masksToBounds = YES;
    cell.dianImgView.hidden = YES;
    cell.model = model;
    if (model.isSelect) {
//        cell.dianImgView.hidden = NO;
        cell.bgImgView.hidden = NO;
        
    }else{
//        cell.dianImgView.hidden = YES;
        cell.bgImgView.hidden = YES;
    }
    
    if (model.isAllReady) {
        if (model.isSelect) {
            cell.dianImgView.backgroundColor = WhiteColor;
        }else {
             cell.dianImgView.backgroundColor = GreenColor;
        }
        cell.dianImgView.hidden = NO;
    }else{
        cell.dianImgView.hidden = YES;
    }
   
    return cell;
}
- (void)setModel:(XMCalendarModel *)model {
    _linModel = model;
    if (model.isEmpty) {
        self.dayLabel.hidden = YES;
        self.lunarLabel.hidden = YES;
        self.userInteractionEnabled = NO;
    } else {
        self.dayLabel.hidden = NO;
        self.lunarLabel.hidden = YES;
        self.userInteractionEnabled = YES;
        self.dayLabel.text = [NSString stringWithFormat:@"%ld",model.dateNumber];
        if (model.holidayName != nil) {
            self.lunarLabel.text = model.holidayName;
            self.lunarLabel.textColor = CharacterBlack100;
        } else if (model.chinesDateNumber == 1) {
            self.lunarLabel.text = model.chinesMonthStr;
            self.lunarLabel.textColor = CharacterBlack100;
        } else {
            self.lunarLabel.text = model.chinesDateStr;
            self.lunarLabel.textColor = CharacterBlack100;
        }
        
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        int year1 = (int)[dateComponent year];
        int month1 = (int)[dateComponent month];
        int day1 = (int)[dateComponent day];

        NSDateComponents *dateComponent1 = [calendar components:unitFlags fromDate:model.date];
        int year2 = (int)[dateComponent1 year];
        if (day1 == model.dateNumber && month1 == model.month && year1 == year2) {
            self.bgImgView.hidden = NO;
//            self.dianImgView.hidden = NO;
        }else{
            self.bgImgView.hidden = YES;
//            self.dianImgView.hidden = YES;
        }
    }
}

@end
