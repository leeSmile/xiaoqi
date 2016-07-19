//
//  UserCollectionViewCell.h
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/7/12.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "UserParentViewCell.h"

@class UserCollectionViewCell;

@protocol UserCollectionViewCellDelegate <NSObject>
- (void)UserCollectionViewCellClickShopCar:(UserCollectionViewCell *)userCell;
- (void)UserCollectionViewCellclickRemind:(UserCollectionViewCell *)userCell;
@end

@interface UserCollectionViewCell : UserParentViewCell
@property(nonatomic, weak) id<UserCollectionViewCellDelegate> delegate;
@end
