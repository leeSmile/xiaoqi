//
//  DetailWebViewCell.h
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/27.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"
@interface DetailWebViewCell : UITableViewCell
DIYObj_(Article, article)
float_(cellHeigth)
@property(nonatomic, strong)UIViewController *parentViewController;
@end
