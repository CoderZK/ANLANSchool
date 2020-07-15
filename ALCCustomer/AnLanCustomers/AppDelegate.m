//
//  AppDelegate.m
//  AnLanCustomers
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UserNotifications/UserNotifications.h>
#import <WXApi.h>
#import "TabBarController.h"
#import "LYGuideViewController.h"
#import "ALCHeightAndWeightVC.h"
#import "ALCInterestTVC.h"
#import "HHHHVC.h"
#import "ALCJianKangRiZhiDetailTVC.h"
#import "ALCTiXingDetailTVC.h"

#define UMKey @"5ebbbba6167edd1a690004c0"
//友盟安全密钥//r6xbw5gy0zenei6x56xtm9wmkrrz653y
#define SinaAppKey @"3443149913"
#define SinaAppSecret @"2d6bac14bc37989170ba9ab6214f06c3"
#define WXAppID @"wx88961cb7f6a6195f"
#define WXAppSecret @"231e12228c347ef14b6a68d31e20e7a5"
#define QQAppID @"1110549472"
#define QQAppKey @"LXwoJCeQixi1CBr9"

// 健康管理友盟账号：安澜健康 密码：biyou123@A 手机号：13205209300
//苹果帐号：juj5407@163.com   邮箱密码：qwe123  帐号密码： Vv11223344

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [self instantiateRootVC];
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    /* 设置友盟appkey */
    
    [zkSignleTool shareTool].isUp = YES;
   
    [WXApi registerApp:WXAppID universalLink:@"https://www.onlandtech.cn/"];
  
    [self initPush];
    [self configUSharePlatforms];
    [self initUMeng:launchOptions];
    
    // 发送崩溃日志
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dataPath = [path stringByAppendingPathComponent:@"Exception.txt"];
    
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    
    if (data != nil) {
        
        //        [self sendExceptionLogWithData:data path:dataPath];
        
    }
    
    if (![zkSignleTool shareTool].isLogin) {
        ALCLoginOneVC * vc =[[ALCLoginOneVC alloc] init];
        BaseNavigationController * navc =[[BaseNavigationController alloc] initWithRootViewController:vc];
        navc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.window.rootViewController presentViewController:navc animated:YES completion:nil];
    }
    
    
//     [[JZTouchIDManager shareManager] openTouchId:NO];
    
    
    
    return YES;
}

-(void)initPush
{
    //1.向系统申请推送
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    }
    else
    {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
    
}

-(void)initUMeng:(NSDictionary *)launchOptions
{
    [UMConfigure initWithAppkey:UMKey channel:@"App Store"];
    // Push组件基本功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate=self;
        
    } else {
        // Fallback on earlier versions
    }
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        
        if (error) {
            NSLog(@"error===%@",error.description);
        }
        
        if (granted) {
            
        }else{
        }
    }];
    
}

- (void)configUSharePlatforms
{
    
    //打开图片水印
    [UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    //关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppID appSecret:WXAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppID/*设置QQ平台的appID*/  appSecret:QQAppKey redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaAppKey  appSecret:SinaAppSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    
}

//iOS10以下使用这两个方法接收通知
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
    }
    //过滤掉Push的撤销功能，因为PushSDK内部已经调用的completionHandler(UIBackgroundFetchResultNewData)，
    //防止两次调用completionHandler引起崩溃
    if(![userInfo valueForKeyPath:@"aps.recall"])
    {
        completionHandler(UIBackgroundFetchResultNewData);
    }
}
//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        //应用处于前台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于前台时的本地推送接受
    }
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}
//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
        LxmPushModel *model = [LxmPushModel mj_objectWithKeyValues:userInfo];
        if (![zkSignleTool shareTool].isLogin) {
            [SVProgressHUD showErrorWithStatus:@"您目前处于离线状态"];
            return;
        }
        TabBarController * bar = (TabBarController *)self.window.rootViewController;
        bar.selectedIndex = 0;
        BaseNavigationController * nav  = (BaseNavigationController *)bar.selectedViewController;
        [self pageTo:model nav:nav];
        
    }else{
        //应用处于后台时的本地推送接受
    }
    
}

//10一下的系统
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [UMessage didReceiveRemoteNotification:userInfo];
    
    NSLog(@"===\n1===%@",userInfo);
    
    LxmPushModel *model = [LxmPushModel mj_objectWithKeyValues:userInfo];
    if (![zkSignleTool shareTool].isLogin) {
        [SVProgressHUD showErrorWithStatus:@"您目前处于离线状态"];
        return;
    }
    TabBarController * bar = (TabBarController *)self.window.rootViewController;
    bar.selectedIndex = 0;
    BaseNavigationController * nav  = (BaseNavigationController *)bar.selectedViewController;
    [self pageTo:model nav:nav];
    
}

