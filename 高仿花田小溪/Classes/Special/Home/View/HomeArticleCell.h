//
//  HomeArticleCell.h
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/25.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@class HomeArticleCell;

@protocol HomeArticleCellDelegate <NSObject>
- (void)clickHeadImage:(HomeArticleCell *)HomeArticleCell Article:(Article *)article;
@end

@interface HomeArticleCell : UITableViewCell
//模型
DIYObj_(Article, article)
@property(nonatomic, weak) id<HomeArticleCellDelegate> delegate;
@end
