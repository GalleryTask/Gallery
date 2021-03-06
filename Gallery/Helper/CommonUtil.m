//
//  CommonUtil.m
//  NBox
//
//  Created by 安东 on 2018/1/22.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "CommonUtil.h"
#import "MBProgressHUD.h"

static MBProgressHUD *hud;
static NSDateFormatter *cachedDateFormatter = nil;

@implementation CommonUtil

/**
 缓存dateFormatter对象

 @return dateFormatter对象
 */
+ (NSDateFormatter *)cachedDateFormatter {
  if (!cachedDateFormatter) {
    cachedDateFormatter = [[NSDateFormatter alloc] init];
    [cachedDateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [cachedDateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [cachedDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
  }
  return cachedDateFormatter;
}

/**
 正则验证手机号
 
 @param mobile 手机号
 @return 是否是正确的手机号
 */
+ (BOOL)isValidateMobile:(NSString *)mobile {
  
  //  NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
  NSString *phoneRegex = @"^[1][2-9]+\\d{9}$";
  NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
  return [phoneTest evaluateWithObject:mobile];
}

/**
 去掉字符串上的空格
 @param string 源字符串
 @return 去完空格后的字符串
 */
+ (NSString *)removeTheBlankSpace:(NSString *)string {
  
  string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
  return string;
}

/**
 提示
 
 @param text 提示文字
 @param view 提示显示view
 @param hidden 是否自动隐藏提示
 */
+ (void)promptViewWithText:(NSString *)text view:(UIView *)view hidden:(BOOL)hidden {
  
  hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
  if (text) {
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.label.textColor = BASECOLOR_BLACK_333;
    hud.label.font = FONTSIZE_LIGHT(14);
  } else {
    hud.mode = MBProgressHUDModeIndeterminate;
  }
  // 设置背景透明度
  hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
  hud.bezelView.color = [BASECOLOR_GRAY_E9 colorWithAlphaComponent:0.9];
  
  hud.bezelView.layer.cornerRadius = 5;
  
  // 显示、隐藏动画样式
  hud.animationType = MBProgressHUDAnimationZoomOut;
  // HUD的相对于父视图 x 的偏移，默认居中
  hud.offset = CGPointMake(0.f, -NAVIGATIONBAR_HEIGHT);
  // HUD内部视图相对于HUD的边距
  hud.margin = 16;
  
  hidden ? [hud hideAnimated:YES afterDelay:1.f] :nil;
}

/**
 隐藏提示
 */
+ (void)promptHudViewHide {
  [hud hideAnimated:YES];
}

/**
 自动计算字符串高度
 
 @param text 字符串
 @param spaceHight 行间距
 @param size 字符串所需宽高
 @param font 字体大小
 @return  宽高
 */
+ (CGSize)adaptionWithText:(NSString *)text
                 LineSpace:(CGFloat)spaceHight
                      size:(CGSize)size
                      font:(UIFont *)font {
  CGSize labelSize;
  if (text) {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    [paragraphStyle setLineSpacing:spaceHight];
    [attributeString addAttribute:NSParagraphStyleAttributeName
                            value:paragraphStyle
                            range:NSMakeRange(0, [text length])];
    text = [attributeString string];
    
    NSDictionary *attributes = @{NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle.copy};
    labelSize = [text boundingRectWithSize:size
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:attributes
                                   context:nil].size;
  } else {
    labelSize = CGSizeMake(0, 0);
  }
  return labelSize;
}

/**
 计算label的高度并自适应高度

 @param label label
 @param spaceHight 行间距
 @param size 字符串所需宽高
 @return 宽高
 */
+ (CGSize)adaptionWithLabel:(UILabel *)label LineSpace:(CGFloat)spaceHight size:(CGSize)size {
  CGSize labelSize;
  if (label.text) {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[label text]];
    [paragraphStyle setLineSpacing:spaceHight];
    [attributeString addAttribute:NSParagraphStyleAttributeName
                            value:paragraphStyle
                            range:NSMakeRange(0, [[label text] length])];
    label.attributedText = attributeString;
    
    NSDictionary *attributes = @{NSFontAttributeName:label.font,
                                 NSParagraphStyleAttributeName:paragraphStyle.copy};
    labelSize = [label.text boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes
                                         context:nil].size;
  } else {
    labelSize = CGSizeMake(0, 0);
  }
  return labelSize;
}



/**
 自动计算文字宽度

 @param string 字符串
 @param fontSize 字号
 @param height 字符串高度
 @return 字符串宽度
 */
+ (float)adaptionWidthWithString:(NSString *)string fontSize:(float)fontSize andHeight:(float)height {

  NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
  CGSize sizeToFit = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine  attributes:attributes context:nil].size;
  return sizeToFit.width;
}

/**
 将时间戳转化为时间
 
 @param timestamp 时间戳
 @param dateFormatter 时间格式  YYYY-MM-dd hh:mm:ss
 @return 时间
 */
+ (NSString *)timestampSwitchTime:(NSString *)timestamp dateFormatter:(NSString *)dateFormatter {
  
  NSDateFormatter *formatter = [CommonUtil cachedDateFormatter];
  [formatter setDateFormat:dateFormatter];

  NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue] / 1000.0];
  NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
  return confromTimespStr;
}

