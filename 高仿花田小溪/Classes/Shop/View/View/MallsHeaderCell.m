//
//  MallsHeaderCell.m
//  高仿花田小憩OC版
//
//  Created by Lee on 16/7/10.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MallsHeaderCell.h"



@interface MallsHeaderCell ()
//精选
Button_(choiceness)
//商城
Button_(mall)
//积分
Button_(integral)
View_(underLine2)//底部分割线
View_(tipLine)//底部跟着滚动的短线
Button_(nextBtn)//记录上一个按钮
@end


@implementation MallsHeaderCell

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

    self.contentView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.topImageView];
    [self.contentView addSubview:self.choiceness];
    [self.contentView addSubview:self.mall];
    [self.contentView addSubview:self.integral];
    [self.contentView addSubview:self.underLine2];
    [self.contentView addSubview:self.tipLine];
    
    
}

- (XRCarouselView *)topImageView
{
    if (!_topImageView) {
        _topImageView = [[XRCarouselView alloc] init];
        _topImageView.frame = CGRectMake(0, 0, MY_WIHTE, 224);
        _topImageView.time = 2;
            }
    return _topImageView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //约束
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(@224);
    }];
    
    self.mall.center = CGPointMake(self.contentView.center.x, self.contentView.lx_height-20);
    
    CGFloat centerX1 = self.mall.lx_x * 0.5;
    CGFloat centerY1 = self.mall.lx_centerY;
    self.choiceness.lx_centerX =centerX1;
    self.choiceness.lx_centerY =centerY1;
    
    CGFloat maxIntroduceX = self.mall.lx_x +self.mall.lx_width;
    CGFloat centerX2 = (MY_WIHTE - maxIntroduceX) * 0.5 + maxIntroduceX;
    CGFloat centerY2 = self.mall.lx_centerY;
    self.integral.lx_centerX =centerX2;
    self.integral.lx_centerY =centerY2;
    
    [self.underLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(@(self.contentView.lx_height-44));
        make.height.equalTo(@1);
    }];
    [self.tipLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.choiceness.mas_left);
        make.width.equalTo(self.choiceness.mas_width);
        make.bottom.equalTo(self.underLine2.mas_top);
        make.height.equalTo(@2);
        
    }];
    
    //设置分页控件的frame
    CGFloat width = self.imageUrl.count * 30;
    CGFloat height = 20;
    CGFloat x = 10;
    CGFloat y = self.topImageView.frame.size.height  - height - 10;
    self.topImageView.pageControl.frame = CGRectMake(x, y, width, height);

}

- (UIButton *)choiceness
{
    if (!_choiceness) {
        _choiceness = [UIButton title:@"精选" imageName:nil target:self selector:@selector(clickBtn:) font:[UIFont systemFontOfSize:13] titleColor:[UIColor lightGrayColor]];

        [_choiceness sizeToFit];
    }
    return _choiceness;
}

- (UIButton *)mall
{
    if (!_mall) {
        _mall = [UIButton title:@"商城" imageName:nil target:self selector:@selector(clickBtn:) font:[UIFont systemFontOfSize:13] titleColor:[UIColor lightGrayColor]];

        [_mall sizeToFit];
    }
    return _mall;
}

- (UIButton *)integral
{
    if (!_integral) {
        _integral = [UIButton title:@"积分" imageName:nil target:self selector:@selector(clickBtn:) font:[UIFont systemFontOfSize:13] titleColor:[UIColor lightGrayColor]];

        [_integral sizeToFit];
    }
    return _integral;
}

- (UIView *)underLine2
{
    if (!_underLine2) {
        _underLine2 = [UIView new];
        _underLine2.backgroundColor = rgb255(164, 164, 164);
    }
    return _underLine2;
}
- (UIView *)tipLine
{
    if (!_tipLine) {
        _tipLine = [UIView new];
        _tipLine.backgroundColor = [UIColor blackColor];
    }
    return _tipLine;
}

- (void)clickBtn:(UIButton *)btn
{
    [self.nextBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.nextBtn = btn;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if (btn == self.choiceness) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tipLine.lx_centerX = self.choiceness.lx_centerX;
        }];
        
        
        if ([self.delegate respondsToSelector:@selector(commentViewCell: didClickBtn: )]) {
            [self.delegate commentViewCell:self didClickBtn:Choiceness];
        }
        
    }else if (btn == self.mall){
        [UIView animateWithDuration:0.25 animations:^{
            self.tipLine.lx_centerX = self.mall.lx_centerX;
        }];
        
        
        if ([self.delegate respondsToSelector:@selector(commentViewCell: didClickBtn: )]) {
            [self.delegate commentViewCell:self didClickBtn:Mall];
        }
        
    }else if (btn == self.integral){
        [UIView animateWithDuration:0.25 animations:^{
            self.tipLine.lx_centerX = self.integral.lx_centerX;
        }];
        
        if ([self.delegate respondsToSelector:@selector(commentViewCell: didClickBtn: )]) {
            [self.delegate commentViewCell:self didClickBtn:Integral];
        }
        
    }
    
    
}
- (void)setImageUrl:(NSMutableArray<NSString *> *)imageUrl
{
    _imageUrl = imageUrl;
    self.topImageView.imageArray = imageUrl;
    [self layoutIfNeeded];
}

@end
