//
//  Category.h
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Categorys : NSObject
// 专题创建时间
@property (nonatomic, copy) NSString *createDate;
// 专题类型ID
@property (nonatomic, copy) NSString *ID;
// 专题类型名称
@property (nonatomic, copy) NSString *name;
// 专题序号
@property (nonatomic, copy) NSString *order;

@end
