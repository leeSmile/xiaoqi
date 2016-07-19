//
//  Pay.h
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/7/19.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pay : NSObject
// 图标
@property (nonatomic, strong) UIImage *icon;
// 机构名称
@property (nonatomic, copy) NSString *title;
// 支付描述
@property (nonatomic, copy) NSString *des;
@end
