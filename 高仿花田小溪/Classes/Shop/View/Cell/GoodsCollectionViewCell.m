//
//  GoodsCollectionViewCell.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/7/4.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "GoodsCollectionViewCell.h"

@interface GoodsCollectionViewCell ()
//缩略图
ImageView_(bgView)
// 蒙版
View_(coverView)
// 类型
Label_(typeLabel)
// 商品名称
Label_(nameLabel)
// 商品价格
Label_(priceLabel)
@end

@implementation GoodsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.coverView];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.priceLabel];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bgView);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel);
        make.bottom.equalTo(self.priceLabel.mas_top).offset(-6);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.bottom.equalTo(self.nameLabel.mas_top).offset(-3);
    }];
}

- (UIImageView *)bgView
{
    if (!_bgView) {
        _bgView = [UIImageView new];
    }
    return _bgView;
}

- (UIView *)coverView
{
    if (!_coverView) {
        _coverView = [UIView new];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.3;
    }
    return _coverView;
}
- (UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [UILabel new];
        _typeLabel.font = [UIFont systemFontOfSize:13];
        _typeLabel.textColor = [UIColor whiteColor];
        _typeLabel.backgroundColor = [UIColor clearColor];
    }
    return _typeLabel;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.backgroundColor = [UIColor clearColor];
    }
    return _nameLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont systemFontOfSize:11];
        _priceLabel.textColor = [UIColor whiteColor];
        _priceLabel.backgroundColor = [UIColor clearColor];
    }
    return _priceLabel;
}

- (void)setGoods:(Goods *)goods
{
    _goods = goods;
    [self.bgView setImageWithURL:[NSURL URLWithString:goods.fnAttachmentSnap] placeholderImage:[UIImage imageNamed:@"placehodler"]];
    self.typeLabel.text = goods.fnEnName;
    self.nameLabel.text = goods.fnName;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%zd",goods.fnMarketPrice];
}
@end
