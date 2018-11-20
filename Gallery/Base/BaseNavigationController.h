//
//  BaseNavigationController.h
//  NBox
//
//  Created by 安东 on 2018/9/4.
//  Copyright © 2018年 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController


/**
 显示navigation left button
 
 @param leftClickBlock left button click block
 */
- (void)showLeftNavBtnWithClick:(leftNavigationClickBlock)leftClickBlock;


/**
 设置navigation右侧按钮（图片

 @param imageName 设置图片的名字
 @param highlightImageName 高亮图片名字
 @param block 点击回调
 */
- (void)setNavigationBarRightItemWithImageName:(NSString *)imageName
                            highlightImageName:(NSString *)highlightImageName
                                    clickBlock:(rightNavigationClickBlock)block;

/**
 设置navigation右侧按钮（文字）

 @param title 按钮文字
 @param block 点击回调
 */
- (void)setNavigationBarRightItemWithButtonTitle:(NSString *)title
                                      clickBlock:(rightNavigationClickBlock)block;

@end
