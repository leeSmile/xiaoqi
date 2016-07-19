//
//  TopArticleCell.h
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/6/26.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"
@interface TopArticleCell : UITableViewCell
DIYObj_(Article, article)
int_(sort)
ImageView_(smallIconView)
//蒙版
View_(coverView)
//上面的白色分割线
View_(topLine)
//下面的白色分割线
View_(underLine)
//名次
Label_(sortLabel)
//标题
Label_(titleLabel)
//logo
Label_(logLabel)

- (void)setupUI;
@end
