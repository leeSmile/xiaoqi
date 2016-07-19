//
//  AddressViewCell.m
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/7/19.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "AddressViewCell.h"

@interface AddressViewCell ()
Label_(addressLabel)// 收货地址
Label_(nameLabel)// 收货人
Label_(phoneLabel)// 电话
ImageView_(underLine)// 分割线
Button_(checkBox)// 选择按钮
@end

@implementation AddressViewCell

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
    [self.contentView addSubview:self.underLine];
    [self.contentView addSubview:self.checkBox];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.phoneLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@15);
    }];
    
    [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(17, 17));
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(self.checkBox.mas_left).offset(-15);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.right.equalTo(self.checkBox.mas_left).offset(-10);
    }];
    
    [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@1);
    }];
}

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [UILabel new];
        _addressLabel.font = [UIFont systemFontOfSize:13];
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
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textColor = [UIColor blackColor];

    }
    return _nameLabel;
}
- (UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [UILabel new];
        _phoneLabel.font = [UIFont systemFontOfSize:13];
        _phoneLabel.textColor = [UIColor blackColor];
        
    }
    return _phoneLabel;
}
- (UIImageView *)underLine
{
    if (!_underLine) {
        _underLine = [UIImageView new];
        _underLine.image = [UIImage imageNamed:@"underLine"];
    }
    return _underLine;
}
- (UIButton *)checkBox
{
    if (!_checkBox) {
        _checkBox = [UIButton title:nil imageName:@"f_adressUnSel_18x18" target:nil selector:nil font:nil titleColor:nil];
        [_checkBox setImage:[UIImage imageNamed:@"f_adressSel_17x17"] forState:UIControlStateSelected];
    }
    return _checkBox;
}

- (void)setIAddress:(Address *)iAddress
{
    _iAddress = iAddress;
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@牛背山666号洞",iAddress.fnConsigneeAddress,iAddress.fnConsigneeAddress];
    self.phoneLabel.text = [NSString stringWithFormat:@"%@",iAddress.fnMobile];
    self.nameLabel.text = iAddress.fnUserName;
    
}
- (void)setSelectedAddress:(BOOL)selectedAddress
{
    _selectedAddress = selectedAddress;
    self.checkBox.selected = selectedAddress;
}
@end
