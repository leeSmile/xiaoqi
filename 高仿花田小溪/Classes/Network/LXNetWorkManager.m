//
//  LXNetWorkManager.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/27.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "LXNetWorkManager.h"
static LXNetWorkManager *_instance;
@implementation LXNetWorkManager

+ (instancetype)shareManger
{
    dispatch_once_t  onceToken;
    //    第一次创建onceToken为0，以后就是-1
    dispatch_once(&onceToken, ^{
        if(!_instance)
        {
            _instance = [self manager];
            _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        }});
    
    return _instance;
}
@end
