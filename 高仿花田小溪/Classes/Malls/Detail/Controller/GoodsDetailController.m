//
//  GoodsDetailController.m
//  高仿花田小憩OC版
//
//  Created by Lee on 16/7/10.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "GoodsDetailController.h"
#import "NetworkTool.h"
#import "OrderViewController.h"
#import "DetailFooter.h"
#import "ShareBlurView.h"
@interface GoodsDetailController ()<DetailFooterDelegate>
DIYObj_(NetworkTool, tools)

DIYObj_(DetailFooter, footer)
WebView_(detailWeb)
//分享
BOOL_(isShowShared)
//分享视图
DIYObj_(ShareBlurView, blur)

@end

@implementation GoodsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
}
- (void)setup
{
    
    self.isShowShared = NO;

    [self.view addSubview:self.detailWeb];
    [self.view addSubview:self.footer];
    
    //约束
    [self.footer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(@44);

    }];
    
    [self.detailWeb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.footer.mas_top);
    }];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ad_share"] style:UIBarButtonItemStyleDone target:self action:@selector(shareThread:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    //左按钮
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
}
- (void)getGoodsInfo
{
    [self.tools getGoodsInfoDataWithGoodsId:self.goodsId block:^(Goods *goods, NSError *error) {
        if (error == nil) {
            self.goods = goods;
        }else
        {
            [[Tostal sharTostal] tostalMesg:@"网络异常" tostalTime:2];
        }
    }];
}

//分享
- (void)shareThread:(UIBarButtonItem *)item
{
    //    item.
    if (!self.isShowShared) {
        self.isShowShared = YES;
        [KeyWindow addSubview:self.blur];
        
        [self.blur mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(KeyWindow).offset(64);
            make.left.right.bottom.equalTo(KeyWindow);
        }];
        [self.blur startAnim];
    }else
    {
        [self hideShareView];
    }
}
- (void)hideShareView
{
    [self.blur endAnim];
    self.isShowShared = NO;
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - DetailFooterDelegate

-(void)clickBuyBlock:(DetailFooter *)detailFooter
{
    LXLog(@"购买");
    OrderViewController *vc = [[OrderViewController alloc] init];
    vc.olderID = self.goodsId;
    vc.goods = self.goods;
    vc.buyNum = self.footer.num;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - set
//懒加载
- (ShareBlurView *)blur
{
    if (!_blur) {
        _blur = [[ShareBlurView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        [_blur addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideShareView)]];
    }
    return _blur;
}
- (void)setGoodsId:(NSString *)goodsId
{
    _goodsId = goodsId;
    [self getGoodsInfo];
}
- (void)setGoods:(Goods *)goods
{
    _goods = goods;
    self.footer.goods = goods;
    NSString *h5url = [NSString stringWithFormat:@"%@%@",GET_H5URL,self.goodsId];
    [self.detailWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:h5url]]];
}
- (UIWebView *)detailWeb
{
    if (!_detailWeb) {
        _detailWeb = [[UIWebView alloc] init];
        _detailWeb.backgroundColor = Color(241);
    }
    return _detailWeb;
}
- (DetailFooter *)footer
{
    if (!_footer) {
        _footer = [[DetailFooter alloc] init];

        _footer.delegate = self;
    }
    return _footer;
}
- (NetworkTool *)tools
{
    if (!_tools) {
        _tools = [[NetworkTool alloc] init];
    }
    return _tools;
}

@end
