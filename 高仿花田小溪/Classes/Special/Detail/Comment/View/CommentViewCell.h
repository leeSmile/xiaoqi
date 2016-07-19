//
//  CommentViewCell.h
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/29.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
typedef NS_OPTIONS(NSUInteger, CommentBtnType)
{
    More,// 更多
    Reply// 回复
};

@class CommentViewCell;

@protocol CommentViewCellDelegate <NSObject>
- (void)commentViewCell:(CommentViewCell *)commentViewCell didClickBtn:(CommentBtnType)type ReplyComment:(Comment *)comment;
@end


@interface CommentViewCell : UITableViewCell
DIYObj_(Comment, comment)
@property(nonatomic, weak) id<CommentViewCellDelegate> delegate;
@end
