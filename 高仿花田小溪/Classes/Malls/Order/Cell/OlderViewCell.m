//
//  OlderViewCell.m
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/7/18.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "OlderViewCell.h"

@interface OlderViewCell ()
ImageView_(attachmentIcon)// 缩略图
Label_(titleLabel)// 标题
Label_(tipLabel)// tip
Label_(priveLabel)// 价格
@end

@implementation OlderViewCell

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
    [self.contentView addSubview:self.attachmentIcon];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.tipLabel];
    [self.contentView addSubview:self.priveLabel];
    
    //约束
    [self.attachmentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.attachmentIcon).offset(5);
        make.left.equalTo(self.attachmentIcon.mas_right).offset(10);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
    
    [self.priveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.attachmentIcon);
        make.left.equalTo(self.tipLabel);
    }];
}


- (UIImageView *)attachmentIcon
{
    if (!_attachmentIcon) {
        _attachmentIcon = [UIImageView new];
    }
    return _attachmentIcon;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:12];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:11];
        _tipLabel.text = @"花田小憩默认72小时内为您送货";
        _tipLabel.textColor = [UIColor lightGrayColor];
    }
    return _tipLabel;
}
- (UILabel *)priveLabel
{
    if (!_priveLabel) {
        _priveLabel = [UILabel new];
        _priveLabel.font = [UIFont systemFontOfSize:12];
        _priveLabel.textColor = [UIColor brownColor];
    }
    return _priveLabel;
}
- (void)setGoods:(Goods *)goods
{
    _goods = goods;
    [self.attachmentIcon setImageWithURL:[NSURL URLWithString:goods.fnAttachment] placeholderImage:[UIImage imageNamed:@"placehodler"]];
    self.priveLabel.text = [NSString stringWithFormat:@"￥%zd",goods.fnMarketPrice];
    self.titleLabel.text = goods.fnName;
}
@end
