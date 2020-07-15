//
//  ALCHospitalTwoCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCHospitalTwoCell.h"

@interface ALCHospitalTwoCell()
@property(nonatomic,strong)UIView *whiteV;

@end

@implementation ALCHospitalTwoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(15, 10, ScreenW - 30, 20)];
        [self addSubview:self.whiteV];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataArray:(NSArray<ALMessageModel *> *)dataArray{
    _dataArray = dataArray;
    CGFloat space = 10;
    CGFloat ww = (ScreenW - 30-3*space)/4;
    NSInteger lines = dataArray.count /4 + (dataArray.count % 4 ==0?0:1);
    self.whiteV.mj_h = ww* lines + lines * space;
    [self.whiteV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0 ; i<dataArray.count; i++) {
        ALCHospitalTwoCellNeiView * view = [[ALCHospitalTwoCellNeiView alloc] initWithFrame:CGRectMake((space+ww)*(i%4), (space+ww)*(i/4), ww, ww)];
        [self.whiteV addSubview:view];
        [view.imgV sd_setImageWithURL:[dataArray[i].icon getPicURL] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"jkgl%d",i+52]] options:SDWebImageRetryFailed];;
        view.titleLB.text = dataArray[i].name;
        view.clickBt.tag = 100+i;
        [view.clickBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    
}

- (void)clickAction:(UIButton *)button {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(clickALCHospitalTwoCell:withIndex:)]) {
        [self.delegate clickALCHospitalTwoCell:self withIndex:button.tag-100];
    }
    
    
}

@end



@implementation ALCHospitalTwoCellNeiView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-20, frame.size.height/2 - 20-10, 40, 40)];
        self.imgV.image = [UIImage imageNamed:@"placeholder"];
        [self addSubview:self.imgV];
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(5,frame.size.height/2 + 20 , frame.size.width - 10, 17)];
        self.titleLB.font = kFont(13);
        self.titleLB.textColor = CharacterBlack100;
        [self addSubview:self.titleLB];
        self.titleLB.text = @"呼吸内科";
        self.titleLB.textAlignment = NSTextAlignmentCenter;
        
        self.clickBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.clickBt];
        self.backgroundColor = RGB(247, 249, 254);
        self.layer.cornerRadius = 2;
        self.clipsToBounds = YES;
        
        
    }
    return self;
}


@end
