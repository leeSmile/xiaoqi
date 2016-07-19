//
//  NetworkTool.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/25.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "NetworkTool.h"
#import "MJExtension.h"
#import "Article.h"
#import "Categorys.h"
#import "Author.h"
#import "Comment.h"

#import "MallsGoods.h"
#import "ADS.h"
#import "Address.h"
#import "MallsCategory.h"
// 商城列表的identity的枚举
static NSString *MallJingxuan = @"jingList/1";
static NSString *MallTheme = @"theme";
@implementation NetworkTool

-(void)getHomeListDataWithCurrentPage:(int)currentPage selectedCategry:(Categorys *)selectedCategorys block:(void(^)(id json))block failure:(void(^)(NSError *error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"currentPageIndex"] = [NSString stringWithFormat:@"%zd",currentPage];
    parameters[@"pageSize"] = @"5";
    //如果选择了分类就设置分类的请求ID
    if (selectedCategorys.ID) {
        parameters[@"cateId"] = selectedCategorys.ID;
    }
    [LXHttpTool post:POST_HomeList parameters:parameters success:^(id json) {
                
        if (json[@"status"]) {//获取数据成功   已经获取文章列表
            if ([json[@"msg"] isEqualToString:@"已经到最后"]) {
                block(@"已经到最后");
            }
            
            if (![json[@"result"] isKindOfClass:[NSNull class]]){
                //字典数组转模型数组
                NSArray *arr = json[@"result"];
                NSMutableArray *modelArr = [Article mj_objectArrayWithKeyValuesArray:arr];
                block(modelArr);
                
            }
        }

    } failure:^(NSError *error) {
        LXLog(@"%@",error);
        failure(error);
    }];
}

-(void)getCategoriesData:(void(^)(id json))block failure:(void(^)(NSError *error))failure
{
    [LXHttpTool get:GET_Categories parameters:nil success:^(id json) {
//        LXLog(@"%@",json);
        if (json[@"status"]) {//获取数据成功   已经获取分类列表
            if ([json[@"msg"] isEqualToString:@"获取成功"]) {
                if (![json[@"result"] isKindOfClass:[NSNull class]]){
                    //字典数组转模型数组
                    NSArray *arr = json[@"result"];
                    NSMutableArray *modelArr = [Categorys mj_objectArrayWithKeyValuesArray:arr];
                    block(modelArr);
                    //保存数据
                    [LXFileManager saveObject:modelArr byFileName:CategoriesKey];
                    
                }else
                {
                    [[Tostal sharTostal] tostalMesg:@"请求数据失败" tostalTime:1];;
                }
            }
        }
    } failure:^(NSError *error) {
        LXLog(@"%@",error);
        failure(error);
        [[Tostal sharTostal] tostalMesg:@"请求数据失败" tostalTime:1];
    }];
}

