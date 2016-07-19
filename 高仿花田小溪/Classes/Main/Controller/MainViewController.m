//
//  MainViewController.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MainViewController.h"
#import "HomeTableViewController.h"
#import "MallsTableViewController.h"
#import "ColumnistViewController.h"
#import "Author.h"
#import "LocalPushCenter.h"
#import "LoginViewController.h"
static NSString *LoginoutNotify = @"LoginoutNotify";

@interface MainViewController ()<UITabBarControllerDelegate,LoginViewControllerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];

}


- (void)setup
{
    self.tabBar.tintColor = [UIColor blackColor];
    self.tabBar.translucent = NO;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [self addViewController:[[HomeTableViewController alloc] init] title:NSLocalizedString(@"tab_theme", @"")];
    [self addViewController:[[MallsTableViewController alloc] init] title:NSLocalizedString(@"tab_malls", @"")];
    
    Author *author = [[Author alloc] init];
    author.ID = @"4a3dab7f-1168-4a61-930c-f6bc0f989f32";
    author.auth = @"大神";
    author.auth = @"定义自己的美好生活\n";
    author.headImg = @"http://m.htxq.net//UploadFiles/headimg/20160422164405309.jpg";
    author.identity = @"官方认证";
    
    ColumnistViewController *columnistVC = [[ColumnistViewController alloc] init];
    columnistVC.author = author;
    columnistVC.isUser = YES;
    [self addViewController:columnistVC title:NSLocalizedString(@"tab_profile", @"")];
    
    self.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:LoginoutNotify object:nil];
}


- (void)addViewController:(UIViewController *)childController title:(NSString *)title
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childController];
    nav.navigationBar.translucent = NO;
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"tb_%zd",self.childViewControllers.count ]];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"tb_%zd_selected",self.childViewControllers.count ]];
    childController.tabBarItem.tag = self.childViewControllers.count ;
    [self addChildViewController:nav];
}

#pragma mark- UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    UINavigationController *nav = (UINavigationController *)viewController;
    if ([nav.visibleViewController isKindOfClass:[ColumnistViewController class]]) {
        NSString *num = [LXFileManager getObjectByFileName:LoginStatus];
        if (![num isEqualToString:@"1"]) {
            [self login];
            return NO;
        }else
        {
            return YES;
        }
        
    }
    return YES;
}
#pragma mark-LoginViewControllerDelegate
- (void)loginViewControllerDidSuccess:(LoginViewController *)LoginViewController
{
    self.selectedIndex = self.childViewControllers.count -1;
}
- (void)logout
{
    self.selectedIndex = 0;
    [self login];
}

- (void)login
{
    LoginViewController *login = [[LoginViewController alloc] init];
    login.delegate = self;
    UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:login];
//#warning 作用  设置navigationBar的背景色为透明start
    [nav.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    nav.navigationBar.shadowImage = [UIImage new];
    nav.navigationBar.translucent = YES;
    
    [self presentViewController:nav animated:YES completion:nil];
}
@end
