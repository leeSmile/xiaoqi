//
//  HomeArticleCell.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/25.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "HomeArticleCell.h"
#import "ToolBottomView.h"

@interface HomeArticleCell ()
/// 缩略图
ImageView_(smallIconView)
/// 作者
Label_(authorLabel)
/// 称号
Label_(identityLabel)
/// 头像
ImageView_(headImgView)
/// 认证
ImageView_(authView)
/// 分类
Label_(categoryLabel)
/// 标题
Label_(titleLabel)
/// 摘要
Label_(descLabel)
/// 下划线
ImageView_(underline)
/// ToolBottomView
DIYObj_(ToolBottomView, bottomView)
@end

@implementation HomeArticleCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = rgb255(241, 241, 241);
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(8, 8, 0, 8));
    }];
    //调用子控件的set方法
    self.smallIconView.hidden = NO;
    self.authorLabel.hidden = NO;
    self.identityLabel.hidden = NO;
    self.headImgView.hidden = NO;
    self.authView.hidden = NO;
    self.categoryLabel.hidden = NO;
    self.titleLabel.hidden = NO;
    self.descLabel.hidden = NO;
    self.underline.hidden = NO;
    self.bottomView.hidden = NO;
    
  
}
 /// 缩略图
- (UIImageView *)smallIconView
{
    if (!_smallIconView) {
        _smallIconView = [UIImageView new];
        [self.contentView addSubview:_smallIconView];

        [_smallIconView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.equalTo(self.contentView);
            make.left.right.equalTo(self.contentView);
            make.left.right.top.equalTo(self.contentView);
            make.left.right.top.equalTo(self.contentView);
            make.height.equalTo(@160);
        }];
    }
    return _smallIconView;
}
/// 作者
- (UILabel *)authorLabel
{
    if (!_authorLabel) {
        _authorLabel = [UILabel new];
        _authorLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:14];
        _authorLabel.text = @"花田小憩OC版  github :https://github.com/leeSmile/xiaoqi";
        [self.contentView addSubview:_authorLabel];
        [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.headImgView.mas_left).offset(-10);
            make.top.equalTo(self.smallIconView.mas_bottom).offset(8);
        }];

    }
    return _authorLabel;
}


/// 称号
- (UILabel *)identityLabel
{
    if (!_identityLabel) {
        _identityLabel = [UILabel new];
        _identityLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:12];
        _identityLabel.text = @"资深专家";
        _identityLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        [self.contentView addSubview:_identityLabel];
        [_identityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.authorLabel);
            make.top.equalTo(self.authorLabel.mas_bottom).offset(4);
        }];
        
    }
    return _identityLabel;
}
/// 头像
- (UIImageView *)headImgView
{
    if (!_headImgView) {
        _headImgView = [UIImageView new];
        _headImgView.image = [UIImage imageNamed:@"pc_default_avatar"];
        _headImgView.layer.cornerRadius = 51 * 0.5;
        _headImgView.layer.masksToBounds = YES;
        _headImgView.layer.borderWidth = 0.5;
        _headImgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _headImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toProfile)];
        [_headImgView addGestureRecognizer:recognizer];
        [self.contentView addSubview:_headImgView];
        
        [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(51, 51));
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.smallIconView.mas_bottom).offset(-10);
        }];
 
    }
    return _headImgView;
}
/// 认证
- (UIImageView *)authView
{
    if (!_authView) {
        _authView = [UIImageView new];
        _authView.image = [UIImage imageNamed:@"personAuth"];
        [self.contentView addSubview:_authView];
        [_authView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(14, 14));
            make.bottom.right.equalTo(self.headImgView);
        }];
    }
    return _authView;
}
/// 分类
- (UILabel *)categoryLabel
{
    if (!_categoryLabel) {
        _categoryLabel = [UILabel new];
        _categoryLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:14];
        
        _categoryLabel.text = @"[家居庭院]";
        _categoryLabel.textColor = rgb255(199, 167, 98);
        [self.contentView addSubview:_categoryLabel];
        [_categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.identityLabel.mas_bottom);
        }];
        
    }
    return _categoryLabel;
}

/// 标题
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:14];
        
        _titleLabel.text = @"起个什么标题啊啊啊啊啊啊";
        _titleLabel.textColor = rgb255(0, 0, 0);
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.categoryLabel);
            make.top.equalTo((self.categoryLabel.mas_bottom)).offset(10);
            make.width.lessThanOrEqualTo(self.contentView).offset(-20);
        }];
        
    }
    return _titleLabel;
}

/// 摘要
- (UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:12];
        
        _descLabel.text = @"写个什么摘要啊啊啊啊啊啊";
        _descLabel.numberOfLines = 2;
        _descLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        [self.contentView addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
            make.width.lessThanOrEqualTo(self.contentView).offset(-40);
            make.height.equalTo(@30);
        }];
        
    }
    return _descLabel;
}


/// 下划线
- (UIImageView *)underline
{
    if (!_underline) {
        _underline = [UIImageView new];
        _underline.image = [UIImage imageNamed:@"underLine"];
        [self.contentView addSubview:_underline];
        [_underline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.descLabel.mas_bottom).offset(5);
            make.left.equalTo(self.descLabel).offset(5);
            make.right.equalTo(self.headImgView);
        }];
    }
    return _underline;
}


- (ToolBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[ToolBottomView alloc] init];

        [self.contentView addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.underline.mas_bottom).offset(5);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(@30);
        }];
    }
    return _bottomView;
}



- (void)toProfile
{

    if ([self.delegate respondsToSelector:@selector(clickHeadImage: Article:)]) {
        [self.delegate clickHeadImage:self Article:self.article];
    }
}



- (void)setArticle:(Article *)article
{
    _article = article;
    [self.smallIconView setImageWithURL:[NSURL URLWithString:article.smallIcon] placeholderImage:[UIImage imageNamed:@"placehodler"]];
    [self.headImgView setImageWithURL:[NSURL URLWithString:article.author.headImg] placeholderImage:[UIImage imageNamed:@"pc_default_avatar"]];
    self.identityLabel.text = article.author.identity;
    self.authorLabel.text = article.author.userName ? article.author.userName : @"佚名";
    self.categoryLabel.text = [NSString stringWithFormat:@"[%@]",article.category.name];
    self.titleLabel.text = article.title;
    self.descLabel.text = article.desc;
    self.bottomView.article = article;
    self.authView.image = article.author.authImage;
    
}
@end
