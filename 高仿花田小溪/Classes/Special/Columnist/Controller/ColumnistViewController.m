//
//  ColumnistViewController.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/30.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "ColumnistViewController.h"
#import "LevitateHeaderFlowLayout.h"
#import "ArticlesCollectionViewCell.h"
#import "AuthorIntroViewCell.h"
#import "HeaderReusableView.h"
#import "NetworkTool.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#import "UserCollectionViewCell.h"

#import "UserHeaderReusableView.h"
#import "SettingViewController.h"
// 用户头部的重用标识符
static NSString *UserHeaderReuseIdentifier = @"UserHeaderReuseIdentifier";
static NSString *UserInfoHeaderReuseIdentifier = @"UserInfoHeaderReuseIdentifier";
// 专栏简介的cell重用标识符
static NSString *AuthorIntroReuseIdentifier = @"AuthorIntroViewCell";
// 作者简介的cell重用标识符
static NSString *UserCellReuseIdentifier = @"UserCollectionCell";

static NSString *ArticlesreuseIdentifier = @"ArticlesCollectionViewCell";

@interface ColumnistViewController ()<UICollectionViewDelegateFlowLayout,HeaderReusableViewDelegate,UserCollectionViewCellDelegate>
// 文章数组
@property(nonatomic, strong) NSMutableArray<Article *> *articles;

@property(nonatomic, strong)LevitateHeaderFlowLayout *CollectionViewFlowLayout;

DIYObj_(NetworkTool, tools)

// 当前页码
int_(currentPage)
@end


@implementation ColumnistViewController
- (NetworkTool *)tools
{
    if (!_tools) {
        _tools = [[NetworkTool alloc] init];
    }
    return _tools;
}

