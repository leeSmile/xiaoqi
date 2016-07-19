//
//  LoginHeaderView.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/7/15.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "LoginHeaderView.h"
#import "LoginInputView.h"
#import "ThirdLoginView.h"

#import "HelperUtil.h"

@interface LoginHeaderView ()
ImageView_(logoView)// Logo
DIYObj_(LoginInputView, localInput)// 国家地区
DIYObj_(LoginInputView, phoneInput)// 手机号
DIYObj_(LoginInputView, pwdInput)// 密码
DIYObj_(LoginInputView, safeInput)// 验证码

Button_(registerBtn)// 注册账号
Button_(revPwdBtn)// 忘记密码
ImageView_(revPwdBtnUnderLine)// 忘记密码下的线
Button_(loginBtn)// 登陆按钮

DIYObj_(ThirdLoginView, thirdLoginView)// 第三方登陆视图
Label_(serviceTermLabel)// 服务条款
@end

@implementation LoginHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.safeInput.hidden = YES;
    
    [self addSubview:self.logoView];
    [self addSubview:self.localInput];
    [self addSubview:self.phoneInput];
    [self addSubview:self.safeInput];
    [self addSubview:self.pwdInput];
    [self addSubview:self.registerBtn];
    [self addSubview:self.revPwdBtn];
    [self addSubview:self.revPwdBtnUnderLine];
    [self addSubview:self.loginBtn];
    [self addSubview:self.thirdLoginView];
    [self addSubview:self.serviceTermLabel];
    
    //约束
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(85, 85));
        make.centerX.equalTo(self);
        make.top.equalTo(self);
    }];
    
    [self.localInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoView.mas_bottom).offset(25);
        make.size.mas_equalTo(CGSizeMake(280, 35));
        make.centerX.equalTo(self);

    }];

    
    [self.phoneInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.localInput);
        make.centerX.equalTo(self);
        make.top.equalTo(self.localInput.mas_bottom).offset(15);

    }];

    
    [self.safeInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.phoneInput);
        make.centerX.equalTo(self);
        make.top.equalTo(self.phoneInput.mas_bottom).offset(15);

    }];

    
    [self.pwdInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.phoneInput);
        make.centerX.equalTo(self);
        make.top.equalTo(self.phoneInput.mas_bottom).offset(15);
    }];

    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pwdInput);
        make.top.equalTo(self.pwdInput.mas_bottom).offset(10);
    }];

    
    [self.revPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.pwdInput);
        make.top.equalTo(self.registerBtn);
    }];

    
    
    CGFloat revPwdBtnWidth = [self.revPwdBtn.currentTitle textWidthWithContentHeight:CGFLOAT_MAX font:[UIFont systemFontOfSize:14]];
    
    [self.revPwdBtnUnderLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.revPwdBtn);
        make.size.mas_equalTo(CGSizeMake(revPwdBtnWidth, 1));
        make.top.equalTo(self.revPwdBtn.mas_bottom);
    }];

    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.pwdInput);
        make.height.equalTo(@36);
        make.centerX.equalTo(self);
        make.top.equalTo(self.registerBtn.mas_bottom).offset(10);
    }];

    
    [self.thirdLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.pwdInput);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(10);
        make.height.equalTo(@100);
    }];

    
    [self.serviceTermLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-20);
    }];

}
- (UIImageView *)logoView
{
    if (!_logoView) {
        _logoView = [UIImageView new];
        _logoView.image = [UIImage imageNamed:@"LOGO_85x85_"];
    }
    return _logoView;
}
- (LoginInputView *)localInput
{
    if (!_localInput) {
        _localInput = [[LoginInputView alloc] initWithIconName:@"local" placeHolder:@"国家地区/Location" isLocation:YES isPhone:NO isSafe:NO];
    }
    return _localInput;
}
- (LoginInputView *)phoneInput
{
    if (!_phoneInput) {
        _phoneInput = [[LoginInputView alloc] initWithIconName:@"phone" placeHolder:@"手机号/Phone Number" isLocation:NO isPhone:YES isSafe:NO];
    }
    return _phoneInput;
}
- (LoginInputView *)pwdInput
{
    if (!_pwdInput) {
        _pwdInput = [[LoginInputView alloc] initWithIconName:@"pwd" placeHolder:@"密码/Password" isLocation:NO isPhone:NO isSafe:NO];
    }
    return _pwdInput;
}
- (LoginInputView *)safeInput
{
    if (!_safeInput) {
        _safeInput = [[LoginInputView alloc] initWithIconName:@"safe" placeHolder:@"验证码/Code" isLocation:NO isPhone:NO isSafe:YES];
    }
    return _safeInput;
}
- (UIButton *)registerBtn
{
    if (!_registerBtn) {
        _registerBtn = [UIButton title:@"注册账号" imageName:nil target:self selector:@selector(clickRegister:) font:[UIFont systemFontOfSize:14] titleColor:[UIColor blackColor]];
    }
    return _registerBtn;
}
- (UIButton *)revPwdBtn
{
    if (!_revPwdBtn) {
        _revPwdBtn = [UIButton title:@"忘记密码?" imageName:nil target:self selector:@selector(clickRePwd:) font:[UIFont systemFontOfSize:14] titleColor:[UIColor blackColor]];
    }
    return _revPwdBtn;
}
- (UIImageView *)revPwdBtnUnderLine
{
    if (!_revPwdBtnUnderLine) {
        _revPwdBtnUnderLine = [UIImageView new];
        _revPwdBtnUnderLine.image = [UIImage imageNamed:@"underLine"];
    }
    return _revPwdBtnUnderLine;
}
- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [UIButton title:@"登录" imageName:nil target:self selector:@selector(clickDone:) font:[UIFont systemFontOfSize:14] titleColor:[UIColor blackColor]];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn"] forState:UIControlStateNormal];
    }
    return _loginBtn;
}
- (ThirdLoginView *)thirdLoginView
{
    if (!_thirdLoginView) {
        _thirdLoginView = [ThirdLoginView new];
    }
    return _thirdLoginView;
}

