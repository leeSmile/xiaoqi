//
//  UIImage+LXExtension.m
//  高仿花田小憩OC版
//
//  Created by Lee on 16/7/17.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "UIImage+LXExtension.h"

@implementation UIImage (LXExtension)
+ (UIImage *)imageWithImageName:(NSString *)imageName Color:(UIColor *)color
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextClipToMask(context, rect, image.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    
    UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimage;
}
@end
