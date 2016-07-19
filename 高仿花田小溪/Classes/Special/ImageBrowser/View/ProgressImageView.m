//
//  ProgressImageView.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/6/28.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "ProgressImageView.h"
#import "ProgressView.h"

@interface ProgressImageView()
DIYObj_(ProgressView, progressView)
@end

@implementation ProgressImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        [KeyWindow addSubview:self.progressView];
        self.progressView.hidden = YES;
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(@0);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
        
    }
    return self;
}


- (ProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[ProgressView alloc] init];
        _progressView.backgroundColor = [UIColor clearColor];
    }
    return _progressView;
}


- (void)setProgress:(float)progress
{
    _progress = progress;
    if (progress == 1) {
        [self.progressView removeFromSuperview];
        return;
    }
    self.progressView.hidden = NO;
    self.progressView.progress = progress;
}

-(void)dealloc
{
    [self.progressView removeFromSuperview];
}
@end
