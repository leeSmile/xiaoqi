//
//  countryHeadView.m
//  高仿花田小憩OC版
//
//  Created by Lee on 16/7/16.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "countryHeadView.h"

@interface countryHeadView ()
TextField_(filed)
@end

@implementation countryHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.filed];
    
    [self.filed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.right.bottom.equalTo(@(-10));
    }];
}
- (UITextField *)filed
{
    if (!_filed) {
        _filed = [UITextField new];
        _filed.backgroundColor = [UIColor whiteColor];
        _filed.borderStyle = UITextBorderStyleRoundedRect;
        
        //占位

        UIImageView *image = [[UIImageView alloc] init];
        image.image = [UIImage imageNamed:@"f_search"];
        image.frame = CGRectMake(0, 0, 15, 15);
        image.lx_x = MY_WIHTE/2;
        image.lx_centerY = self.lx_height/2;
        _filed.leftView = image;
        
        _filed.leftViewMode = UITextFieldViewModeAlways;
        _filed.font = [UIFont systemFontOfSize:13];
        
        _filed.returnKeyType = UIReturnKeySearch;
//        _filed.delegate = self;
        _filed.enablesReturnKeyAutomatically  = YES;//没文字时不可点击
    }
    return _filed;
}
@end
