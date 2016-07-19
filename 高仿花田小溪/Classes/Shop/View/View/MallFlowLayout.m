//
//  MallFlowLayout.m
//  高仿花田小憩OC版
//
//  Created by Lee on 16/7/10.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MallFlowLayout.h"

@implementation MallFlowLayout
- (void)prepareLayout
{
    [super prepareLayout];
    self.minimumLineSpacing = 1;
    self.minimumInteritemSpacing = 1;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    float width = (MY_WIHTE - 2)/2;
    self.itemSize = CGSizeMake(width, width);
    self.collectionView.backgroundColor = [UIColor whiteColor];
}
@end
