

#import "NewFeatureViewController.h"
#import "MainViewController.h"
#define LXVersionKey @"curVersion"


#import "LXGuideTool.h"


@implementation LXGuideTool

+ (UIViewController *)chooseRootViewController
{
    
    UIViewController *rootVc = nil;
    
    // 判断下用户有没有最新的版本
    // 最新的版本都是保存到info.plist
    // 从info.plist文件获取最新版本
    // 获取info.plist
    
    NSDictionary *dict =  [NSBundle mainBundle].infoDictionary;
    
    // 获取最新的版本号
    NSString *curVersion = dict[@"CFBundleShortVersionString"];
    
    // 获取上一次的版本号
    NSString *lastVersion = [LXFileManager readUserDataForKey:LXVersionKey];
    
    // 之前的最新的版本号 lastVersion
    if ([curVersion isEqualToString:lastVersion]) {
        // 版本号相等

        rootVc = [[MainViewController alloc] init];
        
    }else{ // 有最新的版本号
    
        rootVc = [[NewFeatureViewController alloc] init];
        [LXFileManager saveUserData:curVersion forKey:LXVersionKey];
    }
    
    return rootVc;
    
}

@end
