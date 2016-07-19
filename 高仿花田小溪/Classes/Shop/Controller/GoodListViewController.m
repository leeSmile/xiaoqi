//
//  GoodListViewController.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/7/12.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "GoodListViewController.h"
#import "MallFlowLayout.h"
#import "GoodsCollectionViewCell.h"
#import "GoodsDetailController.h"
// 商城模块, 所有的商品列表cell
static NSString *GoodListReuseIdentifier = @"GoodListReuseIdentifier";
@implementation GoodListViewController

- (instancetype)init
{
    MallFlowLayout *mallFlowLayout = [[MallFlowLayout alloc] init];
    return [super initWithCollectionViewLayout:mallFlowLayout];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}
//基本配置
- (void)setup
{
    [self customTitle:@"主题列表"];
    //左按钮
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    //注册
    [self.collectionView registerClass:[GoodsCollectionViewCell class] forCellWithReuseIdentifier:GoodListReuseIdentifier];
    self.collectionView.alwaysBounceVertical = YES;
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.goodList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GoodListReuseIdentifier forIndexPath:indexPath];
    if (self.goodList.count) {
        cell.goods = self.goodList[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailController *vc = [[GoodsDetailController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    Goods *goods = self.goodList[indexPath.row];
    [vc customTitle:goods.fnName];
    vc.goodsId = goods.fnId;
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)setGoodList:(NSMutableArray<Goods *> *)goodList
{
    _goodList = goodList;
    [self.collectionView reloadData];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
