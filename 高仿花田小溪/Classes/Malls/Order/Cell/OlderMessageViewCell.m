//
//  OlderMessageViewCell.m
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/7/18.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "OlderMessageViewCell.h"
#import "PlaceHolderTextView.h"
#import "NumButton.h"
@interface OlderMessageViewCell ()<UITextViewDelegate>
Label_(numLabel)// 文字:"购买数量"
DIYObj_(NumButton, numBtn)// "购买数量"
ImageView_(underLine)// 分割线
Label_(tipLabel)// 卡牌留言
DIYObj_(PlaceHolderTextView, messageView)// 留言板
@end

@implementation OlderMessageViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self.contentView addSubview:self.numLabel];
    [self.contentView addSubview:self.numBtn];
    [self.contentView addSubview:self.underLine];
    [self.contentView addSubview:self.tipLabel];
    [self.contentView addSubview:self.messageView];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@15);
    }];
    
    [self.numBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numLabel);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numLabel.mas_bottom).offset(15);
        make.left.equalTo(self.numLabel);
        make.right.equalTo(@0);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.underLine);
        make.top.equalTo(self.underLine.mas_bottom).offset(10);
    }];
    
    [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipLabel);
        make.right.equalTo(self.contentView).offset(-20);
        make.top.equalTo(self.tipLabel.mas_bottom).offset(10);
        make.height.equalTo(@60);
    }];
}
#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>0) {
        self.messageView.placeHolderLabel.hidden = YES;
    }else
    {
        self.messageView.placeHolderLabel.hidden = NO;
    }
    if (textView.text.length>140) {
        self.messageView.text = [textView.text substringToIndex:140];
    }
}

- (UILabel *)numLabel
{
    if (!_numLabel) {
        _numLabel = [UILabel new];
        _numLabel.font = [UIFont systemFontOfSize:12];
        _numLabel.textColor = [UIColor blackColor];
        _numLabel.text = @"购买数量";
    }
    return _numLabel;
}
- (NumButton *)numBtn
{
    if (!_numBtn) {
        _numBtn = [NumButton new];
        [_numBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _numBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_numBtn setBackgroundImage:[UIImage imageNamed:@"f_count_83x25"] forState:UIControlStateNormal];
        _numBtn.num = 1;
    }
    return _numBtn;
}
- (UIImageView *)underLine
{
    if (!_underLine) {
        _underLine = [UIImageView new];
        _underLine.image = [UIImage imageNamed:@"underLine"];
    }
    return _underLine;
}
- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.font = [UIFont systemFontOfSize:12];
        _tipLabel.textColor = [UIColor blackColor];
        _tipLabel.text = @"卡片留言";
    }
    return _tipLabel;
}
- (PlaceHolderTextView *)messageView
{
    if (!_messageView) {
        _messageView = [PlaceHolderTextView new];
        _messageView.delegate = self;
    }
    return _messageView;
}
- (void)setBuyNum:(int)buyNum
{
    _buyNum = buyNum;
    if (buyNum) {
        self.numBtn.num = buyNum;
    }
}
@end
