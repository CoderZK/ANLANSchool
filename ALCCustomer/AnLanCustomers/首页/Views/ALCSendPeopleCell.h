//
//  ALCSendPeopleCell.h
//  AnLanBB
//
//  Created by zk on 2020/3/31.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCSendPeopleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *lineV;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *phoneLB;
@property (weak, nonatomic) IBOutlet UIImageView *headImgV;
@property (weak, nonatomic) IBOutlet UIImageView *leftImgV;

@end

NS_ASSUME_NONNULL_END
