//
//  UserHeaderReusableView.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/7/12.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "UserHeaderReusableView.h"

@interface UserHeaderReusableView ()
//介绍
Label_(introduce)
View_(underLine1)//上部分割线
View_(underLine2)//底部分割线
@end

@implementation UserHeaderReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.introduce];
    [self addSubview:self.underLine1];
    [self addSubview:self.underLine2];
    
    
    self.introduce.center = CGPointMake(self.center.x, self.lx_height/2);
    //约束
    
    
    [self.underLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(0);
        make.height.equalTo(@1);
    }];
    
    [self.underLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(0);
        make.height.equalTo(@1);
    }];
}

- (UILabel *)introduce
{
    if (!_introduce) {
        _introduce = [UILabel new];
        _introduce.textColor = rgb255(164, 164, 164);
        _introduce.text = @"订阅";
        _introduce.font = [UIFont systemFontOfSize:14];
        [_introduce sizeToFit];
    }
    return _introduce;
}
- (UIView *)underLine1
{
    if (!_underLine1) {
        _underLine1 = [UIView new];
        _underLine1.backgroundColor = rgb255(164, 164, 164);
    }
    return _underLine1;
}
- (UIView *)underLine2
{
    if (!_underLine2) {
        _underLine2 = [UIView new];
        _underLine2.backgroundColor = rgb255(164, 164, 164);
    }
    return _underLine2;
}
@end
