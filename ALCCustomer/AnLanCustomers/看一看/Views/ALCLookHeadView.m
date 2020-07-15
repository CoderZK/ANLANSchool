//
//  ALCLookHeadView.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCLookHeadView.h"

@interface ALCLookHeadView()<WKScriptMessageHandler>

@end

@implementation ALCLookHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, ScreenW - 30, 20)];
        self.titleLB.font = [UIFont systemFontOfSize:16 weight:0.2];
        self.titleLB.text = @"气血不足该如何调理，这篇文章了";
        self.titleLB.numberOfLines = 0;
        [self addSubview:self.titleLB];
        
        //        self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 45, 40, 40)];
        //        self.headBt.layer.cornerRadius = 20;
        //        self.headBt.clipsToBounds = YES;
        //        [self addSubview:self.headBt];
        //        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        //
        //
        //        self.nameLB = [[UILabel alloc] initWithFrame:CGRectMake(60, 45, 120, 40)];
        //        self.nameLB.textColor = CharacterColor50;
        //        self.nameLB.text = @"川渝";
        //        self.nameLB.font = kFont(14);
        //        [self addSubview:self.nameLB];
        
        
        self.lookBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 100, 10, 85, 40)];
        [self.lookBt setImage:[UIImage imageNamed:@"kan"] forState:UIControlStateNormal];
        [self.lookBt setTitle:@"256" forState:UIControlStateNormal];
        [self.lookBt setTitleColor:CharacterBlack100 forState:UIControlStateNormal];
        self.lookBt.titleLabel.font = kFont(13);
        self.lookBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.lookBt setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [self addSubview:self.lookBt];
        
          NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
          
          WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
          WKUserContentController *wkUController = [[WKUserContentController alloc] init];
          [wkUController addUserScript:wkUScript];
          
          WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
          wkWebConfig.userContentController = wkUController;
        
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(10, 50 ,ScreenW -20, 0.1) configuration:wkWebConfig];
        self.webView.allowsBackForwardNavigationGestures=YES;
//        [[self.webView configuration].userContentController addScriptMessageHandler:self name:@"completeFn"];
        self.webView.scrollView.showsVerticalScrollIndicator = NO;
        self.webView.scrollView.showsHorizontalScrollIndicator = NO;
        self.webView.userInteractionEnabled = NO;
        if (@available(iOS 11.0, *)) {
            self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self addSubview:self.webView];
        UIView * backV =[[UIView alloc] init];
        backV.backgroundColor = BackgroundColor;
        [self addSubview:backV];
        
        [backV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@10);
        }];
        
        self.backV = backV;
        
        self.clipsToBounds = YES;
        
    }
    self.backgroundColor = [UIColor whiteColor];
    return self;
}


- (void)setModel:(ALMessageModel *)model {
    _model = model;
    
    self.titleLB.attributedText = [model.title getMutableAttributeStringWithFont:16 withBlood:YES lineSpace:3 textColor:[UIColor blackColor]];
    self.titleLB.mj_h = [model.title getHeigtWithIsBlodFontSize:16 lineSpace:3 width:ScreenW - 30];
    
    //    self.headBt.mj_y = CGRectGetMaxY(self.titleLB.frame) + 15;
    //    [self.headBt sd_setBackgroundImageWithURL:[model.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    
    self.lookBt.mj_y = CGRectGetMaxY(self.titleLB.frame);
    
    //    self.nameLB.mj_y = CGRectGetMaxY(self.titleLB.frame) + 15;
    //    self.nameLB.text = model.createrName;
    //    self.nameLB.mj_w = [model.createrName getWidhtWithFontSize:14];
    //    [self.lookBt setTitle:model.readCnt forState:UIControlStateNormal];
    if (model.readCnt.intValue > 10000) {
        [self.lookBt setTitle:[NSString stringWithFormat:@"%0.1f万",model.readCnt.floatValue/10000.0] forState:UIControlStateNormal];
    }
    self.webView.mj_y = CGRectGetMaxY(self.lookBt.frame) + 5;
    
    model.HHHHHH = CGRectGetMaxY(self.lookBt.frame) + 5 + 10;
}

//WKScriptMessageHandler协议方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    //code
    NSLog(@"name = %@, body = %@", message.name, message.body);
    if (message.name && [message.name isEqualToString:@"completeFn"]) {
        //返回订单详情页
        
    }else {
        
    }
}


@end
