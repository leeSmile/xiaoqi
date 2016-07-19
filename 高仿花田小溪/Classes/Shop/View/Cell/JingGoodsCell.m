//
//  JingGoodsCell.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/7/4.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "JingGoodsCell.h"

@interface JingGoodsCell ()
//缩略图
ImageView_(attachment)
//类型: 最热/推荐
Button_(typeBtn)
// 所属分类
Label_(categoryLabel)
// 标题
Label_(titleLabel)
// 价格
Label_(priveLabel)
@end

@implementation JingGoodsCell

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
    self.backgroundColor = Color(241);
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.attachment];
    [self.contentView addSubview:self.typeBtn];
    [self.contentView addSubview:self.categoryLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.priveLabel];
    
    //布局
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    [self.attachment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(@190);
    }];
    
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.attachment.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(28, 25.5));
    }];
    
    [self.categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeBtn.mas_right).offset(15);
        make.top.equalTo(self.attachment.mas_bottom).offset(10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.categoryLabel);
        make.top.equalTo(self.categoryLabel.mas_bottom).offset(5);
    }];
    
    [self.priveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
    }];
}


- (UIImageView *)attachment
{
    if (!_attachment) {
        _attachment = [UIImageView new];
    }
    return _attachment;
}

- (UIButton *)typeBtn
{
    if (!_typeBtn) {
        _typeBtn = [UIButton new];
        _typeBtn.userInteractionEnabled = YES;
        _typeBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    }
    return _typeBtn;
}

- (UILabel *)categoryLabel
{
    if (!_categoryLabel) {
        _categoryLabel = [UILabel new];
        _categoryLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:14];
    }
    return _categoryLabel;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:15];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
- (UILabel *)priveLabel
{
    if (!_priveLabel) {
        _priveLabel = [UILabel new];
        _priveLabel.font = [UIFont systemFontOfSize:15];
        _priveLabel.textColor = [UIColor brownColor];
    }
    return _priveLabel;
}

- (void)setGoods:(Goods *)goods
{
    _goods = goods;
    [self.attachment setImageWithURL:[NSURL URLWithString:goods.fnAttachment] placeholderImage:[UIImage imageNamed:@"placehodler"]];
    self.categoryLabel.text = goods.fnEnName;
    self.titleLabel.text = goods.fnName;
    self.priveLabel.text = [NSString stringWithFormat:@"￥%zd",goods.fnMarketPrice];
    [self.typeBtn setBackgroundImage:goods.fnjianIcon forState:UIControlStateNormal];
    [self.typeBtn setTitle:goods.fnjianTitle forState:UIControlStateNormal];
}
@end
