//
//  PayItemView.m
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/7/19.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "PayItemView.h"

@interface PayItemView ()

ImageView_(payIcon)// 所用支付的icon
Label_(payTitle)// 所用支付的名字
Label_(payDes)// 所用支付的描述
Button_(checkBox)// 选择按钮
ImageView_(underLine)// 下划线
@end

@implementation PayItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self addSubview:self.payIcon];
    [self addSubview:self.payTitle];
    [self addSubview:self.payDes];
    [self addSubview:self.underLine];
    [self addSubview:self.checkBox];
    
    //约束
    [self.payIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.payTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payIcon);
        make.left.equalTo(self.payIcon.mas_right).offset(15);
    }];
    
    [self.payDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.payIcon);
        make.left.equalTo(self.payTitle);
    }];
    
    [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(@0);
        make.height.equalTo(@1);
        make.bottom.equalTo(self);
    }];
    
    [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15);
    }];
}

- (UIImageView *)payIcon
{
    if (!_payIcon) {
        _payIcon = [UIImageView new];
    }
    return _payIcon;
}
- (UILabel *)payTitle
{
    if (!_payTitle) {
        _payTitle = [UILabel new];
        _payTitle.font = [UIFont systemFontOfSize:14];
        _payTitle.textColor = [UIColor blackColor];
    }
    return _payTitle;
}
- (UILabel *)payDes
{
    if (!_payDes) {
        _payDes = [UILabel new];
        _payDes.font = [UIFont systemFontOfSize:14];
        _payDes.textColor = [UIColor blackColor];
    }
    return _payDes;
}
- (UIButton *)checkBox
{
    if (!_checkBox) {
        _checkBox = [UIButton title:nil imageName:@"f_adressUnSel_18x18" target:nil selector:nil font:nil titleColor:nil];
        [_checkBox setImage:[UIImage imageNamed:@"f_adressSel_17x17"] forState:UIControlStateSelected];
        _checkBox.userInteractionEnabled = NO;
    }
    return _checkBox;
}
- (UIImageView *)underLine
{
    if (!_underLine) {
        _underLine = [UIImageView new];
        _underLine.image = [UIImage imageNamed:@"underLine"];
    }
    return _underLine;
}
- (void)setPayInfo:(Pay *)payInfo
{
    _payInfo = payInfo;
    
    self.payIcon.image = payInfo.icon;
    self.payTitle.text = payInfo.title;
    self.payDes.text = payInfo.des;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    self.checkBox.selected = selected;
}
@end