/**
 将当前日期转化为星期

 @param currentStr 当前的日期 yyyy-MM-dd
 @return 星期字符串
 */
+ (NSString*)getWeekDay:(NSString*)currentStr {
  
  NSDateFormatter *formatter = [CommonUtil cachedDateFormatter];
  [formatter setDateFormat:@"yyyy-MM-dd"];//设定时间格式,要注意跟下面的dateString匹配，否则日起将无效
  NSDate*date =[formatter dateFromString:currentStr];
  NSArray*weekdays = [NSArray arrayWithObjects: [NSNull null],@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",nil];
  NSCalendar*calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSCalendarUnit calendarUnit =NSCalendarUnitWeekday;
  NSDateComponents*theComponents = [calendar components:calendarUnit fromDate:date];
  
  return [weekdays objectAtIndex:theComponents.weekday];
}


/**
 获取当前日期后几天的日期
 
 @param date 天数
 @param dateFormatter 日期的格式
 @return 年月日/ -
 */
+ (NSString *)getTheDateWithAfterDate:(NSInteger)date dateFormatter:(NSString *)dateFormatter {
  
  NSInteger dis = date; //前后的天数
  NSDate *nowDate = [NSDate date];
  NSDate *theDate;
  NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
  //之后的天数
  theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay*dis];

  NSDateFormatter *formatter = [CommonUtil cachedDateFormatter];
  //设定时间格式,这里可以设置成自己需要的格式
  [formatter setDateFormat:dateFormatter];
  //用[NSDate date]可以获取系统当前时间
  NSString * currentDateStr = [formatter stringFromDate:theDate];
  return currentDateStr;
}

/**
 带json格式的对象(字典)转化成json字符串
 
 @param jsonObject json对象
 @return json字符串
 */
+ (NSString *)jsonStringWithObject:(id)jsonObject {
  NSError *error = nil;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:&error];
  NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                               encoding:NSUTF8StringEncoding];
  
  if ([jsonString length] > 0 && error == nil){
    return jsonString;
  }else{
    return nil;
  }
}

/**
 获取当前controller
 
 @return 当前controller
 */
+ (UIViewController *)getCurrentVC {
  UIViewController *result = nil;
  UIWindow * window = [[UIApplication sharedApplication] keyWindow];
  //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
  if (window.windowLevel != UIWindowLevelNormal) {
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for(UIWindow * tmpWin in windows) {
      if (tmpWin.windowLevel == UIWindowLevelNormal) {
        window = tmpWin;
        break;
      }
    }
  }
  id  nextResponder = nil;
  UIViewController *appRootVC=window.rootViewController;
  //    如果是present上来的appRootVC.presentedViewController 不为nil
  if (appRootVC.presentedViewController) {
    nextResponder = appRootVC.presentedViewController;
  } else {
    UIView *frontView = [[window subviews] objectAtIndex:0];
    nextResponder = [frontView nextResponder];
  }
  
  if ([nextResponder isKindOfClass:[UITabBarController class]]){
    UITabBarController * tabbar = (UITabBarController *)nextResponder;
    UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
    result=nav.childViewControllers.lastObject;
    
  } else if ([nextResponder isKindOfClass:[UINavigationController class]]) {
    UIViewController * nav = (UIViewController *)nextResponder;
    result = nav.childViewControllers.lastObject;
  } else {
    result = nextResponder;
  }
  return result;
}


/**
 根据颜色返回一个像素大小的纯色图片
 
 @param color 传入颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color {
  
  CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}


@end

