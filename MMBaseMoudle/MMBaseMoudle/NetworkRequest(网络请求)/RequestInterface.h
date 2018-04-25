
//
//  RequestInterface .h
//  HanyuSearchJoy
#pragma mark 微信AppID
#define WXAppID @"wxa6ee01bb99067502"
#define AppSecret @"a80eac069befb9153b57f98803196450"

#pragma mark 腾讯QQ
#define TxAppId @"1106444507"
#define TxAppKey @"fCN0G6hb4wx2fiUa"

#pragma mark 新浪
#define xlappKey @"4273137370"
#define xlappSecret @"0debbb9c3710186b8be68bb216c17214"

#pragma mark 极光
#define JXAppKey @"98a8bdf0862cc769a2753d7e"

////****************  正式 机   ********************  //
//#pragma mark 环信AppID
//#define HuangXinAppID @"1149170509178357#seventurnip"
//#define HYURL  @"https://luobo.hanyu020.com/api/"
//#define HYShareUrl @"https://luobo.hanyu020.com/"
//#define STApnsCerName @"disturibution"

//****************  测试 机   ********************  //
#pragma mark 环信AppID
#define HuangXinAppID @"1149170509178357#seventurnip"
#define HYURL @"http://192.168.1.174/api/"
#define HYShareUrl @"http://192.168.1.174/"
#define STApnsCerName @"developer"

#define SUCCESS [responseObject[@"code"] isEqual:@"1"]
#define ReturnMsg responseObject[@"msg"]

#define isServer ([[UserObject shareUser].status integerValue] == 2)

#ifndef RequestInterface__h
#define RequestInterface__h

#pragma mark 本地信息存储
#define ChatList @"ChatList"
//  登录回调
#define kLoginCallBack @"LoginCallBack"




#endif /* RequestInterface__h */
