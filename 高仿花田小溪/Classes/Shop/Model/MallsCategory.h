//
//  MallsCategory.h
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/7/4.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MallsCategory : NSObject
// 1是推荐  2是最热
@property (nonatomic, assign) int fnJian;
// 描述
@property (nonatomic, copy) NSString *fnDesc;
// id
@property (nonatomic, copy) NSString *fnId;
// 类型名称
@property (nonatomic, copy) NSString *fnName;
// 商品列表
@property (nonatomic, strong) NSArray <MallsCategory *> *childrenList;
@end
