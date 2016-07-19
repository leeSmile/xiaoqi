//
//  NewFeatureViewController.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "NewFeatureCell.h"
#import "MainViewController.h"
@interface NewFeatureViewController ()

PageControl_(pageControll)
mArray_(imageNames)
@end

@implementation NewFeatureViewController

static NSString * const NewFeatureCellIdentifier = @"NewFeature";

- (NSMutableArray *)imageNames
{
    if (!_imageNames) {
        _imageNames = [NSMutableArray array];
        [_imageNames addObject:@"gp_bg_0"];
        [_imageNames addObject:@"gp_bg_1"];
        [_imageNames addObject:@"gp_bg_2"];
    }
    return _imageNames;
}

- (instancetype)init
{
    UICollectionViewFlowLayout *NewFeatureFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    NewFeatureFlowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    NewFeatureFlowLayout.minimumLineSpacing = 0;
    NewFeatureFlowLayout.minimumInteritemSpacing = 0;
    NewFeatureFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:NewFeatureFlowLayout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    //注册cell
    [self.collectionView registerClass:[NewFeatureCell class] forCellWithReuseIdentifier:NewFeatureCellIdentifier];
    
    //pageControll
    UIPageControl *page = [[UIPageControl alloc] init];
    page.numberOfPages = self.imageNames.count;
    page.pageIndicatorTintColor = [UIColor whiteColor];
    page.currentPageIndicatorTintColor = [UIColor yellowColor];
    self.pageControll = page;
    [self.collectionView addSubview:self.pageControll];
    
    [self.pageControll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-10);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;\
    self.collectionView.backgroundColor = [UIColor redColor];

    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NewFeatureCellIdentifier forIndexPath:indexPath];
    cell.img =  [UIImage imageNamed:self.imageNames[indexPath.item]];
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == self.imageNames.count - 1 ){
        // 进入首页
        KeyWindow.rootViewController = [[MainViewController alloc] init];

    }
    return YES;
}



#pragma mark <scrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentPage = (int)(scrollView.contentOffset.x / MY_WIHTE + 0.5);
    self.pageControll.currentPage = currentPage;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ((scrollView.contentOffset.x/MY_WIHTE) > ((CGFloat)(self.imageNames.count) - 1.5)){
        self.pageControll.hidden = YES;
    }else{
        self.pageControll.hidden = NO;
    }
}
@end
