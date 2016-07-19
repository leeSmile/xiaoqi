//
//  HeaderReusableView.h
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/30.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Author.h"
typedef NS_OPTIONS(NSUInteger, PersonalCenterBtnType)
{
    Column,// 专栏
    Introduce,// 介绍
    Subscriber// 订阅者
};
@class HeaderReusableView;

@protocol HeaderReusableViewDelegate <NSObject>

- (void)commentViewCell:(UICollectionReusableView *)commentViewCell didClickBtn:(PersonalCenterBtnType)type;

@end

@interface HeaderReusableView : UICollectionReusableView
@property(nonatomic, weak) id<HeaderReusableViewDelegate> delegate;
@end
