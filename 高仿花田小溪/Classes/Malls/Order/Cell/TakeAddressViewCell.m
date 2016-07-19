//
//  TakeAddressViewCell.m
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/7/18.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "TakeAddressViewCell.h"

@interface TakeAddressViewCell ()
ImageView_(localView)// 地址图标
Label_(addressLabel)// 收货地址
Label_(nameLabel)// 收货人
Label_(phoneLabel)// 电话
@end

@implementation TakeAddressViewCell

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
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self.contentView addSubview:self.localView];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.phoneLabel];
    
    [self.localView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@15);
        make.size.mas_equalTo(CGSizeMake(16, 20));
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.localView);
        make.left.equalTo(self.localView.mas_right).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressLabel);
        make.top.equalTo(self.localView.mas_bottom).offset(15);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView).offset(-15);
    }];
}
- (UIImageView *)localView
{
    if (!_localView) {
        _localView = [UIImageView new];
        _localView.image = [UIImage imageNamed:@"local"];
    }
    return _localView;
}
- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [UILabel new];
        _addressLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:12];
        _addressLabel.textColor = [UIColor blackColor];
        _addressLabel.text = @"请填写您的收货地址";
        _addressLabel.numberOfLines = 0;
    }
    return _addressLabel;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:12];
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}
- (UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [UILabel new];
        _phoneLabel.font = [UIFont systemFontOfSize:12];
        _phoneLabel.textColor = [UIColor blackColor];
    }
    return _phoneLabel;
}

- (void)setIAddress:(Address *)iAddress
{
    _iAddress = iAddress;
    self.addressLabel.text = [NSString stringWithFormat:@"收货地址：%@%@",iAddress.fnConsigneeArea,iAddress.fnConsigneeAddress];
    self.phoneLabel.text = iAddress.fnMobile;
    self.nameLabel.text = [NSString stringWithFormat:@"收货人：%@",iAddress.fnUserName];
}
- (void)setIsNoAddress:(BOOL)isNoAddress
{
    _isNoAddress = isNoAddress;
    if (!isNoAddress) {
        self.nameLabel.hidden = YES;
    }else
    {
        self.nameLabel.hidden = NO;
    }
}
@end
