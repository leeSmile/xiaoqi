//
//  DistributionViewCell.m
//  高仿花田小溪
//
//  Created by Lee on 16/7/18.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "DistributionViewCell.h"
#import "PlaceHolderTextView.h"
@interface DistributionViewCell ()<UITextViewDelegate>
Button_(anonymousCheckBox)//  匿名选择框
Label_(anonymousLabel)//  匿名配送
Label_(invoiceLabel)//  发票
Button_(invoiceCheckBox)// 发票选择框
DIYObj_(PlaceHolderTextView, invoiceMessageView)// 发票抬头
ImageView_(localView)// 地址图标
Label_(addressLabel)// 收货地址
Button_(clickBtn)// 点击跳转


//选中地址后 显示的Viwe
ImageView_(otherLocalView)// 地址图标
Label_(otherAddressLabel)// 收货地址
Label_(nameLabel)// 收货人
Label_(phoneLabel)// 电话
ImageView_(gotoIcon)// 可点击图片

BOOL_(isAddAddress)//是否已经添加了地址
@end

@implementation DistributionViewCell

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
    self.isAddAddress = NO;
    [self.contentView addSubview:self.anonymousCheckBox];
    [self.contentView addSubview:self.anonymousLabel];
    [self.contentView addSubview:self.invoiceLabel];
    [self.contentView addSubview:self.invoiceCheckBox];
    [self.contentView addSubview:self.invoiceMessageView];
    [self.contentView addSubview:self.localView];
    [self.contentView addSubview:self.addressLabel];
 
    //选中地址后需要显示的VIEW
    [self.contentView addSubview:self.otherLocalView];
    [self.contentView addSubview:self.otherAddressLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.gotoIcon];
    
    [self.contentView addSubview:self.clickBtn];
    
    //约束
    [self.anonymousCheckBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@20);
    }];
    
    [self.anonymousLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.anonymousCheckBox);
        make.left.equalTo(self.contentView).offset(45);
        make.right.equalTo(self.contentView).offset(-20);
    }];

    [self.invoiceCheckBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.anonymousCheckBox);
        make.top.equalTo(self.anonymousCheckBox.mas_bottom).offset(20);
    }];

    
    [self.invoiceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.anonymousLabel);
        make.centerY.equalTo(self.invoiceCheckBox);
    }];
    
    [self.invoiceMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.invoiceLabel.mas_bottom).offset(20);
        make.left.equalTo(self.anonymousCheckBox);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@60);
    }];
    
    [self.localView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.anonymousLabel.mas_left).offset(10);
        make.top.equalTo(self.invoiceMessageView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(16, 20));
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.localView.mas_right).offset(40);
        make.centerY.equalTo(self.localView);
    }];
    
    [self.clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.invoiceMessageView);
        make.top.equalTo(self.invoiceMessageView.mas_bottom);
        make.height.equalTo(@60);
    }];
    
    //选中后约束
    [self.otherLocalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.anonymousCheckBox);
        make.top.equalTo(self.invoiceMessageView.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(16, 20));
    }];
    
    [self.otherAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.otherLocalView);
        make.left.equalTo(self.otherLocalView.mas_right).offset(20);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.otherAddressLabel);
        make.top.equalTo(self.otherAddressLabel.mas_bottom).offset(15);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView).offset(-100);
    }];
    
    [self.gotoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.otherAddressLabel.mas_bottom);
        make.right.equalTo(self.contentView).offset(-50);
        make.size.mas_equalTo(CGSizeMake(16, 20));
    }];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addressChange:) name:InvoiceAddressChangeNotifyKey object:nil];
}
#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>0) {
        self.invoiceMessageView.placeHolderLabel.hidden = YES;
    }else
    {
        self.invoiceMessageView.placeHolderLabel.hidden = NO;
    }
    if (textView.text.length>140) {
        self.invoiceMessageView.text = [textView.text substringToIndex:140];
    }
}
- (UIButton *)anonymousCheckBox
{
    if (!_anonymousCheckBox) {
        _anonymousCheckBox = [UIButton title:nil imageName:@"f_check_12x12" target:self selector:@selector(checkit:) font:nil titleColor:nil];
        [_anonymousCheckBox setImage:[UIImage imageNamed:@"f_check_s_15x12"] forState:UIControlStateSelected];
    }
    return _anonymousCheckBox;
}
- (UILabel *)anonymousLabel
{
    if (!_anonymousLabel) {
        _anonymousLabel = [UILabel new];
        _anonymousLabel.font = [UIFont systemFontOfSize:12];
        _anonymousLabel.textColor = [UIColor blackColor];
        _anonymousLabel.numberOfLines = 0;
        _anonymousLabel.text = @"匿名配送(我们将为您的购买信息保密, 以花田小憩的名义将宝贝送出)";
    }
    return _anonymousLabel;
}
- (UILabel *)invoiceLabel
{
    if (!_invoiceLabel) {
        _invoiceLabel = [UILabel new];
        _invoiceLabel.font = [UIFont systemFontOfSize:12];
        _invoiceLabel.textColor = [UIColor blackColor];
        _invoiceLabel.text = @"需要发票";
    }
    return _invoiceLabel;
}
- (UIButton *)invoiceCheckBox
{
    if (!_invoiceCheckBox) {
        _invoiceCheckBox = [UIButton title:nil imageName:@"f_check_12x12" target:self selector:@selector(checkit:) font:nil titleColor:nil];
        [_invoiceCheckBox setImage:[UIImage imageNamed:@"f_check_s_15x12"] forState:UIControlStateSelected];
    }
    return _invoiceCheckBox;
}
- (PlaceHolderTextView *)invoiceMessageView
{
    if (!_invoiceMessageView) {
        _invoiceMessageView = [PlaceHolderTextView new];
        _invoiceMessageView.delegate = self;
        _invoiceMessageView.placeHolderLabel.text = @"发票抬头";
    }
    return _invoiceMessageView;
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
        _addressLabel.text = @"请选择发票邮寄地址";
        _addressLabel.numberOfLines = 0;
        
        [_addressLabel sizeToFit];
    }
    return _addressLabel;
}
- (void)setIsNeedInvoice:(BOOL)isNeedInvoice
{
    _isNeedInvoice = isNeedInvoice;
    if (!isNeedInvoice) {
        self.invoiceMessageView.hidden = YES;
        self.localView.hidden = YES;
        self.addressLabel.hidden = YES;
        self.clickBtn.hidden = YES;
        
        self.nameLabel.hidden = YES;
        self.phoneLabel.hidden = YES;
        self.otherAddressLabel.hidden = YES;
        self.otherLocalView.hidden = YES;
        self.gotoIcon.hidden = YES;
    }else
    {
        
        if (self.isAddAddress) {//做一个判断
            self.nameLabel.hidden = NO;
            self.phoneLabel.hidden = NO;
            self.otherAddressLabel.hidden = NO;
            self.otherLocalView.hidden = NO;
            self.gotoIcon.hidden = NO;
            
            self.invoiceMessageView.hidden = YES;
            self.localView.hidden = YES;
            self.addressLabel.hidden = YES;
        }else
        {
            
            self.localView.hidden = NO;
            self.addressLabel.hidden = NO;
            
            self.nameLabel.hidden = YES;
            self.phoneLabel.hidden = YES;
            self.otherAddressLabel.hidden = YES;
            self.otherLocalView.hidden = YES;
            self.gotoIcon.hidden = YES;
        }
        self.invoiceMessageView.hidden = NO;
        self.clickBtn.hidden = NO;
    }
}
- (UIButton *)clickBtn
{
    if (!_clickBtn) {
        _clickBtn = [UIButton new];

        _clickBtn.backgroundColor = [UIColor clearColor];
        [_clickBtn addTarget:self action:@selector(clickAddAddress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickBtn;
}



- (UIImageView *)otherLocalView
{
    if (!_otherLocalView) {
        _otherLocalView = [UIImageView new];
        _otherLocalView.image = [UIImage imageNamed:@"local"];
    }
    return _otherLocalView;
}
- (UILabel *)otherAddressLabel
{
    if (!_otherAddressLabel) {
        _otherAddressLabel = [UILabel new];
        _otherAddressLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:12];
        _otherAddressLabel.textColor = [UIColor blackColor];
//        _otherAddressLabel.text = @"请填写您的收货地址";
    }
    return _otherAddressLabel;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:12];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.text = @"ceshiceshiceshiceshi";
    }
    return _nameLabel;
}
- (UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [UILabel new];
        _phoneLabel.font = [UIFont systemFontOfSize:12];
        _phoneLabel.textColor = [UIColor blackColor];
        _phoneLabel.text = @"ceshiceshiceshiceshi";
    }
    return _phoneLabel;
}

