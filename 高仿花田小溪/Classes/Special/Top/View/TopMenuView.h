//
//  TopMenuView.h
//  高仿花田小憩OC版
//
//  Created by Lee on 16/6/26.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopMenuView;

@protocol TopMenuViewDelegate <NSObject>

- (void)topMenuView:(TopMenuView *)topMenuView selectedTopAction:(NSString *)action;

@end

@interface TopMenuView : UIView

@property(nonatomic, weak) id<TopMenuViewDelegate> delegate;
@end
