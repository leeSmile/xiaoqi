//
//  Goods.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/7/4.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "Goods.h"
#import "MJExtension.h"
@implementation Goods
MJCodingImplementation
- (void)setFnJian:(int)fnJian
{
    _fnJian = fnJian;
    if (fnJian == 2) {
        self.fnjianIcon = [UIImage imageNamed:@"f_hot_56x51"];
        self.fnjianTitle = @"最热";
    }else
    {
        self.fnjianIcon = [UIImage imageNamed:@"f_jian_56x51"];
        self.fnjianTitle = @"推荐";
    }
}
@end
