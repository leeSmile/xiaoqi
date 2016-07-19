//
//  GoodListViewController.h
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/7/12.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"
@interface GoodListViewController : UICollectionViewController
@property(nonatomic, strong)NSMutableArray<Goods *> *goodList;
@end
