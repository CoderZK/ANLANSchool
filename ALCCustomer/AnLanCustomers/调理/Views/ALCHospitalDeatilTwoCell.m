//
//  ALCHospitalDeatilTwoCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCHospitalDeatilTwoCell.h"

@interface ALCHospitalDeatilTwoCell()
@property(nonatomic,strong)UIImageView *greenimgV;
@end


@implementation ALCHospitalDeatilTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.dorView = [[ALCMineDorterView alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 15, 10)];
        [self addSubview:self.dorView];
        self.dorView.isNoSelectOne = YES;
        self.dorView.userInteractionEnabled = NO;
   
        self.greenimgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 12.5+15, 10, 10)];
        self.greenimgV.layer.cornerRadius = 5;
        self.greenimgV.clipsToBounds = YES;
        self.greenimgV.backgroundColor = [UIColor greenColor];
        [self.dorView addSubview:self.greenimgV];
        
        
    }
    return self;
}

- (void)setDataArray:(NSMutableArray<ALMessageModel *> *)dataArray {
    _dataArray = dataArray;
  

    
    self.dorView.dataArray = dataArray;
    self.HHHHHH = self.dorView.mj_h = self.dorView.hh;
    if (dataArray.count > 0) {
        dataArray[0].HHHHHH = self.dorView.hh;
    }
    
    NSLog(@" ===== ---- \n%0.2f",self.dorView.hh);

    
}

- (CGFloat)getHeightWithArr:(NSArray<ALMessageModel *> *)dataArray {
    
    self.dorView.dataArray = dataArray;
    return   self.dorView.hh;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
