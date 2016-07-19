//
//  ProtocolViewController.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/7/12.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "ProtocolViewController.h"

@interface ProtocolViewController ()<UIWebViewDelegate>
WebView_(webView)
@end

@implementation ProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
    //左按钮
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
}

- (void)setHTM5Url:(NSString *)HTM5Url
{
    _HTM5Url = HTM5Url;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:HTM5Url]]];
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        [self.view addSubview:_webView];
        
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _webView;
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