- (UILabel *)serviceTermLabel
{
    if (!_serviceTermLabel) {
        _serviceTermLabel = [UILabel new];
        _serviceTermLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:11];
        _serviceTermLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        
        //设置下划线
        NSString *originStr = @"注册即表示我同意 花田小憩OC版服务条款 内容";
        NSMutableAttributedString *attrstr = [[NSMutableAttributedString alloc] initWithString:originStr];
        NSRange range = [originStr rangeOfString:@"花田小憩OC版服务条款"];
        [attrstr addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)} range:range];
        
        _serviceTermLabel.attributedText = attrstr;
        _serviceTermLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickProtocol:)];
        [_serviceTermLabel addGestureRecognizer:tag];
    }
    return _serviceTermLabel;
}

- (void)setIsRegister:(BOOL)isRegister
{
    _isRegister = isRegister;
    if (isRegister) {
        [self hiddenControl];
        [self.loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    }
}

- (void)setIsRevPwd:(BOOL)isRevPwd
{
    _isRevPwd = isRevPwd;
    if (isRevPwd) {
        [self hiddenControl];
        [self.loginBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
}
- (void)hiddenControl
{
    self.thirdLoginView.hidden = YES;
    self.revPwdBtn.hidden = YES;
    self.registerBtn.hidden = YES;
    self.safeInput.hidden = NO;
    
    [self.pwdInput mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneInput.mas_bottom).offset(65);
    }];

}
#pragma mark  click
- (void)clickRegister:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(LoginHeaderView: clickRegister:)]) {
        [self.delegate LoginHeaderView:self clickRegister:btn];
    }
}
- (void)clickRePwd:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(LoginHeaderView: clickRevpwd:)]) {
        [self.delegate LoginHeaderView:self clickRevpwd:btn];
    }
}
// 点击了登录/注册/完成按钮
- (void)clickDone:(UIButton *)btn
{
    LoginProfile *profile = [[LoginProfile alloc] init];
    if ([self.phoneInput.textFiled.text isEqualToString:@""] ) {
        [[Tostal sharTostal] tostalMesg:@"手机号码不能为空" tostalTime:1];
        return;
    }else
    {
        if (![HelperUtil checkTelNumber:self.phoneInput.textFiled.text]) {
            [[Tostal sharTostal] tostalMesg:@"手机号码格式不对" tostalTime:1];
            return;
        }
    }
    
    if (![btn.currentTitle isEqualToString:@"登录"]) {
        
        if ([self.safeInput.textFiled.text isEqualToString:@""]) {
            [[Tostal sharTostal] tostalMesg:@"验证码不能为空" tostalTime:1];
            return;
        }else
        {
            profile.safeNum = self.safeInput.textFiled.text;
        }
        
        
    }
    
    if ([self.pwdInput.textFiled.text isEqualToString:@""]) {
        [[Tostal sharTostal] tostalMesg:@"密码不能为空" tostalTime:1];
        return;
    }
    profile.phoneNumber = self.phoneInput.textFiled.text;
    profile.password = self.pwdInput.textFiled.text;
    
    if ([self.delegate respondsToSelector:@selector(LoginHeaderView: clickDoneWithProfile:)]) {
        [self.delegate LoginHeaderView:self clickDoneWithProfile:profile];
    }
}

- (void)clickProtocol:(UITapGestureRecognizer *)tag
{
    if ([self.delegate respondsToSelector:@selector(LoginHeaderView: clickProtocol:)]) {
        [self.delegate LoginHeaderView:self clickProtocol:nil];
    }
}
@end
