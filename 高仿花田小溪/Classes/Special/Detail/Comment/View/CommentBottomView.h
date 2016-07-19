//
//  CommentBottomView.h
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/29.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
@class CommentBottomView;

@protocol CommentBottomViewDelegate <NSObject>
- (void)commentBottomView:(CommentBottomView *)commentBottomView keyboradFrameChange:(NSDictionary *)userInfo;
- (void)commentBottomView:(CommentBottomView *)commentBottomView keyboardWillHide:(NSDictionary *)userInfo;
//- (void)commentBottomView:(CommentBottomView *)commentBottomView keyboardWillShow:(NSDictionary *)userInfo;
- (void)commentBottomView:(CommentBottomView *)commentBottomView sendMessage:(NSString *)message replyComment:(Comment *)comment;
@end

@interface CommentBottomView : UIView
TextField_(textFiled)
String_(placeHolderStr)
DIYObj_(Comment, comment)
@property(nonatomic, weak) id<CommentBottomViewDelegate> delegate;
@end
