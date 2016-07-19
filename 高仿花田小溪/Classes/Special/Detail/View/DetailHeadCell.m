//
//  DetailHeadCell.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/27.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "DetailHeadCell.h"

@interface DetailHeadCell()
/// 顶部的缩略图
ImageView_(topImageView)
/// 标题
Label_(titleLabel)
/// 分类
Label_(categoryLabel)
/// 分割线
ImageView_(shortLine)
@end

@implementation DetailHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{

    [self.contentView addSubview:self.topImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.categoryLabel];
    [self.contentView addSubview:self.shortLine];
    
    
    //添加约束
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(@160);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.topImageView.mas_bottom).offset(20);
    }];

    [self.categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.contentView);
    }];

    NSString *text = @"四个字啦";
    UIFont *font = [UIFont fontWithName:@"CODE LIGHT" size:13];
    float shortLineWidth = [text textWidthWithContentHeight:MAXFLOAT font:font];
    [self.shortLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryLabel.mas_bottom).offset(8);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(@(shortLineWidth));
    }];

}


/// 缩略图
- (UIImageView *)topImageView
{
    if (!_topImageView) {
        _topImageView = [UIImageView new];
     
    }
    return _topImageView;
}

///
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        
        
    }
    return _titleLabel;
}
///
- (UILabel *)categoryLabel
{
    if (!_categoryLabel) {
        _categoryLabel = [UILabel new];
        _categoryLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:13];
        _categoryLabel.text = @"#家居庭院#";
    }
    return _categoryLabel;
}
///
- (UIImageView *)shortLine
{
    if (!_shortLine) {
        _shortLine = [UIImageView new];
        _shortLine.image = [UIImage imageNamed:@"underLine"];
        
    }
    return _shortLine;
}
- (void)setArticle:(Article *)article
{
    _article = article;
    [self.topImageView setImageWithURL:[NSURL URLWithString:article.smallIcon] placeholderImage:[UIImage imageNamed:@"placehodler"]];
    self.titleLabel.text = article.title;
    if (article.category) {
        self.categoryLabel.text = [NSString stringWithFormat:@"#%@#",article.category.name];
    }
}
@end
