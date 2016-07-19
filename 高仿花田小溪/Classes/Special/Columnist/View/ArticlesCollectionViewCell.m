//
//  ArticlesCollectionViewCell.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/30.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "ArticlesCollectionViewCell.h"

@interface ArticlesCollectionViewCell ()
/// 赞的数量
Button_(zanBtn)
/// 查看的数量
Button_(seeBtn)
/// 标题
Label_(nameLabel)
/// 描述信息
Label_(descLabel)
/// 缩略图
ImageView_(thumbnail)
/// 分割线
ImageView_(underLine)
@end

@implementation ArticlesCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.thumbnail];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.descLabel];
    [self.contentView addSubview:self.underLine];
    [self.contentView addSubview:self.zanBtn];
    [self.contentView addSubview:self.seeBtn];
    
    //约束
    
    [self.thumbnail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(@140);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thumbnail.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
    }];
    
    [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
        make.height.equalTo(@1);
        make.top.equalTo(self.descLabel.mas_bottom).offset(15);
    }];
    
    [self.zanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.underLine).offset(5);
        make.width.equalTo(self.contentView).multipliedBy(0.4);
        make.top.equalTo(self.underLine.mas_bottom).offset(5);
    }];
    
    [self.seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX).multipliedBy(0.8);
        make.width.top.equalTo(self.zanBtn);
    }];
}

- (UIButton *)zanBtn
{
    if (!_zanBtn) {
        _zanBtn = [self createBtnWithImageName:@"p_zan"];
    }
    return _zanBtn;
}
- (UIButton *)seeBtn
{
    if (!_seeBtn) {
        _seeBtn = [self createBtnWithImageName:@"hp_count"];
    }
    return _seeBtn;
}
- (UIImageView *)thumbnail
{
    if (!_thumbnail) {
        _thumbnail = [UIImageView new];
    }
    return _thumbnail;
}
- (UIImageView *)underLine
{
    if (!_underLine) {
        _underLine = [UIImageView new];
        _underLine.image = [UIImage imageNamed:@"underLine"];
    }
    return _underLine;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}
- (UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.font = [UIFont systemFontOfSize:11];
        _descLabel.textColor = [UIColor lightGrayColor];
    }
    return _descLabel;
}
- (void)setArticle:(Article *)article
{
    _article = article;
    
    [self.thumbnail setImageWithURL:[NSURL URLWithString:article.smallIcon] placeholderImage:[UIImage imageNamed:@"placehodler"]];
    self.nameLabel.text = article.title;
    self.descLabel.text = article.desc;
    [self.zanBtn setTitle:[NSString stringWithFormat:@"%zd",article.favo] forState:UIControlStateNormal];
    [self.seeBtn setTitle:[NSString stringWithFormat:@"%zd",article.read] forState:UIControlStateNormal];
}

- (UIButton *)createBtnWithImageName:(NSString *)imageName
{
    UIButton *btn = [UIButton title:nil imageName:imageName target:nil selector:nil font:[UIFont systemFontOfSize:11] titleColor:[UIColor lightGrayColor]];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.userInteractionEnabled = NO;
    return btn;
}
@end
