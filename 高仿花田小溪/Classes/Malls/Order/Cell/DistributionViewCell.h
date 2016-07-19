//
//  DistributionViewCell.h
//  高仿花田小溪
//
//  Created by Lee on 16/7/18.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"
typedef NS_OPTIONS(NSUInteger, OtherType)
{
    Anonymity,// 匿名
    invoice,// 需要发票

};

@class DistributionViewCell;

@protocol DistributionViewCellDelegate <NSObject>

- (void)DistributionViewCell:(DistributionViewCell *)MallsHeaderCell didClickBtn:(OtherType)type need:(BOOL)need;
- (void)DistributionViewCellAddAddress;
@end

@interface DistributionViewCell : UITableViewCell
BOOL_(isNeedInvoice)//是否需要发票
DIYObj_(Address, iAddress)
@property(nonatomic, weak) id<DistributionViewCellDelegate> delegate;
@end