- (void)pageTo:(LxmPushModel *)model nav:(BaseNavigationController *)nav {
    //1 问诊消息 , 2 日程消息 3 系统消息 4 聊天
    if (model.eventType.intValue == 1) {
        ALCJianKangRiZhiDetailTVC * vc =[[ALCJianKangRiZhiDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        NSArray * arr = [model.objectId componentsSeparatedByString:@"-"];
        if (arr.count == 0) {
            return;
        }
        vc.ID = [arr lastObject];;
        [nav pushViewController:vc animated:YES];
    }else if (model.eventType.intValue == 2) {
        ALCTiXingDetailTVC * vc =[[ALCTiXingDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.ID = model.objectId;
        [nav pushViewController:vc animated:YES];
        
    }else if (model.eventType.intValue  == 3) {//
        ACLMineMessageTVC * vc =[[ACLMineMessageTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:vc animated:YES];
    }else if (model.eventType.intValue == 4) {
        ALChatMessageTVC* vc =[[ALChatMessageTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        NSArray * arr = [model.objectId componentsSeparatedByString:@"-"];
        if (arr.count < 3) {
            return;
        }
        vc.toUserId = arr[arr.count - 3];
        vc.aimUserId = arr[arr.count - 2];
        vc.aimtype = arr[arr.count -1];
        [nav pushViewController:vc animated:YES];
    }
}





//在用户接受推送通知后系统会调用
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [UMessage registerDeviceToken:deviceToken];
    
    NSString * token = @"";
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13) {
        if (![deviceToken isKindOfClass:[NSData class]]) {
            //记录获取token失败的描述
            return;
        }
        const unsigned *tokenBytes = (const unsigned *)[deviceToken bytes];
        token = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                 ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                 ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                 ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
        
    } else {
        token = [NSString
                 stringWithFormat:@"%@",deviceToken];
        token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
        token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
        token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
        
    }
    
    NSLog(@"deviceToken1:%@", token);
    [zkSignleTool shareTool].deviceToken = token;
    [[zkSignleTool shareTool] uploadDeviceToken];
    
}


//设置根视图控制器
- (UIViewController *)instantiateRootVC{
    
    //没有引导页
    TabBarController *BarVC=[[TabBarController alloc] init];
    return BarVC;
    
    
    
    //    //获取app运行的版本号
    //    NSString *currentVersion =[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    //    //取出本地缓存的版本号
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSString *localVersion = [defaults objectForKey:@"appversion"];
    //    if ([currentVersion isEqualToString:localVersion]) {
    //        TabBarController *BarVC=[[TabBarController alloc] init];
    //        return BarVC;
    //        //        TabBarController * tabVc = [[TabBarController alloc] init];
    //        //        return tabVc;
    //
    //    }else{
    //        LYGuideViewController *guideVc = [[LYGuideViewController alloc] init];
    //        return guideVc;
    //    }
}
//跳转主页
- (void)showHomeVC{
    TabBarController  *BarVC=[[TabBarController alloc] init];
    self.window.rootViewController = BarVC;
    
    //更新本地储存的版本号
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"appversion"];
    //同步到物理文件存储
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark -支付宝 微信支付
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    //跳转到支付宝支付的情况
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //发送一个通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZFBPAY" object:resultDic];
            NSLog(@"result ======================== %@",resultDic);
        }];
    } else if ([url.absoluteString hasPrefix:@"wx88961cb7f6a6195f://pay"] ) {
        //微信
        [WXApi handleOpenURL:url delegate:self];
        
    }else {//友盟
        [[UMSocialManager defaultManager] handleOpenURL:url];
    }
    return YES;
    
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    //跳转到支付宝支付的情况
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //发送一个通知,告诉支付界面要做什么
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZFBPAY" object:resultDic];
            NSLog(@"result ======================== %@",resultDic);
        }];
    } else if ([url.absoluteString hasPrefix:@"wx88961cb7f6a6195f://pay"] ) {
        
        [WXApi handleOpenURL:url delegate:self];
        
        
    }else {
        [[UMSocialManager defaultManager] handleOpenURL:url];
    }
    
    return YES;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    //跳转到支付宝支付的情况
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //发送一个通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZFBPAY" object:resultDic];
            
            NSLog(@"result ======================== %@",resultDic);
        }];
    } else if ([url.absoluteString hasPrefix:@"wx88961cb7f6a6195f://pay"] ) {
        [WXApi handleOpenURL:url delegate:self];
        
    }else {
        [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    }
    return YES;
}
//微信支付结果
- (void)onResp:(BaseResp *)resp {
    //发送一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WXPAY" object:resp];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
