//
//  OlderBottomView.m
//  高仿花田小溪
//
//  Created by Lee on 16/7/18.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "OlderBottomView.h"

@interface OlderBottomView ()
View_(leftView)// 左边的视图
Button_(entryBtn)// 确认按钮
Label_(totalPriceLabel)// 总价

@end

@implementation OlderBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = Color(241);
    [self addSubview:self.leftView];
    [self.leftView addSubview:self.totalPriceLabel];
    [self addSubview:self.entryBtn];
    
    //约束
    [self.entryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self);
        make.top.equalTo(@5);
        make.width.equalTo(@100);
    }];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self);
        make.top.equalTo(@5);
        make.right.equalTo(self.entryBtn.mas_left);

    }];
    
    [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(self.leftView);
    }];
}
- (UIView *)leftView
{
    if (!_leftView) {
        _leftView = [UIView new];
        _leftView.backgroundColor = [UIColor whiteColor];
    }
    return _leftView;
}

- (UILabel *)totalPriceLabel
{
    if (!_totalPriceLabel) {
        _totalPriceLabel = [UILabel new];
        _totalPriceLabel.font = [UIFont systemFontOfSize:15];
        _totalPriceLabel.textColor = [UIColor blackColor];
    }
    return _totalPriceLabel;
}
- (UIButton *)entryBtn
{
    if (!_entryBtn) {
        _entryBtn = [UIButton title:@"确认" imageName:nil target:self selector:@selector(clickEntry) font:[UIFont systemFontOfSize:15] titleColor:[UIColor whiteColor]];
        _entryBtn.backgroundColor = [UIColor blackColor];
    }
    return _entryBtn;
}
- (void)setTotalPrice:(NSString *)totalPrice
{
    _totalPrice = totalPrice;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计： ￥%@.0",totalPrice];
}
- (void)clickEntry
{
    if ([self.delegate respondsToSelector:@selector(OlderBottomViewEntryToBuyTotalPrice:)]) {
        [self.delegate OlderBottomViewEntryToBuyTotalPrice:self.totalPrice];
    }
}
@end
