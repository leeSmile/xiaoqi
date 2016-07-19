//
//  LoginViewController.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/7/15.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginHeaderView.h"
#import "CountryTableViewController.h"
#import "ProtocolViewController.h"
static NSString *ToCountryNotifName = @"ToCountryNotifName";
@interface LoginViewController ()<LoginHeaderViewDelegate>
DIYObj_(LoginHeaderView, logoView)
ImageView_(bgImageView)
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}
- (void)setup
{
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toCountry) name:ToCountryNotifName object:nil];
    
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.logoView];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(@64);
    }];

    //设置导航条
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close"] style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
}
#pragma mark - LoginHeaderViewDelegate
- (void)LoginHeaderView:(LoginHeaderView *)loginHeaderView clickRevpwd:(UIButton *)btn
{
    LoginViewController *login = [[LoginViewController alloc] init];
    login.isRevPwd = YES;
    [self.navigationController pushViewController:login animated:YES];
}
- (void)LoginHeaderView:(LoginHeaderView *)loginHeaderView clickRegister:(UIButton *)btn
{
    LoginViewController *login = [[LoginViewController alloc] init];
    login.isRegister = YES;
    [self.navigationController pushViewController:login animated:YES];

    
}
- (void)LoginHeaderView:(LoginHeaderView *)loginHeaderView clickProtocol:(UILabel *)protocelLabel
{
    //协议
    ProtocolViewController *vc = [[ProtocolViewController alloc] init];
    [vc customTitle:@"服务协议"];
    vc.HTM5Url = @"http://m.htxq.net/servlet/SysContentServlet?action=getDetail&id=af50c0f4-d048-419b-a2de-47bb47fb99a5";
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)LoginHeaderView:(LoginHeaderView *)loginHeaderView clickDoneWithProfile:(LoginProfile *)profile
{
    if (profile.safeNum == nil) {
        //登录成功
        [LXFileManager saveObject:@"1" byFileName:LoginStatus];
        [[Tostal sharTostal] tostalMesg:@"登录成功" tostalTime:2];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
            //登录成功后的回调
            if ([self.delegate respondsToSelector:@selector(loginViewControllerDidSuccess:)]) {
                [self.delegate loginViewControllerDidSuccess:self];
            }
        });
    }else
    {
        if (self.isRegister) {
            [[Tostal sharTostal] tostalMesg:@"注册成功" tostalTime:2];
        }else
        {
            [[Tostal sharTostal] tostalMesg:@"密码重置成功" tostalTime:2];
        }
    }
}
#pragma mark - self
- (void)toCountry
{
    CountryTableViewController *countryVC = [[CountryTableViewController alloc] init];
    UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:countryVC];
    [nav.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    nav.navigationBar.shadowImage = [UIImage new];
    nav.navigationBar.translucent = YES;
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)back
{
    if (self.navigationController.childViewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self dismiss];
    }
}
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark set 
- (void)setIsRevPwd:(BOOL)isRevPwd
{
    _isRevPwd = isRevPwd;
    if (isRevPwd) {
        self.logoView.isRevPwd = isRevPwd;
    }
}

- (void)setIsRegister:(BOOL)isRegister
{
    _isRegister = isRegister;
    if (isRegister) {
        self.logoView.isRegister = isRegister;
    }
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.image = [UIImage imageNamed:@"loginBack"];
    }
    return _bgImageView;
}
- (LoginHeaderView *)logoView
{
    if (!_logoView) {
        _logoView = [LoginHeaderView new];
        _logoView.delegate = self;
    }
    return _logoView;
}

@end
