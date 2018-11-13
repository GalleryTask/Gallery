//
//  CommonUtil.h
//  NBox
//
//  Created by 安东 on 2018/1/22.
//  Copyright © 2018年 安东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtil : NSObject

/**
 正则验证手机号
 
 @param mobile 手机号
 @return 是否是正确的手机号
 */
+(BOOL)isValidateMobile:(NSString *)mobile;

/**
 去掉字符串上的空格
 @param string 源字符串
 @return 去完空格后的字符串
 */
+ (NSString *)removeTheBlankSpace:(NSString *)string;


/**
 提示

 @param text 提示文字
 @param view 提示显示view
 @param hidden 是否自动隐藏提示
 */
+ (void)promptViewWithText:(NSString *)text view:(UIView *)view hidden:(BOOL)hidden;

/**
 隐藏提示
 */
+ (void)promptHudViewHide;

/**
 将时间戳转化为时间

 @param timestamp 时间戳
 @param dateFormatter 时间格式  YYYY-MM-dd hh:mm:ss
 @return 时间
 */
+ (NSString *)timestampSwitchTime:(NSString *)timestamp dateFormatter:(NSString *)dateFormatter;

/**
 将当前日期转化为星期
 
 @param currentStr 当前的日期 yyyy-MM-dd
 @return 星期字符串
 */
+ (NSString*)getWeekDay:(NSString*)currentStr;

/**
 获取当前日期后几天的日期
 
 @param date 天数
 @param dateFormatter 日期的格式
 @return 年月日/ -
 */
+ (NSString *)getTheDateWithAfterDate:(NSInteger)date dateFormatter:(NSString *)dateFormatter;

/**
 带json格式的对象(字典)转化成json字符串

 @param jsonObject json对象
 @return json字符串
 */
+ (NSString *)jsonStringWithObject:(id)jsonObject;



/**
 获取当前controller

 @return 当前controller
 */
+(UIViewController *)getCurrentVC;



/**
 自动计算字符串高度

 @param text 字符串
 @param spaceHight 行间距
 @param size 字符串所需宽高
 @param font 字体大小
 @return  宽高
 */
+ (CGSize)adaptionWithText:(NSString *)text LineSpace:(CGFloat)spaceHight size:(CGSize)size font:(UIFont *)font;

/**
 计算label的高度并自适应高度
 
 @param label label
 @param spaceHight 行间距
 @param size 字符串所需宽高
 @return 宽高
 */
+ (CGSize)adaptionWithLabel:(UILabel *)label LineSpace:(CGFloat)spaceHight size:(CGSize)size;

/**
 自动计算文字宽度
 
 @param string 字符串
 @param fontSize 字号
 @param height 字符串高度
 @return 字符串宽度
 */
+ (float)adaptionWidthWithString:(NSString *)string fontSize:(float)fontSize andHeight:(float)height;

/**
 颜色转化为图片

 @param color 传入颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
