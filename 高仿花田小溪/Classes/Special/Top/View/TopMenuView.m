//
//  TopMenuView.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/6/26.
//  Copyright © 2016年 Lee. All rights reserved.
//
#import "TopMenuView.h"

@interface TopMenuView()
View_(underLine)//底部分割线
Button_(authorBtn)//作者按钮
Button_(articleBtn)//文字按钮
View_(tipLine)//底部跟着滚动的短线

Label_(authorLab)//作者文字
Label_(articleLab)//文字文字
@end

@implementation TopMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI
{

    [self addSubview:self.authorLab];
    [self addSubview:self.articleLab];
    
    [self addSubview:self.underLine];
    [self addSubview:self.authorBtn];
    [self addSubview:self.articleBtn];
    [self addSubview:self.tipLine];
    
    //mansony又不好使了
    //专栏
//    [self.articleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(self);
//        make.centerX.equalTo(self.mas_left).offset(articleLabCentX);
//    }];
    
//    self.authorLab.lx_x = self.articleLab.lx_x + self.articleLab.lx_width;
    
//    [self.authorLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(self);
//        make.centerX.equalTo(@(authorLabCentX));
//    }];
    
    
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    float articleLabCentX = MY_WIHTE/3;
    float authorLabCentX = MY_WIHTE/3 * 2;

    self.articleLab.lx_centerX = articleLabCentX;
    self.articleLab.lx_centerY = self.lx_height/2;
    
    self.authorLab.lx_centerX = authorLabCentX;
    self.authorLab.lx_centerY = self.lx_height/2;
    
    [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-1);
        make.height.equalTo(@1);
    }];
    
    [self.authorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
        make.left.equalTo(self.articleBtn.mas_right);
        make.size.equalTo(self.articleBtn);
    }];
    
    [self.articleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.height.equalTo(self);
        make.width.equalTo(self.authorBtn);
    }];
    
    
    [self.tipLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.articleLab.mas_left);
        make.width.equalTo(self.articleLab.mas_width);
        make.bottom.equalTo(self.underLine.mas_top);
        make.height.equalTo(@2);
        
    }];
}

- (UIView *)underLine
{
    if (!_underLine) {
        _underLine = [UIView new];
        _underLine.backgroundColor = rgb255(164, 164, 164);
    }
    return _underLine;
}
- (UIButton *)authorBtn
{
    if (!_authorBtn) {
        _authorBtn = [UIButton new];
        [_authorBtn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _authorBtn;
}
- (UIButton *)articleBtn
{
    if (!_articleBtn) {
        _articleBtn = [UIButton new];
        [_articleBtn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _articleBtn;
}

- (UIView *)tipLine
{
    if (!_tipLine) {
        _tipLine = [UIView new];
        _tipLine.backgroundColor = [UIColor blackColor];
    }
    return _tipLine;
}

- (UILabel *)authorLab
{
    if (!_authorLab) {
        _authorLab = [UILabel new];
        _authorLab.text = @"作者";
//        _authorLab.frame = CGRectMake(20, 20, 20, 20);
//        _authorLab.textColor = [UIColor blueColor];
//        _authorLab.backgroundColor = [UIColor redColor];
        [_authorLab sizeToFit];
    }
    return _authorLab;
}
- (UILabel *)articleLab
{
    if (!_articleLab) {
        _articleLab = [UILabel new];
        _articleLab.text = @"专栏";
//        _articleLab.backgroundColor = [UIColor redColor];
        [_articleLab sizeToFit];
    }
    return _articleLab;
}

- (void)clickbtn:(UIButton *)btn
{
    if (btn == self.articleBtn) {
        float lineLeft = self.articleLab.lx_x;
        [self.tipLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(lineLeft));
        }];
        //响应点击事件
        if ([self.delegate respondsToSelector:@selector(topMenuView: selectedTopAction:)]) {
            [self.delegate topMenuView:self selectedTopAction:TopContents];
        }
        
    }else
    {
        float lineLeft = self.authorLab.lx_x;
        [self.tipLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(lineLeft));
        }];
        //响应点击事件
        if ([self.delegate respondsToSelector:@selector(topMenuView: selectedTopAction:)]) {
            [self.delegate topMenuView:self selectedTopAction:TopArticleAuthor];
        }
    }

    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
    
    
}
@end
