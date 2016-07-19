//
//  UIButton+Extension.h
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/25.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)
+ (UIButton *)title:(NSString *)title imageName:(NSString *)imageName target:(id)target selector:( SEL)selector font:(UIFont *)font titleColor:(UIColor *)titleColor;
@end
