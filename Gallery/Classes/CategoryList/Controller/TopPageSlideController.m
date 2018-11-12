//
//  TopPageSlideController.m
//  Gallery
//
//  Created by admin on 2018/11/9.
//  Copyright © 2018 安东. All rights reserved.
//

#import "TopPageSlideController.h"
#import "CategoryDetailController.h"

@interface TopPageSlideController ()<YNPageViewControllerDelegate, YNPageViewControllerDataSource>

@property (nonatomic, strong) NSArray  *titleArray;  // 商品列表数据源
@property (nonatomic, strong) YNPageConfigration  *configration;

@end

@implementation TopPageSlideController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 初始化分类详情
- (instancetype)initCategoryDetailVC {
  
  self.configration.pageStyle = YNPageStyleTop;
  
  self.configration.lineWidthEqualFontWidth = YES;
  
  TopPageSlideController *vc = [TopPageSlideController pageViewControllerWithControllers:[self getControllers]
                                                                                  titles:self.titleArray
                                                                                  config:self.configration];
  vc.dataSource = vc;
  vc.delegate = vc;

  return vc;
}

// 初始化包装定制
- (instancetype)initPackagingCustomVC {
  
  self.configration.pageStyle = YNPageStyleSuspensionCenter;
  self.configration.lineLeftAndRightAddWidth = 3;
  self.configration.pageScrollEnabled = YES;
  
  TopPageSlideController *vc = [TopPageSlideController pageViewControllerWithControllers:[self getControllers]
                                                                                  titles:self.titleArray
                                                                                  config:self.configration];
  vc.dataSource = vc;
  vc.delegate = vc;
  
  UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*300)];
  [headerView setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
  vc.headerView = headerView;
  
  return vc;
}



#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
  if ([pageViewController.controllersM[index] isKindOfClass:[CategoryDetailController class]]) {
    
    UIViewController *vc = pageViewController.controllersM[index];
    return [(CategoryDetailController *)vc listCollection];
  } else {
    UIViewController *vc = pageViewController.controllersM[index];
    return [(CategoryDetailController *)vc listCollection];
  }
  
}

#pragma mark - YNPageViewControllerDelegate
- (void)pageViewController:(YNPageViewController *)pageViewController
            contentOffsetY:(CGFloat)contentOffset
                  progress:(CGFloat)progress {
  NSLog(@"--- contentOffset = %f,    progress = %f", contentOffset, progress);
}

-(YNPageConfigration *)configration {
  if (!_configration) {
    _configration = [YNPageConfigration defaultConfig];
    _configration.scrollMenu = YES;
    _configration.aligmentModeCenter = NO;
    _configration.showBottomLine = YES;
    _configration.normalItemColor = BASECOLOR_BLACK_333;
    _configration.selectedItemColor = BASECOLOR_BLACK_333;
    _configration.bottomLineBgColor = BASECOLOR_GRAY_E9;
    _configration.bottomLineHeight = 0.5;
    _configration.lineColor = BASECOLOR_BLACK_333;
    _configration.lineHeight = 3;
    _configration.itemLeftAndRightMargin = SCALE_SIZE*16;
    _configration.itemMargin = SCALE_SIZE*20;
    _configration.itemFont = [UIFont systemFontOfSize:SCALE_SIZE*14 weight:UIFontWeightBold];
    _configration.selectedItemFont = [UIFont systemFontOfSize:SCALE_SIZE*14 weight:UIFontWeightBold];
    _configration.headerViewCouldScrollPage = YES;
  }
  return _configration;
}

-(NSArray *)titleArray {
  if (!_titleArray) {
    _titleArray = @[@"高档礼盒",@"普通礼盒",@"物流周转",@"快递包装",@"服装",@"酒水饮料",@"日化家纺",
                                        @"家具",@"家用电器",@"玩具饰品",@"家装五金"];
  }
  return _titleArray;
}

- (NSArray *)getControllers {
  @autoreleasepool {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.titleArray.count; i++) {
      CategoryDetailController *vc = [[CategoryDetailController alloc] init];
      [array addObject:vc];
    }
    return array;
  }
}


- (NSArray *)getPageCustomControllers {
  @autoreleasepool {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.titleArray.count; i++) {
      CategoryDetailController *vc = [[CategoryDetailController alloc] init];
      [array addObject:vc];
    }
    return array;
  }
}


@end
