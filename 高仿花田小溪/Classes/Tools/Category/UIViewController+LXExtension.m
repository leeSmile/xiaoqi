//
//  UIViewController+LXExtension.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/7/17.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "UIViewController+LXExtension.h"

@implementation UIViewController (LXExtension)
-(void)customTitle:(NSString *)title
{
    UILabel *customLab = [[UILabel alloc] init];
    customLab.font = [UIFont fontWithName:@"CODE LIGHT" size:17];
    customLab.textColor = [UIColor blackColor];
    customLab.text = title;
    [customLab sizeToFit];
    self.navigationItem.titleView = customLab;
}

@end
