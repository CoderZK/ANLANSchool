//
//  ALCInterestTVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/18.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"



@interface ALCInterestTVC : BaseTableViewController
//男1 女2
@property(nonatomic,strong)NSString *heightStr,*weightStr,*birthdateStr,*genderStr,*phoneStr,*institutionVisitedIds;

@end


@interface ALCInterestVV : UIView
@property(nonatomic,strong)UIButton *clickBt;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *LB;



@end

