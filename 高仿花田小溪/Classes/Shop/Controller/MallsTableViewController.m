//
//  MallsTableViewController.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/7/4.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MallsTableViewController.h"
#import "Categorys.h"
#import "MallsCategory.h"
#import "MJRefresh.h"
#import "MallsHeaderCell.h"
#import "NetworkTool.h"
#import "JingGoodsCell.h"
#import "BlurView.h"
#import "GoodsDetailController.h"
//#import "MallsHeaderCell.h"
#import "MallGoodsCell.h"
#import "ADS.h"
#import "SearchBar.h"
#import "GoodListViewController.h"

#import "GoodListViewController.h"

// 商城列表的identity的枚举
static NSString *MallJingxuan = @"jingList/1";
static NSString *MallTheme = @"theme";

static NSString *JingCellReuseIdentifier = @"JingCellReuseIdentifier";// 精选cell的重用标示符
static NSString *MallsCellReuseIdentifier = @"MallsCellReuseIdentifier";// 商城cell的重用标示符
static NSString *MallsHeaderCellIdentifier = @"MallsHeaderCellIdentifier";// 头部cell的重用标示符
//<MallsTopMenuViewDelegate>
@interface MallsTableViewController ()<MallGoodsCellDelegate,MallsHeaderCellDelegate,XRCarouselViewDelegate,BlurViewDelegate,SearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
// 商城分类
@property(nonatomic, strong)NSMutableArray<MallsCategory *> *categories;
DIYObj_(NetworkTool, tools)
String_(identify)
DIYObj_(SearchBar, searchBar)
View_(searchBlur)
@property(nonatomic, strong) BlurView *blurView;
@property(nonatomic, strong)NSMutableArray<Goods *> *goodses;
@property(nonatomic, strong)NSMutableArray<MallsGoods *> *malls;

@property(nonatomic, strong)NSMutableArray<ADS *> *topADS;

@property(nonatomic, strong)NSMutableArray<NSString *> *topADUrl;

@property(nonatomic, strong)UIButton *menuBtn;
TableView_(tableView)
//选中的分类
DIYObj_(MallsCategory, selectedCategry)
@end

@implementation MallsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self setRefresh];

}

- (void)setup
{
    self.identify = MallJingxuan;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 设置左右item
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuBtn setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    menuBtn.lx_size = CGSizeMake(20, 20);
    [menuBtn addTarget:self action:@selector(selectedCategory:) forControlEvents:UIControlEventTouchUpInside];
    self.menuBtn = menuBtn;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"f_search"] style:UIBarButtonItemStyleDone target:self action:@selector(search:)];
  
    [self customTitle:@"商城"];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//设置刷新控件
- (void)setRefresh
{
    [self gettopAD];
    [self getMallsCategory];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    self.tableView.mj_footer.hidden = YES;
}

- (void)gettopAD
{
    [self.tools getTopMallsData:^(id json, NSError *error) {
        if (error == nil) {
            if ([json isKindOfClass:[NSArray class]]) {
                self.topADS = json;
                for (ADS *adsmodel in self.topADS) {
                    [self.topADUrl addObject:adsmodel.fnImageUrl];
                }
                
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            }
        }else
        {
            LXLog(@"有误");
        }
    }];
}


