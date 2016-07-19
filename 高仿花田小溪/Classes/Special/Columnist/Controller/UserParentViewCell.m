//
//  UserParentViewCell.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/30.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "UserParentViewCell.h"

@interface UserParentViewCell ()

@end

@implementation UserParentViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self.contentView addSubview:self.authorLabel];
    [self.contentView addSubview:self.headImgView];
    [self.contentView addSubview:self.desLabel];
}

- (UILabel *)authorLabel
{
    if (!_authorLabel) {
        _authorLabel = [UILabel new];
        _authorLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:14.0];
        _authorLabel.textColor = [UIColor blackColor];
        _authorLabel.text = @"xiaoxiao";
    }
    return _authorLabel;
}

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
        UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeadImage)];
        
        [_headImgView addGestureRecognizer:tag];
    }
    return _headImgView;
}

- (UILabel *)desLabel
{
    if (!_desLabel) {
        _desLabel = [UILabel new];
        _desLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:12];
        _desLabel.textColor = [UIColor lightGrayColor];
    }
    return _desLabel;
}

- (void)setAuthor:(Author *)author
{
    _author = author;
    [self.headImgView setImageWithURL:[NSURL URLWithString:author.headImg] placeholderImage:[UIImage imageNamed:@"pc_default_avatar"]];
    self.authorLabel.text = author.userName ? author.userName :@"佚名";
    self.desLabel.text = author.content ? author.content :@"这家伙很懒, 什么也没留下...";
}

- (void)clickHeadImage
{
    if (self.parentViewController&&self.author) {
        //弹框
    }
}
@end
