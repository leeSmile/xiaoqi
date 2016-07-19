//
//  DetailHeaderView.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/27.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "DetailHeaderView.h"

@interface DetailHeaderView()
/// 头像
ImageView_(headImgView)
/// z作者
Label_(authorLabel)
/// z称号
Label_(identityLabel)
/// 认证
ImageView_(authView)
/// 订阅数
Label_(subscriberLabel)
///定义按钮
Button_(subscriberBtn)
@end

@implementation DetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.authorLabel];
    [self addSubview:self.headImgView];
    [self addSubview:self.authView];
    [self addSubview:self.identityLabel];
    [self addSubview:self.subscriberBtn];
    [self addSubview:self.subscriberLabel];
    
    
    //添加约束
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(31, 31));
    }];
    
    [self.authView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headImgView);
        make.bottom.equalTo(self.headImgView);
        make.size.mas_equalTo(CGSizeMake(8, 8));
    }];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.headImgView.mas_right).offset(5);
    }];
    
    [self.identityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authorLabel.mas_right).offset(8);
        make.centerY.equalTo(self);
    }];
    
    [self.subscriberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50, 25));
    }];
    
    [self.subscriberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.subscriberBtn.mas_left).offset(-8);
        make.centerY.equalTo(self);
    }];
}

///
- (UILabel *)authorLabel
{
    if (!_authorLabel) {
        _authorLabel = [UILabel new];
        _authorLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:13.0];
        
    }
    return _authorLabel;
}


///
- (UILabel *)identityLabel
{
    if (!_identityLabel) {
        _identityLabel = [UILabel new];
        _identityLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:12.0];
        _identityLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
    }
    return _identityLabel;
}

///
- (UIImageView *)headImgView
{
    if (!_headImgView) {
        _headImgView = [UIImageView new];

        _headImgView.image = [UIImage imageNamed:@"p_avatar"];
        _headImgView.layer.cornerRadius = 31 * 0.5;
        _headImgView.layer.masksToBounds = YES;
        _headImgView.layer.borderWidth = 0.5;
        _headImgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
    }
    return _headImgView;
}

///
- (UIImageView *)authView
{
    if (!_authView) {
        _authView = [UIImageView new];
        
        _authView.image = [UIImage imageNamed:@"personAuth"];

    }
    return _authView;
}

///
- (UILabel *)subscriberLabel
{
    if (!_subscriberLabel) {
        _subscriberLabel = [UILabel new];
        _subscriberLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:12.0];
        _subscriberLabel.text = @"已有0人订阅";
        _subscriberLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    }
    return _subscriberLabel;
}

///
- (UIButton *)subscriberBtn
{
    if (!_subscriberBtn) {
        _subscriberBtn = [UIButton new];
        _subscriberBtn.backgroundColor = rgb255(255, 211, 117);
        [_subscriberBtn setTitle:@"订阅" forState:UIControlStateNormal];
        [_subscriberBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8] forState:UIControlStateNormal];
        [_subscriberBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _subscriberBtn.titleLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:12.0];
        _subscriberBtn.layer.cornerRadius = 3;
        _subscriberBtn.layer.masksToBounds = YES;
    }
    return _subscriberBtn;
}

- (void)setArticle:(Article *)article
{
    _article = article;

    [self.headImgView setImageWithURL:[NSURL URLWithString:article.author.headImg] placeholderImage:[UIImage imageNamed:@"p_avatar"]];
    self.authorLabel.text = article.author.userName;
    self.identityLabel.text = article.author.identity;
    self.subscriberLabel.text = [NSString stringWithFormat:@"已有%zd人订阅",article.author.subscibeNum];
    self.authView.image = article.author.authImage;
    
}

- (void)btnClick:(UIButton *)btn
{
    [[Tostal sharTostal] tostalMesg:@"订阅成功" tostalTime:1];
    if ([self.delegate respondsToSelector:@selector(clickHeaderView: didSelectBtn:)]) {
        [self.delegate clickHeaderView:self didSelectBtn:btn];
    }
}
@end
