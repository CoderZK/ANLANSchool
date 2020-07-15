//
//  ALCDorDetailHeadView.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCDorDetailHeadView : UIView
@property(nonatomic,strong)UILabel *nameLB,*keshiLB1,*yuYueLB,*ziXunLB,*shanchangLB;
@property(nonatomic,strong)UIButton *dorMeBt ,*headBt,*addressBt;
@property(nonatomic,strong)ALMessageModel *model;
@property(nonatomic,assign)BOOL isProject;
@end

NS_ASSUME_NONNULL_END
