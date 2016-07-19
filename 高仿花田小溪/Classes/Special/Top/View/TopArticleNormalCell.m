//
//  TopArticleNormalCell.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/6/26.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "TopArticleNormalCell.h"

@implementation TopArticleNormalCell

- (void)setupUI
{
    [super setupUI];
    
    [self.contentView addSubview:self.smallIconView];
    [self.smallIconView addSubview:self.coverView];
    [self.contentView addSubview:self.topLine];
    [self.contentView addSubview:self.underLine];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.sortLabel];
    [self.contentView addSubview:self.logLabel];

    [self.smallIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);

    }];

    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];

    [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.centerX.equalTo(self.contentView);
        make.height.equalTo(@1);
        make.width.equalTo(self.contentView.mas_height);
    }];

    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleLabel.mas_top).offset(-15);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(self.underLine);

    }];

    [self.sortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topLine.mas_top).offset(-5);
        make.centerX.equalTo(self.contentView);
    }];

    [self.logLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.underLine.mas_bottom).offset(5);

    }];

}
@end
