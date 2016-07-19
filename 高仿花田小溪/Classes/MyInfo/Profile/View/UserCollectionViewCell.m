//
//  UserCollectionViewCell.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/7/12.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "UserCollectionViewCell.h"

@interface UserCollectionViewCell ()
// 购物车
Button_(shopCarBtn)
// 提醒
Button_(remindBtn)
// 积分
Label_(pointsLabel)
// 已经获得的积分
Label_(pointsNumLabel)
// 经验
Label_(experienceLabel)
// 等级
Button_(levelBtn)
// 经验条
Button_(empiricalBtn)
// 两条分割线
ImageView_(pointsLine)
ImageView_(experienceLine)
@end

@implementation UserCollectionViewCell
- (void)setup
{
    [super setup];
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.shopCarBtn];
    [self.contentView addSubview:self.remindBtn];
    [self.contentView addSubview:self.levelBtn];
    [self.contentView addSubview:self.experienceLine];
    [self.contentView addSubview:self.experienceLabel];
    [self.contentView addSubview:self.empiricalBtn];
    [self.contentView addSubview:self.pointsLine];
    [self.contentView addSubview:self.pointsLabel];
    [self.contentView addSubview:self.pointsNumLabel];
    
    //约束
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
     
        make.left.equalTo(@15);
        make.top.equalTo(@30);
        make.size.mas_equalTo(CGSizeMake(51, 51));
    }];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headImgView).offset(5);
        make.left.equalTo(self.headImgView.mas_right).offset(10);
        make.width.lessThanOrEqualTo(@250);
    }];
    
    [self.remindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.authorLabel);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    [self.shopCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.remindBtn.mas_left).offset(-5);
        make.size.top.equalTo(self.remindBtn);
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.authorLabel);
        make.top.equalTo(self.authorLabel.mas_bottom).offset(10);
        make.right.equalTo(self.shopCarBtn.mas_left).offset(15);
    }];
    
    [self.pointsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.headImgView);
        make.top.equalTo(self.headImgView.mas_bottom).offset(20);
        make.height.equalTo(@15);
    }];
    
    [self.pointsLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.pointsLabel.mas_right).offset(10);
        make.bottom.top.equalTo(self.pointsLabel);
        make.width.equalTo(@1);
    }];
    
    [self.pointsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.pointsLine.mas_right).offset(10);
        make.centerY.equalTo(self.pointsLine);
    }];
    
    [self.experienceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.pointsLabel);
        make.top.equalTo(self.pointsLabel.mas_bottom).offset(10);
        make.height.equalTo(self.pointsLabel);
    }];
    
    [self.experienceLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.experienceLabel.mas_right).offset(10);
        make.top.equalTo(self.experienceLabel);
        make.height.equalTo(self.pointsLabel);
        make.width.equalTo(@1);
    }];
    
    [self.levelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.experienceLine.mas_right).offset(10);
        make.centerY.equalTo(self.experienceLine);
    }];
    
    [self.empiricalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.levelBtn.mas_right).offset(10);
        make.top.equalTo(self.experienceLine);
        make.height.equalTo(self.pointsLabel);
        make.width.equalTo(@80);
    }];
}
- (void)setAuthor:(Author *)author
{
    [super setAuthor:author];
    self.pointsNumLabel.text = [NSString stringWithFormat:@"已获取%zd个积分",author.integral];
    [self.levelBtn setTitle:[NSString stringWithFormat:@"lv.%zd",author.level] forState:UIControlStateNormal];
    [self.empiricalBtn setTitle:[NSString stringWithFormat:@"%zd",author.experience] forState:UIControlStateNormal];

}
- (UIButton *)shopCarBtn
{
    if (!_shopCarBtn) {
        _shopCarBtn = [UIButton title:nil imageName:@"shoppingCar_35x35" target:self selector:@selector(clickCar) font:nil titleColor:nil];
        
    }
    return _shopCarBtn;
}
- (UIButton *)remindBtn
{
    if (!_remindBtn) {
        _remindBtn = [UIButton title:nil imageName:@"setIcon_35x35" target:self selector:@selector(clickRemindBtn) font:nil titleColor:nil];
        
    }
    return _remindBtn;
}
- (UILabel *)pointsLabel
{
    if (!_pointsLabel) {
        _pointsLabel = [UILabel new];
        _pointsLabel.font = [UIFont systemFontOfSize:11];
        _pointsLabel.textColor = [UIColor blackColor];
        _pointsLabel.text = @"积分值";
    }
    return _pointsLabel;
}
- (UILabel *)pointsNumLabel
{
    if (!_pointsNumLabel) {
        _pointsNumLabel = [UILabel new];
        _pointsNumLabel.font = [UIFont systemFontOfSize:11];
        _pointsNumLabel.textColor = [UIColor blackColor];
    }
    return _pointsNumLabel;
}
- (UILabel *)experienceLabel
{
    if (!_experienceLabel) {
        _experienceLabel = [UILabel new];
        _experienceLabel.font = [UIFont systemFontOfSize:11];
        _experienceLabel.textColor = [UIColor blackColor];
        _experienceLabel.text = @"经验值";
    }
    return _experienceLabel;
}
- (UIButton *)levelBtn
{
    if (!_levelBtn) {
        _levelBtn = [UIButton title:@"lv.1" imageName:nil target:nil selector:nil font:[UIFont systemFontOfSize:8] titleColor:[UIColor whiteColor]];
        [_levelBtn setBackgroundImage:[UIImage imageNamed:@"pc_level_bg_33x10"] forState:UIControlStateNormal];
        
    }
    return _levelBtn;
}
- (UIButton *)empiricalBtn
{
    if (!_empiricalBtn) {
        _empiricalBtn = [UIButton title:@"0" imageName:@"empirical_57x9" target:nil selector:nil font:[UIFont systemFontOfSize:10] titleColor:[UIColor blackColor]];
        _empiricalBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    }
    return _empiricalBtn;
}
- (UIImageView *)pointsLine
{
    if (!_pointsLine) {
        _pointsLine = [UIImageView new];
        _pointsLine.image = [UIImage imageNamed:@"f_loginfo_line_0x61"];
        
    }
    return _pointsLine;
}
- (UIImageView *)experienceLine
{
    if (!_experienceLine) {
        _experienceLine = [UIImageView new];
        _experienceLine.image = [UIImage imageNamed:@"f_loginfo_line_0x61"];
        
    }
    return _experienceLine;
}
#pragma mark -clikbtn
//点击购物车
- (void)clickCar
{
    if ([self.delegate respondsToSelector:@selector(UserCollectionViewCellClickShopCar:)]) {
        [self.delegate UserCollectionViewCellClickShopCar:self];
    }
}
//铃铛
- (void)clickRemindBtn
{
    if ([self.delegate respondsToSelector:@selector(UserCollectionViewCellclickRemind:)]) {
        [self.delegate UserCollectionViewCellclickRemind:self];
    }
}
@end
