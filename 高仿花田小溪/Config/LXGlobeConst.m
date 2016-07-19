#import <UIKit/UIKit.h>
//
NSString * const GET_Categories = @"http://m.htxq.net/servlet/SysCategoryServlet?action=getList";

NSString * const POST_HomeList = @"http://m.htxq.net/servlet/SysArticleServlet?action=mainList";

NSString * const POST_TOP10List = @"http://ec.htxq.net/servlet/SysArticleServlet?currentPageIndex=0&pageSize=10";

NSString * const POST_ArticleDetail = @"http://m.htxq.net/servlet/SysArticleServlet?action=getArticleDetail";

NSString * const POST_CommentList = @"http://m.htxq.net/servlet/UserCommentServlet";

NSString * const POST_UserDetail = @"http://m.htxq.net/servlet/UserCustomerServlet?action=getUserDetail";

NSString * const POST_ColumnistDetails = @"http://m.htxq.net/servlet/UserCenterServlet?action=getMyContents&pageSize=15";

NSString * const GET_GetMalls = @"http://ec.htxq.net/rest/htxq/index/";

NSString * const GET_GetMallsCategories = @"http://ec.htxq.net/rest/htxq/item/tree";

NSString * const GET_GetTopMalls = @"http://ec.htxq.net/rest/htxq/index/carousel";

NSString * const GET_GetGoodsInfo = @"http://ec.htxq.net/rest/htxq/goods/detail/";

NSString * const GET_H5URL = @"http://m.htxq.net/shop/PGoodsAction/goodsDetail.do?goodsId=";

NSString * const GET_SelectedCategory = @"http://ec.htxq.net/rest/htxq/goods/itemGoods";

NSString * const GET_GetOlder = @"http://ec.htxq.net/rest/htxq/goods/orderConfirm/041a470b-79ee-4c0b-b870-9356f15f6a8b/";

NSString * const GET_GetAddressList = @"http://ec.htxq.net/rest/htxq/address/list/041a470b-79ee-4c0b-b870-9356f15f6a8b";