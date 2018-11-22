//
//  TopPageSlideController.h
//  Gallery
//
//  Created by admin on 2018/11/9.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YNPageViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface TopPageSlideController : YNPageViewController

// 初始化分类详情
- (instancetype)initCategoryDetailVC;

// 初始化包装定制
- (instancetype)initPackagingCustomVC;

// 初始化我的订单页面
- (instancetype)initMyOrderListVC;
@end

NS_ASSUME_NONNULL_END
