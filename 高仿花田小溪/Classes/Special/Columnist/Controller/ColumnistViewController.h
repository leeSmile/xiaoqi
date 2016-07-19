//
//  ColumnistViewController.h
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/30.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"
#import "Author.h"
@interface ColumnistViewController : UICollectionViewController
DIYObj_(Author, author)
// 是否是用户(用户和专栏是不一样的)
BOOL_(isUser)
@end
