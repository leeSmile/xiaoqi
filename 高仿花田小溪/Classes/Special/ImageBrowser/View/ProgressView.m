//
//  ProgressView.m
//  高仿花田小憩OC版
//
//  Created by Lee on 16/6/28.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView
- (void)setProgress:(float)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (self.progress > 1) {
        return;
    }
    ;
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = rect.size.width * 0.4;
    CGFloat startAngle = -(CGFloat)M_PI_2;
    CGFloat endAngle = (CGFloat)M_PI * 2 * self.progress + startAngle;
    //画圆弧
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];

    path.lineWidth = 3;
    [[UIColor whiteColor] setStroke];
    [path stroke];
}

@end
