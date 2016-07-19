//
//  DetailHeaderView.h
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/27.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"
@class DetailHeaderView;
@protocol DetailHeaderViewDelegate <NSObject>

- (void)clickHeaderView:(DetailHeaderView *)headerView didSelectBtn:(UIButton *)btn;

@end


@interface DetailHeaderView : UIView
DIYObj_(Article, article)
@property(nonatomic, weak) id<DetailHeaderViewDelegate> delegate;
@end
