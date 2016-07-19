//
//  LoginInputView.h
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/7/15.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginInputView : UIView
ImageView_(undLine)
ImageView_(iconView)
TextField_(textFiled)
Button_(locationBtn)
Button_(safeBtn)
- (instancetype)initWithIconName:(NSString *)iconName placeHolder:(NSString *)placeHolder isLocation:(BOOL)isLocation isPhone:(BOOL)isPhone isSafe:(BOOL)isSafe;
@end