- (UIImageView *)gotoIcon
{
    if (!_gotoIcon) {
        _gotoIcon = [UIImageView new];
        _gotoIcon.image = [UIImage imageNamed:@"goto"];
    }
    return _gotoIcon;
}
#pragma mark -click
- (void)checkit:(UIButton *)btn
{
    
    if (btn == self.invoiceCheckBox) {//发票
        self.invoiceCheckBox.selected = !btn.selected;
        self.isNeedInvoice = !self.isNeedInvoice;
        if ([self.delegate respondsToSelector:@selector(DistributionViewCell: didClickBtn: need:)]) {
            [self.delegate DistributionViewCell:self didClickBtn:invoice need:self.isNeedInvoice];
        }
    }else
    {
        self.anonymousCheckBox.selected = !btn.selected;
    }
}
- (void)clickAddAddress
{

    if ([self.delegate respondsToSelector:@selector(DistributionViewCellAddAddress)]) {
        [self.delegate DistributionViewCellAddAddress];
    }
}

- (void)setIAddress:(Address *)iAddress
{
    _iAddress = iAddress;
    self.otherAddressLabel.text = [NSString stringWithFormat:@"收货地址：%@%@",iAddress.fnConsigneeArea,iAddress.fnConsigneeAddress];
    self.phoneLabel.text = iAddress.fnMobile;
    self.nameLabel.text = [NSString stringWithFormat:@"收货人：%@",iAddress.fnUserName];
}
#pragma mark - self
- (void)addressChange:(NSNotification *)notify
{
    Address *address = notify.userInfo[AddressChangeNotifyKey];
    self.isAddAddress = YES;
    self.isNeedInvoice = YES;
    self.iAddress = address;
}
@end
