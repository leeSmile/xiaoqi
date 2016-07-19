//
//  TotalInfoViewCell.m
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/7/18.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "TotalInfoViewCell.h"


@interface TotalInfoViewCell ()
Label_(totalNumLabel)// 总共多少件产品
Label_(totalPriceLabel)// 总价
Label_(luggageLabel)// 运费
Label_(luggagePriceLabel)// 运费的总价
Label_(totalLabel)// 总计
Label_(priceLabel)// 总价
@end

@implementation TotalInfoViewCell

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
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.totalLabel];
    [self.contentView addSubview:self.totalNumLabel];
    [self.contentView addSubview:self.luggageLabel];
    [self.contentView addSubview:self.luggagePriceLabel];
    [self.contentView addSubview:self.totalPriceLabel];
    [self.contentView addSubview:self.priceLabel];
    
    [self.totalNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@15);
    }];
    
    [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.totalNumLabel);
    }];
    
    [self.luggageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalNumLabel);
        make.top.equalTo(self.totalNumLabel.mas_bottom).offset(15);
    }];
    
    [self.luggagePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.totalPriceLabel);
        make.top.equalTo(self.luggageLabel);
    }];
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.luggageLabel);
        make.top.equalTo(self.luggageLabel.mas_bottom).offset(15);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.luggagePriceLabel);
        make.top.equalTo(self.totalLabel);
    }];
}
- (UILabel *)totalNumLabel
{
    if (!_totalNumLabel) {
        _totalNumLabel = [UILabel new];
        _totalNumLabel.font = [UIFont systemFontOfSize:13];
        _totalNumLabel.textColor = [UIColor darkGrayColor];
    }
    return _totalNumLabel;
}
- (UILabel *)totalPriceLabel
{
    if (!_totalPriceLabel) {
        _totalPriceLabel = [UILabel new];
        _totalPriceLabel.font = [UIFont systemFontOfSize:13];
        _totalPriceLabel.textColor = [UIColor blackColor];
    }
    return _totalPriceLabel;
}
- (UILabel *)luggageLabel
{
    if (!_luggageLabel) {
        _luggageLabel = [UILabel new];
        _luggageLabel.font = [UIFont systemFontOfSize:13];
        _luggageLabel.textColor = [UIColor darkGrayColor];
        _luggageLabel.text = @"运费";
    }
    return _luggageLabel;
}
- (UILabel *)luggagePriceLabel
{
    if (!_luggagePriceLabel) {
        _luggagePriceLabel = [UILabel new];
        _luggagePriceLabel.font = [UIFont systemFontOfSize:13];
        _luggagePriceLabel.textColor = [UIColor blackColor];
    }
    return _luggagePriceLabel;
}
- (UILabel *)totalLabel
{
    if (!_totalLabel) {
        _totalLabel = [UILabel new];
        _totalLabel.font = [UIFont systemFontOfSize:13];
        _totalLabel.textColor = [UIColor darkGrayColor];
        _totalLabel.text = @"总计";
    }
    return _totalLabel;
}
- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.textColor = [UIColor orangeColor];
    }
    return _priceLabel;
}

- (void)setNum:(int)num
{
    _num = num;
    if (self.goods) {
        self.totalNumLabel.text = [NSString stringWithFormat:@"共%zd件产品",num];
        self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%zd",self.goods.fnMarketPrice*num];
        self.luggagePriceLabel.text = @"¥ 0";
        self.priceLabel.text = [NSString stringWithFormat:@"￥%zd",self.goods.fnMarketPrice*num];
    }
}

@end
