//
//  TopPageSlideController.m
//  Gallery
//
//  Created by admin on 2018/11/9.
//  Copyright © 2018 安东. All rights reserved.
//

#import "TopPageSlideController.h"
#import "CategoryDetailController.h"
#import "PackagingPalletController.h"
#import "PackagingLiningController.h"

@interface TopPageSlideController ()<YNPageViewControllerDelegate, YNPageViewControllerDataSource>

@property (nonatomic, strong) NSArray  *titleArray;  // 商品列表数据源
@property (nonatomic, strong) NSArray  *packagingCustomArray;  // 自定义包装数据源
@property (nonatomic, strong) UIBarButtonItem  *rightBtnItem;
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
  self.configration.lineLeftAndRightAddWidth = 5;
  self.configration.itemLeftAndRightMargin = SCALE_SIZE*21;
  self.configration.itemMargin = SCALE_SIZE*55;
  
  TopPageSlideController *vc = [TopPageSlideController pageViewControllerWithControllers:[self getPackagingCustomControllers]
                                                                                  titles:self.packagingCustomArray
                                                                                  config:self.configration];
  vc.dataSource = vc;
  vc.delegate = vc;
  
  UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*300)];
  [headerView setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
  vc.headerView = headerView;
  
  vc.navigationItem.rightBarButtonItem = self.rightBtnItem;
  
  return vc;
}



#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
  
  if ([pageViewController.controllersM[index] isKindOfClass:[CategoryDetailController class]]) {
    
    UIViewController *vc = pageViewController.controllersM[index];
    return [(CategoryDetailController *)vc listCollection];
  } else {
    UIViewController *vc = pageViewController.controllersM[index];
    switch (index) {
      case 0:
        return [(CategoryDetailController *)vc listCollection];
        break;
      case 1:
        return [(PackagingLiningController *)vc scrollView];
        break;
      case 2:
        return [(CategoryDetailController *)vc listCollection];
        break;
      case 3:
        return [(PackagingPalletController *)vc scrollView];
        break;
      case 4:
        return [(CategoryDetailController *)vc listCollection];
        break;
        
      default:
        return nil;
        break;
    }
    
  }
}

- (void)rightNavigationBtnClick:(id)sender {
  
}

#pragma marks - getters
-(UIBarButtonItem *)rightBtnItem {
  if (!_rightBtnItem) {
    UIButton  *rightNavigationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightNavigationBtn setFrame:CGRectMake(0, 0, BASE_HEIGHT*2, BASE_HEIGHT)];
    [rightNavigationBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [rightNavigationBtn addTarget:self
                            action:@selector(rightNavigationBtnClick:)
                  forControlEvents:UIControlEventTouchUpInside];
    [rightNavigationBtn setTitleColor:BASECOLOR_BLACK_333 forState:UIControlStateNormal];
    [[rightNavigationBtn titleLabel] setFont:FONTSIZE(14)];
    [rightNavigationBtn setTitle:@"保存" forState:UIControlStateNormal];
    _rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightNavigationBtn];
  }
  return _rightBtnItem;
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

-(NSArray *)packagingCustomArray {
  if (!_packagingCustomArray) {
    _packagingCustomArray = @[@"规格",@"内衬",@"标签",@"托盘",@"平面设计"];
  }
  return _packagingCustomArray;
}

- (NSArray *)getPackagingCustomControllers {
  NSMutableArray *array = [NSMutableArray array];
//  @autoreleasepool {
//    for (int i = 0; i < self.packagingCustomArray.count; i++) {
//      if (i == 3) {
//        PackagingPalletController *vc = [[PackagingPalletController alloc] init];
//        [array addObject:vc];
//      } else {
//        CategoryDetailController *vc = [[CategoryDetailController alloc] init];
//        [array addObject:vc];
//
//      }
//    }
//    return array;
//  }
  
  CategoryDetailController *vc = [[CategoryDetailController alloc] init];
  [array addObject:vc];
  
  PackagingLiningController *liningVC = [[PackagingLiningController alloc] init];
  [array addObject:liningVC];
  
  CategoryDetailController *vc1 = [[CategoryDetailController alloc] init];
  [array addObject:vc1];
  
  PackagingPalletController *palletVC = [[PackagingPalletController alloc] init];
  [array addObject:palletVC];
  
  CategoryDetailController *vc2 = [[CategoryDetailController alloc] init];
  [array addObject:vc2];
  
  
  return array;
}


@end
