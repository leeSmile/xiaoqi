//
//  MallsHeaderCell.h
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/7/10.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRCarouselView.h"

typedef NS_OPTIONS(NSUInteger, MallType)
{
    Choiceness,// 精选
    Mall,// 商城
    Integral// 积分
};

@class MallsHeaderCell;

@protocol MallsHeaderCellDelegate <NSObject>

- (void)commentViewCell:(MallsHeaderCell *)MallsHeaderCell didClickBtn:(MallType)type;

@end


@interface MallsHeaderCell : UITableViewCell
@property(nonatomic, strong)NSMutableArray<NSString *> *imageUrl;
//顶部的轮播图
DIYObj_(XRCarouselView, topImageView)
@property(nonatomic, weak) id<MallsHeaderCellDelegate> delegate;

@end
