//
//  NetworkTool.h
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/25.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXHttpTool.h"
#import "Categorys.h"
#import "Goods.h"
@interface NetworkTool : NSObject
-(void)getHomeListDataWithCurrentPage:(int)currentPage selectedCategry:(Categorys *)selectedCategorys block:(void(^)(id json))block failure:(void(^)(NSError *error))failure;

-(void)getCategoriesData:(void(^)(id json))block failure:(void(^)(NSError *error))failure;

-(void)getTop10DataWithActionType:(NSString *)actionType block:(void(^)(id json))block failure:(void(^)(NSError *error))failure;

-(void)getArticleDetailDataWithDetailID:(NSString *)ID block:(void(^)(id json))block failure:(void(^)(NSError *error))failure;
-(void)getCommentListDataWithBbsID:(NSString *)bbsID block:(void(^)(id json))block failure:(void(^)(NSError *error))failure;
//- (NSURLSessionDataTask *)POST:(NSString *)URLString
//                    parameters:(id)parameters
//                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
//                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
//                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
-(void)getCommentListDataWithBbsID:(NSString *)bbsID CurrentPage:(int)currentPage block:(void(^)(id json , NSError *error, BOOL isNotComment))block;

-(void)getUserDetailDataWithUserID:(NSString *)userID block:(void(^)(id json , NSError *error))block;

-(void)getColumnistDetailsDataWithUserID:(NSString *)userID CurrentPage:(int)currentPage block:(void(^)(id json , NSError *error, BOOL isMore))block;
//获取商城的商品列表
-(void)getMallsDataWithIdentify:(NSString *)identify block:(void(^)(id json , NSError *error))block;
//获取获取商城的分类
-(void)getMallsCategoriesData:(void(^)(id json , NSError *error))block;
//获得置顶的商品
-(void)getTopMallsData:(void(^)(id json , NSError *error))block;
//获得商品详情
-(void)getGoodsInfoDataWithGoodsId:(NSString *)goodsId block:(void(^)(Goods *goods , NSError *error))block;
//选择商城的分类
-(void)getSelectedCategoryDataWithItemID:(NSString *)itemID block:(void(^)(id json , NSError *error))block;
//获得订单详情
-(void)getOlderDataWithGoodsId:(NSString *)goodsId block:(void(^)(id json , NSError *error))block;
//获取收货地址列表
-(void)getAddressListData:(void(^)(id json , NSError *error))block;
@end
