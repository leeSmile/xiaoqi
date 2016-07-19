//
//  MallsCategoryHeader.h
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MallsCategoryHeader;


@protocol MallsCategoryHeaderDelegate <NSObject>

- (void)mallsCategoryHeaderchick:(MallsCategoryHeader *)header;

@end



@interface MallsCategoryHeader : UIView
/// 显示的父标题
String_(title)
/// 是否显示
BOOL_(isShow)
@property(nonatomic, weak) id<MallsCategoryHeaderDelegate> delegate;
@end
