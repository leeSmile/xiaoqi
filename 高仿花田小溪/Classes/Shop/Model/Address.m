//
//  Address.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/7/4.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "Address.h"
#import "MJExtension.h"
@implementation Address
MJCodingImplementation

- (CGFloat)cellHeight
{
    CGFloat height = 0;
    
    height += (15 + 20 + 10 + 10);
    
    //计算添加详细地址的高度
    height += [[NSString stringWithFormat:@"%@%@",self.fnConsigneeArea,self.fnConsigneeAddress] textHeightWithContentWidth:CGFLOAT_MAX font:[UIFont systemFontOfSize:14]];
    
    if (height < 83) {
        height = 83;
    }else
    {
        height += 10;
    }
    return height;
}
@end
