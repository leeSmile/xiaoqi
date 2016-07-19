//
//  DetailWebViewCell.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/27.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "DetailWebViewCell.h"
#import "ImageBrowserViewController.h"
static NSString *DetailWebViewCellHeightChangeNoti = @"DetailWebViewCellHeightChangeNoti";
static NSString *DetailWebViewCellHeightKey = @"DetailWebCellHeightKey";
@interface DetailWebViewCell()<UIWebViewDelegate>

WebView_(webView)
BOOL_(isFinishLoad)
@end

@implementation DetailWebViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    _isFinishLoad = NO;
    [self.contentView addSubview:self.webView];
    
    //约束
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}



- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scrollView.scrollEnabled = NO;
        _webView.delegate = self;
    }
    return _webView;
}




- (void)setArticle:(Article *)article
{
    _article = article;

    NSString *urlStr = article.pageUrl?article.pageUrl:[NSString stringWithFormat:@"http://m.htxq.net//servlet/SysArticleServlet?action=preview&artId=%@",article.ID];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}


- (void)setCellHeigth:(float)cellHeigth
{
    _cellHeigth = cellHeigth;
    if (cellHeigth > 0) {
        NSDictionary *dic = @{DetailWebViewCellHeightKey:[NSString stringWithFormat:@"%fd",cellHeigth]};
        [[NSNotificationCenter defaultCenter] postNotificationName:DetailWebViewCellHeightChangeNoti object:nil userInfo:dic];
    }
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *str = request.URL.absoluteString;
    
    NSArray *components = [str componentsSeparatedByString:@"::"];
    
    if (components.count >= 1) {
        //如果是点击图片
        if ([components[0] isEqualToString:@"imageclick"]) {
            //跳转
            ImageBrowserViewController *vc = [[ImageBrowserViewController alloc] init];
            vc.imageUrls = @[[NSURL URLWithString:components.lastObject]];
            vc.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.parentViewController presentViewController:vc animated:YES completion:nil];
            return NO;
        }
        
        return YES;
    }
    
    LXLog(@"%@",str);
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //加载本地的JS文件
    NSString *jsStr = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"image" withExtension:@"js"] encoding:NSUTF8StringEncoding error:nil];
    [webView stringByEvaluatingJavaScriptFromString:jsStr];
    //为每个图片添加点击事件
    [webView stringByEvaluatingJavaScriptFromString:@"setImageClick()"];
    
     NSInteger height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] intValue];
    //避免浪费性能，所以计算一次高度即可
    if (!self.isFinishLoad && webView.scrollView.contentSize.height > 0) {
        self.isFinishLoad = YES ;
        self.cellHeigth = height;
//#warning 使用这个方法算出的高度不准
//        self.cellHeigth = webView.scrollView.contentSize.height;
    }
}
@end
