//
//  ALCLookHeadView.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCLookHeadView : UIView
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)UIButton *headBt,*lookBt;
@property(nonatomic,strong)UILabel *nameLB;
@property(nonatomic,strong)UIView *backV;
@property(nonatomic,strong)WKWebView * webView;
@property(nonatomic,strong)ALMessageModel *model;


@end

NS_ASSUME_NONNULL_END
