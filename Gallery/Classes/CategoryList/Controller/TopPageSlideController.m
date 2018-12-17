//
//  TopPageSlideController.m
//  Gallery
//
//  Created by admin on 2018/11/9.
//  Copyright © 2018 安东. All rights reserved.
//

#import "TopPageSlideController.h"
#import "CategoryDetailController.h"
#import "SceneView.h"
#import "PackagingBaseController.h"
#import "MyOrderListController.h"


@interface TopPageSlideController ()<YNPageViewControllerDelegate, YNPageViewControllerDataSource>

@property (nonatomic, copy)   NSArray  *titleArray;  // 商品列表数据源
@property (nonatomic, copy)   NSArray  *packagingCustomArray;  // 自定义包装数据源
@property (nonatomic, copy)   NSArray  *orderList;
@property (nonatomic, strong) UIBarButtonItem  *rightBtnItem;
@property (nonatomic, strong) YNPageConfigration  *configration;
@property (nonatomic, strong) SceneView  *sceneView;

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
  self.configration.lineLeftAndRightAddWidth = 10;
  self.configration.itemLeftAndRightMargin = SCALE_SIZE*21;
  self.configration.itemMargin = SCALE_SIZE*55;
  self.configration.pageScrollEnabled = NO;
  
  TopPageSlideController *vc = [TopPageSlideController pageViewControllerWithControllers:[self getPackagingCustomControllers]
                                                                                  titles:self.packagingCustomArray
                                                                                  config:self.configration];
  vc.dataSource = vc;
  vc.delegate = vc;
  vc.headerView = self.sceneView;
  
  vc.navigationItem.rightBarButtonItem = self.rightBtnItem;
  
  
  return vc;
}

// 初始化我的订单页面
- (instancetype)initMyOrderListVC {
  
  self.configration.pageStyle = YNPageStyleTop;
  
  self.configration.lineWidthEqualFontWidth = YES;
  
  self.configration.lineLeftAndRightAddWidth = 5;
  self.configration.itemLeftAndRightMargin = SCALE_SIZE*10;
  self.configration.itemMargin = SCALE_SIZE*38;
  
  self.configration.scrollMenu = NO;
  
  TopPageSlideController *vc = [TopPageSlideController pageViewControllerWithControllers:[self getOrderListControllers]
                                                                                  titles:self.orderList
                                                                                  config:self.configration];
  vc.dataSource = vc;
  vc.delegate = vc;
  
  
  return vc;
}



#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
  if ([pageViewController.controllersM[index] isKindOfClass:[CategoryDetailController class]]) {
    UIViewController *vc = pageViewController.controllersM[index];
    return [(CategoryDetailController *)vc listCollection];
  } else if ([pageViewController.controllersM[index] isKindOfClass:[PackagingBaseController class]]) {
    PackagingBaseController *vc = pageViewController.controllersM[index];
    return [vc scrollView];
  } else {
    MyOrderListController *vc = pageViewController.controllersM[index];
    return [vc tableView];
  }
}

#pragma mark - YNPageViewControllerDelegate
- (void)pageViewController:(YNPageViewController *)pageViewController
         didScrollMenuItem:(UIButton *)itemButton
                     index:(NSInteger)index {
  if ([pageViewController.controllersM[index] isKindOfClass:[PackagingBaseController class]]) {
    switch (index) {
      case 0:
        [self.sceneView addNode];
        [self.sceneView changeNodeDiffuseWithImageNameArray:@[@"art.scnassets/1_boxtop01.png",@"art.scnassets/0_lining1.png",@"art.scnassets/2_boxdown02.png"]];
        break;
      case 1:
        [self.sceneView removeNode];
        break;
      case 2:
        [self.sceneView addNode];
        [self.sceneView changeNodeDiffuseWithImageNameArray:@[@"art.scnassets/1_boxtop.png",@"art.scnassets/0_lining.png",@"art.scnassets/2_boxdown.png"]];
        break;
        
      default:
        [self.sceneView addNode];
        break;
    }
    [[pageViewController.headerView.subviews objectAtIndex:0] removeFromSuperview];
    [pageViewController.headerView addSubview:self.sceneView];
  
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

-(SceneView *)sceneView {
  if (!_sceneView) {
    _sceneView = [[SceneView alloc] initWithSceneName:@"art.scnassets/box.DAE" frame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*310)];
    _sceneView.cameraNode.position = SCNVector3Make(0, 10, 50);
  }
  return _sceneView;
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
    _configration.lineHeight = 2;
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
  NSArray *controllers = @[@"PackagingStandardController",@"PackagingLiningController",
                           @"PackagingTagController",@"PackagingPalletController",@"PackagingDesignerController"];
  @autoreleasepool {
    
    for (NSString *className in controllers) {
      Class class = NSClassFromString(className);
      if (class) {
        UIViewController *vc = [[class alloc] init];
        [array addObject:vc];
      }
    }
  }
  return array;
}

-(NSArray *)orderList {
  if (!_orderList) {
    
    _orderList = @[@"待付款",@"处理中",@"待收货",@"已完成",@"售后"];
  }
  return _orderList;
}

- (NSArray *)getOrderListControllers {
  @autoreleasepool {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.orderList.count; i++) {
      MyOrderListController *vc = [[MyOrderListController alloc] init];
      [array addObject:vc];
    }
    return array;
  }
}
@end
