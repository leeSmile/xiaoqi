//
//  PayView.m
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/7/19.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "PayView.h"
#import "PayItemView.h"

@interface PayView ()
View_(payView)// 总视图
Label_(needpayText)// "需支付"
Label_(priceLabel)// 价格
ImageView_(underLine)// 下划线
DIYObj_(PayItemView, alipay)// 支付宝
DIYObj_(PayItemView, weichat)// 微信
Button_(entryPay)// 确认支付

DIYObj_(PayItemView, selectedPayItem)
@end

@implementation PayView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    [self addSubview:self.payView];
    [self.payView addSubview:self.needpayText];
    [self.payView addSubview:self.priceLabel];
    [self.payView addSubview:self.underLine];
    [self.payView addSubview:self.weichat];
    [self.payView addSubview:self.alipay];
    [self.payView addSubview:self.entryPay];
    
    
    //约束
    [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@350);
    }];
    
    [self.needpayText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@15);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.needpayText.mas_right).offset(15);
        make.top.equalTo(self.needpayText);
    }];
    
    [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.needpayText.mas_bottom).offset(5);
        make.left.equalTo(self.needpayText);
        make.right.equalTo(@0);
        make.height.equalTo(@1);
    }];
    
    [self.alipay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.underLine.mas_bottom).offset(5);
        make.left.equalTo(self.needpayText);
        make.right.equalTo(@0);
        make.height.equalTo(@60);
    }];
    
    [self.weichat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alipay.mas_bottom).offset(5);
        make.left.equalTo(self.alipay);
        make.right.equalTo(@0);
        make.height.equalTo(@60);
    }];
    
    [self.entryPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(278, 39));
        make.centerX.equalTo(self);
        make.bottom.equalTo(@(-20));
    }];
    
    self.payView.transform = CGAffineTransformMakeTranslation(0, 350);
    
    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endAnim)];
    
    [self addGestureRecognizer:tag];
}
#pragma  mark -- set get
- (UIView *)payView
{
    if (!_payView) {
        _payView = [UIView new];
        _payView.backgroundColor = [UIColor whiteColor];
    }
    return _payView;
}
- (UILabel *)needpayText
{
    if (!_needpayText) {
        _needpayText = [UILabel new];
        _needpayText.font = [UIFont systemFontOfSize:14];
        _needpayText.textColor = [UIColor blackColor];
        _needpayText.text = @"需支付:";
    }
    return _needpayText;
}
- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont systemFontOfSize:14];
        _priceLabel.textColor = [UIColor orangeColor];
    }
    return _priceLabel;
}
- (PayItemView *)alipay
{
    if (!_alipay) {
        _alipay = [PayItemView new];
        Pay *pay = [Pay new];
        pay.icon = [UIImage imageNamed:@"f_alipay_26x26"];
        pay.title = @"支付宝支付";
        pay.des = @"推荐有支付宝账号的用户使用";
        _alipay.payInfo = pay;
        
        UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPayItem:)];
        [_alipay addGestureRecognizer:tag];
    }
    return _alipay;
}
- (PayItemView *)weichat
{
    if (!_weichat) {
        _weichat = [PayItemView new];
        Pay *pay = [Pay new];
        pay.icon = [UIImage imageNamed:@"f_wechat_26x26"];
        pay.title = @"微信支付";
        pay.des = @"推荐安装微信5.0及以上版本使用";
        _weichat.payInfo = pay;
        
        UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPayItem:)];
        [_weichat addGestureRecognizer:tag];
    }
    return _weichat;
}

- (UIButton *)entryPay
{
    if (!_entryPay) {
        _entryPay = [UIButton title:nil imageName:@"f_okPay_278x39" target:self selector:@selector(entryBuy) font:nil titleColor:nil];

    }
    return _entryPay;
}
- (UIImageView *)underLine
{
    if (!_underLine) {
        _underLine = [UIImageView new];
        _underLine.image = [UIImage imageNamed:@"underLine"];
    }
    return _underLine;
}


- (void)setTotalPrice:(NSString *)totalPrice
{
    _totalPrice = totalPrice;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",totalPrice];
}

#pragma mark - self
- (void)selectPayItem:(UITapGestureRecognizer *)tap
{
    self.selectedPayItem = (PayItemView *)tap.view;
    if (tap.view == self.weichat) {
        self.weichat.selected = YES;
        self.alipay.selected = NO;
    }else
    {
        self.weichat.selected = NO;
        self.alipay.selected = YES;
    }
}

- (void)entryBuy
{
    [self endAnim];
    if (self.selectedPayItem == self.weichat) {
        [[Tostal sharTostal] tostalMesg:[NSString stringWithFormat:@"恭喜您使用微信支付了%@元",self.totalPrice ] tostalTime:2];
    }else
    {
        [[Tostal sharTostal] tostalMesg:[NSString stringWithFormat:@"恭喜您使用支付宝支付了%@元",self.totalPrice ] tostalTime:2];
    }
}
// 开始动画
- (void)startAnim
{
    [UIView animateWithDuration:0.5 animations:^{
        self.payView.transform = CGAffineTransformIdentity;
    }];
}
// 结束动画
- (void)endAnim
{
    [UIView animateWithDuration:0.5 animations:^{
        self.payView.transform = CGAffineTransformMakeTranslation(0, 350);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
