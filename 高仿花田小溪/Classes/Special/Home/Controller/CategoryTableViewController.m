//
//  CategoryTableViewController.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/7/17.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "HomeArticleCell.h"
#import "Article.h"
#import "NetworkTool.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#import "ColumnistViewController.h"

static NSString *HomeArticleReuseIdentifier = @"HomeArticleReuseIdentifier";
@interface CategoryTableViewController ()<HomeArticleCellDelegate>
// 当前页
int_(currentPage)
// 文章数组
@property(nonatomic, strong) NSMutableArray<Article *> *articles;
DIYObj_(NetworkTool, tools)
//是否加载更多
BOOL_(isToLoadMore)
DIYObj_(Article, selecterArticle)
@end

@implementation CategoryTableViewController
- (NetworkTool *)tools
{
    if (!_tools) {
        _tools = [[NetworkTool alloc] init];
    }
    return _tools;
}

- (NSMutableArray *)articles
{
    if (!_articles) {
        _articles = [NSMutableArray array];
    }
    return _articles;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self getNewData];
    [self setRefresh];

}
//基本配置
- (void)setup
{
    self.currentPage = 0;
    self.isToLoadMore = NO;
    
    //左按钮
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
//    self.customTitle = self.selectedCategry.name;
    [self customTitle:self.selectedCategry.name];
//    self.navigationItem.
    
    
    //tableView配置
    //注册
    [self.tableView registerClass:[HomeArticleCell class] forCellReuseIdentifier:HomeArticleReuseIdentifier];
    self.tableView.rowHeight = 330;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    //    self.
    
}
//设置刷新控件
- (void)setRefresh
{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
//    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    self.tableView.mj_footer.hidden = YES;
}

//请求第一次数据列表
- (void)getNewData
{
    self.currentPage = 0;
    [self.articles removeAllObjects];
    
    [self.tools getHomeListDataWithCurrentPage:self.currentPage selectedCategry:self.selectedCategry block:^(id json) {
        
        [self.tableView.mj_header endRefreshing];
        
        if ([json isKindOfClass:[NSString class]]) {
            if ([json isEqualToString:@"已经到最后"] )//显示蒙版
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"已经到最后了";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hideAnimated:YES afterDelay:2];
                self.currentPage -= 1;
                return ;
            }
        }
        if ([json isKindOfClass:[NSArray class]]) {
            [self.articles addObjectsFromArray:json];
            self.isToLoadMore = NO;
            [self.tableView reloadData];
        }
        
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        self.isToLoadMore = NO;
        // 获取数据失败后
        self.currentPage -= 1;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"网路异常";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:2];
        LXLog(@"%@",error);
    }];
}

//请求更多
- (void)getMoreData
{
    [self.tools getHomeListDataWithCurrentPage:self.currentPage selectedCategry:self.selectedCategry block:^(id json) {
        
        [self.tableView.mj_header endRefreshing];
        
        if ([json isKindOfClass:[NSString class]]) {
            if ([json isEqualToString:@"已经到最后"] )//显示蒙版
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"已经到最后了";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hideAnimated:YES afterDelay:2];
                self.currentPage -= 1;
                return ;
            }
        }
        if ([json isKindOfClass:[NSArray class]]) {
            [self.articles addObjectsFromArray:json];
            //            self.articles = json;
            self.isToLoadMore = NO;
            [self.tableView reloadData];
        }
        
        //        LXLog(@"%@",json);
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        self.isToLoadMore = NO;
        // 获取数据失败后
        self.currentPage -= 1;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"网路异常";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:2];
        LXLog(@"%@",error);
    }];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeArticleReuseIdentifier forIndexPath:indexPath];
    
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.articles.count) {
        Article *article = self.articles[indexPath.row];
        //        LXLog(@"name -- %@",article.desc);
        cell.article = article;
        cell.delegate = self;
        //添加点击头像按钮的点击事件
    }
    
    if (self.articles.count && indexPath.row == self.articles.count - 1 && !self.isToLoadMore) {
        self.isToLoadMore = YES;
        
        self.currentPage += 1;
        LXLog(@"%zd",self.currentPage);
        [self getMoreData];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Article *article = self.articles[indexPath.row];
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.article = article;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - HomeArticleCellDelegate

- (void)clickHeadImage:(HomeArticleCell *)HomeArticleCell Article:(Article *)article
{
    
    NSIndexPath * path = [self.tableView indexPathForCell:HomeArticleCell];
    self.selecterArticle = self.articles[path.row];
    ColumnistViewController *vc = [[ColumnistViewController alloc] init];
    vc.author = self.selecterArticle.author;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
