//
//  Author.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "Author.h"
#import "MJExtension.h"
@implementation Author
MJCodingImplementation
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

- (void)setHeadImg:(NSString *)headImg
{
    
    if (![headImg hasPrefix:@"http://"]) {
        headImg = [NSString stringWithFormat:@"http://static.htxq.net/%@",headImg];
    }
    _headImg = headImg;
}

- (void)setNewAuth:(int)newAuth
{
    _newAuth = newAuth;
    switch (newAuth) {
        case 1:
            self.authImage = [UIImage imageNamed:@"u_vip_yellow"];
            break;
        case 2:
            self.authImage = [UIImage imageNamed:@"personAuth"];
            break;
        default:
            self.authImage = [UIImage imageNamed:@"u_vip_blue"];
            break;
    }
}
@end
