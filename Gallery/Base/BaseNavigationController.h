//
//  BaseNavigationController.h
//  NBox
//
//  Created by 安东 on 2018/9/4.
//  Copyright © 2018年 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController

@property (nonatomic, strong) UIButton          *rightNavigationBtn;
/**
 显示navigation left button
 
 @param leftClickBlock left button click block
 */
- (void)showLeftNavBtnWithClick:(leftNavigationClickBlock)leftClickBlock;


/**
 显示navigation right button
 
 @param rightClickBlock right button click block
 */
- (void)showRightNavBtnWithClick:(rightNavigationClickBlock)rightClickBlock;

/**
 设置navigation右侧按钮（图片）

 @param imageName 正常图片
 @param highlightImageName 高亮图片
 */
- (void)setNavigationBarRightItemWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName;

/**
 设置navigation右侧按钮（文字）

 @param title 按钮文字
 */
- (void)setNavigationBarRightItemWithButtonTitle:(NSString *)title;

@end
