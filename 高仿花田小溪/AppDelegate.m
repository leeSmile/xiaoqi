//
//  AppDelegate.m
//  高仿花田小憩OC版
//
//  Created by Lee on 16/6/23.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "AppDelegate.h"
#import "LXGuideTool.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    //处理iOS8本地推送不能收到
    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
    if (sysVersion>=8.0) {
        UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    }
    
    //配置全局
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.tintColor = [UIColor blackColor];
    NSMutableDictionary *TextAttributes = [NSMutableDictionary dictionary];
    TextAttributes[@"NSFontAttributeName"] = [UIFont systemFontOfSize:15];
    TextAttributes[@"NSForegroundColorAttributeName"] = [UIColor blackColor];
    bar.titleTextAttributes = TextAttributes;
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //根据版本号判断显示哪个控制器
    self.window.rootViewController = [LXGuideTool chooseRootViewController];
    [self.window makeKeyAndVisible];
    
//    设置相关的appkey
    [self setAppKey];
    
    return YES;
}



- (void)setAppKey
{
    
}





- (void)saveContext
{
    
}
- (NSURL *)applicationDocumentsDirectory
{
    return nil;
}
@end
