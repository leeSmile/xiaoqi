//
//  MallsGoods.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/7/9.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MallsGoods.h"
#import "MJExtension.h"

@implementation MallsGoods
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"childrenList":[Goods class]
             };
}
@end
