//
//  CommentBottomView.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/29.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "CommentBottomView.h"

@interface CommentBottomView ()

Button_(sendBtn)
ImageView_(underLine)
@end

@implementation CommentBottomView


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
    [self addSubview:self.textFiled];
    [self addSubview:self.sendBtn];
    [self addSubview:self.underLine];
    
    //约束
    [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@1);
    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(@40);
    }];
    
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.centerY.equalTo(self.sendBtn);
        make.left.equalTo(@15);
        make.right.equalTo(self.sendBtn.mas_left).offset(-10);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
}

- (UITextField *)textFiled
{
    if (!_textFiled) {
        _textFiled = [UITextField new];
        _textFiled.background = [UIImage imageNamed:@"s_bg_3rd_292x43"];
        _textFiled.placeholder = @" 评论";
        _textFiled.font = [UIFont systemFontOfSize:12];
        
        //设置占位文字的字体
//        [_textFiled setValue:[UIFont systemFontOfSize:12] forKey:@"placeholderLabel.font"];
    }
    return _textFiled;
}

- (UIButton *)sendBtn
{
    if (!_sendBtn) {
        _sendBtn = [UIButton title:@"发送" imageName:nil target:self selector:@selector(sendMessage) font:[UIFont systemFontOfSize:13] titleColor:[UIColor blackColor]];
      
    }
    return _sendBtn;
}

- (UIImageView *)underLine
{
    if (!_underLine) {
        _underLine = [UIImageView new];
        _underLine.image = [UIImage imageNamed:@"underLine"];
    }
    return _underLine;
}

- (void)setPlaceHolderStr:(NSString *)placeHolderStr
{
    _placeHolderStr = placeHolderStr;
    
    self.textFiled.placeholder = [NSString stringWithFormat:@"回复：%@",placeHolderStr];
    [self.textFiled becomeFirstResponder];
    
}

- (void)sendMessage
{
    if (self.textFiled.text.length < 1) {
        [[Tostal sharTostal] tostalMesg:@"不能发送空消息" tostalTime:1];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(commentBottomView: sendMessage: replyComment:)]) {
        [self.delegate commentBottomView:self sendMessage:self.textFiled.text replyComment:self.comment];
    }
    
    self.textFiled.text = nil;
}

- (void)keyboardDidChangeFrame:(NSNotification *)notification
{
    CGRect rect = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    //如果是隐藏键盘
    if (rect.origin.y == MY_HEIGHT) {
        self.placeHolderStr = nil;
        self.comment = nil;

    }
    if ([self.delegate respondsToSelector:@selector(commentBottomView: keyboradFrameChange:)]) {
        [self.delegate commentBottomView:self keyboradFrameChange:notification.userInfo];
    }
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    if ([self.delegate respondsToSelector:@selector(commentBottomView: keyboardWillHide:)]) {
        [self.delegate commentBottomView:self keyboardWillHide:notification.userInfo];
    }
}
//- (void)keyboardWillShow:(NSNotification *)notification
//{
//    if ([self.delegate respondsToSelector:@selector(commentBottomView: keyboardWillShow:)]) {
//        [self.delegate commentBottomView:self keyboardWillShow:notification.userInfo];
//    }
//}
@end
