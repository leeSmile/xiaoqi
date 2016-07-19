//
//  ToolBottomView.h
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/25.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"
@class ToolBottomView;


typedef NS_OPTIONS(NSUInteger, ToolBarBtnType){
         See, // 查看数
         Zan, // 点赞
         Comments //评论
};

@protocol ToolBottomViewDelegate <NSObject>

- (void)toolBottomView:(ToolBottomView *)toolBottomView ToolBarBtnType:(ToolBarBtnType)ToolBarBtnType;

@end


@interface ToolBottomView : UIView
//模型
DIYObj_(Article, article)

@property(nonatomic, weak)id<ToolBottomViewDelegate> delegate;
@end
