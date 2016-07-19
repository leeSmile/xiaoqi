//
//  MallGoodsCell.h
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/7/9.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MallsGoods.h"
@class MallGoodsCell;

@protocol MallGoodsCellDelegate <NSObject>
// 选中了类型, 去查看所有的类型
- (void)mallGoodsCellDidSelectedCategory:(MallGoodsCell *)mallGoodsCell malls:(NSArray<Goods *> *)malls;
// 点击单独一个, 去查看详情
- (void)mallGoodsCellDidSelectedGoods:(MallGoodsCell *)mallGoodsCell goods:(Goods *)goods;
@end


@interface MallGoodsCell : UITableViewCell
DIYObj_(MallsGoods, mallsGoods)
@property(nonatomic, weak) id<MallGoodsCellDelegate> delegate;
@end
