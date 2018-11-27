//
//  NextButton.h
//  NBox
//
//  Created by 安东 on 2018/4/2.
//  Copyright © 2018年 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(id sender);

@interface NextButton : UIButton

+ (NextButton *)buttonWithTitle:(NSString *)title clickBlock:(ClickBlock)block;

@end
