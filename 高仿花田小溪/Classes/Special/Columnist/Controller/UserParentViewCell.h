//
//  UserParentViewCell.h
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/30.
//  Copyright © 2016年 Lee. All rights reserved.
//

//cell基类
#import <UIKit/UIKit.h>
#import "Author.h"
@interface UserParentViewCell : UICollectionViewCell
DIYObj_(Author, author)
//作者
Label_(authorLabel)
//头像
ImageView_(headImgView)
/// 个性签名
Label_(desLabel)
@property(nonatomic, strong)UIViewController *parentViewController;

- (void)setup;
@end
