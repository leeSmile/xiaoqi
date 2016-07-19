//
//  CommentViewCell.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/29.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "CommentViewCell.h"

#import "UIImageView+WebCache.h"
// 默认头像宽高
static CGFloat DefaultHeadHeight = 51.0;
// 默认10间距
static CGFloat DefaultMargin10 = 10.0;
// 默认15间距
static CGFloat DefaultMargin15 = 15.0;
// 默认20间距
static CGFloat DefaultMargin20 = 20.0;

@interface CommentViewCell ()
/// 头像
ImageView_(headImageView)
//用户名
Label_(userNameLable)
//时间
Label_(timeLable)
//内容
Label_(contentLable)
//回复按钮
Button_(replyBtn)
//更多操作按钮
Button_(moreBtn)
///分割线
ImageView_(underLine)

@end

@implementation CommentViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.userNameLable];
    [self.contentView addSubview:self.timeLable];
    [self.contentView addSubview:self.contentLable];
    [self.contentView addSubview:self.replyBtn];
    [self.contentView addSubview:self.moreBtn];
    [self.contentView addSubview:self.underLine];
    
    self.timeLable.textAlignment = NSTextAlignmentRight;
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(DefaultMargin15);
        make.top.equalTo(self.contentView).offset(DefaultMargin10);
        make.size.mas_equalTo(CGSizeMake(DefaultHeadHeight, DefaultHeadHeight));
    }];
    
    [self.userNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(DefaultMargin10);
        make.top.equalTo(self.headImageView).offset(DefaultMargin10);
    }];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userNameLable);
        make.right.equalTo(self.contentView).offset(-DefaultMargin15);
    }];
    
    [self.contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLable);
        make.right.equalTo(self.contentView).offset(-DefaultMargin20);
        make.top.equalTo(self.headImageView.mas_bottom);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.timeLable);
        make.top.equalTo(self.contentLable.mas_bottom).offset(DefaultMargin10);
        make.width.equalTo(@40);
    }];
    
    [self.replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.moreBtn);
        make.right.equalTo(self.moreBtn.mas_left);
    }];
    
    [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
    
    
}

- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [UIImageView new];
        _headImageView.layer.cornerRadius = DefaultHeadHeight * 0.5;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

- (UILabel *)userNameLable
{
    if (!_userNameLable) {
        _userNameLable = [UILabel new];
        _userNameLable.textColor = [UIColor blackColor];
        _userNameLable.font = [UIFont systemFontOfSize:14];
    }
    return _userNameLable;
}
- (UILabel *)timeLable
{
    if (!_timeLable) {
        _timeLable = [UILabel new];
        _timeLable.textColor = [UIColor lightGrayColor];
        _timeLable.font = [UIFont systemFontOfSize:11];
    }
    return _timeLable;
}
- (UILabel *)contentLable
{
    if (!_contentLable) {
        _contentLable = [UILabel new];
        _contentLable.textColor = [UIColor lightGrayColor];
        _contentLable.font = [UIFont systemFontOfSize:12];
        _contentLable.numberOfLines = 0;
    }
    return _contentLable;
}
- (UIButton *)replyBtn
{
    if (!_replyBtn) {
        _replyBtn = [UIButton title:@"回复" imageName:nil target:self selector:@selector(click:) font:[UIFont systemFontOfSize:12] titleColor:[UIColor orangeColor]];

    }
    return _replyBtn;
}
- (UIButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [UIButton title:nil imageName:@"p_more_19x15" target:self selector:@selector(click:) font:nil titleColor:nil];

    }
    return _moreBtn;
}

- (void)click:(UIButton *)btn
{
    if (btn == self.replyBtn) {
        if ([self.delegate respondsToSelector:@selector(commentViewCell: didClickBtn: ReplyComment:)]) {
            [self.delegate commentViewCell:self didClickBtn:Reply ReplyComment:self.comment];
        }
        
    }else if (btn == self.moreBtn)
    {
        if ([self.delegate respondsToSelector:@selector(commentViewCell: didClickBtn: ReplyComment:)]) {
            [self.delegate commentViewCell:self didClickBtn:More ReplyComment:self.comment];
        }
    }
}

- (UIImageView *)underLine
{
    if (!_underLine) {
        _underLine = [UIImageView new];
        _underLine.image = [UIImage imageNamed:@"underLine"];
    }
    return _underLine;
}

- (void)setComment:(Comment *)comment
{
    _comment = comment;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:comment.writer.headImg] placeholderImage:[UIImage imageNamed:@"p_avatar"]];
    self.userNameLable.text = comment.anonymous ? @"匿名用户" : comment.writer.userName;
    self.timeLable.text = comment.createDateDesc;
    
    if (comment.toUser.ID.length > 0) {
        NSString *userName = comment.toUser.userName.length > 0 ? comment.toUser.userName : @"匿名用户";
        NSString *userNameColo = [NSString stringWithFormat:@"@%@:",userName];
        NSString *content = [NSString stringWithFormat:@"%@%@",userNameColo,comment.content];
        NSRange range = [content rangeOfString:userNameColo];
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content];
        [attr addAttributes:@{NSForegroundColorAttributeName : rgb255(203, 47, 34)} range:range];
        self.contentLable.attributedText = attr;
    }else
    {
        self.contentLable.text = comment.content;
    }
}
@end
