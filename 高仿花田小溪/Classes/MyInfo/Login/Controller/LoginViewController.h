//
//  LoginViewController.h
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/7/15.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginViewController;

@protocol LoginViewControllerDelegate <NSObject>
- (void)loginViewControllerDidSuccess:(LoginViewController *)LoginViewController;/**< 登录成功 */
@end


@interface LoginViewController : UIViewController
BOOL_(isRegister)/**< 是否是注册按钮 */
BOOL_(isRevPwd)/**< 是否是完成按钮 */
@property(nonatomic, weak) id<LoginViewControllerDelegate> delegate;
@end
