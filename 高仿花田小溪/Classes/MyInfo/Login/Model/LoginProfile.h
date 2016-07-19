//
//  LoginProfile.h
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/7/13.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginProfile : NSObject
// 国家编号  默认选中中国
@property (nonatomic, assign) int countryNum;
// 手机号
@property (nonatomic, copy) NSString *phoneNumber;
// 验证码
@property (nonatomic, copy) NSString *safeNum;
// 密码
@property (nonatomic, copy) NSString *password;

//- (BOOL)isPhoneNumber;
@end
