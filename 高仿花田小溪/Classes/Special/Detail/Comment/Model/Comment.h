//
//  Comment.h
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/29.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"
@interface Comment : NSObject
// 评论的文章的id
@property (nonatomic, copy) NSString *bbsId;
// 评论的内容
@property (nonatomic, copy) NSString *content;
// 评论的id
@property (nonatomic, copy) NSString *ID;
/// 回复的是谁, 显示 @XXXX
@property (nonatomic, strong) Author *toUser;
// 回复人
@property (nonatomic, strong) Author *writer;
// 评论时间
@property (nonatomic, copy) NSString *createDate;
// 转换后的时间
@property (nonatomic, copy) NSString *createDateDesc;
// 是否是匿名
@property (nonatomic, assign) BOOL anonymous;
// 行高, 计算性属性, 只读
@property (nonatomic, readonly, assign) CGFloat rowHeight;
@end