-(void)getTop10DataWithActionType:(NSString *)actionType block:(void(^)(id json))block failure:(void(^)(NSError *error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"action"] = actionType;
    [LXHttpTool post:POST_TOP10List parameters:parameters success:^(id json) {
        
        if (json[@"status"]) {//获取数据成功   已经获取文章列表
            if ([json[@"msg"] isEqualToString:@"已经到最后"]) {
                block(@"已经到最后");
            }
            
            if (![json[@"result"] isKindOfClass:[NSNull class]]){
                
                //作者
                if ([actionType isEqualToString:@"topArticleAuthor"]) {
                    //字典数组转模型数组
                    NSArray *arr = json[@"result"];
                    NSMutableArray *modelArr = [Author mj_objectArrayWithKeyValuesArray:arr];
                    block(modelArr);
                    
                }else if ([actionType isEqualToString:@"topContents"])//专栏
                {
                    //字典数组转模型数组
                    NSArray *arr = json[@"result"];
                    NSMutableArray *modelArr = [Article mj_objectArrayWithKeyValuesArray:arr];
                    block(modelArr);

                }
                
            }
        }
        
    } failure:^(NSError *error) {
        LXLog(@"%@",error);
        failure(error);
    }];
}
-(void)getArticleDetailDataWithDetailID:(NSString *)ID block:(void(^)(id json))block failure:(void(^)(NSError *error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"articleId"] = ID;
    [LXHttpTool post:POST_ArticleDetail parameters:parameters success:^(id json) {
        if (json[@"status"]) {
            
            if (![json[@"result"] isKindOfClass:[NSNull class]]){
                
                //字典数组转模型数组
                NSDictionary *dic = json[@"result"];
                Article *article = [Article mj_objectWithKeyValues:dic];
                block(article);
                
            }else
            {
                [[Tostal sharTostal] tostalMesg:@"请求数据失败" tostalTime:1];
            }
        }else
        {
            [[Tostal sharTostal] tostalMesg:@"请求数据失败" tostalTime:1];
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)getCommentListDataWithBbsID:(NSString *)bbsID block:(void(^)(id json))block failure:(void(^)(NSError *error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"action"] = @"getList";
    parameters[@"bbsId"] = bbsID;
    parameters[@"currentPageIndex"] = @"0";
    parameters[@"pageSize"] = @"10";
    
    [LXHttpTool post:POST_CommentList parameters:parameters success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)getCommentListDataWithBbsID:(NSString *)bbsID CurrentPage:(int)currentPage block:(void(^)(id json , NSError *error, BOOL isNotComment))block
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"action"] = @"getList";
    parameters[@"bbsId"] = bbsID;
    parameters[@"currentPageIndex"] = [NSString stringWithFormat:@"%zd",currentPage];
    parameters[@"pageSize"] = @"10";
    
    [LXHttpTool post:POST_CommentList parameters:parameters success:^(id json) {
        if (json[@"status"]) {
            if ([json[@"msg"] isEqualToString:@"还没有发布任何评论。"]) {//当没有评论时，返回这个字段
                block(nil,nil,YES);
                return ;
            }
            if (![json[@"result"] isKindOfClass:[NSNull class]]){
                
                    //字典数组转模型数组
                    NSArray *arr = json[@"result"];
                    NSMutableArray *modelArr = [Comment mj_objectArrayWithKeyValuesArray:arr];
                    block(modelArr,nil,NO);
        }
        }
        
    } failure:^(NSError *error) {
        block(nil,error,NO);
    }];
}

-(void)getUserDetailDataWithUserID:(NSString *)userID block:(void(^)(id json , NSError *error))block
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"userId"] = userID;
    [LXHttpTool get:POST_UserDetail parameters:parameters success:^(id json) {
        if (json[@"status"]) {
            Author *author = [Author mj_objectWithKeyValues:json[@"result"]];
            block(author,nil);
        }
    } failure:^(NSError *error) {
        block(nil,error);
    }];
    
}
-(void)getColumnistDetailsDataWithUserID:(NSString *)userID CurrentPage:(int)currentPage block:(void(^)(id json , NSError *error, BOOL isMore))block
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"userId"] = userID;
    parameters[@"currentPageIndex"] = [NSString stringWithFormat:@"%zd",currentPage];
    
    [LXHttpTool post:POST_ColumnistDetails parameters:parameters success:^(id json) {
    
        if (json[@"status"]) {
            if ([json[@"msg"] isEqualToString:@"已经到最后"]) {//当没有评论时，返回这个字段
                block(nil,nil,NO);
                return ;
            }
            if (![json[@"result"] isKindOfClass:[NSNull class]]){
                
                //字典数组转模型数组
                NSArray *arr = json[@"result"];
                NSMutableArray *modelArr = [Article mj_objectArrayWithKeyValuesArray:arr];
                block(modelArr,nil,YES);
            }
        }
    } failure:^(NSError *error) {
         block(nil,error,YES);
    }];
    
}

-(void)getMallsDataWithIdentify:(NSString *)identify block:(void(^)(id json , NSError *error))block
{
    [LXHttpTool get:[NSString stringWithFormat:@"%@%@",GET_GetMalls,identify]parameters:nil success:^(id json) {
        if (json[@"status"]) {

            NSMutableArray *goodsArr = [NSMutableArray array];
            if ([identify isEqualToString:MallJingxuan]) {
                goodsArr = [Goods mj_objectArrayWithKeyValuesArray:json[@"result"]];
                
            }else if ([identify isEqualToString:MallTheme])
                
            {
                NSMutableArray *MallsGoodsDicArr = json[@"result"];
                for (NSDictionary *allDic in MallsGoodsDicArr) {
                    
                    NSMutableArray *childrenListArr = allDic[@"childrenList"];
                    
                    NSMutableArray *MallsgoodsArr = [NSMutableArray array];
                    MallsGoods *goods = [[MallsGoods alloc] init];
                    goods.fnDesc =allDic[@"fnDesc"];
                    goods.fnId =allDic[@"fnId"];
                    goods.fnName =allDic[@"fnName"];
                    
                    for (NSDictionary *dic in childrenListArr) {
                        
                        Goods *malls = [Goods mj_objectWithKeyValues:dic[@"pGoods"]];
                        [MallsgoodsArr addObject:malls];
  
                    }
                    
                    goods.childrenList = MallsgoodsArr;
                    [goodsArr addObject:goods];
                    
                }

            }
            
            block(goodsArr,nil);
        }
    } failure:^(NSError *error) {
        block(nil,error);

    }];
}

