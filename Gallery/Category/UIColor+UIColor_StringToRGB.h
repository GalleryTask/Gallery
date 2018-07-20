//
//  UIColor+UIColor_StringToRGB.h
//  Tourmaline
//
//  Created by dongan on 16/5/26.
//  Copyright © 2016年 dongan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIColor_StringToRGB)

#pragma 颜色转换成RGB
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;

@end
