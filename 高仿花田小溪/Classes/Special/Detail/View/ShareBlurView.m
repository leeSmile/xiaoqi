//
//  ShareBlurView.m
//  高仿花田小憩OC版
//
//  Created by Lee on 16/6/27.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "ShareBlurView.h"
static float DefaultMargin20 = 20;
static float DefaultImageWh = 66;
static float DefaultShareH = 70.0;

@interface ShareBlurView ()
// 分享按钮的父视图
View_(shareView)
ImageView_(wechat)
ImageView_(wesseion)
ImageView_(weibo)
ImageView_(qq)

@end

@implementation ShareBlurView

- (instancetype)initWithEffect:(UIVisualEffect *)effect
{
    if ([super initWithEffect:effect]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.alpha = 0.77;//高斯效果
    
    CGFloat margin = (MY_WIHTE - DefaultMargin20 * 2 - DefaultImageWh * 4) / 3.0;
    [self.contentView addSubview:self.shareView];
    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(DefaultMargin20));
        make.left.right.equalTo(self);
        make.height.equalTo(@(DefaultShareH));

    }];

    
    
    [self.shareView addSubview:self.wechat];
    [self.shareView addSubview:self.wesseion];
    [self.shareView addSubview:self.weibo];
    [self.shareView addSubview:self.qq];
    
    [self.wechat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(DefaultMargin20));
        make.centerY.equalTo(self.shareView);
        make.size.mas_equalTo(CGSizeMake(DefaultImageWh, DefaultImageWh));
    }];
    
    [self.wesseion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wechat.mas_right).offset(margin);
        make.centerY.equalTo(self.shareView);
        make.size.equalTo(self.wechat);
    }];

    [self.weibo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wesseion.mas_right).offset(margin);
        make.centerY.equalTo(self.shareView);
        make.size.equalTo(self.wechat);

    }];

    [self.qq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.weibo.mas_right).offset(margin);
        make.centerY.equalTo(self.shareView);
        make.size.equalTo(self.wechat);
    }];

}

- (UIView *)shareView
{
    if (!_shareView) {
        _shareView = [UIView new];
//        _shareView.backgroundColor = [UIColor blackColor];
    }
    return _shareView;
}

- (UIImageView *)wechat
{
    if (!_wechat) {
        _wechat = [UIImageView new];
        _wechat.image = [UIImage imageNamed:@"s_weixin_50x50"];
//        _wechat.backgroundColor = [UIColor redColor];
    }
    return _wechat;
}

- (UIImageView *)wesseion
{
    if (!_wesseion) {
        _wesseion = [UIImageView new];
        _wesseion.image = [UIImage imageNamed:@"s_pengyouquan_50x50"];
    }
    return _wesseion;
}

- (UIImageView *)weibo
{
    if (!_weibo) {
        _weibo = [UIImageView new];
        _weibo.image = [UIImage imageNamed:@"s_weibo_50x50"];
    }
    return _weibo;
}

- (UIImageView *)qq
{
    if (!_qq) {
        _qq = [UIImageView new];
        _qq.image = [UIImage imageNamed:@"s_qq_50x50"];
    }
    return _qq;
}
- (void)startAnim
{
    self.shareView.transform = CGAffineTransformMakeTranslation(0, -DefaultShareH);
    [UIView animateWithDuration:0.5 animations:^{
        self.shareView.transform = CGAffineTransformIdentity;
    }];
}
- (void)endAnim
{
    [UIView animateWithDuration:0.5 animations:^{
        self.shareView.transform = CGAffineTransformMakeTranslation(0, -DefaultShareH);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
