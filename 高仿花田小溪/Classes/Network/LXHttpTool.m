//
//  LXHttpTool.m
//  sunt6
//
//  Created by 祥云创想 on 16/6/7.
//  Copyright © 2016年 杨闯. All rights reserved.
//

#import "LXHttpTool.h"
#import "AFNetworking.h"

@implementation LXHttpTool

+ (AFHTTPSessionManager *)manager {
    static AFHTTPSessionManager *manager = nil;
    if (manager == nil) {
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    }
    return manager;
}

+(void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success
   failure:(void (^)(NSError *error))failure
{
    //显示状态栏的网络指示器
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager  = [self manager];
//    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置加载时间
    manager.requestSerializer.timeoutInterval = 10.0f;
    
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];

}


+(void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success
    failure:(void (^)(NSError *error))failure
{
    

    AFHTTPSessionManager *manager  = [self manager];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
@end
