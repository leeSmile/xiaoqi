//
//  LoginInputView.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/7/15.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "LoginInputView.h"

static NSString *ToCountryNotifName = @"ToCountryNotifName";
static NSString *ChangeCountyNotifyName = @"ChangeCountyNotifyName";
@interface LoginInputView ()



@end

@implementation LoginInputView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCounty:) name:ChangeCountyNotifyName object:nil];
    
    [self addSubview:self.undLine];
    [self addSubview:self.iconView];
    [self addSubview:self.textFiled];
    [self addSubview:self.locationBtn];
    [self addSubview:self.safeBtn];
    
    //约束
    [self.undLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-1);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(19, 20));
        make.centerY.equalTo(self);
    }];
    
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(10);
        make.width.equalTo(self);
        make.centerY.equalTo(self);
    }];
    
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(@100);
        make.centerY.equalTo(self);
    }];
    
    [self.safeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
}
- (instancetype)initWithIconName:(NSString *)iconName placeHolder:(NSString *)placeHolder isLocation:(BOOL)isLocation isPhone:(BOOL)isPhone isSafe:(BOOL)isSafe
{
    self = [self initWithFrame:CGRectZero];

    self.iconView.image = [UIImage imageNamed:iconName];
    self.textFiled.placeholder = placeHolder;
    
    if (isLocation) {
        self.locationBtn.hidden = NO;
        self.textFiled.userInteractionEnabled = NO;
    }else
    {
        self.locationBtn.hidden = YES;
        self.textFiled.userInteractionEnabled = YES;
    }
    
    
    if (isPhone) {
        self.textFiled.keyboardType = UIKeyboardTypeNumberPad;
    }else
    {
        self.textFiled.keyboardType = UIKeyboardTypeDefault;
    }
    
    if (isSafe) {
        self.safeBtn.hidden = NO;
    }else
    {
        self.safeBtn.hidden = YES;
    }
    
    return self;
}
- (UIImageView *)undLine
{
    if (!_undLine) {
        _undLine = [UIImageView new];
        _undLine.image = [UIImage imageNamed:@"underLine"];
    }
    return _undLine;
}
- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [UIImageView new];
        _iconView.image = [UIImage imageNamed:@"safe"];
    }
    return _iconView;
}
- (UITextField *)textFiled
{
    if (!_textFiled) {
        _textFiled = [UITextField new];
        _textFiled.placeholder = @"国家地区/Location";
        _textFiled.font = [UIFont systemFontOfSize:14];
//        [_textFiled setValue:[UIColor blackColor] forKey:@"_placeholderLabel.textColor"];
//        [_textFiled setValue:[UIFont systemFontOfSize:14] forKey:@"_placeholderLabel.font"];
    }
    return _textFiled;
}
- (UIButton *)locationBtn
{
    if (!_locationBtn) {
        _locationBtn = [UIButton title:@"中国/+86" imageName:@"goto" target:self selector:@selector(toLocation) font:[UIFont systemFontOfSize:14] titleColor:[UIColor blackColor]];
        _locationBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
        _locationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 80, 0, 0);
    }
    return _locationBtn;
}
- (UIButton *)safeBtn
{
    if (!_safeBtn) {
        _safeBtn = [UIButton title:@"获取验证码" imageName:nil target:self selector:@selector(clickSafeNum:) font:[UIFont systemFontOfSize:14] titleColor:[UIColor blackColor]];
        [_safeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        _safeBtn.layer.borderWidth = 1;
        _safeBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _safeBtn;
}

- (void)toLocation
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ToCountryNotifName object:nil];
}

- (void)clickSafeNum:(UIButton *)btn
{
    
    __block int seconds = 10 ;//倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(timer,dispatch_walltime(nil, 0),1 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if(seconds<=0){ //倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                btn.userInteractionEnabled = YES;
            });
        }else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                
                [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                [btn setTitle:[NSString stringWithFormat:@"%zd秒后重新发送",seconds] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:11];
                [UIView commitAnimations];
                btn.userInteractionEnabled = NO;
            });
            
            seconds -= 1;
        }
    });
    dispatch_resume(timer);
}

- (void)changeCounty:(NSNotification *)noti
{
    if (noti.userInfo[@"country"]) {
        [self.locationBtn setTitle:noti.userInfo[@"country"] forState:UIControlStateNormal];
    }
}
@end
