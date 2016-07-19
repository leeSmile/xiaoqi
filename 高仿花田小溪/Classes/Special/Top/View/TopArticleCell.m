
//
//  TopArticleCell.m
//  高仿花田小憩OC版
//
//  Created by Lee on 16/6/26.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "TopArticleCell.h"
@interface TopArticleCell()
@end
@implementation TopArticleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)setupUI
{
    self.backgroundColor = rgb255(241, 241, 241);
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 0, 0, 0));
    }];
    
}
- (UIImageView *)smallIconView
{
    if (!_smallIconView) {
        _smallIconView = [UIImageView new];
    }
    return _smallIconView;
}
- (UIView *)coverView
{
    if (!_coverView) {
        _coverView = [UIView new];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.2;
    }
    return _coverView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}
- (UIView *)topLine
{
    if (!_topLine) {
        _topLine = [UIView new];
        _topLine.backgroundColor = [UIColor whiteColor];
    }
    return _topLine;
}

- (UIView *)underLine
{
    if (!_underLine) {
        _underLine = [UIView new];
        _underLine.backgroundColor = [UIColor whiteColor];
    }
    return _underLine;
}

- (UILabel *)sortLabel
{
    if (!_sortLabel) {
        _sortLabel = [UILabel new];
        _sortLabel.textColor = [UIColor whiteColor];
        _sortLabel.font = [UIFont systemFontOfSize:11];
    }
    return _sortLabel;
}
- (UILabel *)logLabel
{
    if (!_logLabel) {
        _logLabel = [UILabel new];
        _logLabel.text = @"FLORAL & FILE";
        _logLabel.textColor = [UIColor whiteColor];
        _logLabel.font = [UIFont systemFontOfSize:10];
    }
    return _logLabel;
}

- (void)setSort:(int)sort
{
    _sort = sort;
    
    self.sortLabel.text = [NSString stringWithFormat:@"TOP %zd",sort];
    
}

- (void)setArticle:(Article *)article
{
    _article = article;
    self.smallIconView.opaque = NO;
    [self.smallIconView setImageWithURL:[NSURL URLWithString:article.smallIcon] placeholderImage:[UIImage imageNamed:@"placehodler"]];
    self.titleLabel.text = article.title;
}
@end
