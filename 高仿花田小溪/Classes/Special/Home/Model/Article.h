//
//  Article.h
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/25.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"
#import "Categorys.h"

@interface Article : NSObject
// 创建时间
@property (nonatomic, copy) NSString *createDate;
// 描述创建时间, 比如昨天, 今天, 去年等
@property (nonatomic, copy) NSString *createDateDesc;
// 摘要
@property (nonatomic, copy) NSString *desc;
// 评论数
@property (nonatomic, assign) int fnCommentNum;
// 点赞数
@property (nonatomic, assign) int favo;
// 文章ID
@property (nonatomic, copy) NSString *ID;
// 序号
@property (nonatomic, assign) int order;
// 文章的H5地址
@property (nonatomic, copy) NSString *pageUrl;
// 阅读数
@property (nonatomic, assign) int read;
// 分享数
@property (nonatomic, assign) int share;
// 用户分享的URL
@property (nonatomic, copy) NSString *sharePageUrl;
// 缩略图
@property (nonatomic, copy) NSString *smallIcon;
// 文章标题
@property (nonatomic, copy) NSString *title;
// 是否是首页的, 如果是首页不显示时间
@property (nonatomic, assign) BOOL isNotHomeList;
// 作者
@property (nonatomic, strong) Author *author;
// 所属分类
@property (nonatomic, strong) Categorys *category;

@end
