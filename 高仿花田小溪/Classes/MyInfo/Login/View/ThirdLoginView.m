//
//  ThirdLoginView.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/7/13.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "ThirdLoginView.h"
#import "UIImage+LXExtension.h"
@interface ThirdLoginView ()
Label_(titleLabel)
ImageView_(leftLine)
ImageView_(rightLine)
Button_(weixinBtn)
Button_(weiboBtn)
Button_(qqBtn)
@end

@implementation ThirdLoginView


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
    [self addSubview:self.titleLabel];
    [self addSubview:self.leftLine];
    [self addSubview:self.rightLine];
    [self addSubview:self.weixinBtn];
    [self addSubview:self.weiboBtn];
    [self addSubview:self.qqBtn];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.centerX.equalTo(self);
    }];
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(50, 1));
    }];
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.centerY.equalTo(self.titleLabel);
        make.size.equalTo(self.leftLine);
    }];
    [self.weixinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
    }];
    [self.weiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.weixinBtn);
    }];
    [self.qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-5);
        make.top.equalTo(self.weixinBtn);
    }];
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"第三方账号登陆";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:13];
    }
    return _titleLabel;
}
- (UIImageView *)leftLine
{
    if (!_leftLine) {
        _leftLine = [UIImageView new];
        
        _leftLine.image = [UIImage imageNamed:@"underLine"];
    }
    return _leftLine;
}
- (UIImageView *)rightLine
{
    if (!_rightLine) {
        _rightLine = [UIImageView new];
        _rightLine.image = [UIImage imageNamed:@"underLine"];
    }
    return _rightLine;
}

- (UIButton *)weixinBtn
{
    if (!_weixinBtn) {
        _weixinBtn = [self createBtnWithImageName:@"s_weixin_50"];
    }
    return _weixinBtn;
}
- (UIButton *)weiboBtn
{
    if (!_weiboBtn) {
        _weiboBtn = [self createBtnWithImageName:@"s_weibo_50"];
    }
    return _weiboBtn;
}
- (UIButton *)qqBtn
{
    if (!_qqBtn) {
        _qqBtn = [self createBtnWithImageName:@"s_qq_50"];
    }
    return _qqBtn;
}

- (UIButton *)createBtnWithImageName:(NSString *)imageName
{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageWithImageName:imageName Color:[UIColor blackColor]] forState:UIControlStateNormal];
    
    [btn sizeToFit];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


- (void)click:(UIButton *)btn
{
}

@end