- (void)getNewData
{
    
    [self.tools getMallsDataWithIdentify:self.identify block:^(id json, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        if (error == nil) {
            if (self.identify == MallJingxuan) {
                
                if ([json isKindOfClass:[NSArray class]]) {
                    
                    self.goodses = json;
                    [self.tableView reloadData];
                    self.tableView.mj_footer.hidden = NO;
                }
                
            }else if(self.identify == MallTheme)
            {
                if ([json isKindOfClass:[NSArray class]]) {
                    
                    self.malls = json;
                    [self.tableView reloadData];
                }
            }
        }else
        {
            [[Tostal sharTostal] tostalMesg:@"网络异常" tostalTime:2];
        }
    }];
}
- (void)getMallsCategory
{
    //保存数据
    self.categories = [LXFileManager getObjectByFileName:MallCategoriesKey];
    if (!self.categories.count) {
        [self.tools getMallsCategoriesData:^(id json, NSError *error) {
            if (error == nil) {
                
                self.categories = json;
            }
        }];
    }
    
}
- (void)getMoreData
{

    if (self.identify == MallJingxuan) {
        //如果是精选  下拉刷新调用这个接口
        [self.tools getMallsDataWithIdentify:@"jingList/2" block:^(id json, NSError *error) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
            if (error == nil) {
                
                if ([json isKindOfClass:[NSArray class]]) {
                    
                    [self.goodses addObjectsFromArray: json];
                    [self.tableView reloadData];
                }
                
            }else
            {
                [[Tostal sharTostal] tostalMesg:@"网络异常" tostalTime:2];
            }
        }];
    }else if (self.identify == MallTheme){
        
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    
    

}
#pragma mark - Table view data source and delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.identify == MallJingxuan ? self.goodses.count:self.malls.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.topADS.count) {
        
        if (indexPath.section == 0) {
            return 264;
        }
    }
    
    
    CGFloat height = 0;
    if (self.malls.count && self.identify == MallTheme) {
       MallsGoods *mallsGoods = self.malls[indexPath.row];
        NSUInteger goodscount = mallsGoods.childrenList.count;
        goodscount = goodscount > 4 ? 4: goodscount;
        height += (CGFloat)((goodscount % 2 == 0) ? goodscount / 2 : (goodscount / 2 + 1)) * (MY_WIHTE / 2.0);
        
        height += 70;// 加上头部60+10的间距
    }
    return self.identify == MallJingxuan ? 280 :height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //做一个容错处理  当轮播图请求有误时，取消上面的轮播显示
    
    if (self.topADS.count) {
        if (indexPath.section == 0) {//顶部广告
            MallsHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:MallsHeaderCellIdentifier];
            cell.delegate = self;
            
            cell.topImageView.delegate = self;
            cell.imageUrl = self.topADUrl;
            return cell;
        }
    }
    
    
    // 非精选, 商城的cell
    if (self.identify == MallTheme) {
        MallGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:MallsCellReuseIdentifier];
        if (self.malls.count) {
            cell.mallsGoods = self.malls[indexPath.row];
            cell.delegate = self;
        }
        return cell;
    }
    
    //精选
    JingGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:JingCellReuseIdentifier];
    if (self.goodses.count) {
        cell.goods = self.goodses[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.identify == MallJingxuan) {
        
        GoodsDetailController *vc = [[GoodsDetailController alloc] init];
        [vc setHidesBottomBarWhenPushed:YES];
        
        [vc customTitle:self.goodses[indexPath.row].fnName];
        vc.goodsId = self.goodses[indexPath.row].fnId;
        [self.navigationController pushViewController:vc animated:YES];

    }
}
#pragma mark MallsHeaderCellDelegate

- (void)commentViewCell:(MallsHeaderCell *)topMenuView didClickBtn:(MallType)type
{
    LXLog(@"点击topMenuView按钮");
    if (type == Choiceness) {
        self.identify = MallJingxuan;
    }else if (type == Mall)
    {
        self.identify = MallTheme;
        
    }else if (type == Integral)//积分
    {
        
    }
    
    //清空
    [self reSet];
    [self getNewData];
}
#pragma mark XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView didClickImage:(NSInteger)index {
    
    LXLog(@"点击轮播图");
    
    GoodsDetailController *vc = [[GoodsDetailController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    if (self.topADS.count) {
        [vc customTitle:self.topADS[index].fnTitle];
        vc.goodsId = self.topADS[index].fnUrl;
    }
    
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark - SearchBarDelegate
- (void)searchBarDidCancel:(SearchBar *)searchBar
{
    [self hideSearBar];
}
- (void)searchBar:(SearchBar *)searchBar search:(NSString *)search
{
    
}
#pragma mark - MallGoodsCellDelegate

// 选中了类型, 去查看所有的类型
- (void)mallGoodsCellDidSelectedCategory:(MallGoodsCell *)mallGoodsCell malls:(NSArray<Goods *> *)malls
{
    GoodListViewController *vc = [[GoodListViewController alloc] init];
    vc.goodList = (NSMutableArray *)malls;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

// 点击单独一个, 去查看详情
- (void)mallGoodsCellDidSelectedGoods:(MallGoodsCell *)mallGoodsCell goods:(Goods *)goods
{
    GoodsDetailController *vc = [[GoodsDetailController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [vc customTitle:goods.fnName];
    vc.goodsId = goods.fnId;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -blurViewDelegate
- (void)blurView:(BlurView *)blurView didSelectCategory:(id)Category
{
//    [self selectedCategory:self.menuBtn];
    //设置选中的类型
    self.selectedCategry = Category;
    
    [self.tools getSelectedCategoryDataWithItemID:self.selectedCategry.fnId block:^(id json, NSError *error) {
        if (error == nil) {
            
            if ([json isKindOfClass:[NSArray class]]) {
                GoodListViewController *vc = [[GoodListViewController alloc] init];
                vc.goodList = json;
                [vc setHidesBottomBarWhenPushed:YES];
                [vc customTitle:self.selectedCategry.fnName];
                
                [self.navigationController pushViewController:vc animated:YES];
            }else
            {
                [[Tostal sharTostal] tostalMesg:@"网络异常" tostalTime:1];
            }
            
        }else
        {
            [[Tostal sharTostal] tostalMesg:@"网络异常" tostalTime:1];
        }
    }];
    
}
#pragma mark - click---
//弹出蒙版及动画
- (void)selectedCategory:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        
        [self.view addSubview:self.blurView];
        //设置blurView的约束
        [self.blurView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            
            make.top.equalTo(self.view.mas_top);
            
            make.size.mas_equalTo(CGSizeMake(MY_WIHTE, MY_HEIGHT-49-64));
        }];
        // 设置transform
        self.blurView.transform = CGAffineTransformMakeTranslation(0, -MY_HEIGHT);
        
    }
    
    
    [UIView animateWithDuration:0.5 animations:^{
        if (btn.selected) {
            //旋转
            btn.transform = CGAffineTransformMakeRotation((CGFloat)M_PI_2);
            //复原
            self.blurView.transform = CGAffineTransformIdentity;
            
            self.tableView.scrollEnabled = NO;
        }else
        {
            //复原
            btn.transform = CGAffineTransformIdentity;
            self.blurView.transform = CGAffineTransformMakeTranslation(0, -MY_HEIGHT);
            self.tableView.scrollEnabled = YES;
        }
        
    } completion:^(BOOL finished) {
        if (!btn.selected) {
            [self.blurView removeFromSuperview];
        }
    }];
}

- (void)search:(UIButton *)btn
{
    [KeyWindow addSubview:self.searchBar];
    
    [KeyWindow addSubview:self.searchBlur];
    self.searchBlur.lx_y = 64;
    self.tableView.scrollEnabled = YES;
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(-44));
        make.left.width.equalTo(KeyWindow);
        make.height.equalTo(@44);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.searchBar.transform = CGAffineTransformMakeTranslation(0, 64);
    } completion:^(BOOL finished) {
        [self.searchBar.filed becomeFirstResponder];
    }];


}
//隐藏searbar
- (void)hideSearBar
{
    [UIView animateWithDuration:0.25 animations:^{
        self.searchBar.transform = CGAffineTransformIdentity;
        [self.searchBar endEditing:YES];
    } completion:^(BOOL finished) {
        self.tableView.scrollEnabled = YES;

        [self.searchBar clearText];
        [self.searchBar removeFromSuperview];
        [self.searchBlur removeFromSuperview];
    }];
}

