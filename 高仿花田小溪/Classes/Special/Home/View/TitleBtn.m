//
//  TitleBtn.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "TitleBtn.h"

@implementation TitleBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self initBtn];
    }
    return self;
}

- (void)initBtn
{
    [self setTitle:@"主题" forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"hp_arrow_down"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"hp_arrow_up"] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self sizeToFit];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //设置按钮文字与图片的位置
    if (self.imageView.lx_x < self.titleLabel.lx_x) {
        self.titleLabel.lx_x = self.imageView.lx_x;
        self.imageView.lx_x = CGRectGetMaxX(self.titleLabel.frame) + 10;
    }
}
@end
