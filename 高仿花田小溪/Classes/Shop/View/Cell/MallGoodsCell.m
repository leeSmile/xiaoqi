//
//  MallGoodsCell.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/7/9.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MallGoodsCell.h"
#import "CategoryInfoView.h"
#import "MallFlowLayout.h"
#import "GoodsCollectionViewCell.h"

static NSString *GoodsCellIdentfy = @"GoodsCellIdentfy";// 精选cell的重用标示符

@interface MallGoodsCell ()<UICollectionViewDataSource, UICollectionViewDelegate>
//顶部
DIYObj_(CategoryInfoView, topView)
CollectionView_(goodListView)
@end


@implementation MallGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    return self;
}


- (void)setupUI
{
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.goodListView];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(@60);
    }];
    
    [self.goodListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.topView.mas_bottom).offset(10);

    }];
}

#pragma MARK: - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSUInteger  count = self.mallsGoods.childrenList.count;
    
    return count > 4 ? 4 : count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GoodsCellIdentfy forIndexPath:indexPath];
    
    if (self.mallsGoods.childrenList.count) {
        cell.goods = self.mallsGoods.childrenList[indexPath.item];
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(mallGoodsCellDidSelectedGoods: goods:)]) {
        [self.delegate mallGoodsCellDidSelectedGoods:self goods:self.mallsGoods.childrenList[indexPath.item]];
    }

}
- (CategoryInfoView *)topView
{
    if (!_topView) {
        _topView = [CategoryInfoView new];
        UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toLookAll)];
        [_topView addGestureRecognizer:tag];
    }
    return _topView;
}

- (UICollectionView *)goodListView
{
    if (!_goodListView) {
        _goodListView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[MallFlowLayout new]];
        _goodListView.dataSource = self;
        _goodListView.delegate = self;
        _goodListView.alwaysBounceHorizontal = NO;
        _goodListView.alwaysBounceVertical = NO;
        [_goodListView registerClass:[GoodsCollectionViewCell class] forCellWithReuseIdentifier:GoodsCellIdentfy];
    }
    return _goodListView;
}


- (void)setMallsGoods:(MallsGoods *)mallsGoods
{
    _mallsGoods = mallsGoods;
    // 最多只显示4个
    NSUInteger count = mallsGoods.childrenList.count;
    count = count > 4 ? 4 : count;
    // 更新高度
    CGFloat height = (CGFloat)((count % 2 == 0) ? count / 2 : (count / 2 + 1)) * (MY_WIHTE / 2.0);
    [self.goodListView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];

    self.topView.malls = mallsGoods;
    
    [self.goodListView reloadData];
}

- (void)toLookAll
{
    if ([self.delegate respondsToSelector:@selector(mallGoodsCellDidSelectedCategory: malls:)]) {
        [self.delegate mallGoodsCellDidSelectedCategory:self malls:self.mallsGoods.childrenList];
    }
}
@end
