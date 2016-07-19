//
//  OlderBottomView.h
//  高仿花田小溪
//
//  Created by Lee on 16/7/18.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OlderBottomView;

@protocol OlderBottomViewDelegate <NSObject>
- (void)OlderBottomViewEntryToBuyTotalPrice:(NSString *)totalPrice;
@end

@interface OlderBottomView : UIView
String_(totalPrice)
@property(nonatomic, weak) id<OlderBottomViewDelegate> delegate;
@end
