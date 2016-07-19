
//
//  NumButton.m
//  高仿花田小溪
//
//  Created by Lee on 16/7/18.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "NumButton.h"

@interface NumButton ()
@end

@implementation NumButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.num = 1;
    }
    return self;
}
- (void)setNum:(int)num
{
    _num = num;
    if (num < 1) {
        [[Tostal sharTostal] tostalMesg:@"购买数量不能小于1, 亲" tostalTime:1];
    }else if (num > 99){
    
        [[Tostal sharTostal] tostalMesg:@"企业购买请联系我们的客服" tostalTime:1];
    }
    [self setTitle:[NSString stringWithFormat:@"%zd",num] forState:UIControlStateNormal];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //取出当前点击的点
    UITouch *touch = touches.anyObject;
    // 获取point
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(CGRectMake(0, 0, self.lx_width*0.5, self.lx_height), point)) {
        if (self.num == 0) {
            
            return;
        }
        self.num -= 1;
    }else
    {
        self.num += 1;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BuyNumNotifyName object:nil userInfo:@{BuyNumKey: @(self.num)}];
}
@end
