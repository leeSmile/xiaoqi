//
//  BlurView.h
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Categorys.h"
@class BlurView;

@protocol BlurViewDelegate <NSObject>
- (void)blurView:(BlurView *)blurView didSelectCategory:(id)Category;
@end



@interface BlurView : UIVisualEffectView<UITableViewDelegate, UITableViewDataSource>
//分类数组
mArray_(categories)
TableView_(tableView)
// 是否是商城的蒙版
BOOL_(isMalls)
@property(nonatomic, weak) id<BlurViewDelegate> delegate;
@end
