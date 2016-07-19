//
//  CategoryInfoView.m
//  高仿花田小憩OC版
//
//  Created by Lee on 16/7/9.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "CategoryInfoView.h"

@interface CategoryInfoView ()
//goto图标
Button_(gotoBtn)
// 描述信息
Label_(DescLabel)
// 名称
Label_(titleLabel)

@end


@implementation CategoryInfoView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self addSubview:self.gotoBtn];
    [self addSubview:self.DescLabel];
    [self addSubview:self.titleLabel];
    
    //约束
    [self.DescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(12);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.DescLabel);
        make.top.equalTo(self.DescLabel.mas_bottom).offset(5);
    }];
    
    [self.gotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-20);
    }];
}
- (UIButton *)gotoBtn
{
    if (!_gotoBtn) {
        _gotoBtn = [UIButton new];
        [_gotoBtn setBackgroundImage:[UIImage imageNamed:@"goto"] forState:UIControlStateNormal];
        _gotoBtn.userInteractionEnabled = NO;
        
    }
    return _gotoBtn;
}

- (UILabel *)DescLabel
{
    if (!_DescLabel) {
        _DescLabel = [UILabel new];
        _DescLabel.textColor = [UIColor blackColor];
        _DescLabel.font = [UIFont systemFontOfSize:14];
    }
    return _DescLabel;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (void)setMalls:(MallsGoods *)malls
{
    _malls = malls;
    self.DescLabel.text = malls.fnDesc;
    self.titleLabel.text = malls.fnName;
}
@end
