//
//  TopAuthorCell.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/6/26.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "TopAuthorCell.h"

@interface TopAuthorCell()
ImageView_(headImgView)
//认证图片
ImageView_(authView)
//名次
Label_(sortLabel)
//作者
Label_(authorLabel)
@end

@implementation TopAuthorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI
{
    [self.contentView addSubview:self.headImgView];
    [self.contentView addSubview:self.authView];
    [self.contentView addSubview:self.authorLabel];
    [self.contentView addSubview:self.sortLabel];
    
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(51, 51));
    }];
    
    [self.authView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.bottom.right.equalTo(self.headImgView);

    }];
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgView.mas_right).offset(10);
        make.centerY.equalTo(self);
    }];
    [self.sortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(self);

    }];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];

}

- (UIImageView *)headImgView
{
    if (!_headImgView) {
        _headImgView = [UIImageView new];
        _headImgView.layer.cornerRadius = 51 * 0.5;
        _headImgView.layer.masksToBounds = YES;
        _headImgView.layer.borderWidth = 0.5;
        _headImgView.layer.borderColor = [UIColor lightGrayColor].CGColor;

    }
    return _headImgView;
}

- (UIImageView *)authView
{
    if (!_authView) {
        _authView = [UIImageView new];
    }
    return _authView;
}

- (UILabel *)sortLabel
{
    if (!_sortLabel) {
        _sortLabel = [UILabel new];
        _sortLabel.textColor = [UIColor blackColor];
        _sortLabel.font = [UIFont systemFontOfSize:20];
    }
    return _sortLabel;
}

- (UILabel *)authorLabel
{
    if (!_authorLabel) {
        _authorLabel = [UILabel new];
        _authorLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:14.0];
        _authorLabel.text = @"花田小憩OC版  github :https://github.com/leeSmile/xiaoqi";
    }
    return _authorLabel;
}

- (void)setSort:(int)sort
{
    _sort = sort;
    
    self.sortLabel.text = [NSString stringWithFormat:@"%zd",sort];
    
}
- (void)setAuthor:(Author *)author
{
    _author = author;
    [self.headImgView setImageWithURL:[NSURL URLWithString:author.headImg] placeholderImage:[UIImage imageNamed:@"pc_default_avatar"]];
    self.authorLabel.text = author.userName?author.userName:@"佚名";
    self.authView.image = author.authImage;
}
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}
@end
