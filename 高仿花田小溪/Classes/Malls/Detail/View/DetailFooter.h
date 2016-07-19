//
//  DetailFooter.h
//  高仿花田小憩OC版
//
//  Created by Lee on 16/7/10.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"

@class DetailFooter;

@protocol DetailFooterDelegate <NSObject>
- (void)clickBuyBlock:(DetailFooter *)detailFooter;
@end

@interface DetailFooter : UIView
int_(num)
@property(nonatomic, weak) id<DetailFooterDelegate> delegate;
DIYObj_(Goods, goods)
@end
