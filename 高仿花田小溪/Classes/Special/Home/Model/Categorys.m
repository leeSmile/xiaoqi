//
//  Category.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "Categorys.h"
#import "MJExtension.h"

@implementation Categorys
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
MJCodingImplementation
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
@end
