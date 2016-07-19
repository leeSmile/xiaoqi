//
//  TopViewController.m
//  高仿花田小憩OC版
//
//  Created by Lee on 16/6/26.
//  Copyright © 2016年 Lee. All rights reserved.
//

//#warning 使用一个tableView  当网络不好时切换  用户体验不好！！
#import "TopViewController.h"
#import "TopMenuView.h"
#import "NetworkTool.h"
#import "TopArticleNormalCell.h"
#import "TopArticleOtherCell.h"
#import "TopAuthorCell.h"
#import "DetailViewController.h"
#import "ColumnistViewController.h"
static NSString *TopAuthorCellReuseIdentifier = @"TopAuthorCellReuseIdentifier";
static NSString *TopArticleNormalCellReuseIdentifier = @"TopArticleNormalCellReuseIdentifier";
static NSString *TopArticleOtherCellReuseIdentifier = @"TopArticleOtherCellReuseIdentifier";
@interface TopViewController ()<UITableViewDelegate, UITableViewDataSource, TopMenuViewDelegate>
//
mArray_(datasource)
TableView_(tableView)
/// 获取数据的操作, 默认是获取专栏
String_(action)
DIYObj_(NetworkTool, tools)
DIYObj_(TopMenuView, topMenuView)
@end

@implementation TopViewController
//懒加载
- (TopMenuView *)topMenuView
{
    if (!_topMenuView) {
        _topMenuView = [[TopMenuView alloc] init];
        _topMenuView.delegate = self;
//        _topMenuView.backgroundColor = [UIColor redColor];
    }
    return _topMenuView;
}

- (NetworkTool *)tools
{
    if (!_tools) {
        _tools = [[NetworkTool alloc] init];
    }
    return _tools;
}
- (void)setDatasource:(NSMutableArray *)datasource
{
    _datasource = datasource;
//    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self getList];
}

- (void)setup
{
    self.action = TopContents;

    [self customTitle:@"本周排行TOP10"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topMenuView];
    
    [self.view addSubview:self.tableView];
    
    //左按钮
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    //约束
    [self.topMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@40);

    }];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.topMenuView.mas_bottom);
    }];
    
}

// 默认请求专栏
- (void)getList
{
    [self.tools getTop10DataWithActionType:self.action block:^(id json) {
        if ([json isKindOfClass:[NSArray class]]) {
            [self.datasource removeAllObjects];
            self.datasource = json;
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //专题
    if ([self.action isEqualToString:TopContents]) {
        
        if ([self.datasource[indexPath.row] isKindOfClass:[Article class]]) {

            if (indexPath.row <3) {
                TopArticleNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:TopArticleNormalCellReuseIdentifier forIndexPath:indexPath];
                if (self.datasource.count) {
                    cell.article = self.datasource[indexPath.row];
                    cell.sort = (int)(indexPath.row + 1);
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                
            }else
            {
                TopArticleOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:TopArticleOtherCellReuseIdentifier forIndexPath:indexPath];
                if (self.datasource.count) {
                    cell.article = self.datasource[indexPath.row];
                    cell.sort = (int)(indexPath.row + 1);
                }
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
        
        
    }
    //作者

    TopAuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:TopAuthorCellReuseIdentifier forIndexPath:indexPath];

    if (self.datasource.count) {
        if ([self.datasource[indexPath.row] isKindOfClass:[Author class]]) {
            cell.author = self.datasource[indexPath.row];
            cell.sort = (int)(indexPath.row + 1);
        }
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //如果是作者
    if ([self.action isEqualToString:TopArticleAuthor]) {
        
        if ([self.datasource[indexPath.row] isKindOfClass:[Author class]]) {

            return 60;
        }
        
    }
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //如果是作者
    if ([self.action isEqualToString:TopArticleAuthor]) {
        ColumnistViewController *columnistVC = [[ColumnistViewController alloc] init];
        columnistVC.author = self.datasource[indexPath.row];
        [self.navigationController pushViewController:columnistVC animated:YES];
    }else
    {
        DetailViewController *detailVC = [[DetailViewController alloc] init];
        detailVC.article = self.datasource[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
    
    
}




#pragma mark - TopMenuViewDelegate
- (void)topMenuView:(TopMenuView *)topMenuView selectedTopAction:(NSString *)action
{
    LXLog(@"%@",action);
    self.action = action;
    [self.datasource removeAllObjects];

    [self getList];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = Color(241);
        [_tableView registerClass:[TopArticleNormalCell class] forCellReuseIdentifier:TopArticleNormalCellReuseIdentifier];
        [_tableView registerClass:[TopArticleOtherCell class] forCellReuseIdentifier:TopArticleOtherCellReuseIdentifier];
        [_tableView registerClass:[TopAuthorCell class] forCellReuseIdentifier:TopAuthorCellReuseIdentifier];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
