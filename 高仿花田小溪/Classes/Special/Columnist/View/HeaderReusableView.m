//
//  HeaderReusableView.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/30.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "HeaderReusableView.h"

@interface HeaderReusableView ()
//专栏
Button_(column)
//介绍
Button_(introduce)
//订阅者
Button_(subscriber)
View_(underLine1)//上部分割线
View_(underLine2)//底部分割线
View_(tipLine)//底部跟着滚动的短线
@end

@implementation HeaderReusableView


- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self addSubview:self.column];
    [self addSubview:self.introduce];
    [self addSubview:self.subscriber];
    [self addSubview:self.underLine1];
    [self addSubview:self.underLine2];
    [self addSubview:self.tipLine];
    
    self.backgroundColor = [UIColor whiteColor];
    

    //不清楚为什么  self.introduce.center = self.center;  为什么y值就不对？
    self.introduce.center = CGPointMake(self.center.x, self.lx_height/2);
    
    CGFloat centerX1 = self.introduce.lx_x * 0.5;
    CGFloat centerY1 = self.introduce.lx_centerY;
    self.column.lx_centerX =centerX1;
    self.column.lx_centerY =centerY1;
    
    CGFloat maxIntroduceX = self.introduce.lx_x +self.introduce.lx_width;
    CGFloat centerX2 = (MY_WIHTE - maxIntroduceX) * 0.5 + maxIntroduceX;
    CGFloat centerY2 = self.introduce.lx_centerY;
    self.subscriber.lx_centerX =centerX2;
    self.subscriber.lx_centerY =centerY2;
    
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
    [self.tipLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.column.mas_left);
        make.width.equalTo(self.column.mas_width);
        make.bottom.equalTo(self.underLine2.mas_top);
        make.height.equalTo(@2);
        
    }];
//另外在这里用Mansonry为什么就位置错误
    
//    [self.introduce mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(30, 30));
//        make.center.mas_equalTo(self);
//
//    }];
    
//    CGFloat centerX1 = self.introduce.lx_x * 0.5;//0  96
//    CGFloat centerY1 = self.introduce.lx_centerY;//150  20
//    [self.column mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.center.mas_equalTo(CGPointMake(centerX1, centerY1));
////        make.centerX.equalTo(self).offset(centerX1);
////        make.centerY.equalTo(self).offset(centerY1);
//        make.centerX.equalTo(@(centerX1));
//        make.centerY.equalTo(@(centerY1));
//    }];
    
////    CGRectGetMaxX(self.introduce.frame);
//    CGFloat maxIntroduceX = self.introduce.lx_x +self.introduce.lx_width;//30  20
//    CGFloat centerX2 = (MY_WIHTE - maxIntroduceX) * 0.5 + maxIntroduceX;//222  318
//    CGFloat centerY2 = self.introduce.lx_centerY;//150
//    [self.subscriber mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(CGPointMake(centerX2, centerY2));
//    }];
    
//    [self layoutIfNeeded];

}



- (UIButton *)column
{
    if (!_column) {
        _column = [UIButton title:@"专栏" imageName:nil target:self selector:@selector(clickBtn:) font:[UIFont systemFontOfSize:13] titleColor:[UIColor lightGrayColor]];
        [_column sizeToFit];
    }
    return _column;
}

- (UIButton *)introduce
{
    if (!_introduce) {
        _introduce = [UIButton title:@"介绍" imageName:nil target:self selector:@selector(clickBtn:) font:[UIFont systemFontOfSize:13] titleColor:[UIColor lightGrayColor]];
        [_introduce sizeToFit];
    }
    return _introduce;
}

- (UIButton *)subscriber
{
    if (!_subscriber) {
        _subscriber = [UIButton title:@"订阅者" imageName:nil target:self selector:@selector(clickBtn:) font:[UIFont systemFontOfSize:13] titleColor:[UIColor lightGrayColor]];
        [_subscriber sizeToFit];
    }
    return _subscriber;
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
    if (btn == self.column) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tipLine.lx_centerX = self.column.lx_centerX;
        }];
        
        
        if ([self.delegate respondsToSelector:@selector(commentViewCell: didClickBtn: )]) {
            [self.delegate commentViewCell:self didClickBtn:Column];
        }
        
    }else if (btn == self.introduce){
        [UIView animateWithDuration:0.25 animations:^{
            self.tipLine.lx_centerX = self.introduce.lx_centerX;
        }];

        
        if ([self.delegate respondsToSelector:@selector(commentViewCell: didClickBtn: )]) {
            [self.delegate commentViewCell:self didClickBtn:Introduce];
        }
        
    }else if (btn == self.subscriber){
        [UIView animateWithDuration:0.25 animations:^{
            self.tipLine.lx_centerX = self.subscriber.lx_centerX;
        }];
    
        if ([self.delegate respondsToSelector:@selector(commentViewCell: didClickBtn: )]) {
            [self.delegate commentViewCell:self didClickBtn:Subscriber];
        }
        
    }

    
}
@end
