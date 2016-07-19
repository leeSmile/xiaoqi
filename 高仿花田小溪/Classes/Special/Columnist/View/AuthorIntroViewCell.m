//
//  AuthorIntroViewCell.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/30.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "AuthorIntroViewCell.h"

@interface AuthorIntroViewCell ()
/// 订阅按钮
Button_(subscribeBtn)
/// 订阅数
Label_(subscribeLable)
/// 称号
Label_(identityLabel)
/// 认证
ImageView_(authView)
@end

@implementation AuthorIntroViewCell

- (void)setup
{
    [super setup];
    
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.subscribeBtn];
    [self.contentView addSubview:self.subscribeLable];
    [self.contentView addSubview:self.identityLabel];
    [self.contentView addSubview:self.authView];
    
    
    //约束
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(51, 51));
    }];
    
    [self.authView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.headImgView);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImgView).offset(2);
        make.left.equalTo(self.headImgView.mas_right).offset(10);
    }];
    
    [self.identityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorLabel).offset(2);
        make.left.equalTo(self.authorLabel.mas_right).offset(15);
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorLabel.mas_bottom).offset(10);
        make.left.equalTo(self.authorLabel);
    }];
    
    [self.subscribeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.desLabel).offset(3);
    }];
    
    [self.subscribeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImgView.mas_bottom).offset(10);
        make.left.equalTo(self.headImgView);
        make.right.equalTo(self.subscribeLable);
        make.height.equalTo(@30);
    }];
    
}

- (void)setAuthor:(Author *)author
{
    [super setAuthor:author];
    self.identityLabel.text = author.identity;
    self.authView.image = author.authImage;
    self.subscribeLable.text = [NSString stringWithFormat:@"已有%zd人订阅",author.subscibeNum];
}
- (UIButton *)subscribeBtn
{
    if (!_subscribeBtn) {
        _subscribeBtn = [UIButton title:@"订阅" imageName:nil target:self selector:@selector(subscribe) font:[UIFont systemFontOfSize:14] titleColor:[UIColor blackColor]];
        [_subscribeBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn"] forState:UIControlStateNormal];
        
    }
    return _subscribeBtn;
}

- (UILabel *)subscribeLable
{
    if (!_subscribeLable) {
        _subscribeLable = [UILabel new];
        _subscribeLable.font = [UIFont systemFontOfSize:13];
        _subscribeLable.textColor = [UIColor lightGrayColor];
    }
    return _subscribeLable;
}
- (UILabel *)identityLabel
{
    if (!_identityLabel) {
        _identityLabel = [UILabel new];
        _identityLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:12];
        _identityLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        _identityLabel.text = @"资深专家";
    }
    return _identityLabel;
}
- (UIImageView *)authView
{
    if (!_authView) {
        _authView = [UIImageView new];
        _authView.image = [UIImage imageNamed:@"personAuth"];

    }
    return _authView;
}


- (void)subscribe
{
    [[Tostal sharTostal] tostalMesg:@"订阅" tostalTime:2];
}
@end
