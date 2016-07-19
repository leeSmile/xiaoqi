//
//  DetailViewController.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/27.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "DetailViewController.h"
#import "ToolBottomView.h"
#import "DetailHeadCell.h"
#import "DetailWebViewCell.h"
#import "DetailHeaderView.h"
#import "NetworkTool.h"
#import "ShareBlurView.h"
#import "CommentViewController.h"
// 头部Cell的高度
static float DetailHeadCellHeight = 240;
// HeaderView的高度
static float DetailHeaderViewHeight = 50;
// 底部工具栏的高度
static float DetailFooterViewHeight = 50;

static NSString *DetailHeadCellReuseIdentifier = @"DetailHeadCellReuseIdentifier";
static NSString *DetailWebCellReuseIdentifier = @"DetailWebCellReuseIdentifier";


static NSString *DetailWebViewCellHeightChangeNoti = @"DetailWebViewCellHeightChangeNoti";
static NSString *DetailWebViewCellHeightKey = @"DetailWebCellHeightKey";
@interface DetailViewController () <ToolBottomViewDelegate>

float_(WebCellHeight)
//分享
BOOL_(isShowShared)
//底部
DIYObj_(ToolBottomView, toolBar)
DIYObj_(NetworkTool, tools)
//分享视图
DIYObj_(ShareBlurView, blur)
@end

@implementation DetailViewController
//懒加载
- (ShareBlurView *)blur
{
    if (!_blur) {
        _blur = [[ShareBlurView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        [_blur addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideShareView)]];
    }
    return _blur;
}

- (NetworkTool *)tools
{
    if (!_tools) {
        _tools = [[NetworkTool alloc] init];
    }
    return _tools;
}

- (ToolBottomView *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[ToolBottomView alloc] init];
        _toolBar.backgroundColor = [UIColor whiteColor];
        _toolBar.layer.borderWidth = 0.5;
        _toolBar.layer.borderColor = [UIColor lightGrayColor ].CGColor;
        _toolBar.delegate = self;
        // 此时需要显示时间了
        self.article.isNotHomeList = YES;
        _toolBar.article = self.article;
    }
    return _toolBar;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self baseSetup];
    //不用请求数据  用的数据是老数据  不准
    [self getDetail];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addToolBar];
}
- (void)addToolBar
{
    [KeyWindow addSubview:self.toolBar];
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@50);

    }];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.toolBar removeFromSuperview];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)baseSetup
{
    self.isShowShared = NO;
    [self customTitle:self.article.title?self.article.title:@"详情"];
    //左按钮
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ad_share"] style:UIBarButtonItemStyleDone target:self action:@selector(shareThread:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    //注册
    [self.tableView registerClass:[DetailHeadCell class] forCellReuseIdentifier:DetailHeadCellReuseIdentifier];
    [self.tableView registerClass:[DetailWebViewCell class] forCellReuseIdentifier:DetailWebCellReuseIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //监听高度 通知
    Weak(self);
    [[NSNotificationCenter defaultCenter] addObserverForName:DetailWebViewCellHeightChangeNoti object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        wArg.WebCellHeight = [note.userInfo[DetailWebViewCellHeightKey] floatValue];
        [wArg.tableView reloadData];
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
- (void)getDetail
{
    [self.tools getArticleDetailDataWithDetailID:self.article.ID block:^(id json) {
        if ([json isKindOfClass:[Article class]]) {
            self.article = json;
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
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
#pragma mark -tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        DetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:DetailHeadCellReuseIdentifier];
        cell.article = self.article;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    
    DetailWebViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DetailWebCellReuseIdentifier];
    cell.article = self.article;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.parentViewController = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return DetailHeaderViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DetailHeaderView *headView = [[DetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, DetailHeaderViewHeight)];
    headView.article = self.article;
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return DetailHeadCellHeight;
    }
    return self.WebCellHeight?self.WebCellHeight:MY_HEIGHT -  DetailHeadCellHeight - DetailHeaderViewHeight - DetailFooterViewHeight;
}
#pragma mark -ToolBottomViewDelegate
- (void)toolBottomView:(ToolBottomView *)toolBottomView ToolBarBtnType:(ToolBarBtnType)ToolBarBtnType
{
    if (ToolBarBtnType == Comments) {
        LXLog(@"跳转到评论控制器");
        
        CommentViewController *commentVC = [[CommentViewController alloc] init];
        commentVC.bbsID = self.article.ID;
        [self.navigationController pushViewController:commentVC animated:YES];
    }
}
@end
