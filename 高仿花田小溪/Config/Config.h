
#ifndef Config_h
#define Config_h

//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)();
typedef void (^NetWorkBlock)(BOOL netConnetState);


#define KeyWindow  [UIApplication sharedApplication].keyWindow
/** RGB颜色 */
#define rgb255(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
// 判断手机的系统版本
#define iOS(v) ([UIDevice currentDevice].systemVersion.doubleValue >= (v))
/** 弱引用 */
#define WeakSelf __weak typeof(self) weakSelf = self;
/** 随机色 */
#define RandomColor Color(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
/** 灰色 */
#define Color(v) rgb255(v, v, v)


#define isIOS9 ([[[UIDevice currentDevice] systemVersion] intValue] >=9)


#define MY_WIHTE [UIScreen mainScreen].bounds.size.width
#define MY_HEIGHT [UIScreen mainScreen].bounds.size.height




//通知key
#define CategoriesKey @"CategoriesKey"
#define MallCategoriesKey @"MallCategoriesKey"
#define TopArticleAuthor @"topArticleAuthor"
#define TopContents @"topContents"
#define LoginStatus @"LoginStatus"

#define BuyNumNotifyName @"BuyNumNotifyName"// 购买数量变化的通知名
#define BuyNumKey @"BuyNumKey"// 购买数量变化的通知的userinfo的key
#define AddressChangeNotify @"AddressChangeNotify"// 地址改变通知
#define AddressChangeNotifyKey @"AddressChangeNotifyKey"// 地址改变通知useinfo的key
#define InvoiceAddressChangeNotifyKey @"InvoiceAddressChangeNotifyKey"// 发票地址改变通知useinfo的key

#ifdef DEBUG //如果处于调试阶段调用
#define LXLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] );
#else//如果处于其它状态  发布状态
#define LXLog(s,...)

#endif
#endif





//单利
#define interfaceSingleton(name)  +(instancetype)share##name

#if __has_feature(objc_arc)
// ARC
#define implementationSingleton(name)  \
+ (instancetype)share##name \
{ \
name *instance = [[self alloc] init]; \
return instance; \
} \
static name *_instance = nil; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[super allocWithZone:zone] init]; \
}); \
return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone{ \
return _instance; \
} \
- (id)mutableCopyWithZone:(NSZone *)zone \
{ \
return _instance; \
}
#else
// MRC

#define implementationSingleton(name)  \
+ (instancetype)share##name \
{ \
name *instance = [[self alloc] init]; \
return instance; \
} \
static name *_instance = nil; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[super allocWithZone:zone] init]; \
}); \
return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone{ \
return _instance; \
} \
- (id)mutableCopyWithZone:(NSZone *)zone \
{ \
return _instance; \
} \
- (oneway void)release \
{ \
} \
- (instancetype)retain \
{ \
return _instance; \
} \
- (NSUInteger)retainCount \
{ \
return  MAXFLOAT; \
}
#endif