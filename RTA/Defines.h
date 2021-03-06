//
//  Defines.h
//  deyi
//
//  Created by tangwei1 on 16/9/2.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#ifndef Defines_h
#define Defines_h

#import "AWMacros.h"

#import "AWGeometry.h"

#import "AWUITools.h"

#import "AWTextField.h"

#import "AWTableView.h"

#import "AWHairlineView.h"

#import "AWAPIManager.h"

#import "NSStringAdditions.h"

#import "AWMediator.h"

#import "MBProgressHUD.h"

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

#import "APIManager.h"

#import "UITextView+AWPlaceholder.h"

#define IOS_DEFAULT_NAVBAR_BOTTOM_LINE_COLOR  AWColorFromRGB(163, 164, 165)
#define IOS_DEFAULT_CELL_SEPARATOR_LINE_COLOR AWColorFromRGB(187, 188, 193)

#define MAIN_BG_COLOR         [UIColor whiteColor]
#define NAV_BAR_BG_COLOR      AWColorFromRGB(50, 69, 255)
#define CONTENT_VIEW_BG_COLOR AWColorFromRGB(239, 239, 239)

#define HOME_HAIRLINE_COLOR   MAIN_BG_COLOR//AWColorFromRGB(240, 240, 242)

#define WX_APP_ID     @"wx0a45255c7eb48647"
#define WX_APP_SECRET @"31130acde0e69ede9e6850f86f0050d8"

#define AMAP_API_KEY  @"6f4e24990a00e6aa94c66671cbb3a82d"

#define QQ_APP_ID     @"1105708415"
#define QQ_APP_SECRET @"QDJvHqvcyZ5eod53"

#define UMENG_KEY     @"57feef1d67e58e04c2000198"

#define NFC_APP_URL       @""
#define OFFICIAL_TELPHONE @"18108037442"
#define OFFICIAL_QQ       @"2757801355"

#define OFFICIAL_WECHAT_URL   @"http://rth.cddzgj.com/RTH/weixin.html"
#define FEEDBACK_URL          @"http://rth.cddzgj.com/RTH/feedback.html"

// 公交换乘地址
#define TRANSFER_URL          @"http://rth.cddzgj.com/RTH/search.html"

// 广场列表地址
#define SQUARE_LIST_URL       @"http://rth.cddzgj.com/RTH/squarelist.html"

// 线路详情地址
#define LINE_DETAIL_URL       @"http://rth.cddzgj.com/RTH/lineDetails.html"

////// API接口
#define API_HOST      @"http://rti.cddzgj.com/RTIWCF.svc"

#define API_KEY    @"27654725447"
#define API_SECRET @"dfjhskdhsiwnvhkjhdguwnvbxmn"
#define AES_KEY    @"666AA4DF3533497D973D852004B975BC"

// 获取官方信息接口
#define GET_RT_RESULT @"GetRTResult"

// 用户登陆
#define USER_LOGIN    @"UserLogin" // pwd, loginname

// 用户注册
#define ADD_USER_INFO @"AddUserInfo" // pwd, tel

// 更新用户信息
#define UPDATE_USER_INFO @"UpdateUserInfo" // userid, key, value (key可以为：username, sex, birthday)

// SendVerCode
#define SEND_VER_CODE    @"SendVerCode" // tel

// 验证验证码
#define CHECK_VER_CODE   @"CheckVerCode" // tel, vercode

// 判断用户是否存在
#define IS_EXIST_USER_INFO @"IsExitUserInfo" // tel

// 首页获取站点
#define GET_STATION_BY_LNG_AND_LAT @"GetStationByLngAndLat" // lng, lat

// 根据最近的站台获取车辆线路
#define GET_BUS_LINE_QUERY_RESULT  @"GetBusLineQueryResult" // stationid, lng, lat

// 更新头像
#define UPLOAD_PIC @"UploadPic"

#define BUS_LIST_TITLE_BLACK_COLOR AWColorFromRGB(83,83,83)
#define BUS_LIST_TITLE_GRAY_COLOR  AWColorFromRGB(135,135,135)
#define BUS_LIST_CONTAINER_BORDER_GRAY_COLOR  AWColorFromRGB(208,208,208)

#define BUS_LIST_FONT_SMALL 14

#import "ParamUtil.h"

#import "AWLocationManager.h"

#import "UIViewController+CreateFactory.h"
#import "NSObject+RTIDataService.h"
#import "UITableView+RefreshControl.h"

#import "AppDelegate.h"

#import "CustomNavBar.h"

#import "AWButton.h"

#import "NetworkService.h"

#import "UIView+Toast.h"

#import "AWTextField.h"

// Models
#import "User.h"
#import "Location.h"
#import "BuslineSearchHistory.h"
#import "LocationSearchHistory.h"

// Services
#import "UserService.h"
#import "VersionCheckService.h"
#import "SearchHistoryService.h"

// Views
#import "SettingTableHeader.h"
#import "DatePicker.h"
#import "SexPicker.h"
#import "InputCell.h"

// Controllers
#import "WebViewVC.h"

#endif /* Defines_h */
