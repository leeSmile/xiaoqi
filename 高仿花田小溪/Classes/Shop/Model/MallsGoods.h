//
//  MallsGoods.h
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/7/9.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Goods.h"
@interface MallsGoods : NSObject
// 分类描述信息
@property (nonatomic, copy) NSString *fnDesc;
// 分类id
@property (nonatomic, copy) NSString *fnId;
// 分类
@property (nonatomic, copy) NSString *fnName;
// 商品列表
@property (nonatomic, strong) NSArray <Goods *> *childrenList;

@end
