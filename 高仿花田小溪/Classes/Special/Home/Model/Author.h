//
//  Author.h
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Author : NSObject
// 认证类型: 专家
@property (nonatomic, copy) NSString *auth;
// 所在城市
@property (nonatomic, copy) NSString *city;
// 简介
@property (nonatomic, copy) NSString *content;
// 是否订阅
@property (nonatomic, assign) int dingYue;
// 头像
@property (nonatomic, copy) NSString *headImg;
// 用户id
@property (nonatomic, copy) NSString *ID;
// 标示: 官方认证
@property (nonatomic, copy) NSString *identity;
// 用户名
@property (nonatomic, copy) NSString *userName;
// 手机号 Int64 = 18618234090
@property (nonatomic, copy) NSString *mobile;
// 订阅数
@property (nonatomic, assign) int subscibeNum;
// 认证的等级, 1是yellow, 2是个人认证
@property (nonatomic, assign) int newAuth;

@property (nonatomic, strong) UIImage *authImage;
// 经验值 Int = 0
@property (nonatomic, assign) int experience;
// 等级 Int = 1
@property (nonatomic, assign) int level;
// 积分 Int = 0
@property (nonatomic, assign) int integral;

@end
