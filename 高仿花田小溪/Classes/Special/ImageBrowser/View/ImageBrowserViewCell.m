//
//  ImageBrowserViewCell.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/6/28.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "ImageBrowserViewCell.h"

#import "UIImageView+WebCache.h"

@interface ImageBrowserViewCell ()<UIScrollViewDelegate>
ScrollView_(scrollview)

@end

@implementation ImageBrowserViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self.contentView addSubview:self.scrollview];
    [self.scrollview addSubview:self.iconView];
    
    self.scrollview.frame = self.bounds;
    self.iconView.frame = self.scrollview.frame;
}

- (UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] init];
        _scrollview.delegate = self;
        _scrollview.maximumZoomScale = 2.0;
        _scrollview.minimumZoomScale = 0.5;
    }
    return _scrollview;
}

- (ProgressImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[ProgressImageView alloc] initWithFrame:CGRectZero];
        _iconView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePhotoBrowser)];
        UILongPressGestureRecognizer *longtap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longclickImage)];
        [_iconView addGestureRecognizer:tap];
        [_iconView addGestureRecognizer:longtap];
    }
    return _iconView;
}
- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [self resetScrollview];
    
    [self.iconView sd_setImageWithURL:imageURL  placeholderImage:nil options:SDWebImageCacheMemoryOnly  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //绘制进度条
        self.iconView.progress =  (CGFloat)receivedSize/(CGFloat)expectedSize;
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 重新调整图片的frame
        [self setupImagePostion];
    }];

    
}
- (void)setupImagePostion
{
    if (self.iconView.image == nil) {
        return;
    }
    
    float scale = self.iconView.image.size.height / self.iconView.image.size.width;
    float height = scale * MY_WIHTE;
    
    self.iconView.frame = CGRectMake(0, 0, MY_WIHTE, height);
    
    //如果是长图
    if (height > MY_HEIGHT) {
        self.scrollview.contentSize = self.iconView.bounds.size;
    }else
    {
        //如果是小图，显示在中间
        CGFloat y = (MY_HEIGHT - height) * 0.5;
        self.scrollview.contentInset = UIEdgeInsetsMake(y, 0, y, 0);
    }
}
- (void)resetScrollview
{
    self.iconView.transform = CGAffineTransformIdentity;
    self.scrollview.contentInset = UIEdgeInsetsZero;
    self.scrollview.contentOffset = CGPointZero;
    self.scrollview.contentSize = CGSizeZero;

}
- (void)closePhotoBrowser
{
    if ([self.delegate respondsToSelector:@selector(ImageBrowserViewCellDidClickImage:)]) {
        [self.delegate ImageBrowserViewCellDidClickImage:self];
    }
}

- (void)longclickImage
{
    if ([self.delegate respondsToSelector:@selector(ImageBrowserViewCellDidLongClickImage:)]) {
        [self.delegate ImageBrowserViewCellDidLongClickImage:self];
    }
}
#pragma UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.iconView;
}
#pragma  需要完善
//缩放结束后，调整被缩放View的位置
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    float offsetY = (MY_HEIGHT - view.lx_height)*0.5;
    offsetY = offsetY < 0 ? 0 : offsetY;
    float offsetX = (MY_WIHTE - view.lx_width)*0.5;
    offsetX = offsetX < 0 ? 0 : offsetX;
    scrollView.contentInset = UIEdgeInsetsMake(offsetY, offsetX, offsetY, offsetX);
}
@end
