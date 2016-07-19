//
//  Address.h
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/7/4.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject
// 收货详细地址
@property (nonatomic, copy) NSString *fnConsigneeAddress;
// 收货地区, 如 :北京, 通州
@property (nonatomic, copy) NSString *fnConsigneeArea;
// 用户ID
@property (nonatomic, copy) NSString *fnCustomerId;
// 地址ID
@property (nonatomic, copy) NSString *fnId;
// 是否是默认地址, 1是默认, 0是非, 也有可能传空, 所有这儿不能设默认值
@property (nonatomic, assign) int fnIsUse;
// 手机号
@property (nonatomic, strong) NSString *fnMobile;
// 邮编
@property (nonatomic, assign) int fnPostCode;
// 收货人
@property (nonatomic, copy) NSString *fnUserName;
// 未知属性, 现在传回来的都是空字符串
@property (nonatomic, copy) NSString *fnConsigneeName;
// cell的高度
@property (nonatomic, assign) CGFloat cellHeight;
@end
