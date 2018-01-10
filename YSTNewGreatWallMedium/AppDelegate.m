//
//  AppDelegate.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/21.
//  Copyright © 2017年 zhubiao. All rights reserved.
//


#import "AppDelegate.h"
#import "YSTTabBarViewController.h"
#import "YSTLoginViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "XYDJViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "RootViewController.h"
#define KBaiduMapKey @"d0jqHI5ybsxSSOneCXAbGIVa"


#import "Chat.h"
@interface AppDelegate ()<BMKGeneralDelegate>
{
    BMKMapManager* mapManager;
}
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    YSTTabBarViewController *tabbarVC = [[YSTTabBarViewController alloc]init];
    YSTLoginViewController *logineVC = [[YSTLoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:logineVC];
    self.window.rootViewController = nav;
    [self.window makeKeyWindow];
    [[[IQKeyboardManager sharedManager] disabledDistanceHandlingClasses] addObject:[XYDJViewController class]];
    [[[IQKeyboardManager sharedManager] disabledToolbarClasses] addObject:[XYDJViewController class]];
    [[[IQKeyboardManager sharedManager] disabledDistanceHandlingClasses] addObject:[RootViewController class]];
    [[[IQKeyboardManager sharedManager] disabledToolbarClasses] addObject:[RootViewController class]];
    
    return YES;
}

-(void)setupBaiduMap
{
    mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [mapManager start:KBaiduMapKey generalDelegate:self];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }
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


- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

@end
