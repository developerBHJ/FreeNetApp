//
//  AppDelegate.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/10.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "AppDelegate.h"
#import "BHJTabBarController.h"
#import "BHJDisplayView.h"
#import <Bugtags/Bugtags.h>

#define bugTagsKey @"869d79abe6818934659f369ede111049"
#define webChatKey @"wx1a80045afaa2b19e"
#define UMAppKey @"5829190882b63547eb0017c7"

@interface AppDelegate ()<CLLocationManagerDelegate>

@property (nonatomic,strong)MBProgressHUD *progressHud;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    // Bugtags
//    [Bugtags startWithAppKey:bugTagsKey invocationEvent:BTGInvocationEventBubble];
    
    BHJTabBarController *tabBarVC = [[BHJTabBarController alloc]init];
    [tabBarVC setupChildViewControllers];
    self.window.rootViewController = tabBarVC;
    
    // 引导页
//    [self setLuanchView];       // 使用了UIViewController (KSGuid)
    
    // 网络检测
    [self networkStatus];
    
    //友盟分享
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMAppKey];
    [self configUSharePlatforms];
    // 高德地图
    [AMapServices sharedServices].apiKey = mapKey;

    [self.window makeKeyAndVisible];
    
    return YES;
}


//开场动画
-(void)setLuanchView{
    
    /**
     可以在这里进行一个判断的设置，如果是app第一次启动就加载启动页，如果不是，则直接进入首页
     **/
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        // 这里判断是否第一次
        
       BHJDisplayView  *displayView = [[BHJDisplayView alloc]initWithFrame:CGRectMake(0, 0, MainScreen_width, MainScreen_height)];
        
        [self.window.rootViewController.view addSubview:displayView];
        
        [UIView animateWithDuration:0.25 animations:^{
            displayView.frame = CGRectMake(0, 0, MainScreen_width, MainScreen_height);
            
        }];
    }
}

#pragma mark - 判断网络状态
- (void)networkStatus
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        NSString *message = nil;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                message = @"未知网络";
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                message = @"您的网络开小差了";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                message = @"您正在使用3G/4G网络";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
               message = @"您正在使用WIFI网络";
                break;
        }
        self.progressHud = [[MBProgressHUD alloc] initWithView:self.window];
        [self.window addSubview:self.progressHud];
        self.progressHud.label.text = message;
        [self.progressHud.label setFont:[UIFont systemFontOfSize:15]];
        self.progressHud.mode = MBProgressHUDModeText;
        //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
            [self.progressHud setOffset:CGPointMake(0, 150)];
        //    HUD.xOffset = 100.0f;
        // 隐藏时候从父控件中移除
        self.progressHud.removeFromSuperViewOnHide = YES;
        [self.progressHud showAnimated:YES];
        [self.progressHud hideAnimated:YES afterDelay:1];
    }];
    // 3.开始监控
    [manger startMonitoring];
}



- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:webChatKey appSecret:@"fd0fc988dbacb3b36908634f5e64a39d" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
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

#pragma mark - 强制竖屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - 取消第一响应者
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.window endEditing:YES];
}

@end
