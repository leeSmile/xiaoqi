//
//  ImageBrowserViewCell.h
//  高仿花田小憩OC版
//
//  Created by Lee on 16/6/28.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressImageView.h"
@class ImageBrowserViewCell;

@protocol ImageBrowserViewCellDelegate <NSObject>
- (void)ImageBrowserViewCellDidClickImage:(ImageBrowserViewCell *)cell;
- (void)ImageBrowserViewCellDidLongClickImage:(ImageBrowserViewCell *)cell;
@end

@interface ImageBrowserViewCell : UICollectionViewCell
DIYObj_(ProgressImageView, iconView)
@property(nonatomic, strong)NSURL *imageURL;
@property(nonatomic, weak) id<ImageBrowserViewCellDelegate> delegate;

@end
