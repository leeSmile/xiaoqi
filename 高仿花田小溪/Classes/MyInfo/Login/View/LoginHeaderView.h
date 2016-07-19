//
//  LoginHeaderView.h
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/7/15.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginProfile.h"
@class LoginHeaderView;

@protocol LoginHeaderViewDelegate <NSObject>
- (void)LoginHeaderView:(LoginHeaderView *)loginHeaderView clickRegister:(UIButton *)btn;/**< 点击注册按钮 */
- (void)LoginHeaderView:(LoginHeaderView *)loginHeaderView clickRevpwd:(UIButton *)btn;/**< 点击忘记密码按钮 */
- (void)LoginHeaderView:(LoginHeaderView *)loginHeaderView clickDoneWithProfile:(LoginProfile *)profile;/**< 点击登录按钮 */
- (void)LoginHeaderView:(LoginHeaderView *)loginHeaderView clickProtocol:(UILabel *)protocelLabel;/**< 点击协议 */
@end

@interface LoginHeaderView : UIView
BOOL_(isRegister)/**< 是否是注册按钮 */
BOOL_(isRevPwd)/**< 是否是完成按钮 */
@property(nonatomic, weak) id<LoginHeaderViewDelegate> delegate;
@end
