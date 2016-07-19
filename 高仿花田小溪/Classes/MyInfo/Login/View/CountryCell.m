//
//  CountryCell.m
//  高仿花田小憩OC版
//
//  Created by Lee on 16/7/16.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "CountryCell.h"

@interface CountryCell ()
/// 下划线
ImageView_(underline)
@end

@implementation CountryCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self.contentView addSubview:self.countryNameLabel];
    [self.contentView addSubview:self.countryIDLabel];
    [self.contentView addSubview:self.underline];
    
    [self.countryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.countryIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-20));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.underline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.countryNameLabel.mas_left);
        make.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@1);
    }];
}

- (UILabel *)countryNameLabel
{
    if (!_countryNameLabel) {
        _countryNameLabel = [UILabel new];
        _countryNameLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:14];
        
    }
    return _countryNameLabel;
}


- (UILabel *)countryIDLabel
{
    if (!_countryIDLabel) {
        _countryIDLabel = [UILabel new];
        _countryIDLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:14];
        _countryIDLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        _countryIDLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _countryIDLabel;
}
- (UIImageView *)underline
{
    if (!_underline) {
        _underline = [UIImageView new];
        _underline.image = [UIImage imageNamed:@"underLine"];
    }
    return _underline;
}

@end
