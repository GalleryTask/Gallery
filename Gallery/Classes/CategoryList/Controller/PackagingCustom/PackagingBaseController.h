//
//  PackagingBaseController.h
//  Gallery
//
//  Created by 安东 on 13/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "BaseViewController.h"
#import "PackagingCustomView.h"
#import "BottomSelectBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface PackagingBaseController : BaseViewController

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) BottomSelectBar  *bottomBar;

@end

NS_ASSUME_NONNULL_END
