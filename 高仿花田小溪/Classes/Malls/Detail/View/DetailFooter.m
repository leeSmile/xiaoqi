//
//  DetailFooter.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/7/10.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "DetailFooter.h"
#import "ShopCarBtn.h"

@interface DetailFooter ()
DIYObj_(ShopCarBtn, shopCarBtn)
Label_(priceLabel)
Button_(addtoCar)
Button_(buyNow)

@property(nonatomic, strong)CALayer *animLayer;
@property(nonatomic, strong)UIBezierPath *animPath;
@property(nonatomic, strong)CAAnimationGroup *groupAnim;
@end

@implementation DetailFooter

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self initView];
    }
    return self;
}

- (void)initView
{
    
    self.num = 0;
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.shopCarBtn];
    [self addSubview:self.priceLabel];
    [self addSubview:self.addtoCar];
    [self addSubview:self.buyNow];
    
    //约束
    [self.shopCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(self);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopCarBtn.mas_right).offset(20);
        make.centerY.equalTo(self.shopCarBtn);
        make.width.equalTo(@100);
    }];
    
    [self.addtoCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right);
        make.top.bottom.equalTo(self);
        make.width.equalTo(self.buyNow);
    }];
    
    [self.buyNow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addtoCar.mas_right);
        make.right.equalTo(self);
        make.top.bottom.equalTo(self);
        make.width.equalTo(self.addtoCar);
    }];
}

- (CALayer *)animLayer
{
    if (!_animLayer) {
        _animLayer = [[CALayer alloc] init];
        _animLayer.backgroundColor = [UIColor redColor].CGColor;
        _animLayer.contentsGravity = kCAGravityResizeAspectFill;
        _animLayer.bounds = CGRectMake(0, 0, 50, 50);
        _animLayer.cornerRadius = CGRectGetHeight(_animLayer.bounds) / 2;
        _animLayer.masksToBounds = YES;
    }
    return _animLayer;
}
- (UIBezierPath *)animPath
{
    if (!_animPath) {
        _animPath = [[UIBezierPath alloc] init];

    }
    return _animPath;
}
- (CAAnimationGroup *)groupAnim
{
    if (!_groupAnim) {
        
        //位置
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.path = self.animPath.CGPath;
        animation.rotationMode = kCAAnimationRotateAuto;
        
        //形变
        CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        expandAnimation.duration = 1;
        expandAnimation.fromValue = @(0.5);
        expandAnimation.toValue = @(2);
        /*动画速度,何时快、慢
         (
         kCAMediaTimingFunctionLinear 线性（匀速）|
         kCAMediaTimingFunctionEaseIn 先慢|
         kCAMediaTimingFunctionEaseOut 后慢|
         kCAMediaTimingFunctionEaseInEaseOut 先慢 后慢 中间快|
         kCAMediaTimingFunctionDefault 默认|
         )
         */
        expandAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        narrowAnimation.beginTime = 1;
        narrowAnimation.duration = 0.5;
        narrowAnimation.fromValue = @(2);
        narrowAnimation.toValue = @(0.5);
        narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        _groupAnim = [[CAAnimationGroup alloc] init];
        _groupAnim.animations = @[animation,expandAnimation,narrowAnimation];
        _groupAnim.duration = 1.5;
        _groupAnim.removedOnCompletion = NO;
        _groupAnim.fillMode = kCAFillModeForwards;
        _groupAnim.delegate = self;
    }
    return _groupAnim;
}
- (ShopCarBtn *)shopCarBtn
{
    if (!_shopCarBtn) {
        _shopCarBtn = [[ShopCarBtn alloc] init];
        [_shopCarBtn setImage:[UIImage imageNamed:@"f_cart_23x21"] forState:UIControlStateNormal];
    }
    return _shopCarBtn;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.textColor = [UIColor blackColor];
        _priceLabel.font = [UIFont systemFontOfSize:16];
        _priceLabel.text = @"1000";
    }
    return _priceLabel;
}
- (UIButton *)addtoCar
{
    if (!_addtoCar) {
        _addtoCar = [UIButton title:@"加入购物车" imageName:nil target:self selector:@selector(gotoShopCar) font:[UIFont systemFontOfSize:14] titleColor:[UIColor whiteColor]];
        _addtoCar.backgroundColor = [UIColor lightGrayColor];
    }
    return _addtoCar;
}
- (UIButton *)buyNow
{
    if (!_buyNow) {
        _buyNow = [UIButton title:@"购买" imageName:nil target:self selector:@selector(clickBtn:) font:[UIFont systemFontOfSize:14] titleColor:[UIColor whiteColor]];
        _buyNow.backgroundColor = [UIColor blackColor];
    }
    return _buyNow;
}
- (void)setGoods:(Goods *)goods
{
    _goods = goods;

    self.priceLabel.text = [NSString stringWithFormat:@"￥%zd",goods.fnMarketPrice];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:goods.fnAttachment]];
    if (data != nil) {
        self.animLayer.contents = (__bridge id _Nullable)([UIImage imageWithData:data].CGImage);
    }else
    {
        self.animLayer.contents =  (__bridge id _Nullable)([UIImage imageNamed:@"AppIcon"].CGImage);
    }
}

- (void)gotoShopCar
{
    if (self.num >= 99) {
        [[Tostal sharTostal] tostalMesg:@"亲, 企业采购请联系我们客服" tostalTime:2];
        return;
    }
    
    self.addtoCar.userInteractionEnabled = NO;
    
    //设置layer
    
    self.animLayer.position = self.addtoCar.center;
    [self.layer addSublayer:self.animLayer];
    [self.animPath moveToPoint:self.animLayer.position];
    
    //设置弧线
    CGFloat controlPointX = CGRectGetMaxX(self.addtoCar.frame) * 0.5;
    [self.animPath addQuadCurveToPoint:self.shopCarBtn.center controlPoint:CGPointMake(controlPointX, -self.frame.size.height * 5)];
    [self.animLayer addAnimation:self.groupAnim forKey:@"groups"];
    
}

- (void)clickBtn:(UIButton *)btn
{
    if (btn == self.buyNow) {
        if ([self.delegate respondsToSelector:@selector(clickBuyBlock:)]) {
            [self.delegate clickBuyBlock:self];
        }
    }
}

#pragma CAAnimationGroupdelegate 动画停止

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CAAnimation *animGroup = [self.animLayer animationForKey:@"groups"];
    if (animGroup != nil) {
        [self.animLayer removeFromSuperlayer];
        [self.animLayer removeAllAnimations];
        
        self.num += 1;
        self.shopCarBtn.num = self.num;
        
//        CATransition *animation = [[CATransition alloc] init];
//        animation.duration = 0.25;
//        
//        [self.shopCarBtn.layer addAnimation:animation forKey:nil];
        
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        shakeAnimation.duration = 0.25;
        shakeAnimation.fromValue = @(-5);
        shakeAnimation.toValue = @(5);
        shakeAnimation.autoreverses = YES;
        
        [self.shopCarBtn.layer addAnimation:shakeAnimation forKey:nil];
        self.addtoCar.userInteractionEnabled = YES;
    }
}
@end
