//
//  OrderViewController.h
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/7/18.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"
@interface OrderViewController : UITableViewController
DIYObj_(Goods, goods)
int_(buyNum)// 购买数量
String_(olderID)
@end
