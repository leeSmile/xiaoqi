//
//  MallsCategoryHeader.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MallsCategoryHeader.h"
#import "TitleBtn.h"
@interface MallsCategoryHeader()


DIYObj_(TitleBtn, btn)
@end


@implementation MallsCategoryHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        //初始化子控件
        [self setUpHeader];
        
    }
    return self;
}

- (void)setUpHeader
{
    [self addSubview:self.btn];
    self.isShow = NO;
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.height.equalTo(@44);
        make.centerY.equalTo(self);
        make.left.equalTo(self);
    }];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.btn setTitle:[NSString stringWithFormat:@"%@     ",self.title] forState:UIControlStateNormal];
}

- (TitleBtn *)btn
{
    if (!_btn) {
        _btn = [[TitleBtn alloc] init];
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)click:(UIButton *)btn
{
    self.isShow = btn.selected;
    btn.selected =!btn.selected;
    if ([self.delegate respondsToSelector:@selector(mallsCategoryHeaderchick:)]) {
        [self.delegate mallsCategoryHeaderchick:self];
    }
}

@end
