//
//  Goods.h
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/7/4.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Address;
@interface Goods : NSObject
// 1是推荐  2是最热
@property (nonatomic, assign) int fnJian;
// 图片地址
@property (nonatomic, copy) NSString *fnAttachment;
// 缩略图
@property (nonatomic, copy) NSString *fnAttachmentSnap;
// 价格
@property (nonatomic, assign) int fnMarketPrice;
// 类型(暂且理解为是类型)
@property (nonatomic, copy) NSString *fnEnName;
// 商品名字
@property (nonatomic, copy) NSString *fnName;
// 商品ID 6fbee05b-fe2a-40d5-8165-2c16faac134d
@property (nonatomic, copy) NSString *fnId;
// 推荐/最热的图片
@property (nonatomic, copy) UIImage *fnjianIcon;
// 推荐/最热的文字
@property (nonatomic, copy) NSString *fnjianTitle;
// 默认收货地址
@property (nonatomic, strong) Address *uAddress;
@end
