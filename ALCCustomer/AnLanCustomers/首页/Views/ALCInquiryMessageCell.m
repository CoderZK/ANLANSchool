//
//  ALCInquiryMessageCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCInquiryMessageCell.h"

@implementation ALCInquiryMessageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headBt = [[ButtonView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
        [self.headBt.button setBackgroundImage: [UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        [self addSubview:self.headBt];
        
        self.nameLB = [[UILabel alloc] initWithFrame:CGRectMake(75, 15, ScreenW - 75 - 15 - 100, 20)];
        self.nameLB.textColor = CharacterColor50;
        self.nameLB.text = @"陈继续 主任医生";
        [self addSubview:self.nameLB];
        
        self.timeLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 115, 15, 100, 17)];
        self.timeLB.textColor = CharacterBlack100;
        self.timeLB.font = kFont(13);
        self.timeLB.text = @"03-20";
        self.timeLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.timeLB];
        
        
        self.desLB = [[UILabel alloc] initWithFrame:CGRectMake(75, 50, ScreenW - 90, 20)];
        self.desLB.textColor = CharacterBlack100;
        self.desLB.font = kFont(14);
        self.desLB.text = @"常州市第一人民医院 骨科";
        [self addSubview:self.desLB];
        
        
        self.rightBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 80, 25, 70, 30)];
        [self.rightBt setBackgroundImage:[UIImage imageNamed:@"gback"] forState:UIControlStateNormal];
        self.rightBt.layer.cornerRadius = 3;
        [self.rightBt setTitle:@"聊天" forState:UIControlStateNormal];
        self.rightBt.titleLabel.font = kFont(14);
        self.rightBt.userInteractionEnabled = NO;
        [self.rightBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        self.rightBt.clipsToBounds = YES;
        [self addSubview:self.rightBt];
        self.rightBt.hidden = YES;
        
        
    }
    return self;
}

- (void)setModel:(ALMessageModel *)model {
    _model = model;
    
    
    [self.headBt.button sd_setBackgroundImageWithURL:[model.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    
    if (model.is_read) {
        self.headBt.redV.hidden = YES;
    }else {
        self.headBt.redV.hidden = NO;
    }
    self.timeLB.text = model.lastSessionTime;
    if (self.isNewFirend) {
        self.nameLB.text = model.phone;
        self.desLB.text = model.name;
    }else {
        
        self.nameLB.text = [NSString stringWithFormat:@"%@",model.institutionName];
        self.desLB.text = [NSString stringWithFormat:@"%@ %@",model.name,model.level];;
        self.timeLB.text = model.appointmentDate;
        self.headBt.redV.hidden = YES;
        
//        self.nameLB.text = [NSString stringWithFormat:@"%@  %@",model.name,model.level];;
//        self.desLB.text = [NSString stringWithFormat:@"%@ %@",model.institutionName,model.departmentName];
    }
    
   
    
    
    
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
