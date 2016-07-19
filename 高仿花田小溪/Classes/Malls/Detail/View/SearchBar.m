
//
//  SearchBar.m
//  高仿花田小憩OC版
//
//  Created by Lee on 16/7/11.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "SearchBar.h"

@interface SearchBar ()<UITextFieldDelegate>

Button_(cancelBtn)
@end

@implementation SearchBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self initBar];
    }
    return self;
}
- (void)clearText
{
    self.filed.text = @"";
}
- (void)initBar
{
    self.backgroundColor = Color(247);
    
    [self addSubview:self.filed];
    [self addSubview:self.cancelBtn];
    
    //约束
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-10));
        make.top.height.equalTo(self);
        make.width.equalTo(@40);

    }];
    
    [self.filed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(self.cancelBtn.mas_left).offset(-5);
        make.height.equalTo(@27);
        make.centerY.equalTo(self.cancelBtn);
    }];
}

- (UITextField *)filed
{
    if (!_filed) {
        _filed = [UITextField new];
        _filed.background = [UIImage imageNamed:@"hp_search_bg_259x27_"];
        //占位
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 0)];
        _filed.leftView = view;
        
        _filed.leftViewMode = UITextFieldViewModeAlways;
        _filed.font = [UIFont systemFontOfSize:13];
        _filed.placeholder = @"请输入搜索关键字";
//        [_filed setValue:[UIFont systemFontOfSize:13] forKey:@"_placeholderLabel.font"];
        _filed.returnKeyType = UIReturnKeySearch;
        _filed.delegate = self;
        _filed.enablesReturnKeyAutomatically  = YES;//没文字时不可点击
    }
    return _filed;
}
- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton title:@"取消" imageName:nil target:self selector:@selector(cancel) font:[UIFont systemFontOfSize:14] titleColor:[UIColor blackColor]];
    }
    return _cancelBtn;
}


- (void)cancel
{
    if ([self.delegate respondsToSelector:@selector(searchBarDidCancel:)]) {
        [self.delegate searchBarDidCancel:self];
    }
}

#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(searchBar: search:)]) {
        [self.delegate searchBar:self search:textField.text];
    }

    return YES;
}
@end