//重置数据。清空之前数据
- (void)reSet
{
    if (self.identify == MallJingxuan) {
        [self.goodses removeAllObjects];
    }else if (self.identify == MallTheme)
    {
        [self.malls removeAllObjects];
    }
}
#pragma mark - set get
- (NSMutableArray<MallsCategory *> *)categories
{
    if (!_categories) {
        _categories = [NSMutableArray array];
    }
    return _categories;

}

- (NetworkTool *)tools
{
    if (!_tools) {
        _tools = [[NetworkTool alloc] init];
    }
    return _tools;
}
- (UIView *)searchBlur
{
    if (!_searchBlur) {
        _searchBlur = [[UIView alloc] init];
        _searchBlur.frame = self.view.bounds;
        _searchBlur.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagClickBlur)];
        [_searchBlur addGestureRecognizer:tag];
    }
    return _searchBlur;
}
- (SearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[SearchBar alloc] init];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (NSMutableArray *)goodses
{
    if (!_goodses) {
        _goodses = [NSMutableArray array];
    }
    return _goodses;
}
- (NSMutableArray *)malls
{
    if (!_malls) {
        _malls = [NSMutableArray array];
    }
    return _malls;
}
- (NSMutableArray *)topADS
{
    if (!_topADS) {
        _topADS = [NSMutableArray array];
    }
    return _topADS;
}
- (NSMutableArray *)topADUrl
{
    if (!_topADUrl) {
        _topADUrl = [NSMutableArray array];
    }
    return _topADUrl;
}
- (BlurView *)blurView
{
    if (!_blurView) {
        _blurView = [[BlurView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _blurView.backgroundColor = [UIColor whiteColor];
//        _blurView.tableView.backgroundColor = [UIColor whiteColor];
        _blurView.categories = self.categories;
        _blurView.delegate = self;
        _blurView.isMalls = YES;
    }
    return _blurView;
}

- (void)tagClickBlur
{
    [self hideSearBar];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //注册
        [_tableView registerClass:[JingGoodsCell class] forCellReuseIdentifier:JingCellReuseIdentifier];
        [_tableView registerClass:[MallsHeaderCell class] forCellReuseIdentifier:MallsHeaderCellIdentifier];
        [_tableView registerClass:[MallGoodsCell class] forCellReuseIdentifier:MallsCellReuseIdentifier];

    }
    return _tableView;
}
@end
