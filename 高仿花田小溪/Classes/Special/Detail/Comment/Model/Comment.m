//
//  Comment.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/29.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "Comment.h"
#import "MJExtension.h"
// 默认头像宽高
static CGFloat DefaultHeadHeight = 51.0;
// 默认10间距
static CGFloat DefaultMargin10 = 10.0;
// 默认15间距
static CGFloat DefaultMargin15 = 15.0;
// 默认20间距
static CGFloat DefaultMargin20 = 20.0;

@implementation Comment
MJCodingImplementation
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

- (void)setCreateDate:(NSString *)createDate
{
    if ([createDate containsString:@".0"]) {
        createDate = [createDate stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    _createDate = createDate;
    //生产日期描述文字
    self.createDateDesc = [createDate dateDesc];
    
}

- (BOOL)anonymous
{
    if (self.writer.userName.length>0) {
        return NO;
    }
    return YES;
}

//动态计算行高
- (CGFloat)rowHeight
{
    CGFloat contentWidth = MY_WIHTE - DefaultMargin15 - DefaultMargin20 - DefaultHeadHeight;
    CGFloat contentHeight = [self.content textHeightWithContentWidth:contentWidth font:[UIFont systemFontOfSize:12]];
    return DefaultMargin10 + DefaultHeadHeight  + contentHeight + DefaultMargin10 + 30 + DefaultMargin10;
}
@end
