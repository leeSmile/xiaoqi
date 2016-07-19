//
//  MallsTopMenuView.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/7/10.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MallsTopMenuView.h"

@interface MallsTopMenuView ()
//精选
Button_(choiceness)
//商城
Button_(mall)
//积分
Button_(integral)
//View_(underLine1)//上部分割线
View_(underLine2)//底部分割线
View_(tipLine)//底部跟着滚动的短线

@end

@implementation MallsTopMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.lx_height = 40;
    self.lx_width = MY_WIHTE;
    
    [self addSubview:self.choiceness];
    [self addSubview:self.mall];
    [self addSubview:self.integral];
//    [self addSubview:self.underLine1];
    [self addSubview:self.underLine2];
    [self addSubview:self.tipLine];
    
    self.backgroundColor = [UIColor whiteColor];
    
    
    //不清楚为什么  self.introduce.center = self.center;  为什么y值就不对？
    self.mall.center = CGPointMake(self.center.x, self.lx_height/2);
    
    CGFloat centerX1 = self.mall.lx_x * 0.5;
    CGFloat centerY1 = self.mall.lx_centerY;
    self.choiceness.lx_centerX =centerX1;
    self.choiceness.lx_centerY =centerY1;
    
    CGFloat maxIntroduceX = self.mall.lx_x +self.mall.lx_width;
    CGFloat centerX2 = (MY_WIHTE - maxIntroduceX) * 0.5 + maxIntroduceX;
    CGFloat centerY2 = self.mall.lx_centerY;
    self.integral.lx_centerX =centerX2;
    self.integral.lx_centerY =centerY2;
    
//    [self.underLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.top.equalTo(self).offset(0);
//        make.height.equalTo(@1);
//    }];
    
    [self.underLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(@(self.lx_height));
        make.height.equalTo(@1);
    }];
    [self.tipLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.choiceness.mas_left);
        make.width.equalTo(self.choiceness.mas_width);
        make.bottom.equalTo(self.underLine2.mas_top);
        make.height.equalTo(@2);
        
    }];
    
}


- (UIButton *)choiceness
{
    if (!_choiceness) {
        _choiceness = [UIButton title:@"精选" imageName:nil target:self selector:@selector(clickBtn:) font:[UIFont systemFontOfSize:13] titleColor:[UIColor lightGrayColor]];
//        _choiceness.backgroundColor = [UIColor grayColor];
        _choiceness.lx_height = 30;
        _choiceness.lx_width = 30;
//        [_choiceness sizeToFit];
    }
    return _choiceness;
}

- (UIButton *)mall
{
    if (!_mall) {
        _mall = [UIButton title:@"商城" imageName:nil target:self selector:@selector(clickBtn:) font:[UIFont systemFontOfSize:13] titleColor:[UIColor lightGrayColor]];
//        _mall.backgroundColor = [UIColor grayColor];
        [_mall addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//        [_mall sizeToFit];
        _mall.lx_height = 30;
        _mall.lx_width = 30;
    }
    return _mall;
}

- (UIButton *)integral
{
    if (!_integral) {
        _integral = [UIButton title:@"积分" imageName:nil target:self selector:@selector(clickBtn:) font:[UIFont systemFontOfSize:13] titleColor:[UIColor lightGrayColor]];
        [_integral addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//        _integral.backgroundColor = [UIColor grayColor];
        [_integral sizeToFit];
    }
    return _integral;
}

//- (UIView *)underLine1
//{
//    if (!_underLine1) {
//        _underLine1 = [UIView new];
//        _underLine1.backgroundColor = rgb255(164, 164, 164);
//    }
//    return _underLine1;
//}
- (UIView *)underLine2
{
    if (!_underLine2) {
        _underLine2 = [UIView new];
        _underLine2.backgroundColor = rgb255(164, 164, 164);
    }
    return _underLine2;
}
- (UIView *)tipLine
{
    if (!_tipLine) {
        _tipLine = [UIView new];
        _tipLine.backgroundColor = [UIColor blackColor];
    }
    return _tipLine;
}
- (void)clickBtn:(UIButton *)btn
{
    if (btn == self.choiceness) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tipLine.lx_centerX = self.choiceness.lx_centerX;
        }];
        
        
        if ([self.delegate respondsToSelector:@selector(commentViewCell: didClickBtn: )]) {
            [self.delegate commentViewCell:self didClickBtn:Choiceness];
        }
        
    }else if (btn == self.mall){
        [UIView animateWithDuration:0.25 animations:^{
            self.tipLine.lx_centerX = self.mall.lx_centerX;
        }];
        
        
        if ([self.delegate respondsToSelector:@selector(commentViewCell: didClickBtn: )]) {
            [self.delegate commentViewCell:self didClickBtn:Mall];
        }
        
    }else if (btn == self.integral){
        [UIView animateWithDuration:0.25 animations:^{
            self.tipLine.lx_centerX = self.integral.lx_centerX;
        }];
        
        if ([self.delegate respondsToSelector:@selector(commentViewCell: didClickBtn: )]) {
            [self.delegate commentViewCell:self didClickBtn:Integral];
        }
        
    }
    
    
}


@end
