//
//  Config.h
//  NBox
//
//  Created by 安东 on 2017/12/20.
//  Copyright © 2017年 安东. All rights reserved.
//

#ifndef Config_h
#define Config_h

// 手机型号
#define IS_IPHONE_4  (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5  (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6  (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6P (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)
#define IS_IPHONE_X  (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)812) < DBL_EPSILON)
// 屏幕宽度
#define SCREEN_WIDTH             [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define SCREEN_HEIGHT            [UIScreen mainScreen].bounds.size.height
// 基本高度
#define BASE_HEIGHT              44
// 状态栏高度
#define STATUSBAR_HRIGHT         [UIApplication sharedApplication].statusBarFrame.size.height
// navigation的高度
#define NAVIGATIONBAR_HEIGHT     (STATUSBAR_HRIGHT + BASE_HEIGHT)
// 请求数据状态
#define REQUEST_SUCCESS(status)  [status isEqualToString:@"0000"]
// iPhone X 安全区
#define SafeAreaBottomHeight     (IS_IPHONE_X ? 34 : 0)
// 适配比例
#define SCALE_SIZE               (SCREEN_WIDTH == 375 ? 1 : (SCREEN_WIDTH == 414 ? 1.1 : 0.9))
// 适配iOS11
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever; view.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaBottomHeight, 0);} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}
// root view
#define ROOTVIEW                 UIApplication.sharedApplication.delegate.window.rootViewController.view
// 字体大小
#define FONTSIZE(value)          [UIFont systemFontOfSize:value * SCALE_SIZE]
// 系统基本颜色
#define BASECOLOR_BACKGROUND_GRAY   [UIColor hexStringToColor:@"#F5F5F5"]
#define BASECOLOR_LINE              [UIColor hexStringToColor:@"#EBEBEB"]
#define BASECOLOR_BLACK             [UIColor hexStringToColor:@"#1A1A1A"]
#define BASECOLOR_LIGHTGRAY         [UIColor hexStringToColor:@"#D9D9D9"]
#define BASECOLOR_MIDDLEBLACK       [UIColor hexStringToColor:@"#999999"]
#define BASECOLOR_LIGHTBLACK        [UIColor hexStringToColor:@"#666666"]
#define BASECOLOR_DARKBLACK         [UIColor hexStringToColor:@"#333333"]
#define BASECOLOR_BUTTON_BLACK      [UIColor hexStringToColor:@"#001A26"]
#define BASECOLOR_BLUE              [UIColor hexStringToColor:@"#418eff"]
#define BASECOLOR_GREEN             [UIColor hexStringToColor:@"#77D977"]
#define BASECOLOR_RED               [UIColor hexStringToColor:@"#FF4C4C"]


// 地图的appkey
#define MAP_APPKEY                  @"369bfc0d3d2a8b52bfad1c8d3ed53343"
// 注册唯一标识
#define CLIENTID_iOS                @"8wwzPELMJoo9p7KJH5G7saZuepUFsZcc"
#define CLIENTID_SECRET             @"Y7zXLAKF75zpeZXfaqnm5qyIFeIVorCi"
// 应用注册scheme,在Info.plist定义URL types
#define ALIPAY_SCHEME               @"Alipay"
// 测试URL
//#define BASE_URL                    @"http://192.168.1.89:9999"
// 线上地址
#define BASE_URL                    @"http://59.110.213.5:8010"

#define ImageURL(imageId,accessToken)   [NSURL URLWithString:[NSString stringWithFormat:@"%@/userinfo/nbox/showImg/%@?access_token=%@",BASE_URL,imageId,accessToken]]


// 获取app的info.plist详细信息
#define Version      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]  // build 版本号
#define ShortVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] // version 版本号
#define Package      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] // 包名
#define DisplayName  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"] // 应用显示的名称
#define BundleName   [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"] // 工程名

#endif /* Config_h */

