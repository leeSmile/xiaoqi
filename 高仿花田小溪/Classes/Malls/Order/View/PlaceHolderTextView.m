//
//  PlaceHolderTextView.m
//  高仿花田小溪
//
//  Created by Lee on 16/7/18.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "PlaceHolderTextView.h"

@interface PlaceHolderTextView ()

@end

@implementation PlaceHolderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self addSubview:self.placeHolderLabel];
    

    self.placeHolderLabel.lx_x = 5;
    self.placeHolderLabel.lx_y = 8;


}
- (UILabel *)placeHolderLabel
{
    if (!_placeHolderLabel) {
        _placeHolderLabel = [UILabel new];
        _placeHolderLabel.font = [UIFont systemFontOfSize:12];
        _placeHolderLabel.textColor = [UIColor lightGrayColor];
        _placeHolderLabel.text = @"请在此处留下您想要的卡片内容, 限70汉字以内.";
        [_placeHolderLabel sizeToFit];
    }
    return _placeHolderLabel;
}

@end
