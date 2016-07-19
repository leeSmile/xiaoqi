//
//  TopArticleOtherCell.m
//  高仿花田小憩OC版
//
//  Created by Lee on 16/6/26.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "TopArticleOtherCell.h"
@interface TopArticleOtherCell()
ImageView_(logoView)
@end

@implementation TopArticleOtherCell

- (void)setupUI
{
    [super setupUI];
    
    [self.contentView addSubview:self.smallIconView];
    [self.smallIconView addSubview:self.coverView];
    [self.contentView addSubview:self.logoView];
    [self.logoView addSubview:self.sortLabel];
    [self.contentView addSubview:self.topLine];
    [self.contentView addSubview:self.underLine];
    [self.contentView addSubview:self.titleLabel];

    self.smallIconView.contentMode = UIViewContentModeScaleAspectFill;
    self.smallIconView.clipsToBounds = YES;
    self.sortLabel.textColor = [UIColor blackColor];
    self.underLine.backgroundColor = [UIColor blackColor];
    self.topLine.backgroundColor = [UIColor blackColor];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    
    
    [self.smallIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
        make.height.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_height);

    }];
    
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    // logo的x应该是除去缩略图之后, 剩下的一半的位置
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(97, 58));
        make.top.equalTo(@10);
        make.left.equalTo(self.smallIconView.mas_right).offset((MY_WIHTE-120 - 97) * 0.5);
    }];
    
    [self.sortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.logoView.mas_centerX);
//        make.centerY.equalTo(self.logoView.mas_centerY);
        make.center.equalTo(self.logoView);
        
    }];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoView.mas_bottom).offset(10);
        make.left.equalTo(self.logoView);
        make.height.equalTo(@1);
        make.width.equalTo(self.logoView.mas_width);

    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLine.mas_bottom).offset(5);
        make.left.width.equalTo(self.topLine);

    }];
    
    [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topLine);
        make.size.equalTo(self.topLine);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);

    }];
}
- (UIImageView *)logoView
{
    if (!_logoView) {
        _logoView = [UIImageView new];
        _logoView.image = [UIImage imageNamed:@"f_top"];
    }
    return _logoView;
}
@end