-(void)getMallsCategoriesData:(void(^)(id json , NSError *error))block
{
    [LXHttpTool get:GET_GetMallsCategories parameters:nil success:^(id json) {
        //        LXLog(@"%@",json);
        if (json[@"status"]) {//获取数据成功   已经获取分类列表
            if ([json[@"msg"] isEqualToString:@"操作成功"]) {
                if (![json[@"result"] isKindOfClass:[NSNull class]]){
                    //字典数组转模型数组
                    NSArray *arr = json[@"result"];
                    NSMutableArray *modelArr = [MallsCategory mj_objectArrayWithKeyValuesArray:arr];
                    block(modelArr,nil);
                    //保存数据
                    [LXFileManager saveObject:modelArr byFileName:MallCategoriesKey];
                    
                }else
                {
                    [[Tostal sharTostal] tostalMesg:@"请求数据失败" tostalTime:1];
                }
            }
        }
    } failure:^(NSError *error) {
        LXLog(@"%@",error);
        block(nil,error);
        [[Tostal sharTostal] tostalMesg:@"请求数据失败" tostalTime:1];
    }];

}
-(void)getTopMallsData:(void(^)(id json , NSError *error))block
{
    [LXHttpTool get:GET_GetTopMalls parameters:nil success:^(id json) {
                LXLog(@"%@",json);
        if (json[@"status"]) {//获取数据成功   已经获取分类列表
            if ([json[@"msg"] isEqualToString:@"操作成功"]) {
                if (![json[@"result"] isKindOfClass:[NSNull class]]){
                    //字典数组转模型数组
                    NSArray *arr = json[@"result"];
                    NSMutableArray *modelArr = [ADS mj_objectArrayWithKeyValuesArray:arr];
                    block(modelArr,nil);

                }else
                {
                    [[Tostal sharTostal] tostalMesg:@"请求数据失败" tostalTime:1];;
                }
            }
        }
    } failure:^(NSError *error) {
        LXLog(@"%@",error);
        block(nil,error);
        [[Tostal sharTostal] tostalMesg:@"请求数据失败" tostalTime:1];
    }];
}

-(void)getGoodsInfoDataWithGoodsId:(NSString *)goodsId block:(void(^)(Goods *goods , NSError *error))block
{
    [LXHttpTool get:[NSString stringWithFormat:@"%@%@",GET_GetGoodsInfo,goodsId] parameters:nil success:^(id json) {
        if (json[@"status"]) {
            NSDictionary *dic = json[@"result"];
            Goods *goods = [Goods mj_objectWithKeyValues:dic[@"goods"]];
            block(goods,nil);
        }
    } failure:^(NSError *error) {
        block(nil,error);
        
    }];

}
-(void)getSelectedCategoryDataWithItemID:(NSString *)itemID block:(void(^)(id json , NSError *error))block
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"itemId"] = itemID;
    [LXHttpTool get:GET_SelectedCategory parameters:parameters success:^(id json) {
        if (json[@"status"]) {
            
//            NSDictionary *dic = json[@"result"];
            NSArray *goodsArr = [Goods mj_objectArrayWithKeyValuesArray:json[@"result"][@"result"]];
            block(goodsArr,nil);
        }
    } failure:^(NSError *error) {
        block(nil,error);
        
    }];

}
-(void)getOlderDataWithGoodsId:(NSString *)goodsId block:(void(^)(id json , NSError *error))block
{
    [LXHttpTool get:[NSString stringWithFormat:@"%@%@",GET_GetOlder,goodsId]parameters:nil success:^(id json) {
        if (json[@"status"]) {
            NSDictionary *dic = json[@"result"];
            Goods *goods = [Goods mj_objectWithKeyValues:dic];
            block(goods,nil);
        }
    } failure:^(NSError *error) {
        block(nil,error);
    }];
}

-(void)getAddressListData:(void(^)(id json , NSError *error))block
{
    [LXHttpTool get:GET_GetAddressList parameters:nil success:^(id json) {
        if (json[@"status"]) {
            
            NSArray *AddressArr = [Address mj_objectArrayWithKeyValuesArray:json[@"result"]];
            block(AddressArr,nil);
        }
    } failure:^(NSError *error) {
        block(nil,error);
    }];
}
@end
