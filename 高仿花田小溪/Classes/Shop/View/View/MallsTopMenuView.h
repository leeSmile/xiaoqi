//
//  MallsTopMenuView.h
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/7/10.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, MallType)
{
    Choiceness,// 精选
    Mall,// 商城
    Integral// 积分
};

@class MallsTopMenuView;

@protocol MallsTopMenuViewDelegate <NSObject>

- (void)commentViewCell:(MallsTopMenuView *)topMenuView didClickBtn:(MallType)type;

@end

@interface MallsTopMenuView : UIView

@property(nonatomic, weak) id<MallsTopMenuViewDelegate> delegate;
@end
