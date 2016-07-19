//
//  AddressViewCell.h
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/7/19.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"
@interface AddressViewCell : UITableViewCell
DIYObj_(Address, iAddress)
BOOL_(selectedAddress)// 是否选中当前的地址
@end