//
- (NSMutableArray *)articles
{
    if (!_articles) {
        _articles = [NSMutableArray array];
    }
    return _articles;
}
- (LevitateHeaderFlowLayout *)CollectionViewFlowLayout
{
    if (!_CollectionViewFlowLayout) {
        _CollectionViewFlowLayout = [[LevitateHeaderFlowLayout alloc] init];
        // 1.设置layout
        _CollectionViewFlowLayout.minimumInteritemSpacing = 0;
        _CollectionViewFlowLayout.minimumLineSpacing = 5;
        _CollectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _CollectionViewFlowLayout;
}

- (instancetype)init
{
    return [super initWithCollectionViewLayout:self.CollectionViewFlowLayout];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self getList];
    [self getNewData];
    [self setRefresh];
}
//基本配置
- (void)setup
{
    self.currentPage = 0;
    
    self.collectionView.backgroundColor = rgb255(241, 241, 241);
    [self customTitle:@"个人中心"];
    
    
    if (!self.isUser) {
        //左按钮
        UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
        self.navigationItem.leftBarButtonItem = leftBtn;
    }
    
    
    //注册
    [self.collectionView registerClass:[ArticlesCollectionViewCell class] forCellWithReuseIdentifier:ArticlesreuseIdentifier];
    [self.collectionView registerClass:[AuthorIntroViewCell class] forCellWithReuseIdentifier:AuthorIntroReuseIdentifier];
    //注册头部视图
    
    [self.collectionView registerClass:[HeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UserHeaderReuseIdentifier];
}

//设置刷新控件
- (void)setRefresh
{
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    self.collectionView.mj_footer.hidden = YES;
}


- (void)getNewData
{
    [self.articles removeAllObjects];
    
    [self.tools getColumnistDetailsDataWithUserID:self.author.ID CurrentPage:0 block:^(id json, NSError *error, BOOL isMore) {
        if ([error isKindOfClass:[NSNull class]]) {
            [[Tostal sharTostal] tostalMesg:@"网络异常" tostalTime:1];
        }else
        {
            if (!isMore) {//如果没有数据
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [self.articles addObjectsFromArray:json];
                
                self.currentPage +=1;
                [self.collectionView reloadData];
                self.collectionView.mj_footer.hidden = NO;
                [self.collectionView.mj_footer endRefreshing];
            }
        }

        
    }];
}

- (void)getMoreData
{
    [self.tools getColumnistDetailsDataWithUserID:self.author.ID CurrentPage:self.currentPage block:^(id json, NSError *error, BOOL isMore) {
        if ([error isKindOfClass:[NSNull class]]) {
            [[Tostal sharTostal] tostalMesg:@"网络异常" tostalTime:1];
            self.currentPage -=1;
        }else
        {
            if (!isMore) {//如果没有数据
                
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                
            }else
            {

                [self.articles addObjectsFromArray:json];
                
                self.currentPage +=1;
                [self.collectionView reloadData];
                self.collectionView.mj_footer.hidden = NO;
                [self.collectionView.mj_footer endRefreshing];
            }
        }
        
        
    }];
}

- (void)getList
{
    [[[NetworkTool alloc] init] getUserDetailDataWithUserID:self.author.ID block:^(id json, NSError *error) {
        self.author = json;
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    }];
}




// 是否是用户(用户和专栏是不一样的)
- (void)setIsUser:(BOOL)isUser
{
    _isUser = isUser;
    if (isUser) {
        //进行其它操作
        //注册
        [self.collectionView registerClass:[UserCollectionViewCell class] forCellWithReuseIdentifier:UserCellReuseIdentifier];
        
        //注册头部视图
        
        [self.collectionView registerClass:[UserHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UserInfoHeaderReuseIdentifier];
        
        //右按钮
        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"pc_setting_40x40"] style:UIBarButtonItemStyleDone target:self action:@selector(gotoSetting)];
        self.navigationItem.rightBarButtonItem = rightBtn;
    }
}
#pragma mark - UICollectionView Datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.articles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.isUser) {
            
            UserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:UserCellReuseIdentifier forIndexPath:indexPath];
            cell.author = self.author;
            cell.delegate = self;
            return cell;
        }else
        {
            AuthorIntroViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AuthorIntroReuseIdentifier forIndexPath:indexPath];
            cell.author = self.author;
            cell.parentViewController = self;
            return cell;
        }
    }
    
    ArticlesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ArticlesreuseIdentifier forIndexPath:indexPath];
    if (self.articles.count) {
        cell.article = self.articles[indexPath.item];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
//#warning 头部视图 进行判断
    if (self.isUser) {
        UserHeaderReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:UserInfoHeaderReuseIdentifier forIndexPath:indexPath];
        return header;
    }
    HeaderReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:UserHeaderReuseIdentifier forIndexPath:indexPath];
    header.delegate = self;
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        DetailViewController *vc = [[DetailViewController alloc] init];
        vc.article = self.articles[indexPath.item];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.isUser) {
            return CGSizeMake(MY_WIHTE, 160);
        }else
        {
            return CGSizeMake(MY_WIHTE, 130);
        }
    }
    
    return CGSizeMake((MY_WIHTE - 24)/2, 230);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(MY_WIHTE, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsZero;
    }
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

#pragma mark - HeaderReusableViewDelegate
- (void)commentViewCell:(UICollectionReusableView *)commentViewCell didClickBtn:(PersonalCenterBtnType)type
{
    if (type == Column) {// 专栏
        [[Tostal sharTostal] tostalMesg:@"专栏" tostalTime:1];
    }else if (type == Introduce)// 介绍
    {
        [[Tostal sharTostal] tostalMesg:@"介绍" tostalTime:1];
    }else if (type == Subscriber)// 订阅者
    {
        [[Tostal sharTostal] tostalMesg:@"订阅者" tostalTime:1];
    }
}
#pragma mark - UserCollectionViewCellDelegate
- (void)UserCollectionViewCellClickShopCar:(UserCollectionViewCell *)userCell
{
    [[Tostal sharTostal] tostalMesg:@"购物车" tostalTime:1];
}
- (void)UserCollectionViewCellclickRemind:(UserCollectionViewCell *)userCell
{
    [[Tostal sharTostal] tostalMesg:@"通知" tostalTime:1];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)gotoSetting
{
    SettingViewController *set = [[UIStoryboard storyboardWithName:@"SettingViewController" bundle:nil] instantiateInitialViewController];
    [self customTitle:@"设置"];
    set.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:set animated:YES];
}

@end
