//
//  ACLJianKangOneCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ACLJianKangOneCell.h"

@implementation ACLJianKangOneCell

- (void)awakeFromNib {
    [super awakeFromNib];

       
       self.backV.backgroundColor = WhiteColor;
       self.backV.layer.cornerRadius = 5;
       self.backV.layer.shadowColor = [UIColor blackColor].CGColor;
       self.backV.layer.shadowOffset = CGSizeMake(0, 0);
       self.backV.layer.shadowRadius = 5;
       self.backV.layer.shadowOpacity = 0.08;
       self.backgroundColor = self.contentView.backgroundColor = [UIColor clearColor];;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
